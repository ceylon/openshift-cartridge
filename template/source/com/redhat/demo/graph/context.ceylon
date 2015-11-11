alias Number => Integer|Float;

"Ascribes static types to the operations of the HTML 
 canvas context. Note that this is not necessary, 
 since we could access the canvas in a dynamic block, 
 but it makes the code more typesafe."
dynamic CanvasRenderingContext2D {
    
    shared formal variable String fillStyle;
    shared formal variable String strokeStyle;
    shared formal variable Number lineWidth;
    shared formal variable String font;

    shared formal void beginPath();
    shared formal void closePath();

    shared formal void moveTo(Number x, Number y);
    shared formal void lineTo(Number x, Number y);

    shared formal void fill();
    shared formal void stroke();

    shared formal void fillText(String text, Number x, Number y, Number maxWidth=-1);

    shared formal void arc(Number x, Number y, Number radius, Number startAngle, Number endAngle, Boolean anticlockwise);
    shared formal void arcTo(Number x1, Number y1, Number x2, Number y2, Number radius);

    shared formal void bezierCurveTo(Number cp1x, Number cp1y, Number cp2x, Number cp2y, Number x, Number y);

    shared formal void strokeRect(Number x, Number y, Number width, Number height);
    shared formal void fillRect(Number x, Number y, Number width, Number height);
    shared formal void clearRect(Number x, Number y, Number width, Number height);

    //TODO: more operations!!
}

