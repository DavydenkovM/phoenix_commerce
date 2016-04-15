import React                   from 'react';
import ProductForm             from '../components/product_form';
import { Link }                from 'react-router';
import { connect }             from 'react-redux';
import Actions                 from '../actions/products';
import * as form_actions            from 'redux-form';
import {httpGet, httpPost} from '../utils';

class ProductFormContainer extends React.Component {
  _handleSubmit(values) {
    return new Promise((resolve, reject) => {
      httpPost(`/api/products/`,
          {product: JSON.parse(this.stringify(values))})
      .then((response) => {
        resolve();
      })
      .catch((error) => {
        error.response.json()
        .then((json) => {
          let responce = {};
          Object.keys(json.errors).map((key) => {
            Object.assign(responce, {[key] : json.errors[key]});
          });

          if (json.errors) {
            reject({...responce, _error: 'Login failed!'});
          } else {
            reject({_error: 'Something went wrong!'});
          };
        });
      });
    });
  }

  replacer(key, value) {
    if (value instanceof FileList) {
      return Array.from(value).map(file => file.name).join(', ') || 'No Files Selected';
    }
    return value;
  }

  stringify(values) {
    return JSON.stringify(values, this.replacer, 1);
  }

  render() {
    const { products } = this.props;

    return (
      <div>
        <h2> New product </h2>

        <ProductForm title="Add product" onSubmit={::this._handleSubmit} />

        <Link to='/admin/products'> Back </Link>
      </div>
    );
  }
}

export default connect()(ProductFormContainer);
