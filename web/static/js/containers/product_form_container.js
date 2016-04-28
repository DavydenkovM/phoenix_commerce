import React                   from 'react';
import ProductForm             from '../components/product_form';
import { Link }                from 'react-router';
import { connect }             from 'react-redux';
import Actions                 from '../actions/products';
import * as form_actions            from 'redux-form';
import {httpGet, httpPost, httpPostForm} from '../utils';

class ProductFormContainer extends React.Component {
  _handleSubmit(values) {
    return new Promise((resolve, reject) => {
      // let data = JSON.parse(this.stringify(values));
      let form_data = new FormData();

      Object.keys(values).forEach((key) => {
        let obj = values[key];

        if (values[key] instanceof FileList) {
          form_data.append(`product[${key}]`, values[key][0], values[key][0].name);
        } else {
          form_data.append(`product[${key}]`, values[key]);
        }
      });

      httpPostForm(`/api/products/`, form_data)
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
    // if (value instanceof FileList) {
    //   return Array.from(value).map(file => file.name).join(', ') || 'No Files Selected';
    // }
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
