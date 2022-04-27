Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871C4C433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Apr 2022 06:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353644AbiD0GtC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 27 Apr 2022 02:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358320AbiD0Gsv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Apr 2022 02:48:51 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F05106DDC;
        Tue, 26 Apr 2022 23:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651041939; x=1682577939;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bJiU5gmv860c0Y31LeVU2FGewPvJGAQH7v4ZruhWpak=;
  b=il/Jn6v4wQpkQzUBwhFZuhsSdV/Ugm62N3CFYyBxcL4VD8GXZlxcEAao
   DC4K3Q5EmLGS2l/Z4ehetuUHEigYsoCeHwY+e+HJgUyrMZ3vmkfZklnMp
   5/bAy0PDT25q/URReO6ouIF02FYQoVyim+z6QKYlRH9Argc6LNdraHFGi
   Prn+32efRAWtlhpJaqI5lG7AcYIjIe0FPQhzIal2GOauN35N6DCFv98Cv
   jNDNoqDOg/EvTkeDDB+ZYX4pSw2INaPQ77ppDDDiqe04DVeylZHVGBSRv
   zZOCKKMdRN5TYjIW25+RqItznHgTRLnqX/OkeyIZ6zdcP/Tk2nJ5ay4d0
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="352273177"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="352273177"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 23:45:37 -0700
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="580414388"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.60.122])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 23:45:34 -0700
Message-ID: <ae700666-293e-60c9-0528-2d0a97d5c92f@intel.com>
Date:   Wed, 27 Apr 2022 09:45:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH 5/5] mmc: sdhci-brcmstb: Add ability to increase max clock
 rate for 72116b0
Content-Language: en-US
To:     Kamal Dasu <kdasu.kdev@gmail.com>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, alcooperx@gmail.com
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220421182803.6495-1-kdasu.kdev@gmail.com>
 <20220421182803.6495-6-kdasu.kdev@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220421182803.6495-6-kdasu.kdev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 21/04/22 21:28, Kamal Dasu wrote:
> From: Al Cooper <alcooperx@gmail.com>
> 
> The 72116B0 has improved SDIO controllers that allow the max clock
> rate to be increased from a max of 100MHz to a max of 150MHz. The
> driver will need to get the clock and increase it's default rate
> and override the caps register, that still indicates a max of 100MHz.
> The new clock will be named "sdio_freq" in the DT node's "clock-names"
> list. The driver will use a DT property, "clock-frequency", to
> enable this functionality and will get the actual rate in MHz
> from the property to allow various speeds to be requested.
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> ---
>  drivers/mmc/host/sdhci-brcmstb.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index d5cb3e8978b2..4f3629a8e70a 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -250,6 +250,7 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>  	struct sdhci_pltfm_host *pltfm_host;
>  	const struct of_device_id *match;
>  	struct sdhci_brcmstb_priv *priv;
> +	uint32_t base_clock_hz = 0;

Prefer u32 i.e. uint32_t -> u32

>  	struct sdhci_host *host;
>  	struct resource *iomem;
>  	struct clk *clk;
> @@ -330,6 +331,30 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>  	if (match_priv->flags & BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT)
>  		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
>  
> +	/* Change the base clock frequency if the DT property exists */
> +	if (device_property_read_u32(&pdev->dev, "clock-frequency",
> +				     &base_clock_hz) == 0) {
> +		struct clk *master_clk;
> +		u32 actual_clock_mhz;
> +
> +		master_clk = devm_clk_get(&pdev->dev, "sdio_freq");
> +		if (IS_ERR(master_clk)) {
> +			dev_warn(&pdev->dev,
> +				 "Clock for \"sdio_freq\" was not found\n");
> +		} else {
> +			clk_set_rate(master_clk, base_clock_hz);
> +			actual_clock_mhz = clk_get_rate(master_clk) / 1000000;
> +
> +			host->caps &= ~SDHCI_CLOCK_V3_BASE_MASK;
> +			host->caps |=
> +				(actual_clock_mhz << SDHCI_CLOCK_BASE_SHIFT);
> +			/* Disable presets because they are now incorrect */
> +			host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
> +			dev_dbg(&pdev->dev,
> +				"Base Clock Frequency changed to %dMHz\n",
> +				actual_clock_mhz);
> +		}
> +	}
>  	res = sdhci_brcmstb_add_host(host, priv);
>  	if (res)
>  		goto err;

