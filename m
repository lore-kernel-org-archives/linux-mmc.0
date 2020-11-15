Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9319FC2D0E4
	for <linux-mmc@archiver.kernel.org>; Sun, 15 Nov 2020 20:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D7BF223FB
	for <linux-mmc@archiver.kernel.org>; Sun, 15 Nov 2020 20:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbgKOUni (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 15 Nov 2020 15:43:38 -0500
Received: from mga03.intel.com ([134.134.136.65]:30369 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727317AbgKOUnh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 15 Nov 2020 15:43:37 -0500
IronPort-SDR: tQTrJoqOmUwZ8C+Lwh95Zrc44oerLzORo3tkBTIgLvBj+3ITZVlV9hNUxqIX7mb/NRiIMUkTu8
 sf3GOaNLTB2w==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="170779554"
X-IronPort-AV: E=Sophos;i="5.77,481,1596524400"; 
   d="scan'208";a="170779554"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2020 12:43:36 -0800
IronPort-SDR: u9jbGC9fZG23z0o/Jw2BS0gwYGGsozdcACR6K2zXhJK7aLIhD2DekmSKJ/RBVpTsOuPCFZnOPZ
 9jjxxBOAVwiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,481,1596524400"; 
   d="scan'208";a="358235821"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.94]) ([10.237.72.94])
  by fmsmga004.fm.intel.com with ESMTP; 15 Nov 2020 12:43:33 -0800
Subject: Re: [PATCH] mmc: xenon: enable ACPI support in the driver
To:     Marcin Wojtas <mw@semihalf.com>, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, huziji@marvell.com, jaz@semihalf.com,
        tn@semihalf.com, ard.biesheuvel@arm.com, kostap@marvell.com
References: <20201114090811.19356-1-mw@semihalf.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <d7f579f8-30c6-aafa-4c2d-098ec72bba0a@intel.com>
Date:   Sun, 15 Nov 2020 22:43:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201114090811.19356-1-mw@semihalf.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 14/11/20 11:08 am, Marcin Wojtas wrote:
> This patch introduces an alternative way of obtaining resources - via
> ACPI tables provided by firmware. In addition to the of_* -> device_*
> API replacement, sdhci_xenon_acpi_match table was introduced.
> Also, the entire supply clocks configuration had to be skipped,
> because in case of ACPI it is firmware responsibility to enable them.
> 
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>

Seems fine, but maybe split into 3 patches:
1. of_property -> device_property changes and renaming
2. clock changes (if it seems neater, maybe try to simplify to 2 new
functions: one to prepare clocks and one to unprepare clocks)
3. add ACPI device id

