From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH 21/23] mmc: sdhci-esdhc-imx: factor out hw related
 intialization into function
Date: Thu, 26 May 2016 19:45:49 +0800
Message-ID: <20160526114548.GB23988@shlinux2>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
 <1460741387-23815-22-git-send-email-aisheng.dong@nxp.com>
 <5731D0FF.60807@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33668 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753463AbcEZLu6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 May 2016 07:50:58 -0400
Received: by mail-pa0-f65.google.com with SMTP id f8so8860194pag.0
        for <linux-mmc@vger.kernel.org>; Thu, 26 May 2016 04:50:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5731D0FF.60807@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, chris@printf.net, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org, haibo.chen@nxp.com

On Tue, May 10, 2016 at 03:15:59PM +0300, Adrian Hunter wrote:
> On 15/04/16 20:29, Dong Aisheng wrote:
> > Factor out hw related intialization into a separate function which
> > has two benifits:
> > 1) concentrate hw related intialization at one place
> > 2) ease the hw state restore after resume by simply
> > calling this function
> 
> There are really 2 changes here, please make it 2 patches.
> 

Okay i will do it in V2.
Thanks for the suggestion.

Regards
Dong Aisheng

> > 
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >  drivers/mmc/host/sdhci-esdhc-imx.c | 76 +++++++++++++++++++++-----------------
> >  1 file changed, 42 insertions(+), 34 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> > index 3ff213f..95f3632 100644
> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > @@ -978,6 +978,44 @@ static const struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
> >  	.ops = &sdhci_esdhc_ops,
> >  };
> >  
> > +static void sdhci_esdhc_imx_hwinit(struct sdhci_host *host)
> > +{
> > +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > +	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
> > +
> > +	if (esdhc_is_usdhc(imx_data)) {
> > +		/*
> > +		 * The imx6q ROM code will change the default watermark
> > +		 * level setting to something insane.  Change it back here.
> > +		 */
> > +		writel(0x10401040, host->ioaddr + ESDHC_WTMK_LVL);
> > +
> > +		/*
> > +		 * ROM code will change the bit burst_length_enable setting
> > +		 * to zero if this usdhc is choosed to boot system. Change
> > +		 * it back here, otherwise it will impact the performance a
> > +		 * lot. This bit is used to enable/disable the burst length
> > +		 * for the external AHB2AXI bridge, it's usefully especially
> > +		 * for INCR transfer because without burst length indicator,
> > +		 * the AHB2AXI bridge does not know the burst length in
> > +		 * advance. And without burst length indicator, AHB INCR
> > +		 * transfer can only be converted to singles on the AXI side.
> > +		 */
> > +		writel(readl(host->ioaddr + SDHCI_HOST_CONTROL)
> > +			| ESDHC_BURST_LEN_EN_INCR,
> > +			host->ioaddr + SDHCI_HOST_CONTROL);
> > +		/*
> > +		* errata ESDHC_FLAG_ERR004536 fix for MX6Q TO1.2 and MX6DL
> > +		* TO1.1, it's harmless for MX6SL
> > +		*/
> > +		writel(readl(host->ioaddr + 0x6c) | BIT(7),
> > +			host->ioaddr + 0x6c);
> > +
> > +		/* disable DLL_CTRL delay line settings */
> > +		writel(0x0, host->ioaddr + ESDHC_DLL_CTRL);
> > +	}
> > +}
> > +
> >  #ifdef CONFIG_OF
> >  static int
> >  sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
> > @@ -1175,43 +1213,13 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
> >  		host->quirks |= SDHCI_QUIRK_NO_MULTIBLOCK
> >  			| SDHCI_QUIRK_BROKEN_ADMA;
> >  
> > -	/*
> > -	 * The imx6q ROM code will change the default watermark level setting
> > -	 * to something insane.  Change it back here.
> > -	 */
> > -	if (esdhc_is_usdhc(imx_data)) {
> > -		writel(0x10401040, host->ioaddr + ESDHC_WTMK_LVL);
> > +	sdhci_esdhc_imx_hwinit(host);
> >  
> > +	if (esdhc_is_usdhc(imx_data)) {
> >  		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
> >  		host->mmc->caps |= MMC_CAP_1_8V_DDR;
> > -
> > -		/*
> > -		 * ROM code will change the bit burst_length_enable setting
> > -		 * to zero if this usdhc is choosed to boot system. Change
> > -		 * it back here, otherwise it will impact the performance a
> > -		 * lot. This bit is used to enable/disable the burst length
> > -		 * for the external AHB2AXI bridge, it's usefully especially
> > -		 * for INCR transfer because without burst length indicator,
> > -		 * the AHB2AXI bridge does not know the burst length in
> > -		 * advance. And without burst length indicator, AHB INCR
> > -		 * transfer can only be converted to singles on the AXI side.
> > -		 */
> > -		writel(readl(host->ioaddr + SDHCI_HOST_CONTROL)
> > -			| ESDHC_BURST_LEN_EN_INCR,
> > -			host->ioaddr + SDHCI_HOST_CONTROL);
> > -
> >  		if (!(imx_data->socdata->flags & ESDHC_FLAG_HS200))
> >  			host->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
> > -
> > -		/*
> > -		* errata ESDHC_FLAG_ERR004536 fix for MX6Q TO1.2 and MX6DL
> > -		* TO1.1, it's harmless for MX6SL
> > -		*/
> > -		writel(readl(host->ioaddr + 0x6c) | BIT(7),
> > -			host->ioaddr + 0x6c);
> > -
> > -		/* disable DLL_CTRL delay line settings */
> > -		writel(0x0, host->ioaddr + ESDHC_DLL_CTRL);
> >  	}
> >  
> >  	if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING)
> > @@ -1289,8 +1297,8 @@ static int sdhci_esdhc_resume(struct device *dev)
> >  {
> >  	struct sdhci_host *host = dev_get_drvdata(dev);
> >  
> > -	/* restore watermark setting in case it's lost in low power mode */
> > -	writel(0x10401040, host->ioaddr + ESDHC_WTMK_LVL);
> > +	/* reinitialize hw state in case it's lost in low power mode */
> > +	sdhci_esdhc_imx_hwinit(host);
> >  
> >  	return sdhci_pltfm_resume(dev);
> >  }
> > 
> 
