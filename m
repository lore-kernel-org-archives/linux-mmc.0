Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861A7C433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Apr 2022 06:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346571AbiD0Gr1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 27 Apr 2022 02:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352922AbiD0GrW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Apr 2022 02:47:22 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADED314AADA;
        Tue, 26 Apr 2022 23:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651041852; x=1682577852;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=re7LN+N41bRnAIzjSbkbrTfuLiFGkUj/O/UB6i31Auc=;
  b=hfjeGJwRQeb7/O/yEi6fk7PkNoB9ugUYccugweVkUVNpKyflLrcquCgV
   4uaI9+0XOxT+VUQKKGvrrUiyOF3O3uPccB2rpTR0ZV1v/lGc+PB7894fW
   H82defWcQhUHMAmkPT2NOQfesw6VAzTtGkMxaDUGgc3eunk3VglK4zCiM
   qDi7Fw0+Tc+/RZraHR2V27fchYi5qrgGWx5H9Zl16Ur69k1Pg6bdOSpVl
   9cDy3bLWzuHOCW0R9dW65RJixIHV3GCVU7hMN0O5ICy9LBB2rHVgMnEBK
   s8YRX25aKaHe52fYysIxZMfUT5CjJpYG+pUkaHcfWm3NsBVVJzNbT4GrU
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="326325004"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="326325004"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 23:44:00 -0700
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="580413754"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.60.122])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 23:43:57 -0700
Message-ID: <fcd49d21-7176-4940-e988-a4815ae013f3@intel.com>
Date:   Wed, 27 Apr 2022 09:43:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH 2/5] mmc: sdhci-brcmstb: Re-organize flags
Content-Language: en-US
To:     Kamal Dasu <kdasu.kdev@gmail.com>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, alcooperx@gmail.com
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220421182803.6495-1-kdasu.kdev@gmail.com>
 <20220421182803.6495-3-kdasu.kdev@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220421182803.6495-3-kdasu.kdev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 21/04/22 21:28, Kamal Dasu wrote:
> From: Al Cooper <alcooperx@gmail.com>
> 
> Re-organize the flags by basing the bit names on the flag that they
> apply to. Also change the "flags" member in the "brcmstb_match_priv"
> struct to const.
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-brcmstb.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index 11037cd14cfa..f32aa045c26d 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -18,20 +18,22 @@
>  #define SDHCI_VENDOR 0x78
>  #define  SDHCI_VENDOR_ENHANCED_STRB 0x1
>  
> -#define BRCMSTB_PRIV_FLAGS_NO_64BIT		BIT(0)
> -#define BRCMSTB_PRIV_FLAGS_BROKEN_TIMEOUT	BIT(1)
> +#define BRCMSTB_MATCH_FLAGS_NO_64BIT		BIT(0)
> +#define BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT	BIT(1)
> +
> +#define BRCMSTB_PRIV_FLAGS_HAS_CQE		BIT(0)
>  
>  #define SDHCI_ARASAN_CQE_BASE_ADDR		0x200
>  
>  struct sdhci_brcmstb_priv {
>  	void __iomem *cfg_regs;
> -	bool has_cqe;
> +	unsigned int flags;
>  };
>  
>  struct brcmstb_match_priv {
>  	void (*hs400es)(struct mmc_host *mmc, struct mmc_ios *ios);
>  	struct sdhci_ops *ops;
> -	unsigned int flags;
> +	const unsigned int flags;
>  };
>  
>  static void sdhci_brcmstb_hs400es(struct mmc_host *mmc, struct mmc_ios *ios)
> @@ -134,13 +136,13 @@ static struct sdhci_ops sdhci_brcmstb_ops_7216 = {
>  };
>  
>  static struct brcmstb_match_priv match_priv_7425 = {
> -	.flags = BRCMSTB_PRIV_FLAGS_NO_64BIT |
> -	BRCMSTB_PRIV_FLAGS_BROKEN_TIMEOUT,
> +	.flags = BRCMSTB_MATCH_FLAGS_NO_64BIT |
> +	BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT,
>  	.ops = &sdhci_brcmstb_ops,
>  };
>  
>  static struct brcmstb_match_priv match_priv_7445 = {
> -	.flags = BRCMSTB_PRIV_FLAGS_BROKEN_TIMEOUT,
> +	.flags = BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT,
>  	.ops = &sdhci_brcmstb_ops,
>  };
>  
> @@ -176,7 +178,7 @@ static int sdhci_brcmstb_add_host(struct sdhci_host *host,
>  	bool dma64;
>  	int ret;
>  
> -	if (!priv->has_cqe)
> +	if ((priv->flags & BRCMSTB_PRIV_FLAGS_HAS_CQE) == 0)
>  		return sdhci_add_host(host);
>  
>  	dev_dbg(mmc_dev(host->mmc), "CQE is enabled\n");
> @@ -225,7 +227,6 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>  	struct sdhci_brcmstb_priv *priv;
>  	struct sdhci_host *host;
>  	struct resource *iomem;
> -	bool has_cqe = false;
>  	struct clk *clk;
>  	int res;
>  
> @@ -244,10 +245,6 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>  		return res;
>  
>  	memset(&brcmstb_pdata, 0, sizeof(brcmstb_pdata));
> -	if (device_property_read_bool(&pdev->dev, "supports-cqe")) {
> -		has_cqe = true;
> -		match_priv->ops->irq = sdhci_brcmstb_cqhci_irq;
> -	}
>  	brcmstb_pdata.ops = match_priv->ops;
>  	host = sdhci_pltfm_init(pdev, &brcmstb_pdata,
>  				sizeof(struct sdhci_brcmstb_priv));
> @@ -258,7 +255,10 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>  
>  	pltfm_host = sdhci_priv(host);
>  	priv = sdhci_pltfm_priv(pltfm_host);
> -	priv->has_cqe = has_cqe;
> +	if (device_property_read_bool(&pdev->dev, "supports-cqe")) {
> +		priv->flags |= BRCMSTB_PRIV_FLAGS_HAS_CQE;
> +		match_priv->ops->irq = sdhci_brcmstb_cqhci_irq;
> +	}
>  
>  	/* Map in the non-standard CFG registers */
>  	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> @@ -287,14 +287,14 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>  	 * properties through mmc_of_parse().
>  	 */
>  	host->caps = sdhci_readl(host, SDHCI_CAPABILITIES);
> -	if (match_priv->flags & BRCMSTB_PRIV_FLAGS_NO_64BIT)
> +	if (match_priv->flags & BRCMSTB_MATCH_FLAGS_NO_64BIT)
>  		host->caps &= ~SDHCI_CAN_64BIT;
>  	host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
>  	host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_SDR104 |
>  			 SDHCI_SUPPORT_DDR50);
>  	host->quirks |= SDHCI_QUIRK_MISSING_CAPS;
>  
> -	if (match_priv->flags & BRCMSTB_PRIV_FLAGS_BROKEN_TIMEOUT)
> +	if (match_priv->flags & BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT)
>  		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
>  
>  	res = sdhci_brcmstb_add_host(host, priv);

