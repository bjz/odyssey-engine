module odyssey.util.gl3;

import odyssey.util.prettyout;
import std.stdio, std.conv;

public import derelict.opengl3.gl3;

class OpenGLException : Exception {
    this(string message1 = "", string message2 = "") {
        super(errorString(message1) ~ message2);
    }
}

void writeGLError(string file = __FILE__, int line = __LINE__) {
    GLenum glError = glGetError();
    if (glError != GL_NO_ERROR) {
        writefln("%s %s in %s + %d", errorString("OpenGL Error:"),
            glErrorString(glError), file, line);
        
        // abit of a hack - prints the stack trace.
        try 
            throw new OpenGLException();
        catch (Exception e)
            writeln(e.info);
    }
}

void writeGLInfo() {
    if (!DerelictGL3.isLoaded()) {
        writefln(errorString("DerelictGL3 is not loaded!"));
        return;
    }

    // Print OpenGL and GLSL version
    writefln(headingString("OpenGL"));
    writefln("Vendor:   %s", to!string(glGetString(GL_VENDOR)));
    writefln("Renderer: %s", to!string(glGetString(GL_RENDERER)));
    writefln("Version:  %s", to!string(glGetString(GL_VERSION)));
    writefln("GLSL:     %s", to!string(glGetString(GL_SHADING_LANGUAGE_VERSION)));
    writeln();
}

pure string glErrorString(GLenum glError) {
    switch(glError) {
        case GL_NO_ERROR:
            return "GL_NO_ERROR";
            
        case GL_INVALID_ENUM:
            return "GL_INVALID_ENUM";
            
        case GL_INVALID_VALUE:
            return "GL_INVALID_VALUE";
            
        case GL_INVALID_OPERATION:
            return "GL_INVALID_OPERATION";
            
        case GL_INVALID_FRAMEBUFFER_OPERATION:
            return "GL_INVALID_FRAMEBUFFER_OPERATION";
            
        case GL_OUT_OF_MEMORY:
            return "GL_OUT_OF_MEMORY";
            
        default:
            return "Unknown Error";
    }
}