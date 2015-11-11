
import com.vasileff.ceylon.xmath.float {
    sin
}

shared void run() {
    value [ctx, w, h] = createCanvas();
    
    void clear() {
        ctx.fillStyle = "#000";
        ctx.fillRect(0,0,w,h);
    }
    clear();
    
    function remainder(Float x, Integer i)
        => (x/i).fractionalPart * i;

    value graphs = [
        ["red", sin],
        ["green", 
         (Float x) => 2.0 - (remainder(x,8)-4).magnitude],
        ["blue", 
         (Float x) => 3.0 * sin(x/12)^2 * sin(x)]
    ].indexed;
    
    variable value x = 0;
    void do() {
        x = (x+1) % w;
        if (x == 0) {
            clear();
        }
        for (i->[color, f] in graphs) {
            value y = 
                f(75.0 * x / w) * h/40 
                    + h/3 * (i+0.5);
            ctx.fillStyle = color;
            ctx.fillRect(x, y, 3, 3);
        }
    }

    dynamic {
        dynamic id = setInterval(do, 1);
    }
}


[CanvasRenderingContext2D, Integer, Integer]
createCanvas() {
    dynamic {
        dynamic canvas = document.getElementById("graph");
        Integer w = canvas.scrollWidth;
        Integer h = canvas.scrollHeight;
        canvas.width = w;
        canvas.height = h;
        CanvasRenderingContext2D ctx 
            = canvas.getContext("2d");
        return [ctx, w, h];
    }
}

