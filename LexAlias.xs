/*	$Id$	*/

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

/* cargo-culted from PadWalker */

MODULE = Devel::LexAlias                PACKAGE = Devel::LexAlias

void
_lexalias(SV* cv_ref, char *name, SV* new_rv)
  CODE:
{
    CV *cv   = SvROK(cv_ref) ? (CV*) SvRV(cv_ref) : NULL;
    AV* padn = cv ? (AV*) AvARRAY(CvPADLIST(cv))[0] : PL_comppad_name;
    AV* padv = cv ? (AV*) AvARRAY(CvPADLIST(cv))[1] : PL_comppad;
    SV* new_sv;
    I32 i;

    if (!SvROK(new_rv)) croak("ref is not a reference");
    new_sv = SvRV(new_rv);

    for (i = 0; i <= av_len(padn); ++i) {
        SV** name_ptr = av_fetch(padn, i, 0);
        if (name_ptr) {
            SV* name_sv = *name_ptr;
            
            if (SvPOKp(name_sv)) {
                char *name_str = SvPVX(name_sv);

                if (!strcmp(name, name_str)) {
                    SV* old_sv = (SV*) av_fetch(padv, i, 0);
                    av_store(padv, i, new_sv);
                    SvREFCNT_inc(new_sv);
                }
            }
        }
    }
}
