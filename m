Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426C1463B6F;
	Wed, 23 Sep 2026 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790152931; cv=none; b=CmIxgykxpSWUPzHboWthPT5QHW3DxZHgOcowtvbKUhRGteHfk6LKfiaHcFMyKSvbMHstkped/SKPk7fcYRMLhz3Ntol9ulKwTKqxRHQPoVPq+Aysjh3v3plkkAzi63qyC8utwl5SAU4y/bknbdaEiqL43ScVMUtbGtgAjgzR+qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790152931; c=relaxed/simple;
	bh=SjnDyw2HoqxDvp4VpQpC7G8xibqPQKGBmuPcCak24rQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MmvpzANa+sve9Ly/51ILvni+c+a2nskbv8NwkbMZIh8TlmscZcWhasxGm0bdPL78SyjE3WjowNx1ISWU3g94tVQw2S/TyLqZ5NHLZZKfWEaU/QiaMG2/Iy1g5BIoRfanqyI7EE85t0IFAZoAfUzN+JhGsvCuyZlA70LkAcKor5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8jS0hY4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8jS0hY4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E169A1F000FF;
	Wed, 23 Sep 2026 08:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790152922;
	bh=VJF4/vr5y5VcWETmgrbJDPEEq5BFKEqJfgmd5Y2tQcQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=H8jS0hY4lKcJBzeLTpK4BQQqUSaDV5pSY42s2J2J/9E/8UyXF8r39ELo8ION0kD0c
	 Jhk50GZshpDQ10AQGyrLFVpcH76Z7mHe7nnynn3pNX2PyzAI/cMrILI/bBFkfNKLRl
	 VTuxW/+ixSerK/Z3pSo57HhZvG/E9dtkHeCk4WB29ABXkbkp6iqQl8NQqE5HOCKmdl
	 SulfDHaNWAfHDZtfd+9TLZA/nRjUuXZtWABwjsbXvBHWmmr227uZAm0FjiDORGMt++
	 uBqcNBAHd3GiqOldPMfNugTZrIWuTZ4MGA67E/uCfLnxOeWhLNHWnh2bOwPA5Yhl7K
	 xq2nOcnyciqBw==
Message-ID: <ead48f50-5d37-406c-b51e-d754c2c512f8@kernel.org>
Date: Wed, 23 Sep 2026 11:41:57 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-of-at91: disable selectively clocks on pm
 runtime
To: Aubin Constans <aubin.constans@microchip.com>,
 Ulf Hansson <ulfh@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Eugen Hristev <ehristev@kernel.org>,
 Romain Sioen <romain.sioen@microchip.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Robert Marko <robert.marko@sartura.hr>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Ryan Wanner <ryan.wanner@microchip.com>, linux-mmc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260918153414.909333-1-aubin.constans@microchip.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@kernel.org>
In-Reply-To: <20260918153414.909333-1-aubin.constans@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Aubin,

On 9/18/26 18:34, Aubin Constans wrote:
> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> 
> SAMA7G5's SDMMC run-time clock disabling is not supported.
> Add support to avoid this scenario for SAMA7G5.
> 
> [Amended with a fix from Romain Sioen below this line]

This should go close to the Romain's SoB.

> 
> Sama7 boards are impacted by an unbalanced prepare/unprepare
> and enable/disable clock management in sdhci driver due to
> the lack of support for SDMMC clock runtime disabling,
> managed instead by the PMC driver.
> 
> Add conditions in the preset function to manage clock
> depending on if the board support runtime clock disabling
> and if we come from the probing or restoring procedure.
> 
> Add boolean start_clks variable to manage condition
> in preset function.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

Maybe better use the @microchip.com emails, even though that is not available 
anymore, to give Microchip credit for that and avoid any legal issues, if any. 
There is a mailmap for claudiu.beznea@microchip.com available in the .mailmap 
file, if any.

Thank you,
Claudiu

