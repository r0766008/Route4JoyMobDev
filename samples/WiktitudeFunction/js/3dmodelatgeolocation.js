var World = {

    init: function initFn() {
        this.createModelAtLocation();
    },

    createModelAtLocation: function createModelAtLocationFn() {
        var location;
        if (Math.floor(Math.random() * 2) == 0) {
            if (Math.floor(Math.random() * 2) == 0) location = new AR.RelativeLocation(null, -Math.abs(Math.floor(Math.random() * 150) + 100), -Math.abs(Math.floor(Math.random() * 150) + 100));
            else location = new AR.RelativeLocation(null, -Math.abs(Math.floor(Math.random() * 150) + 100), Math.floor(Math.random() * 150) + 100);
        } else {
            if (Math.floor(Math.random() * 2) == 0) location = new AR.RelativeLocation(null, Math.floor(Math.random() * 150) + 100, -Math.abs(Math.floor(Math.random() * 150) + 100));
            else location = new AR.RelativeLocation(null, Math.floor(Math.random() * 150) + 100, Math.floor(Math.random() * 150) + 100);
        }

        var modelQuestion = new AR.Model("assets/question-mark.wt3", {
            onError: World.onError,
            scale: {
                x: 0.015,
                y: 0.015,
                z: 0.015
            }
        });

        modelQuestion.onClick = function () {
            AR.platform.sendJSONObject({
                "image_clicked": ""
            });
        };

        this.geoObject = new AR.GeoObject(location, {
            drawables: {
                cam: modelQuestion,
            }
        });

        
        this.idleAnimation = new AR.PropertyAnimation(modelQuestion, 'rotate.y', 1, 359, 3000);
        this.idleAnimation.start(-1);
    },

    onError: function onErrorFn(error) {
        alert(error);
    }
};

World.init();