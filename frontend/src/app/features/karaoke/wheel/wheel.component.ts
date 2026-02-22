import { AfterViewInit, Component, ElementRef, ViewChild,  } from "@angular/core";

@Component({
    selector: "app-wheel",
    templateUrl: "wheel.component.html",
})



export class Wheel implements AfterViewInit{

    //angular no le gusta getelementbyid ,ejeje
    @ViewChild("wheel")
    canvas! : ElementRef<HTMLCanvasElement>

    private ctx! : CanvasRenderingContext2D;

    //se ejecuta cuando se renderiza el html
    ngAfterViewInit(): void {
        const canvas = this.canvas.nativeElement;
        canvas.width = 200;
        canvas.height = 200;
        const context =  canvas.getContext("2d");

        if(!context){
            console.error("Contexto nulo");
            return;
        }
        this.ctx = context;
        this.draw();
    }

    public draw(){
        if(!this.ctx)return ;
        let paint  = this.ctx;
        paint.beginPath();
        paint.strokeStyle = "blue";
        paint.moveTo(20,20);
        paint.lineTo(200,20);
        paint.stroke();
    }

}