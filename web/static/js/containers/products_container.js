import React                    from 'react';
import ProductsList             from '../components/products_list';
import ProductItem              from '../components/product_item';
import { Link }                 from 'react-router';
import { connect }              from 'react-redux';
import Actions                  from '../actions/products';


class ProductsContainer extends React.Component {
  componentWillMount() {
    this.props.dispatch(Actions.getProducts());
  }

  render() {
    const { products } = this.props;

    return (
      <div>
        <h2>Listing products</h2>

        <ProductsList title="Products">
          {products.items.map(p =>
            <ProductItem
              key={p.id}
              product={p}
              onAddToCartClicked={() => this.props.addToCart(p.id)}
            />
          )}
        </ProductsList>

        <Link to='/admin/products/new'> New product </Link>
      </div>
    );
  }
}

const mapStateToProps = (state, ownProps) => ({
  products: state.products
})

export default connect(mapStateToProps)(ProductsContainer);
