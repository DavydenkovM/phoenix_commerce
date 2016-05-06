import { IndexRoute, Route }        from 'react-router';
import React                        from 'react';
import ProductContainer            from '../containers/product_container';
import ProductsContainer            from '../containers/products_container';
import ProductFormContainer         from '../containers/product_form_container';

export default function configRoutes() {
  return (
    <Route>
      <Route path="/admin">
        <Route path="products" component={ProductsContainer} />
        <Route path="products/new" component={ProductFormContainer} />
        <Route path="products/:id" component={ProductContainer} />
        <Route path="products/:id/edit" component={ProductFormContainer} />
      </Route>
    </Route>
  );
}
