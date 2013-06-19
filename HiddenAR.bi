/**
 * Simplest possible Linear Gaussian model.
 * 
 * @author Pierre Jacob <pierre.jacob.work@gmail.com>
 * $Rev$
 * $Date$
 */
 
/*
 * This is a simple linear Gaussian model 
 * with only one parameter, specifying 
 * the AR coefficient of the hidden process
 * 
 * (v_k, w_k)_{k} are iid std Normal variables
 * x_0 = v_0
 * x_t = rho * x_{t-1} + v_t
 * y_t = x_t + w_t
 */ 
 
model HiddenAR {

  param rho
  state X
  obs Y
  noise eps
  
  sub parameter {
    rho ~ uniform(0.0, 1.0)
  }
  
  sub proposal_parameter {
    rho ~ gaussian(rho, 0.1);
  }

  sub initial {
    X ~ gaussian(0.0, 1)
  }

  sub transition(delta = 1.0) {
    eps ~ gaussian(0, 1)
    X <- rho*X + eps
  }

  sub observation {
    Y ~ gaussian(X, 1)
  }
}

