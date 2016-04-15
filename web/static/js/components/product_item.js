import React, { Component, PropTypes } from 'react'
import Product from './product'

export default class ProductItem extends Component {
  render() {
    const { product } = this.props
    const { price, quantity, name, description } = product

    return (
      <li style={{ marginBottom: 20 }}>
        <Product
          name={name}
          description={name}
          image={name}
          price={price} 
        />
      </li>
    )
  }
}

ProductItem.propTypes = {
  product: PropTypes.shape({
    name: PropTypes.string.isRequired,
    price: PropTypes.string.isRequired
  }).isRequired,
  onAddToCartClicked: PropTypes.func.isRequired
}
