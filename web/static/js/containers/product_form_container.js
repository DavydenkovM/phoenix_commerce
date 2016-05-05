import React                   from 'react';
import ProductForm             from '../components/product_form';
import { Link }                from 'react-router';
import { connect }             from 'react-redux';
import Actions                 from '../actions/products';
import * as form_actions            from 'redux-form';
import {httpGet, httpPost, httpPostForm, handleError} from '../utils';

class ProductFormContainer extends React.Component {
  handleSubmit(values) {
    return new Promise((resolve, reject) => {
      httpPostForm(`/api/products/`, this.form_data(values))
      .then((response) => {
        console.log('success');
        return resolve();
      })
      .catch((error) => {
        console.log('error');
        return handleError(error, reject)
      });
    });
  }

  form_data(values) {
    let form_data = new FormData();

    Object.keys(values).forEach((key) => {
      if (values[key] instanceof FileList) {
        form_data.append(`product[${key}]`, values[key][0], values[key][0].name);
      } else {
        form_data.append(`product[${key}]`, values[key]);
      }
    });

    return form_data;
  }

  render() {
    const { products } = this.props;

    return (
      <div>
        <h2> New product </h2>

        <ProductForm title="Add product" onSubmit={::this.handleSubmit} />

        <Link to='/admin/products'> Back </Link>
      </div>
    );
  }
}

export default connect()(ProductFormContainer);
