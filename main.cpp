#include "ay_application.h"

int main(int argc, char *argv[])
{
    int status ;
    AtApplication app(argc, argv);
    status = app.exec();
    return status;
}
