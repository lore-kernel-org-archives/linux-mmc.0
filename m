From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [v5, 2/4] mmc: sdhci-of-esdhc: support both BE and LE host controller
Date: Tue, 29 Sep 2015 14:25:47 +0200
Message-ID: <32811311.hiIQqMpiG0@wuerfel>
References: <1443422113-15054-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:54264 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964843AbbI2MZx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Sep 2015 08:25:53 -0400
In-Reply-To: <1443422113-15054-1-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@freescale.com>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, LeoLi@freescale.com

On Monday 28 September 2015 14:35:13 Yangbo Lu wrote:
> +struct esdhc_host {
> +	u8 vendor_ver;
> +	u8 spec_ver;
> +	u16 xfer_mode_shadow;
> +	struct sdhci_host *host;
> +};
> +
> +static struct esdhc_host *esdhc;

Please avoid global variables like this one and keep the state
within the per-device structure.

>  
> -static const struct sdhci_pltfm_data sdhci_esdhc_pdata = {
> -	/*
> -	 * card detection could be handled via GPIO
> -	 * eSDHC cannot support End Attribute in NOP ADMA descriptor
> -	 */
> -	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_BROKEN_CARD_DETECTION
> -		| SDHCI_QUIRK_NO_CARD_NO_RESET
> -		| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
> -	.ops = &sdhci_esdhc_ops,
> +static struct sdhci_ops sdhci_esdhc_ops = {
> +	.set_clock = esdhc_of_set_clock,
> +	.enable_dma = esdhc_of_enable_dma,
> +	.get_max_clock = esdhc_of_get_max_clock,
> +	.get_min_clock = esdhc_of_get_min_clock,
> +	.adma_workaround = esdhc_of_adma_workaround,
> +	.set_bus_width = esdhc_pltfm_set_bus_width,
> +	.reset = esdhc_reset,
> +	.set_uhs_signaling = sdhci_set_uhs_signaling,
>  };
> +static struct sdhci_pltfm_data sdhci_esdhc_pdata;
> +
> +static void esdhc_setup_pltfm_data(struct platform_device *pdev)
> +{
> +	struct device_node *np;
> +
> +	np = pdev->dev.of_node;
> +	if (of_get_property(np, "little-endian", NULL)) {
> +		sdhci_esdhc_ops.read_l	= esdhc_le_readl;
> +		sdhci_esdhc_ops.read_w	= esdhc_le_readw;
> +		sdhci_esdhc_ops.read_b	= esdhc_le_readb;
> +		sdhci_esdhc_ops.write_l	= esdhc_le_writel;
> +		sdhci_esdhc_ops.write_w	= esdhc_le_writew;
> +		sdhci_esdhc_ops.write_b	= esdhc_le_writeb;
> +	} else {
> +		sdhci_esdhc_ops.read_l	= esdhc_be_readl;
> +		sdhci_esdhc_ops.read_w	= esdhc_be_readw;
> +		sdhci_esdhc_ops.read_b	= esdhc_be_readb;
> +		sdhci_esdhc_ops.write_l	= esdhc_be_writel;
> +		sdhci_esdhc_ops.write_w	= esdhc_be_writew;
> +		sdhci_esdhc_ops.write_b	= esdhc_be_writeb;
> +	}

Just define two instances of the sdhci_esdhc_ops structure and
pick one or the other pointer, rather changing the members individually.
That makes it easier to read and gives smaller code. Similarly, use
two instances of sdhci_pltfm_data.

Ideally also mark the structure as 'const', as we normally do for
structures with callback pointers. (this might require a larger
cleanup though).

>  static int sdhci_esdhc_probe(struct platform_device *pdev)
>  {
> @@ -360,10 +563,15 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
>  	struct device_node *np;
>  	int ret;
>  
> +	esdhc_setup_pltfm_data(pdev);
> +
>  	host = sdhci_pltfm_init(pdev, &sdhci_esdhc_pdata, 0);
>  	if (IS_ERR(host))
>  		return PTR_ERR(host);
>  
> +	esdhc = kmalloc(sizeof(struct esdhc_host), GFP_KERNEL);
> +	esdhc_init(esdhc, host);
> +

You can combine these, by passing sizeof(struct esdhc_host) as the 'priv'
argument of the sdhci_pltfm_init function.

	Arnd