> Co-developed-by: Romain Sioen <romain.sioen@microchip.com>
> Signed-off-by: Romain Sioen <romain.sioen@microchip.com>
> Signed-off-by: Aubin Constans <aubin.constans@microchip.com>
> ---
>   drivers/mmc/host/sdhci-of-at91.c | 36 ++++++++++++++++++++++++--------
>   1 file changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index 7c4ac65f247d..399856643e57 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -39,6 +39,7 @@ struct sdhci_at91_soc_data {
>   	const struct sdhci_pltfm_data *pdata;
>   	bool baseclk_is_generated_internally;
>   	unsigned int divider_for_baseclk;
> +	bool pm_runtime_disable_clks;
>   };
>   
>   struct sdhci_at91_priv {
> @@ -149,12 +150,14 @@ static const struct sdhci_pltfm_data sdhci_sama5d2_pdata = {
>   static const struct sdhci_at91_soc_data soc_data_sama5d2 = {
>   	.pdata = &sdhci_sama5d2_pdata,
>   	.baseclk_is_generated_internally = false,
> +	.pm_runtime_disable_clks = true,
>   };
>   
>   static const struct sdhci_at91_soc_data soc_data_sam9x60 = {
>   	.pdata = &sdhci_sama5d2_pdata,
>   	.baseclk_is_generated_internally = true,
>   	.divider_for_baseclk = 2,
> +	.pm_runtime_disable_clks = true,
>   };
>   
>   static const struct of_device_id sdhci_at91_dt_match[] = {
> @@ -164,7 +167,7 @@ static const struct of_device_id sdhci_at91_dt_match[] = {
>   };
>   MODULE_DEVICE_TABLE(of, sdhci_at91_dt_match);
>   
> -static int sdhci_at91_set_clks_presets(struct device *dev)
> +static int sdhci_at91_set_clks_presets(struct device *dev, bool start_clks)
>   {
>   	struct sdhci_host *host = dev_get_drvdata(dev);
>   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -174,7 +177,14 @@ static int sdhci_at91_set_clks_presets(struct device *dev)
>   	unsigned int			gck_rate, clk_base_rate;
>   	unsigned int			preset_div;
>   
> -	clk_prepare_enable(priv->hclock);
> +	/*
> +	 * Manage clock prepare/enable procedure depending on if the board
> +	 * support runtime clock disabling and if we come from the probing
> +	 * or restoring procedure (for backup+self refresh).
> +	 */
> +	if (start_clks)
> +		clk_prepare_enable(priv->hclock);
> +
>   	caps0 = readl(host->ioaddr + SDHCI_CAPABILITIES);
>   	caps1 = readl(host->ioaddr + SDHCI_CAPABILITIES_1);
>   
> @@ -223,8 +233,11 @@ static int sdhci_at91_set_clks_presets(struct device *dev)
>   	writew(SDHCI_AT91_PRESET_COMMON_CONF | preset_div,
>   	       host->ioaddr + SDHCI_PRESET_FOR_DDR50);
>   
> -	clk_prepare_enable(priv->mainck);
> -	clk_prepare_enable(priv->gck);
> +	/* Same clock management as for hclock */
> +	if (start_clks) {
> +		clk_prepare_enable(priv->mainck);
> +		clk_prepare_enable(priv->gck);
> +	}
>   
>   	return 0;
>   }
> @@ -254,9 +267,11 @@ static int sdhci_at91_runtime_suspend(struct device *dev)
>   	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
>   		mmc_retune_needed(host->mmc);
>   
> -	clk_disable_unprepare(priv->gck);
> -	clk_disable_unprepare(priv->hclock);
> -	clk_disable_unprepare(priv->mainck);
> +	if (priv->soc_data->pm_runtime_disable_clks) {
> +		clk_disable_unprepare(priv->gck);
> +		clk_disable_unprepare(priv->hclock);
> +		clk_disable_unprepare(priv->mainck);
> +	}
>   
>   	return 0;
>   }
> @@ -269,7 +284,7 @@ static int sdhci_at91_runtime_resume(struct device *dev)
>   	int ret;
>   
>   	if (priv->restore_needed) {
> -		ret = sdhci_at91_set_clks_presets(dev);
> +		ret = sdhci_at91_set_clks_presets(dev, priv->soc_data->pm_runtime_disable_clks);
>   		if (ret)
>   			return ret;
>   
> @@ -277,6 +292,9 @@ static int sdhci_at91_runtime_resume(struct device *dev)
>   		goto out;
>   	}
>   
> +	if (!priv->soc_data->pm_runtime_disable_clks)
> +		goto out;
> +
>   	ret = clk_prepare_enable(priv->mainck);
>   	if (ret) {
>   		dev_err(dev, "can't enable mainck\n");
> @@ -344,7 +362,7 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>   		return dev_err_probe(&pdev->dev, PTR_ERR(priv->gck),
>   				     "failed to get multclk\n");
>   
> -	ret = sdhci_at91_set_clks_presets(&pdev->dev);
> +	ret = sdhci_at91_set_clks_presets(&pdev->dev, true);
>   	if (ret)
>   		return ret;
>   