> ---
> Hi,
> 
> In case anyone would like to test the patch, I share the EDK2
> firmware for MacchiatoBin board, which has relevant ACPI
> description https://drive.google.com/file/d/1ygdHGl30ww9LAqZAQlTsz2nnhN3Od9GG
> 
> Looking forward to your feedback.
> 
> Best regards,
> Marcin
> 
>  drivers/mmc/host/sdhci-xenon.h     |   4 +-
>  drivers/mmc/host/sdhci-xenon-phy.c |  36 ++++---
>  drivers/mmc/host/sdhci-xenon.c     | 109 +++++++++++++-------
>  3 files changed, 91 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-xenon.h b/drivers/mmc/host/sdhci-xenon.h
> index 593b82d7b68a..542b6ad35ff3 100644
> --- a/drivers/mmc/host/sdhci-xenon.h
> +++ b/drivers/mmc/host/sdhci-xenon.h
> @@ -93,8 +93,8 @@ struct xenon_priv {
>  };
>  
>  int xenon_phy_adj(struct sdhci_host *host, struct mmc_ios *ios);
> -int xenon_phy_parse_dt(struct device_node *np,
> -		       struct sdhci_host *host);
> +int xenon_phy_parse_params(struct device *dev,
> +			   struct sdhci_host *host);
>  void xenon_soc_pad_ctrl(struct sdhci_host *host,
>  			unsigned char signal_voltage);
>  #endif
> diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
> index 03ce57ef4585..a6df95ec31c5 100644
> --- a/drivers/mmc/host/sdhci-xenon-phy.c
> +++ b/drivers/mmc/host/sdhci-xenon-phy.c
> @@ -689,35 +689,37 @@ static int get_dt_pad_ctrl_data(struct sdhci_host *host,
>  	return ret;
>  }
>  
> -static int xenon_emmc_phy_parse_param_dt(struct sdhci_host *host,
> -					 struct device_node *np,
> -					 struct xenon_emmc_phy_params *params)
> +static int xenon_emmc_phy_parse_params(struct sdhci_host *host,
> +				       struct device *dev,
> +				       struct xenon_emmc_phy_params *params)
>  {
>  	u32 value;
>  
>  	params->slow_mode = false;
> -	if (of_property_read_bool(np, "marvell,xenon-phy-slow-mode"))
> +	if (device_property_read_bool(dev, "marvell,xenon-phy-slow-mode"))
>  		params->slow_mode = true;
>  
>  	params->znr = XENON_ZNR_DEF_VALUE;
> -	if (!of_property_read_u32(np, "marvell,xenon-phy-znr", &value))
> +	if (!device_property_read_u32(dev, "marvell,xenon-phy-znr", &value))
>  		params->znr = value & XENON_ZNR_MASK;
>  
>  	params->zpr = XENON_ZPR_DEF_VALUE;
> -	if (!of_property_read_u32(np, "marvell,xenon-phy-zpr", &value))
> +	if (!device_property_read_u32(dev, "marvell,xenon-phy-zpr", &value))
>  		params->zpr = value & XENON_ZPR_MASK;
>  
>  	params->nr_tun_times = XENON_TUN_CONSECUTIVE_TIMES;
> -	if (!of_property_read_u32(np, "marvell,xenon-phy-nr-success-tun",
> -				  &value))
> +	if (!device_property_read_u32(dev, "marvell,xenon-phy-nr-success-tun",
> +				      &value))
>  		params->nr_tun_times = value & XENON_TUN_CONSECUTIVE_TIMES_MASK;
>  
>  	params->tun_step_divider = XENON_TUNING_STEP_DIVIDER;
> -	if (!of_property_read_u32(np, "marvell,xenon-phy-tun-step-divider",
> -				  &value))
> +	if (!device_property_read_u32(dev, "marvell,xenon-phy-tun-step-divider",
> +				      &value))
>  		params->tun_step_divider = value & 0xFF;
>  
> -	return get_dt_pad_ctrl_data(host, np, params);
> +	if (dev->of_node)
> +		return get_dt_pad_ctrl_data(host, dev->of_node, params);
> +	return 0;
>  }
>  
>  /* Set SoC PHY Voltage PAD */
> @@ -811,7 +813,7 @@ int xenon_phy_adj(struct sdhci_host *host, struct mmc_ios *ios)
>  	return ret;
>  }
>  
> -static int xenon_add_phy(struct device_node *np, struct sdhci_host *host,
> +static int xenon_add_phy(struct device *dev, struct sdhci_host *host,
>  			 const char *phy_name)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -830,15 +832,15 @@ static int xenon_add_phy(struct device_node *np, struct sdhci_host *host,
>  	if (ret)
>  		return ret;
>  
> -	return xenon_emmc_phy_parse_param_dt(host, np, priv->phy_params);
> +	return xenon_emmc_phy_parse_params(host, dev, priv->phy_params);
>  }
>  
> -int xenon_phy_parse_dt(struct device_node *np, struct sdhci_host *host)
> +int xenon_phy_parse_params(struct device *dev, struct sdhci_host *host)
>  {
>  	const char *phy_type = NULL;
>  
> -	if (!of_property_read_string(np, "marvell,xenon-phy-type", &phy_type))
> -		return xenon_add_phy(np, host, phy_type);
> +	if (!device_property_read_string(dev, "marvell,xenon-phy-type", &phy_type))
> +		return xenon_add_phy(dev, host, phy_type);
>  
> -	return xenon_add_phy(np, host, "emmc 5.1 phy");
> +	return xenon_add_phy(dev, host, "emmc 5.1 phy");
>  }
> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> index 24c978de2a3f..f2990e474e58 100644
> --- a/drivers/mmc/host/sdhci-xenon.c
> +++ b/drivers/mmc/host/sdhci-xenon.c
> @@ -11,6 +11,7 @@
>   * Special thanks to Video BG4 project team.
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/delay.h>
>  #include <linux/ktime.h>
>  #include <linux/module.h>
> @@ -247,6 +248,16 @@ static void xenon_voltage_switch(struct sdhci_host *host)
>  	sdhci_readw(host, SDHCI_HOST_CONTROL2);
>  }
>  
> +static unsigned int xenon_get_max_clock(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +
> +	if (pltfm_host->clk)
> +		return sdhci_pltfm_clk_get_max_clock(host);
> +	else
> +		return pltfm_host->clock;
> +}
> +
>  static const struct sdhci_ops sdhci_xenon_ops = {
>  	.voltage_switch		= xenon_voltage_switch,
>  	.set_clock		= sdhci_set_clock,
> @@ -254,7 +265,7 @@ static const struct sdhci_ops sdhci_xenon_ops = {
>  	.set_bus_width		= sdhci_set_bus_width,
>  	.reset			= xenon_reset,
>  	.set_uhs_signaling	= xenon_set_uhs_signaling,
> -	.get_max_clock		= sdhci_pltfm_clk_get_max_clock,
> +	.get_max_clock		= xenon_get_max_clock,
>  };
>  
>  static const struct sdhci_pltfm_data sdhci_xenon_pdata = {
> @@ -407,9 +418,9 @@ static void xenon_replace_mmc_host_ops(struct sdhci_host *host)
>   *	    Refer to XENON_SYS_CFG_INFO register
>   * tun-count: the interval between re-tuning
>   */
> -static int xenon_probe_dt(struct platform_device *pdev)
> +static int xenon_probe_params(struct platform_device *pdev)
>  {
> -	struct device_node *np = pdev->dev.of_node;
> +	struct device *dev = &pdev->dev;
>  	struct sdhci_host *host = platform_get_drvdata(pdev);
>  	struct mmc_host *mmc = host->mmc;
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -418,11 +429,12 @@ static int xenon_probe_dt(struct platform_device *pdev)
>  	u32 tuning_count;
>  
>  	/* Disable HS200 on Armada AP806 */
> -	if (of_device_is_compatible(np, "marvell,armada-ap806-sdhci"))
> +	if (device_property_match_string(dev, "compatible",
> +					 "marvell,armada-ap806-sdhci") >= 0)
>  		host->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
>  
>  	sdhc_id = 0x0;
> -	if (!of_property_read_u32(np, "marvell,xenon-sdhc-id", &sdhc_id)) {
> +	if (!device_property_read_u32(dev, "marvell,xenon-sdhc-id", &sdhc_id)) {
>  		nr_sdhc = sdhci_readl(host, XENON_SYS_CFG_INFO);
>  		nr_sdhc &= XENON_NR_SUPPORTED_SLOT_MASK;
>  		if (unlikely(sdhc_id > nr_sdhc)) {
> @@ -434,8 +446,8 @@ static int xenon_probe_dt(struct platform_device *pdev)
>  	priv->sdhc_id = sdhc_id;
>  
>  	tuning_count = XENON_DEF_TUNING_COUNT;
> -	if (!of_property_read_u32(np, "marvell,xenon-tun-count",
> -				  &tuning_count)) {
> +	if (!device_property_read_u32(dev, "marvell,xenon-tun-count",
> +				      &tuning_count)) {
>  		if (unlikely(tuning_count >= XENON_TMR_RETUN_NO_PRESENT)) {
>  			dev_err(mmc_dev(mmc), "Wrong Re-tuning Count. Set default value %d\n",
>  				XENON_DEF_TUNING_COUNT);
> @@ -444,7 +456,7 @@ static int xenon_probe_dt(struct platform_device *pdev)
>  	}
>  	priv->tuning_count = tuning_count;
>  
> -	return xenon_phy_parse_dt(np, host);
> +	return xenon_phy_parse_params(dev, host);
>  }
>  
>  static int xenon_sdhc_prepare(struct sdhci_host *host)
> @@ -483,6 +495,7 @@ static void xenon_sdhc_unprepare(struct sdhci_host *host)
>  static int xenon_probe(struct platform_device *pdev)
>  {
>  	struct sdhci_pltfm_host *pltfm_host;
> +	struct device *dev = &pdev->dev;
>  	struct sdhci_host *host;
>  	struct xenon_priv *priv;
>  	int err;
> @@ -501,37 +514,39 @@ static int xenon_probe(struct platform_device *pdev)
>  	 */
>  	xenon_replace_mmc_host_ops(host);
>  
> -	pltfm_host->clk = devm_clk_get(&pdev->dev, "core");
> -	if (IS_ERR(pltfm_host->clk)) {
> -		err = PTR_ERR(pltfm_host->clk);
> -		dev_err(&pdev->dev, "Failed to setup input clk: %d\n", err);
> -		goto free_pltfm;
> -	}
> -	err = clk_prepare_enable(pltfm_host->clk);
> -	if (err)
> -		goto free_pltfm;
> -
> -	priv->axi_clk = devm_clk_get(&pdev->dev, "axi");
> -	if (IS_ERR(priv->axi_clk)) {
> -		err = PTR_ERR(priv->axi_clk);
> -		if (err == -EPROBE_DEFER)
> -			goto err_clk;
> -	} else {
> -		err = clk_prepare_enable(priv->axi_clk);
> +	if (dev->of_node) {
> +		pltfm_host->clk = devm_clk_get(&pdev->dev, "core");
> +		if (IS_ERR(pltfm_host->clk)) {
> +			err = PTR_ERR(pltfm_host->clk);
> +			dev_err(&pdev->dev, "Failed to setup input clk: %d\n", err);
> +			goto free_pltfm;
> +		}
> +		err = clk_prepare_enable(pltfm_host->clk);
>  		if (err)
> -			goto err_clk;
> +			goto free_pltfm;
> +
> +		priv->axi_clk = devm_clk_get(&pdev->dev, "axi");
> +		if (IS_ERR(priv->axi_clk)) {
> +			err = PTR_ERR(priv->axi_clk);
> +			if (err == -EPROBE_DEFER)
> +				goto err_clk;
> +		} else {
> +			err = clk_prepare_enable(priv->axi_clk);
> +			if (err)
> +				goto err_clk;
> +		}
>  	}
>  
>  	err = mmc_of_parse(host->mmc);
>  	if (err)
>  		goto err_clk_axi;
>  
> -	sdhci_get_of_property(pdev);
> +	sdhci_get_property(pdev);
>  
>  	xenon_set_acg(host, false);
>  
> -	/* Xenon specific dt parse */
> -	err = xenon_probe_dt(pdev);
> +	/* Xenon specific parameters parse */
> +	err = xenon_probe_params(pdev);
>  	if (err)
>  		goto err_clk_axi;
>  
> @@ -559,9 +574,11 @@ static int xenon_probe(struct platform_device *pdev)
>  	pm_runtime_put_noidle(&pdev->dev);
>  	xenon_sdhc_unprepare(host);
>  err_clk_axi:
> -	clk_disable_unprepare(priv->axi_clk);
> +	if (dev->of_node)
> +		clk_disable_unprepare(priv->axi_clk);
>  err_clk:
> -	clk_disable_unprepare(pltfm_host->clk);
> +	if (dev->of_node)
> +		clk_disable_unprepare(pltfm_host->clk);
>  free_pltfm:
>  	sdhci_pltfm_free(pdev);
>  	return err;
> @@ -572,6 +589,7 @@ static int xenon_remove(struct platform_device *pdev)
>  	struct sdhci_host *host = platform_get_drvdata(pdev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	struct device *dev = &pdev->dev;
>  
>  	pm_runtime_get_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> @@ -580,8 +598,10 @@ static int xenon_remove(struct platform_device *pdev)
>  	sdhci_remove_host(host, 0);
>  
>  	xenon_sdhc_unprepare(host);
> -	clk_disable_unprepare(priv->axi_clk);
> -	clk_disable_unprepare(pltfm_host->clk);
> +	if (dev->of_node) {
> +		clk_disable_unprepare(priv->axi_clk);
> +		clk_disable_unprepare(pltfm_host->clk);
> +	}
>  
>  	sdhci_pltfm_free(pdev);
>  
> @@ -618,7 +638,8 @@ static int xenon_runtime_suspend(struct device *dev)
>  	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
>  		mmc_retune_needed(host->mmc);
>  
> -	clk_disable_unprepare(pltfm_host->clk);
> +	if (dev->of_node)
> +		clk_disable_unprepare(pltfm_host->clk);
>  	/*
>  	 * Need to update the priv->clock here, or when runtime resume
>  	 * back, phy don't aware the clock change and won't adjust phy
> @@ -635,10 +656,12 @@ static int xenon_runtime_resume(struct device *dev)
>  	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>  	int ret;
>  
> -	ret = clk_prepare_enable(pltfm_host->clk);
> -	if (ret) {
> -		dev_err(dev, "can't enable mainck\n");
> -		return ret;
> +	if (dev->of_node) {
> +		ret = clk_prepare_enable(pltfm_host->clk);
> +		if (ret) {
> +			dev_err(dev, "can't enable mainck\n");
> +			return ret;
> +		}
>  	}
>  
>  	if (priv->restore_needed) {
> @@ -653,7 +676,8 @@ static int xenon_runtime_resume(struct device *dev)
>  		goto out;
>  	return 0;
>  out:
> -	clk_disable_unprepare(pltfm_host->clk);
> +	if (dev->of_node)
> +		clk_disable_unprepare(pltfm_host->clk);
>  	return ret;
>  }
>  #endif /* CONFIG_PM */
> @@ -674,11 +698,18 @@ static const struct of_device_id sdhci_xenon_dt_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_xenon_dt_ids);
>  
> +static const struct acpi_device_id sdhci_xenon_acpi_ids[] = {
> +	{ .id = "MRVL0002",},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, sdhci_xenon_acpi_ids);
> +
>  static struct platform_driver sdhci_xenon_driver = {
>  	.driver	= {
>  		.name	= "xenon-sdhci",
>  		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>  		.of_match_table = sdhci_xenon_dt_ids,
> +		.acpi_match_table = ACPI_PTR(sdhci_xenon_acpi_ids),
>  		.pm = &sdhci_xenon_dev_pm_ops,
>  	},
>  	.probe	= xenon_probe,
> 

