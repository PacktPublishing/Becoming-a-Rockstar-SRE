import http from 'k6/http';
import { sleep } from 'k6';

export const options = {
  vus: 1,
  duration: '30s',
};

export default function () {
  http.get(`http://${__ENV.GKE_ALB_IP}:${__ENV.GKE_ALB_PORT}`);
  sleep(1);
}