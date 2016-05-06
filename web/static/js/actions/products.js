import Constants  from '../constants';
import {httpGet, httpPost} from '../utils';

const Actions = {
  getProduct: (id) => {
    return dispatch => {
      httpGet(`/api/products/${id}`)
      .then((data) => {
        dispatch({
          type: Constants.FETCH_PRODUCT,
          product: data,
        });
      });
    };
  },

  getProducts: () => {
    return dispatch => {
      httpGet(`/api/products/`)
      .then((data) => {
        dispatch({
          type: Constants.FETCH_PRODUCTS,
          products: data,
        });
      });
    };
  },

  submitProduct: (payload) => {
    return dispatch => {
      httpPost(`/api/products/`, 
               {product: { ...payload }})
      .then((response) => {
        dispatch({
          type: Constants.CREATE_PRODUCT,
          response
        });
      });
    }
  }
};

export default Actions;
