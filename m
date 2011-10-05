From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2] PM: HIBERNATION: add resume_wait param to support MMC-like devices as resume file
Date: Wed, 5 Oct 2011 22:49:03 +0200
Message-ID: <201110052249.03653.rjw@sisk.pl>
References: <1317309357-3871-1-git-send-email-21cnbao@gmail.com> <201110050032.49837.rjw@sisk.pl> <CAGsJ_4zo6-bdcj4w-RuFhXTjQByp1BM_q5994=J3V5Oej6JRtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:50264 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755988Ab1JEUqq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Oct 2011 16:46:46 -0400
In-Reply-To: <CAGsJ_4zo6-bdcj4w-RuFhXTjQByp1BM_q5994=J3V5Oej6JRtg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: pavel@ucw.cz, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Barry Song <baohua.song@csr.com>, linux-kernel@vger.kernel.org, frank.hofmann@tomtom.com, workgroup.linux@csr.com, linux-pm@lists.linux-foundation.org

On Wednesday, October 05, 2011, Barry Song wrote:
> =E5=9C=A8 2011-10-5 =E4=B8=8A=E5=8D=886:30=EF=BC=8C"Rafael J. Wysocki=
" <rjw@sisk.pl>=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Thursday, September 29, 2011, Barry Song wrote:
> > > From: Barry Song <baohua.song@csr.com>
> > >
> > > Some devices like mmc are async detected very slow. For example,
> > > drivers/mmc/host/sdhci.c launchs a 200ms delayed work to detect
> > > mmc partitions then add disk.
> > >
> > > we do have wait_for_device_probe and scsi_complete_async_scans
> > > before calling swsusp_check, but it is not enough to wait mmc.
> > >
> > > This patch adds resumewait kernel param just like rootwait so
> > > that we have enough time to wait mmc ready. The differene is
> > > here we wait for resume partition but rootwait waits for rootfs
> > > partition.
> > >
> > > This patch will make swsusp support many embedded products
> > > without scsi devices but devices like mmc.
> > >
> > > This was tested on one ARM platform with Frank Hofmann's patch.
> > >
> > > Signed-off-by: Barry Song <Baohua.Song@csr.com>
> > > Reviewed-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> >
> > Sorry, I couldn't find the patch previously.
> >
> > I only have one question.  Namely, are there any systems that would
> > use resumewait and wouldn't use rootwait?
>=20
> I think yes. Some devices use nand
> as root and SD as resume swap.
> Still some devices use both SD as root and swap. But rootfs is mounte=
d by
> ramfs without rootwait.

OK, fair enough.  I applied the patch to linux-pm/linux-next and will p=
ush
it for 3.2.

Thanks,
Rafael


> > > ---
> > >  -v2:
> > >  add document for the resumewait kernel parameter
> > >
> > >  Documentation/kernel-parameters.txt |    4 ++++
> > >  kernel/power/hibernate.c            |   16 ++++++++++++++++
> > >  2 files changed, 20 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/Documentation/kernel-parameters.txt
> b/Documentation/kernel-parameters.txt
> > > index 614d038..2aed0d2 100644
> > > --- a/Documentation/kernel-parameters.txt
> > > +++ b/Documentation/kernel-parameters.txt
> > > @@ -2237,6 +2237,10 @@ bytes respectively. Such letter suffixes c=
an also
> be entirely omitted.
> > >                       in <PAGE_SIZE> units (needed only for swap =
files).
> > >                       See  Documentation/power/swsusp-and-swap-fi=
les.txt
> > >
> > > +     resumewait      [HIBERNATION] Wait (indefinitely) for resum=
e
> device to show up.
> > > +                     Useful for devices that are detected
> asynchronously
> > > +                     (e.g. USB and MMC devices).
> > > +
> > >       hibernate=3D      [HIBERNATION]
> > >               noresume        Don't check if there's a hibernatio=
n image
> > >                               present during boot.
> > > diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> > > index 8f7b1db..9f4b4f3 100644
> > > --- a/kernel/power/hibernate.c
> > > +++ b/kernel/power/hibernate.c
> > > @@ -14,6 +14,7 @@
> > >  #include <linux/reboot.h>
> > >  #include <linux/string.h>
> > >  #include <linux/device.h>
> > > +#include <linux/async.h>
> > >  #include <linux/kmod.h>
> > >  #include <linux/delay.h>
> > >  #include <linux/fs.h>
> > > @@ -31,6 +32,7 @@
> > >
> > >  static int nocompress =3D 0;
> > >  static int noresume =3D 0;
> > > +static int resume_wait =3D 0;
> > >  static char resume_file[256] =3D CONFIG_PM_STD_PARTITION;
> > >  dev_t swsusp_resume_device;
> > >  sector_t swsusp_resume_block;
> > > @@ -732,6 +734,13 @@ static int software_resume(void)
> > >                * to wait for this to finish.
> > >                */
> > >               wait_for_device_probe();
> > > +
> > > +             if (resume_wait) {
> > > +                     while ((swsusp_resume_device =3D
> name_to_dev_t(resume_file)) =3D=3D 0)
> > > +                             msleep(10);
> > > +                     async_synchronize_full();
> > > +             }
> > > +
> > >               /*
> > >                * We can't depend on SCSI devices being available =
after
> loading
> > >                * one of their modules until scsi_complete_async_s=
cans()
> is
> > > @@ -1060,7 +1069,14 @@ static int __init noresume_setup(char *str=
)
> > >       return 1;
> > >  }
> > >
> > > +static int __init resumewait_setup(char *str)
> > > +{
> > > +     resume_wait =3D 1;
> > > +     return 1;
> > > +}
> > > +
> > >  __setup("noresume", noresume_setup);
> > >  __setup("resume_offset=3D", resume_offset_setup);
> > >  __setup("resume=3D", resume_setup);
> > >  __setup("hibernate=3D", hibernate_setup);
> > > +__setup("resumewait", resumewait_setup);
> > >
> >
>=20

