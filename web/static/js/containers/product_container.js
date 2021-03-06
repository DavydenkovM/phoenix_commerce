import React                    from 'react';
import ProductItem              from '../components/product_item';
import { Link }                 from 'react-router';
import { connect }              from 'react-redux';
import Actions                  from '../actions/products';


class ProductContainer extends React.Component {
  componentWillMount() {
    this.props.dispatch(Actions.getProduct(this.props.params.id));
  }

  render() {
    const { product } = this.props.product;

    return (
      <div>
        <h2>Product Info</h2>

        <ProductItem
          key={product.id}
          product={product}
          onAddToCartClicked={() => this.props.addToCart(product.id)}
        />

        <Link to='/admin/products'> Back </Link>
      </div>
    );
  }
}

const mapStateToProps = (state, ownProps) => ({
  product: state.product
})

export default connect(mapStateToProps)(ProductContainer);
