module test.main;

import odyssey.core.application;
import odyssey.geom.vertexarray;
import odyssey.render.shader;
import odyssey.math.vec3;

import std.stdio, std.string;
import derelict.glfw3.glfw3;
import derelict.opengl3.gl3;

void main() {
    auto game = new Game();
    game.run();
}

class Game : Application {
    
    // 4D positions of the verticies
    Vec3 vertices[] = [
        { 0.75,  0.75,  0.0 },
        { 0.75, -0.75,  0.0 },
        {-0.75, -0.75,  0.0 }
    ];
    
    // The handle for the shader program
    ShaderProgram shader;
    VertexArray triangle;
    
    void onInit() {
        shader = new ShaderProgram("resources/shader.vert", "resources/shader.frag");
        triangle = new VertexArray(vertices, shader);
    }
    
    void onRender() {
        // Clear the window
        glClear(GL_COLOR_BUFFER_BIT);
        
        triangle.draw();
        
    }
    
    void onCleanup() {
        shader.unload();
    }
    
}