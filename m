From: Stefan Christ <s.christ@phytec.de>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: implement reset quirks for i.MX6
 DualLite/Solo
Date: Mon, 20 Jun 2016 09:56:31 +0200
Message-ID: <20160620075631.GA2377@lws-christ>
References: <1463053968-11598-1-git-send-email-s.christ@phytec.de>
 <HE1PR0401MB1801712347A13DD827ED1880904E0@HE1PR0401MB1801.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.phycore.de ([217.6.246.34]:37880 "EHLO root.phytec.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751687AbcFTIGg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jun 2016 04:06:36 -0400
In-Reply-To: <HE1PR0401MB1801712347A13DD827ED1880904E0@HE1PR0401MB1801.eurprd04.prod.outlook.com>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haibo Chen <haibo.chen@nxp.com>
Cc: "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "aisheng.dong@freescale.com" <aisheng.dong@freescale.com>, "festevam@gmail.com" <festevam@gmail.com>, Aisheng Dong <aisheng.dong@nxp.com>

Hi Haibo,

On Mon, May 23, 2016 at 09:57:00AM +0000, Haibo Chen wrote:
> > -----Original Message-----
> > From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> > owner@vger.kernel.org] On Behalf Of Stefan Christ
> > Sent: Thursday, May 12, 2016 7:53 PM
> > To: adrian.hunter@intel.com; linux-mmc@vger.kernel.org
> > Cc: aisheng.dong@freescale.com; festevam@gmail.com
> > Subject: [PATCH] mmc: sdhci-esdhc-imx: implement reset quirks for i=
=2EMX6
> > DualLite/Solo
> >=20
> > The ROM Code of i.MX6 Quad/Dual uses the MMC interfaces differently=
 than
> > the i.MX6 Solo/DualLite when it loads the bootloader from the inter=
face:
> >=20
> >                 Register DLL_CTRL(0x60)  Bit 25 FBCLK_SEL (0x48)
> >     Quad:       0x0                      0
> >     DualLite:   0x01000021               1
> >=20
> > Since the linux kernel or bootloader driver doesn't reset all regis=
ters, the MMC
> > interface is in an inconsistent state, which leads to boot failures=
 for some
> > eMMC devices on the i.MX6 DualLite SoC. The errors look like:
> >=20
> >     mmcblk1: error -84 transferring data, sector 0, nr 8, cmd respo=
nse 0x900, card
> > status 0xb00
> >     mmcblk1: retrying using single block read
> >     mmcblk1: error -84 transferring data, sector 2, nr 6, cmd respo=
nse 0x900, card
> > status 0x0
> >     blk_update_request: I/O error, dev mmcblk1, sector 2
> >     mmcblk1: error -84 transferring data, sector 3, nr 5, cmd respo=
nse 0x900, card
> > status 0x0
> >     blk_update_request: I/O error, dev mmcblk1, sector 3
> >=20
> > The register DLL_CTRL is already reset. Reset also the bit FBCLK_SE=
L.
> >=20
> > Signed-off-by: Stefan Christ <s.christ@phytec.de>
> > ---
> > Hi,
> >=20
> > this patch is a follow up to
> >=20
> >     http://www.spinics.net/lists/linux-mmc/msg36331.html
>=20
> Hi Stefan,=20
> Aisheng also take this into consideration, please refer to
>=20
>     http://www.spinics.net/lists/linux-mmc/msg36940.html
>=20
> Seems this patch still not be in Ulf's branch.=20
>=20
> Regards,
> Haibo

Please correct me if I'm wrong, but I don't see any activity about this=
 issue
on the mailing list. Is it possible to pick Aisheng's and my patch with=
out
waiting for the whole series to be reworked?

Mit freundlichen Gr=C3=BC=C3=9Fen / Kind regards,
	Stefan Christ

> >=20
> >     mmc: sdhci-esdhci-imx: disable DLL delay line settings explicit=
ly
> >=20
> >     Disable DLL delay line settings explicitly during driver initia=
lization
> >     in case ROM/uBoot had set an invalid delay.
> >     e.g. MX6DL ROM has set the default delay line(DLLCTRL) to 0x100=
0021,
> >     the uSDHC clock timing will become marginal when works on DDR m=
ode
> >     due to default delay and will possibly see CRC errors in case t=
he board
> >     is not perfectly designed on the eMMC chip layout.
> >=20
> >     Signed-off-by: Dong Aisheng <aisheng.dong@xxxxxxx>
> >=20
> > It doesn't apply cleanly on Linus master branch, since the above pa=
tch is missing.
> >=20
> > Mit freundlichen Gr=C3=BC=C3=9Fen / Kind regards,
> >         Stefan Christ
> > ---
> >  drivers/mmc/host/sdhci-esdhc-imx.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/=
sdhci-
> > esdhc-imx.c
> > index 4490808..9101556 100644
> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > @@ -1191,6 +1191,10 @@ static int sdhci_esdhc_imx_probe(struct
> > platform_device *pdev)
> >=20
> >  		/* disable DLL_CTRL delay line settings */
> >  		writel(0x0, host->ioaddr + ESDHC_DLL_CTRL);
> > +
> > +		/* reset bit FBCLK_SEL for i.MX6 Solo/DualLite ROM code */
> > +		writel(readl(host->ioaddr + ESDHC_MIX_CTRL) & ~BIT(25),
> > +			host->ioaddr + ESDHC_MIX_CTRL);
> >  	}
> >=20
> >  	if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING)
> > --
> > 1.9.1
> >=20
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc=
" in the
> > body of a message to majordomo@vger.kernel.org More majordomo info =
at
> > http://vger.kernel.org/majordomo-info.html
