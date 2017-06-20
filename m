From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-of-at91: factor out clks and presets
 setting
Date: Tue, 20 Jun 2017 10:11:16 +0200
Message-ID: <984492b5-9deb-3d61-2ca4-d3750879f8d8@free-electrons.com>
References: <20170616072929.3266-1-quentin.schulz@free-electrons.com>
 <3f227676-1f1f-8c4d-43fe-67930ad87459@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:41149 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751927AbdFTIL2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jun 2017 04:11:28 -0400
In-Reply-To: <3f227676-1f1f-8c4d-43fe-67930ad87459@intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, ludovic.desroches@microchip.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, thomas.petazzoni@free-electrons.com, alexandre.belloni@free-electrons.com, nicolas.ferre@microchip.com

Hi Adrian,

On 20/06/2017 08:36, Adrian Hunter wrote:
> On 16/06/17 10:29, Quentin Schulz wrote:
>> The setting of clocks and presets is currently done in probe only but
>> once deep PM support is added, it'll be needed in the resume function.
>>
>> Let's create a function for this setting.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> 
> Apart from cosmetic comment below:
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> 
>> ---
>>  drivers/mmc/host/sdhci-of-at91.c | 147 ++++++++++++++++++++++-----------------
>>  1 file changed, 82 insertions(+), 65 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
>> index 7611fd679f1a..fb8c6011f13d 100644
>> --- a/drivers/mmc/host/sdhci-of-at91.c
>> +++ b/drivers/mmc/host/sdhci-of-at91.c
>> @@ -128,6 +128,84 @@ static const struct of_device_id sdhci_at91_dt_match[] = {
>>  };
>>  MODULE_DEVICE_TABLE(of, sdhci_at91_dt_match);
>>  
>> +static int sdhci_at91_set_clks_presets(struct device *dev)
>> +{
>> +	struct sdhci_host *host = dev_get_drvdata(dev);
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct sdhci_at91_priv *priv = sdhci_pltfm_priv(pltfm_host);
>> +	int ret;
>> +	unsigned int			caps0, caps1;
>> +	unsigned int			clk_base, clk_mul;
>> +	unsigned int			gck_rate, real_gck_rate;
>> +	unsigned int			preset_div;
> 
> Too much whitespace.
> 

Simply moved some variables from the original code (see sdhci_at91_probe
below).

Thanks,
Quentin

>> +
>> +	/*
>> +	 * The mult clock is provided by as a generated clock by the PMC
>> +	 * controller. In order to set the rate of gck, we have to get the
>> +	 * base clock rate and the clock mult from capabilities.
>> +	 */
>> +	clk_prepare_enable(priv->hclock);
>> +	caps0 = readl(host->ioaddr + SDHCI_CAPABILITIES);
>> +	caps1 = readl(host->ioaddr + SDHCI_CAPABILITIES_1);
>> +	clk_base = (caps0 & SDHCI_CLOCK_V3_BASE_MASK) >> SDHCI_CLOCK_BASE_SHIFT;
>> +	clk_mul = (caps1 & SDHCI_CLOCK_MUL_MASK) >> SDHCI_CLOCK_MUL_SHIFT;
>> +	gck_rate = clk_base * 1000000 * (clk_mul + 1);
>> +	ret = clk_set_rate(priv->gck, gck_rate);
>> +	if (ret < 0) {
>> +		dev_err(dev, "failed to set gck");
>> +		clk_disable_unprepare(priv->hclock);
>> +		return ret;
>> +	}
>> +	/*
>> +	 * We need to check if we have the requested rate for gck because in
>> +	 * some cases this rate could be not supported. If it happens, the rate
>> +	 * is the closest one gck can provide. We have to update the value
>> +	 * of clk mul.
>> +	 */
>> +	real_gck_rate = clk_get_rate(priv->gck);
>> +	if (real_gck_rate != gck_rate) {
>> +		clk_mul = real_gck_rate / (clk_base * 1000000) - 1;
>> +		caps1 &= (~SDHCI_CLOCK_MUL_MASK);
>> +		caps1 |= ((clk_mul << SDHCI_CLOCK_MUL_SHIFT) &
>> +			  SDHCI_CLOCK_MUL_MASK);
>> +		/* Set capabilities in r/w mode. */
>> +		writel(SDMMC_CACR_KEY | SDMMC_CACR_CAPWREN,
>> +		       host->ioaddr + SDMMC_CACR);
>> +		writel(caps1, host->ioaddr + SDHCI_CAPABILITIES_1);
>> +		/* Set capabilities in ro mode. */
>> +		writel(0, host->ioaddr + SDMMC_CACR);
>> +		dev_info(dev, "update clk mul to %u as gck rate is %u Hz\n",
>> +			 clk_mul, real_gck_rate);
>> +	}
>> +
>> +	/*
>> +	 * We have to set preset values because it depends on the clk_mul
>> +	 * value. Moreover, SDR104 is supported in a degraded mode since the
>> +	 * maximum sd clock value is 120 MHz instead of 208 MHz. For that
>> +	 * reason, we need to use presets to support SDR104.
>> +	 */
>> +	preset_div = DIV_ROUND_UP(real_gck_rate, 24000000) - 1;
>> +	writew(SDHCI_AT91_PRESET_COMMON_CONF | preset_div,
>> +	       host->ioaddr + SDHCI_PRESET_FOR_SDR12);
>> +	preset_div = DIV_ROUND_UP(real_gck_rate, 50000000) - 1;
>> +	writew(SDHCI_AT91_PRESET_COMMON_CONF | preset_div,
>> +	       host->ioaddr + SDHCI_PRESET_FOR_SDR25);
>> +	preset_div = DIV_ROUND_UP(real_gck_rate, 100000000) - 1;
>> +	writew(SDHCI_AT91_PRESET_COMMON_CONF | preset_div,
>> +	       host->ioaddr + SDHCI_PRESET_FOR_SDR50);
>> +	preset_div = DIV_ROUND_UP(real_gck_rate, 120000000) - 1;
>> +	writew(SDHCI_AT91_PRESET_COMMON_CONF | preset_div,
>> +	       host->ioaddr + SDHCI_PRESET_FOR_SDR104);
>> +	preset_div = DIV_ROUND_UP(real_gck_rate, 50000000) - 1;
>> +	writew(SDHCI_AT91_PRESET_COMMON_CONF | preset_div,
>> +	       host->ioaddr + SDHCI_PRESET_FOR_DDR50);
>> +
>> +	clk_prepare_enable(priv->mainck);
>> +	clk_prepare_enable(priv->gck);
>> +
>> +	return 0;
>> +}
>> +
>>  #ifdef CONFIG_PM
>>  static int sdhci_at91_runtime_suspend(struct device *dev)
>>  {
>> @@ -192,11 +270,7 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>>  	struct sdhci_host		*host;
>>  	struct sdhci_pltfm_host		*pltfm_host;
>>  	struct sdhci_at91_priv		*priv;
>> -	unsigned int			caps0, caps1;
>> -	unsigned int			clk_base, clk_mul;
>> -	unsigned int			gck_rate, real_gck_rate;
>>  	int				ret;
>> -	unsigned int			preset_div;
>>  
>>  	match = of_match_device(sdhci_at91_dt_match, &pdev->dev);
>>  	if (!match)
>> @@ -228,66 +302,9 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>>  		return PTR_ERR(priv->gck);
>>  	}
>>  
>> -	/*
>> -	 * The mult clock is provided by as a generated clock by the PMC
>> -	 * controller. In order to set the rate of gck, we have to get the
>> -	 * base clock rate and the clock mult from capabilities.
>> -	 */
>> -	clk_prepare_enable(priv->hclock);
>> -	caps0 = readl(host->ioaddr + SDHCI_CAPABILITIES);
>> -	caps1 = readl(host->ioaddr + SDHCI_CAPABILITIES_1);
>> -	clk_base = (caps0 & SDHCI_CLOCK_V3_BASE_MASK) >> SDHCI_CLOCK_BASE_SHIFT;
>> -	clk_mul = (caps1 & SDHCI_CLOCK_MUL_MASK) >> SDHCI_CLOCK_MUL_SHIFT;
>> -	gck_rate = clk_base * 1000000 * (clk_mul + 1);
>> -	ret = clk_set_rate(priv->gck, gck_rate);
>> -	if (ret < 0) {
>> -		dev_err(&pdev->dev, "failed to set gck");
>> -		goto hclock_disable_unprepare;
>> -	}
>> -	/*
>> -	 * We need to check if we have the requested rate for gck because in
>> -	 * some cases this rate could be not supported. If it happens, the rate
>> -	 * is the closest one gck can provide. We have to update the value
>> -	 * of clk mul.
>> -	 */
>> -	real_gck_rate = clk_get_rate(priv->gck);
>> -	if (real_gck_rate != gck_rate) {
>> -		clk_mul = real_gck_rate / (clk_base * 1000000) - 1;
>> -		caps1 &= (~SDHCI_CLOCK_MUL_MASK);
>> -		caps1 |= ((clk_mul << SDHCI_CLOCK_MUL_SHIFT) & SDHCI_CLOCK_MUL_MASK);
>> -		/* Set capabilities in r/w mode. */
>> -		writel(SDMMC_CACR_KEY | SDMMC_CACR_CAPWREN, host->ioaddr + SDMMC_CACR);
>> -		writel(caps1, host->ioaddr + SDHCI_CAPABILITIES_1);
>> -		/* Set capabilities in ro mode. */
>> -		writel(0, host->ioaddr + SDMMC_CACR);
>> -		dev_info(&pdev->dev, "update clk mul to %u as gck rate is %u Hz\n",
>> -			 clk_mul, real_gck_rate);
>> -	}
>> -
>> -	/*
>> -	 * We have to set preset values because it depends on the clk_mul
>> -	 * value. Moreover, SDR104 is supported in a degraded mode since the
>> -	 * maximum sd clock value is 120 MHz instead of 208 MHz. For that
>> -	 * reason, we need to use presets to support SDR104.
>> -	 */
>> -	preset_div = DIV_ROUND_UP(real_gck_rate, 24000000) - 1;
>> -	writew(SDHCI_AT91_PRESET_COMMON_CONF | preset_div,
>> -	       host->ioaddr + SDHCI_PRESET_FOR_SDR12);
>> -	preset_div = DIV_ROUND_UP(real_gck_rate, 50000000) - 1;
>> -	writew(SDHCI_AT91_PRESET_COMMON_CONF | preset_div,
>> -	       host->ioaddr + SDHCI_PRESET_FOR_SDR25);
>> -	preset_div = DIV_ROUND_UP(real_gck_rate, 100000000) - 1;
>> -	writew(SDHCI_AT91_PRESET_COMMON_CONF | preset_div,
>> -	       host->ioaddr + SDHCI_PRESET_FOR_SDR50);
>> -	preset_div = DIV_ROUND_UP(real_gck_rate, 120000000) - 1;
>> -	writew(SDHCI_AT91_PRESET_COMMON_CONF | preset_div,
>> -	       host->ioaddr + SDHCI_PRESET_FOR_SDR104);
>> -	preset_div = DIV_ROUND_UP(real_gck_rate, 50000000) - 1;
>> -	writew(SDHCI_AT91_PRESET_COMMON_CONF | preset_div,
>> -	       host->ioaddr + SDHCI_PRESET_FOR_DDR50);
>> -
>> -	clk_prepare_enable(priv->mainck);
>> -	clk_prepare_enable(priv->gck);
>> +	ret = sdhci_at91_set_clks_presets(&pdev->dev);
>> +	if (ret)
>> +		goto sdhci_pltfm_free;
>>  
>>  	ret = mmc_of_parse(host->mmc);
>>  	if (ret)
>> @@ -335,8 +352,8 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>>  clocks_disable_unprepare:
>>  	clk_disable_unprepare(priv->gck);
>>  	clk_disable_unprepare(priv->mainck);
>> -hclock_disable_unprepare:
>>  	clk_disable_unprepare(priv->hclock);
>> +sdhci_pltfm_free:
>>  	sdhci_pltfm_free(pdev);
>>  	return ret;
>>  }
>>
> 

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
