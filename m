From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 4/5] mmc: sdhci: consolidate sdhci-of-esdhc and
 sdhci-esdhc-imx
Date: Fri, 1 Apr 2011 14:18:36 +0800
Message-ID: <20110401061835.GG25866@S2100-06.ap.freescale.net>
References: <1301042931-4869-1-git-send-email-shawn.guo@linaro.org>
 <1301042931-4869-5-git-send-email-shawn.guo@linaro.org>
 <20110331155312.GC26709@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:28789
	"EHLO VA3EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752690Ab1DAGRI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Apr 2011 02:17:08 -0400
Content-Disposition: inline
In-Reply-To: <20110331155312.GC26709@ponder.secretlab.ca>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Shawn Guo <shawn.guo@linaro.org>, linaro-dev@lists.linaro.org, sameo@linux.intel.com, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Mar 31, 2011 at 09:53:12AM -0600, Grant Likely wrote:
> On Fri, Mar 25, 2011 at 04:48:50PM +0800, Shawn Guo wrote:
> > This patch is to consolidate SDHCI driver for Freescale eSDHC
> > controller found on both MPCxxx and i.MX platforms.  It turns
> > sdhci-of-esdhc.c and sdhci-esdhc-imx.c into one sdhci-esdhc.c,
> > which gets the same pair of .probe and .remove serving two cases.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  drivers/mmc/host/Kconfig           |   38 ++--
> >  drivers/mmc/host/Makefile          |    3 +-
> >  drivers/mmc/host/sdhci-esdhc-imx.c |  210 ------------------
> >  drivers/mmc/host/sdhci-esdhc.c     |  413 ++++++++++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci-of-esdhc.c  |  162 --------------
> 
> This patch would be easier to review if it was split into two patches;
> first rename sdhci-esdhc-imx.c to sdhci-esdhc.c without any changes to
> the .c code, and then a second patch to merge the ppc bits into the
> imx version.
> 
OK.

> > +#if defined(CONFIG_OF)
> > +#include <linux/of_device.h>
> > +static const struct of_device_id sdhci_esdhc_dt_ids[] = {
> > +#ifdef CONFIG_MMC_SDHCI_ESDHC_IMX
> > +	{ .compatible = "fsl,imx-esdhc", .data = &sdhci_esdhc_imx_pdata },
> > +#endif
> > +#ifdef CONFIG_MMC_SDHCI_ESDHC_MPC
> > +	{ .compatible = "fsl,mpc8379-esdhc", .data = &sdhci_esdhc_mpc_pdata },
> > +	{ .compatible = "fsl,mpc8536-esdhc", .data = &sdhci_esdhc_mpc_pdata },
> > +	{ .compatible = "fsl,esdhc", .data = &sdhci_esdhc_mpc_pdata },
> > +#endif
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(platform, sdhci_esdhc_dt_ids);
> > +
> > +static const struct of_device_id *
> > +sdhci_esdhc_get_of_device_id(struct platform_device *pdev)
> > +{
> > +	return of_match_device(sdhci_esdhc_dt_ids, &pdev->dev);
> 
> You can add an empty implementation of of_match_device() to
> linux/of_device.h.  That would eliminate the need for this function.
> 
Will follow what you suggested later to use .of_match pointer newly
added into struct device.

-- 
Regards,
Shawn

