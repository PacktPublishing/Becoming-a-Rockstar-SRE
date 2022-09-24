'use strict;'
// This app uses the Google Cloud SDK Compute and Networking modules
// More details:
// https://cloud.google.com/nodejs/docs/reference/compute/latest

// Global variables used by all functions
const projectId = process.env.GCP_PROJECT_ID;
const machineType = process.env.GCP_MACHINE_TYPE;
const machineImageProject = process.env.GCP_MACHINE_IMAGE_PROJECT;
const machineImageFamily = process.env.GCP_MACHINE_IMAGE_FAMILY;
const zone = process.env.GCP_ZONE;
const networkName = process.env.GCP_NETWORK_NAME;

const compute = require('@google-cloud/compute');

const args = process.argv.slice(2);
/*
List all custom images created under the project Id
based on https://github.com/googleapis/nodejs-compute/blob/main/samples/listImages.js
*/
async function listCustomImages() {

  console.log(
    `Listing the custom images available for ${projectId} project...`
  );
  const imagesClient = new compute.ImagesClient();
  const images = imagesClient.listAsync({
    project: projectId,
    maxResults: 3,
    filter: 'deprecated.state != DEPRECATED',
  });

  if (Object.keys(images).length === 0) {
    console.log(`No custom images found for ${projectId} project.`);
  } else {
    Array.from(images).forEach(function(image){
      console.log(image.name);
    });
  };
}


/*
Create a VM instance with a determined instance name, machine type, and machine image on the specified zone
Based on https://github.com/googleapis/nodejs-compute/blob/main/samples/createInstance.js
*/
async function createInstance(instanceName, netName) {
  const instancesClient = new compute.InstancesClient();

  console.log(
    `Creating the ${instanceName} instance in ${zone}...`
  );

  const [response] = await instancesClient.insert({
    instanceResource: {
      name: instanceName,
      machineType: `zones/${zone}/machineTypes/${machineType}`,
      networkInterfaces: [
        {
          // Use the network interface provided in the netName argument.
          name: `global/networks/${netName}`,
        },
      ],
      disks: [
        {
          // Describe the size and source image of the boot disk to attach to the instance.
          initializeParams: {
            diskSizeGb: '10',
            sourceImage: `projects/${machineImageProject}/global/images/family/${machineImageFamily}`
          },
          autoDelete: true,
          boot: true,
          type: 'PERSISTENT',
        },
      ],
    },
    project: projectId,
    zone: zone
  });
  let operation = response.latestResponse;
  const operationsClient = new compute.ZoneOperationsClient();

  // Wait for the create operation to complete.
  while (operation.status !== 'DONE') {
    [operation] = await operationsClient.wait({
      operation: operation.name,
      project: projectId,
      zone: operation.zone.split('/').pop(),
    });
  }

  console.log(`Instance ${instanceName} has been created.`);
}

/*
Get details about a VM instance
Based on https://github.com/googleapis/nodejs-compute/blob/main/samples/getInstance.js
*/
async function getInstance(instanceName) {
  const instancesClient = new compute.InstancesClient();

  const [instance] = await instancesClient.get({
    project: projectId,
    zone,
    instance: instanceName,
  });

  console.log(
    `Instance ${instanceName} data:\n${JSON.stringify(instance, null, 4)}`
  );
}

/*
Start the VM instance
Based on https://github.com/googleapis/nodejs-compute/blob/main/samples/startInstance.js
*/
async function startInstance(instanceName) {
  const instancesClient = new compute.InstancesClient();

  const [response] = await instancesClient.start({
    project: projectId,
    zone,
    instance: instanceName,
  });
  let operation = response.latestResponse;
  const operationsClient = new compute.ZoneOperationsClient();

  // Wait for the operation to complete.
  while (operation.status !== 'DONE') {
    [operation] = await operationsClient.wait({
      operation: operation.name,
      project: projectId,
      zone: operation.zone.split('/').pop(),
    });
  }

  console.log(`Instance ${instanceName} has started.`);
}

/*
Stop the VM instance
Based on https://github.com/googleapis/nodejs-compute/blob/main/samples/stopInstance.js
*/
async function stopInstance(instanceName) {
  const instancesClient = new compute.InstancesClient();

  const [response] = await instancesClient.stop({
    project: projectId,
    zone,
    instance: instanceName,
  });
  let operation = response.latestResponse;
  const operationsClient = new compute.ZoneOperationsClient();

  // Wait for the operation to complete.
  while (operation.status !== 'DONE') {
    [operation] = await operationsClient.wait({
      operation: operation.name,
      project: projectId,
      zone: operation.zone.split('/').pop(),
    });
  }

  console.log(`Instance ${instanceName} has stopped.`);
}

/*
Delete the VM instance
Based on https://github.com/googleapis/nodejs-compute/blob/main/samples/deleteInstance.js
*/
async function deleteInstance(instanceName) {
  const instancesClient = new compute.InstancesClient();

  console.log(`Deleting ${instanceName} from ${zone}...`);

  const [response] = await instancesClient.delete({
    project: projectId,
    zone,
    instance: instanceName,
  });
  let operation = response.latestResponse;
  const operationsClient = new compute.ZoneOperationsClient();

  // Wait for the delete operation to complete.
  while (operation.status !== 'DONE') {
    [operation] = await operationsClient.wait({
      operation: operation.name,
      project: projectId,
      zone: operation.zone.split('/').pop(),
    });
  }

  console.log(`Instance ${instanceName} has been deleted.`);
}


switch (args[0]) {
  case 'listCustomImages':
    listCustomImages();
    break;
  case 'createInstance':
    createInstance(args[1], args[2]);
    break;
  case 'getInstance':
    getInstance(args[1]);
    break;
  case 'startInstance':
    startInstance(args[1]);
    break;
  case 'stopInstance':
    stopInstance(args[1]);
    break;
  case 'deleteInstance':
    deleteInstance(args[1]);
    break;
  default:
    console.log(`Argument ${args[0]} is not valid.`);
}
