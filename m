From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 3/3] mmc: esdhc i.MX: Support 8bit mode
Date: Tue, 25 Sep 2012 09:27:15 +0200
Message-ID: <20120925072714.GY1322@pengutronix.de>
References: <1348471345-30785-1-git-send-email-s.hauer@pengutronix.de>
 <1348471345-30785-4-git-send-email-s.hauer@pengutronix.de>
 <20120925071505.GG27291@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55425 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097Ab2IYH1U (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Sep 2012 03:27:20 -0400
Content-Disposition: inline
In-Reply-To: <20120925071505.GG27291@S2101-09.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, Eric =?iso-8859-15?Q?B=E9nard?= <eric@eukrea.com>, kernel@pengutronix.de

On Tue, Sep 25, 2012 at 03:15:08PM +0800, Shawn Guo wrote:
> On Mon, Sep 24, 2012 at 09:22:25AM +0200, Sascha Hauer wrote:
> > The i.MX esdhc has a nonstandard bit layout for the SDHCI_HOST_CONTROL
> > register. To support 8bit bus width on i.MX populate the platform_bus_width
> > callback. This is tested on an i.MX25, but should according to the datasheets
> > work on the other i.MX using this hardware aswell. The i.MX6, while having
> > a SDHCI_SPEC_300 controller, still uses the same nonstandard register layout.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |    1 +
> >  arch/arm/plat-mxc/include/mach/esdhc.h             |    1 +
> >  drivers/mmc/host/sdhci-esdhc-imx.c                 |   56 ++++++++++++++++++--
> >  3 files changed, 55 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> > index 1dd6225..c989994 100644
> > --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> > +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> > @@ -12,6 +12,7 @@ Required properties:
> >  Optional properties:
> >  - fsl,cd-controller : Indicate to use controller internal card detection
> >  - fsl,wp-controller : Indicate to use controller internal write protection
> > +- bus-width : Maximum supported bus width. Defaults to 4 if omitted
> >
> This is a common mmc property documented in bindings/mmc/mmc.txt.
> Instead of duplicating the documentation, we should try to make our
> implementation conform to the common definition of the property.

It is conform to the common definition, so all I have to do is drop the
line duplicating the docs. That's easy ;)

> > +		break;
> > +	case MMC_BUS_WIDTH_4:
> > +		ctrl = FSL_SDHCI_CTRL_4BITBUS;
> > +		break;
> > +	default:
> > +		ctrl = 0;
> 
> ... 
> 		ctrl = FSL_SDHCI_CTRL_1BITBUS;
> 
> Any better?

ok.

> >  	if (is_imx25_esdhc(imx_data) || is_imx35_esdhc(imx_data))
> >  		/* Fix errata ENGcm07207 present on i.MX25 and i.MX35 */
> >  		host->quirks |= SDHCI_QUIRK_NO_MULTIBLOCK
> > -			| SDHCI_QUIRK_BROKEN_ADMA;
> > +			 | SDHCI_QUIRK_BROKEN_ADMA;
> >  
> 
> Why this change?

Accident. Will drop.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
