From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 4/8] MMC: add DMA support to tmio_mmc driver, when used
 on  SuperH
Date: Thu, 22 Apr 2010 11:51:03 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1004221139270.4655@axis700.grange>
References: <Pine.LNX.4.64.1004211715050.5292@axis700.grange>
 <Pine.LNX.4.64.1004211733400.5292@axis700.grange>
 <n2saec7e5c31004211712t9441f0r50950ec918bea2e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <n2saec7e5c31004211712t9441f0r50950ec918bea2e3@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Ian Molton <ian@mnementh.co.uk>
List-Id: linux-mmc@vger.kernel.org

On Wed, 21 Apr 2010, Magnus Damm wrote:

> Hi Guennadi,
>=20
> On Wed, Apr 21, 2010 at 11:37 AM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > SDHI controllers on SuperH, served by the tmio_mmc driver, can use =
slave DMA
> > for data transfer. This patch adds support for the dmaengine API to=
 tmio_mmc
> > and the necessary interfacing to the sh_mobile_sdhi MFD driver.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> >
> > It could be further broken down into MMC and MFD parts if required,=
 I
> > think.
> >
> > =A0drivers/mfd/sh_mobile_sdhi.c =A0 =A0 =A0 | =A0 25 +++-
> > =A0drivers/mmc/host/tmio_mmc.c =A0 =A0 =A0 =A0| =A0346 ++++++++++++=
++++++++++++++++++++----
> > =A0drivers/mmc/host/tmio_mmc.h =A0 =A0 =A0 =A0| =A0 11 ++
> > =A0include/linux/mfd/sh_mobile_sdhi.h | =A0 =A03 +
> > =A0include/linux/mfd/tmio.h =A0 =A0 =A0 =A0 =A0 | =A0 10 +
> > =A05 files changed, 359 insertions(+), 36 deletions(-)
>=20
> [snip]
>=20
> > diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mm=
c.c
> > index b2b577f..fafd8c9 100644
> > --- a/drivers/mmc/host/tmio_mmc.c
> > +++ b/drivers/mmc/host/tmio_mmc.c
> > @@ -29,12 +29,21 @@
> > =A0#include <linux/irq.h>
> > =A0#include <linux/device.h>
> > =A0#include <linux/delay.h>
> > +#include <linux/dmaengine.h>
> > =A0#include <linux/mmc/host.h>
> > =A0#include <linux/mfd/core.h>
> > =A0#include <linux/mfd/tmio.h>
> >
> > =A0#include "tmio_mmc.h"
> >
> > +static void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool e=
nable)
> > +{
> > +#if defined(CONFIG_SUPERH) || defined(CONFIG_ARCH_SHMOBILE)
> > + =A0 =A0 =A0 /* Switch DMA mode on or off - SuperH specific? */
> > + =A0 =A0 =A0 sd_ctrl_write16(host, 0xd8, enable ? 2 : 0);
> > +#endif
> > +}
> > +
>=20
> Uhh.. #ifdefs. =3D)

Yeah, I know. But that's the only location in the patch and...

> Can't this register setting be implented in the SDHI driver?

I'm awaiting comments from Ian, maybe other tmio users. Maybe this=20
register is generic, even though I don't see any other tmio-containing=20
chips implementing DMA.

> In general I realize that you need to extend the logic in the tmio_mm=
c
> driver quite a bit to implement DMA support, but I wonder if it is
> possible to extend the tmio_mmc driver with callbacks and use them to
> hook in the DMA code?

As you see, this is all generic dmaengine API, nothing SH-specific. The=
=20
only SH-specific part is filtering of channels, and that's hidden in SH=
=20
platform code and passed as cookies to tmio. And if DMA is not used, al=
l=20
that code just remqins inactive.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
=46reelance Open-Source Software Developer
http://www.open-technology.de/
