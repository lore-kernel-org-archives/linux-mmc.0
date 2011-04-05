From: John Calixto <john.calixto@modsystems.com>
Subject: Re: [PATCH v2 2/2] mmc: Check CAP_SYS_ADMIN for destructive ioctl
 ACMDs
Date: Tue, 5 Apr 2011 16:40:59 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1104051613150.25803@peruna>
References: <alpine.DEB.2.00.1104051458350.25803@peruna> <BANLkTi=xcPEJxophfymqF5+Nd=aF40H=FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811328-2048722079-1302045759=:25803"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from elasmtp-masked.atl.sa.earthlink.net ([209.86.89.68]:47303 "EHLO
	elasmtp-masked.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751859Ab1DEXlR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Apr 2011 19:41:17 -0400
In-Reply-To: <BANLkTi=xcPEJxophfymqF5+Nd=aF40H=FQ@mail.gmail.com>
Content-ID: <alpine.DEB.2.00.1104051627560.25803@peruna>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811328-2048722079-1302045759=:25803
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1104051627561.25803@peruna>

On Tue, 5 Apr 2011, Andrei Warkentin wrote:
> On Tue, Apr 5, 2011 at 4:59 PM, John Calixto
> <john.calixto@modsystems.com> wrote:
> > Some ACMDs might actually damage the card. =A0This check ensures the
> > caller has CAP_SYS_ADMIN before allowing such an activity.
> >
> > Signed-off-by: John Calixto <john.calixto@modsystems.com>
> > ---
> > =A0drivers/mmc/card/block.c | =A0 29 +++++++++++++++++++++++++++++
> > =A01 files changed, 29 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> > index c2e107c..2ed8c57 100644
> > --- a/drivers/mmc/card/block.c
> > +++ b/drivers/mmc/card/block.c
> > @@ -31,6 +31,7 @@
> > =A0#include <linux/mutex.h>
> > =A0#include <linux/scatterlist.h>
> > =A0#include <linux/string_helpers.h>
> > +#include <linux/capability.h>
> > =A0#include <linux/compat.h>
> > =A0#include <linux/delay.h>
> >
> > @@ -205,6 +206,34 @@ static int mmc_blk_ioctl_acmd(struct block_device =
*bdev,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto acmd_done;
> > =A0 =A0 =A0 =A0}
> >
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* The following ACMDs are known to be nondestructive. =
=A0They are used
> > + =A0 =A0 =A0 =A0* by SD security applications (ref: SD Specifications,=
 Part 1,
> > + =A0 =A0 =A0 =A0* Physical Layer Simplified Specification, Version 3.0=
1, Table 4-27).
> > + =A0 =A0 =A0 =A0* Any other commands require CAP_SYS_ADMIN because the=
y may destroy
> > + =A0 =A0 =A0 =A0* the card.
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 switch (sdic.opcode) {
> > + =A0 =A0 =A0 case SD_APP_SD_STATUS:
> > + =A0 =A0 =A0 case 18:
> > + =A0 =A0 =A0 case 25:
> > + =A0 =A0 =A0 case 26:
> > + =A0 =A0 =A0 case 38:
> > + =A0 =A0 =A0 case 43:
> > + =A0 =A0 =A0 case 44:
> > + =A0 =A0 =A0 case 45:
> > + =A0 =A0 =A0 case 46:
> > + =A0 =A0 =A0 case 47:
> > + =A0 =A0 =A0 case 48:
> > + =A0 =A0 =A0 case 49:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > + =A0 =A0 =A0 default:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!capable(CAP_SYS_ADMIN)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EPERM;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto acmd_done;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > + =A0 =A0 =A0 }
> > +
> > =A0 =A0 =A0 =A0cmd.opcode =3D sdic.opcode;
> > =A0 =A0 =A0 =A0cmd.arg =3D sdic.arg;
> > =A0 =A0 =A0 =A0cmd.flags =3D sdic.flags;
> > --
> > 1.7.4.1
>=20
> Hi John,
>=20
> Just to clarify, were the commands supposed to exclude commands that do w=
rites?
>=20
> In MMC-land:
> CMD18 is PROGRAM_CID (which is a once-in-a-lifetime operation).
> CMD38 is erase
> CMD25 is write_multiple_block - this can give a non-root user full
> control over a disk, bypassing security.

Hi Andrei,

I have CMD18 as READ_MULTIPLE_BLOCK...  Regardless, this ioctl is
specifically for ACMD opcodes (application-specific; preceeded by
CMD55), not CMD opcodes.

>=20
> You should definitely check if the the target device is MMC or SD.
> Because the MMC and SD have slightly differing command sets.
>=20

Given that this patch is a conservative opcode filter (it demands
CAP_SYS_ADMIN for all opcodes *except* those listed explicitly), do you
think I still need to add another check for SD vs. MMC?

John
---1463811328-2048722079-1302045759=:25803--
