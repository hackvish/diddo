define(["dojo/_base/declare","dijit/_WidgetBase", "dojox/rpc/Rest"], 
		function(declare,_WidgetBase, Rest) {
	return(declare("DiddoRestAPI", [], {
		serviceURL: null,
		service: null,
		
		constructor: function(serviceName) {
			this.inherited(arguments);
			if(arguments.length == 0 || !serviceName || serviceName.length <= 0) {
				console.error("Invalid service Name");
				this.help();
				return;
			}
			if(serviceName[serviceName.length-1] != '/')
				serviceName += "/";
			this.serviceURL = serviceName;
			this.service = Rest(this.serviceURL, true);
		},
		
		help: function() {
			console.log("Usage: ");
			console.log("var service = new custom.DiddoRestAPI(\"users\")");
			console.log("Get a resource: service.getItem(userId, callbackFunc [, errback])");
			console.log("Get a resource: service.getItems(callbackFunc [, errback])");
			console.log("Edit a resource: service.updateItem([name|id], {properties}, callbackFunc [, errback])");
			console.log("Edit a resource: service.addItem([name|id], {properties}, callbackFunc [, errback])");
		},
		
		getItem: function(id, callback, errback) {
			this.service(id).then(callback || this.defaultCallback, errback || this.showError);
		},
		
		getItems: function(callback, errback) {
			this.service().then(callback || this.defaultCallback, errback || this.showError);
		},
		
		updateItem: function(name, params, callback, errback) {
			this.service.put(name, params).then(callback || this.defaultCallback, errback || this.showError);
		},
		
		addItem: function(name, params, callback, errback) {
			this.service.post(name, params).then(callback || this.defaultCallback, errback || this.showError);
		},
		
		defaultCallback: function(response) {
			console.log(response);
		},
		
		showError: function(error) {
			console.error(error);
		}
	}));
});