From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: Re: [MXS MMC 2/5] Some cleanups for the MMC driver
Date: Wed, 7 Dec 2011 12:57:44 +0100
Message-ID: <20191.21688.696997.76000@ipc1.ka-ro>
References: <cover.1323177907.git.LW@KARO-electronics.de>
	<d935557e044d2ebc56b4e70487b519fe722e9017.1323177907.git.LW@KARO-electronics.de>
	<20111207120120.GK5550@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111207120120.GK5550@S2100-06.ap.freescale.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

Shawn Guo writes:
> I'm fine with this cosmetic patch with the comments below addressed.
>=20
> On Tue, Dec 06, 2011 at 02:41:27PM +0100, Lothar Wa=C3=9Fmann wrote:
> >  - Remove bogus parens around numerical arguments in #define's
> >  - When defining bit masks, use the #def for the shift count
> >    instead of repeating the numbers
>=20
> This change brings a few 'line over 80 characters' checkpatch warning=
s.
>=20
will fix.

> >  - Remove bogus whitespace in indentation
> >  - Remove 'break' at end of switch statement
> >=20
> > Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
> > ---
> >  drivers/mmc/host/mxs-mmc.c |   57 +++++++++++++++++++++-----------=
-----------
> >  1 files changed, 28 insertions(+), 29 deletions(-)
> >=20
> > diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.=
c
> [...]
> > @@ -277,7 +277,7 @@ static irqreturn_t mxs_mmc_irq_handler(int irq,=
 void *dev_id)
> > =20
> >  	stat =3D readl(host->base + HW_SSP_CTRL1);
> >  	writel(stat & MXS_MMC_IRQ_BITS,
> > -	       host->base + HW_SSP_CTRL1 + MXS_CLR_ADDR);
>=20
> This is an intended indentation with 7 spaces.
>=20
According to Documentation/CodingStyle spaces are never used for
indentation (except in documentation, Kconfig and comments).


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
