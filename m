From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] libertas/sdio: set ECSI and SCSI bits for 1-bit
 transfers
Date: Wed, 31 Mar 2010 15:34:14 +0200
Message-ID: <20100331133414.GI30807@buzzloop.caiaq.de>
References: <1269970733-24681-1-git-send-email-daniel@caiaq.de>
 <y2q703729f11003310123w505134f8y61efb0c9f7168a30@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:43594 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757673Ab0CaNeT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Mar 2010 09:34:19 -0400
Content-Disposition: inline
In-Reply-To: <y2q703729f11003310123w505134f8y61efb0c9f7168a30@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alagu Sankar Vellaichamy <alagusankar@gmail.com>
Cc: linux-kernel@vger.kernel.org, Volker Ernst <volker.ernst@txtr.com>, Dan Williams <dcbw@redhat.com>, "John W. Linville" <linville@tuxdriver.com>, Holger Schurig <hs4233@mail.mn-solutions.de>, Bing Zhao <bzhao@marvell.com>, libertas-dev@lists.infradead.org, linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org

On Wed, Mar 31, 2010 at 01:53:21PM +0530, Alagu Sankar Vellaichamy wrot=
e:
> SCSI is read-only.  We ideally should be checking this bit and then
> set the ECSI accordingly, rather than setting both ECSI and SCSI.

Thanks for noticing. However, the libertas chip does not set SCSI, so w=
e
have to do it unconditionally. New patch has just been sent.

Daniel




> On Tue, Mar 30, 2010 at 11:08 PM, Daniel Mack <daniel@caiaq.de> wrote=
:
> > When operating in 1-bit mode, SDAT1 is used as dedicated interrupt =
line.
> > However, the 8686 will only drive this line when the ECSI and SCSI =
bits
> > are set in the CCCR_IF register.
> >
> > Thanks to Alagu Sankar for pointing me in the right direction.
> >
> > Signed-off-by: Daniel Mack <daniel@caiaq.de>
> > Cc: Alagu Sankar <alagusankar@embwise.com>
> > Cc: Volker Ernst <volker.ernst@txtr.com>
> > Cc: Dan Williams <dcbw@redhat.com>
> > Cc: John W. Linville <linville@tuxdriver.com>
> > Cc: Holger Schurig <hs4233@mail.mn-solutions.de>
> > Cc: Bing Zhao <bzhao@marvell.com>
> > Cc: libertas-dev@lists.infradead.org
> > Cc: linux-wireless@vger.kernel.org
> > Cc: linux-mmc@vger.kernel.org
> > ---
> > =A0drivers/net/wireless/libertas/if_sdio.c | =A0 24 +++++++++++++++=
+++++++++
> > =A0include/linux/mmc/sdio.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
2 ++
> > =A02 files changed, 26 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/net/wireless/libertas/if_sdio.c b/drivers/net/=
wireless/libertas/if_sdio.c
> > index 7a73f62..d3170f2 100644
> > --- a/drivers/net/wireless/libertas/if_sdio.c
> > +++ b/drivers/net/wireless/libertas/if_sdio.c
> > @@ -34,6 +34,8 @@
> > =A0#include <linux/mmc/card.h>
> > =A0#include <linux/mmc/sdio_func.h>
> > =A0#include <linux/mmc/sdio_ids.h>
> > +#include <linux/mmc/sdio.h>
> > +#include <linux/mmc/host.h>
> >
> > =A0#include "host.h"
> > =A0#include "decl.h"
> > @@ -942,6 +944,7 @@ static int if_sdio_probe(struct sdio_func *func=
,
> > =A0 =A0 =A0 =A0int ret, i;
> > =A0 =A0 =A0 =A0unsigned int model;
> > =A0 =A0 =A0 =A0struct if_sdio_packet *packet;
> > + =A0 =A0 =A0 struct mmc_host *host =3D func->card->host;
> >
> > =A0 =A0 =A0 =A0lbs_deb_enter(LBS_DEB_SDIO);
> >
> > @@ -1022,6 +1025,27 @@ static int if_sdio_probe(struct sdio_func *f=
unc,
> > =A0 =A0 =A0 =A0if (ret)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto disable;
> >
> > + =A0 =A0 =A0 /* For 1-bit transfers, we need to enable the interru=
pt flags in
> > + =A0 =A0 =A0 =A0* the CCCR register. Temporarily set the function =
number to 0
> > + =A0 =A0 =A0 =A0* for that. */
> > + =A0 =A0 =A0 if ((host->caps & MMC_CAP_SDIO_IRQ) &&
> > + =A0 =A0 =A0 =A0 =A0 (host->ios.bus_width =3D=3D MMC_BUS_WIDTH_1))=
 {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int num =3D func->num;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 reg;
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 func->num =3D 0;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D sdio_readb(func, SDIO_CCCR_IF=
, &ret);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto release_int;
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D SDIO_BUS_ECSI | SDIO_BUS_SCS=
I;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdio_writeb(func, reg, SDIO_CCCR_IF, =
&ret);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto release_int;
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 func->num =3D num;
> > + =A0 =A0 =A0 }
> > +
> > =A0 =A0 =A0 =A0card->ioport =3D sdio_readb(func, IF_SDIO_IOPORT, &r=
et);
> > =A0 =A0 =A0 =A0if (ret)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto release_int;
> > diff --git a/include/linux/mmc/sdio.h b/include/linux/mmc/sdio.h
> > index 0ebaef5..329a8fa 100644
> > --- a/include/linux/mmc/sdio.h
> > +++ b/include/linux/mmc/sdio.h
> > @@ -94,6 +94,8 @@
> >
> > =A0#define =A0SDIO_BUS_WIDTH_1BIT =A0 0x00
> > =A0#define =A0SDIO_BUS_WIDTH_4BIT =A0 0x02
> > +#define =A0SDIO_BUS_ECSI =A0 =A0 =A0 =A0 0x20 =A0 =A0/* Enable con=
tinuous SPI interrupt */
> > +#define =A0SDIO_BUS_SCSI =A0 =A0 =A0 =A0 0x40 =A0 =A0/* Support co=
ntinuous SPI interrupt */
> >
> > =A0#define =A0SDIO_BUS_ASYNC_INT =A0 =A00x20
> >
> > --
> > 1.7.0
> >
> >
