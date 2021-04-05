import { Router } from 'express';

import UserController from './app/controllers/UserController';
import AddressController from './app/controllers/AddressController';


const routes = new Router();

routes.post('/users', UserController.store);
routes.put('/users', UserController.update);


export default routes;