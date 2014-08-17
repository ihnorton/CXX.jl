require("../src/CXX.jl")

const qtincdir = "/usr/include/qt5"
const qtlibdir = "/usr/lib/x86_64-linux-gnu/"

const QtWidgets = joinpath(qtincdir,"QtWidgets/")

defineMacro("__linux")

addHeaderDir(qtincdir, kind = C_System)
addHeaderDir(QtWidgets, kind = C_System)

dlopen(joinpath(qtlibdir,"libQt5Core.so"))
dlopen(joinpath(qtlibdir,"libQt5Gui.so"))

cxxinclude("QApplication", isAngled=true)
#cxxinclude("QtGui/qmessagebox.h")


x = Ptr{Uint8}[pointer("julia"),C_NULL]
app = @cxx QApplication(int32(0),pointer(x))

#@cxx QMessageBox::about(cast(C_NULL,pcpp"QWidget"), pointer("Hello World"), pointer("This is a QMessageBox!"))

@cxx app->exec()
