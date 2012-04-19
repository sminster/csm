

HEADERS=CSMCovarianceModel.h CSMFourParameterCorrelationModel.h CSMError.h CSMImageSupportData.h CSMISDByteStream.h CSMISDNITF.h CSMMisc.h CSMModel.h CSMParameterSharing.h CSMPlugin.h CSMSensorModel.h CSMSensorTypeAndMode.h CSMWarning.h CSMVersion.h

OBJS=CSMPlugin.o CSMFourParameterCorrelationModel.o CSMVersion.o

LIBNAME=libcsmapi
LIBVERSION=3

LIBRARY=$(LIBNAME).so.$(LIBVERSION)
LIBS=-lm -ldl

MKDIR=mkdir
CP=cp -f
LN=ln -s
TAR=tar

LD=$(CC)

%.o: %.cpp
	$(CC) -c $(COPTS) $< -o $@

%.o: %.cc
	$(CC) -c $(COPTS) $< -o $@

$(LIBRARY): $(OBJS)
	$(LD) $(COPTS) $(LDOPTS) $^ $(LIBS) -o $@

all: $(LIBRARY)

install::
	$(MKDIR) -p $(INSTDIR)/lib
	$(CP) $(LIBRARY) $(INSTDIR)/lib
	$(RM) $(INSTDIR)/lib/$(LIBNAME).so && $(LN) $(LIBRARY) $(INSTDIR)/lib/$(LIBNAME).so
	$(MKDIR) -p $(INSTDIR)/include/csm
	$(CP) $(HEADERS) $(INSTDIR)/include/csm

clean::
	$(RM) $(OBJS) $(LIBRARY) *~

package::
	$(TAR) -czvf csm-reform.$(shell date '+%Y%m%d').tar.gz Makefile* CSM*
