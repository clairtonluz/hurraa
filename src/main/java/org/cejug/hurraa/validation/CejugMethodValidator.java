/*
* This file is part of Hurraa.
*
* Hurraa is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* Hurraa is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with Hurraa. If not, see http://www.gnu.org/licenses/gpl-3.0.html.
*
*/
package org.cejug.hurraa.validation;

import java.util.Iterator;
import java.util.Locale;

import javax.enterprise.context.ApplicationScoped;
import javax.enterprise.inject.Specializes;
import javax.inject.Inject;
import javax.validation.ConstraintViolation;
import javax.validation.MessageInterpolator;
import javax.validation.Path.Node;
import javax.validation.Path.ParameterNode;

import br.com.caelum.vraptor.http.ValuedParameter;
import br.com.caelum.vraptor.validator.beanvalidation.MethodValidator;

import com.google.common.base.Joiner;

@Specializes
@ApplicationScoped
public class CejugMethodValidator extends MethodValidator {
	
	@Deprecated
	protected CejugMethodValidator() {
		this(null, null, null);
	}

	@Inject
	public CejugMethodValidator(Locale locale, MessageInterpolator interpolator, javax.validation.Validator bvalidator) {
		super(locale , interpolator, bvalidator);
	}
	
	@Override
	protected String extractCategory(ValuedParameter[] params, ConstraintViolation<Object> violation) {
		Iterator<Node> node = violation.getPropertyPath().iterator();
		int index =  getFirstParameterIndex( node );  
		node = violation.getPropertyPath().iterator();// Reset the interator
		return mountCategory( node ).replace( "arg" + index , params[index].getName() );
	}
	
	private String mountCategory( Iterator<Node> node ){
		ignoreMethodName( node );
		return Joiner.on(".").join( node );
	}
	
	private void ignoreMethodName( Iterator<Node> node ){
		node.next(); 
	}
	
	private int getFirstParameterIndex( Iterator<Node> node ){
		ignoreMethodName( node );
		ParameterNode parameterNode = node.next().as(ParameterNode.class);
		return parameterNode.getParameterIndex();
	}
	
}
