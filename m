Return-Path: <SRS0=eJC8=BP=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD08C433DF
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Aug 2020 08:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D64F22B45
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Aug 2020 08:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgHEIHJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Aug 2020 04:07:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:27768 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728103AbgHEIG7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 5 Aug 2020 04:06:59 -0400
IronPort-SDR: zFV+RSDXo+QrxeBWfm5urjuU+5dK/syNoNXjrI/wBF9hNaWxlMt4cEZWk+YS2uzhuQPmIWy6sy
 0R6yjcZIUBNA==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="132565404"
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="132565404"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 01:06:56 -0700
IronPort-SDR: TXCzUvfTE8HQm5pRaoT3axqbHZpTJ9m0DQlZimClpzcxkZNDv90pZBYKMOQERpX3hG3+4OXvIn
 l9U1IhTsjg3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="493195293"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by fmsmga005.fm.intel.com with ESMTP; 05 Aug 2020 01:06:54 -0700
Subject: Re: [PATCH v2 6/6] sdhci: tegra: Add missing TMCLK for data timeout
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        ulf.hansson@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
References: <1596515363-27235-1-git-send-email-skomatineni@nvidia.com>
 <1596515363-27235-7-git-send-email-skomatineni@nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <d131fc8c-fa1f-cb67-fe6a-955d3582d1d6@intel.com>
Date:   Wed, 5 Aug 2020 11:06:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1596515363-27235-7-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 4/08/20 7:29 am, Sowjanya Komatineni wrote:
> commit b5a84ecf025a ("mmc: tegra: Add Tegra210 support")

So that could be a Fixes tag also?

> 
> Tegra210 and later has a separate sdmmc_legacy_tm (TMCLK) used by Tegra
> SDMMC hawdware for data timeout to achive better timeout than using
> SDCLK and using TMCLK is recommended.
> 
> USE_TMCLK_FOR_DATA_TIMEOUT bit in Tegra SDMMC register
> SDHCI_TEGRA_VENDOR_SYS_SW_CTRL can be used to choose either TMCLK or
> SDCLK for data timeout.
> 
> Default USE_TMCLK_FOR_DATA_TIMEOUT bit is set to 1 and TMCLK is used
> for data timeout by Tegra SDMMC hardware and having TMCLK not enabled
> is not recommended.
> 
> So, this patch fixes it.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-tegra.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 31ed321..c0b9405 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -140,6 +140,7 @@ struct sdhci_tegra_autocal_offsets {
>  struct sdhci_tegra {
>  	const struct sdhci_tegra_soc_data *soc_data;
>  	struct gpio_desc *power_gpio;
> +	struct clk *tmclk;
>  	bool ddr_signaling;
>  	bool pad_calib_required;
>  	bool pad_control_available;
> @@ -1611,6 +1612,44 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>  		goto err_power_req;
>  	}
>  
> +	/*
> +	 * Tegra210 has a separate SDMMC_LEGACY_TM clock used for host
> +	 * timeout clock and SW can choose TMCLK or SDCLK for hardware
> +	 * data timeout through the bit USE_TMCLK_FOR_DATA_TIMEOUT of
> +	 * the register SDHCI_TEGRA_VENDOR_SYS_SW_CTRL.
> +	 *
> +	 * USE_TMCLK_FOR_DATA_TIMEOUT bit default is set to 1 and SDMMC uses
> +	 * 12Mhz TMCLK which is advertised in host capability register.
> +	 * With TMCLK of 12Mhz provides maximum data timeout period that can
> +	 * be achieved is 11s better than using SDCLK for data timeout.
> +	 *
> +	 * So, TMCLK is set to 12Mhz and kept enabled all the time on SoC's
> +	 * supporting SDR104 mode and when not using SDCLK for data timeout.
> +	 */
> +
> +	if ((soc_data->nvquirks & NVQUIRK_ENABLE_SDR104) &&
> +	    !(soc_data->pdata->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)) {
> +		clk = devm_clk_get(&pdev->dev, "tmclk");
> +		if (IS_ERR(clk)) {
> +			rc = PTR_ERR(clk);
> +			if (rc == -EPROBE_DEFER)
> +				goto err_power_req;
> +
> +			dev_warn(&pdev->dev, "failed to get tmclk: %d\n", rc);
> +			clk = NULL;
> +		}
> +
> +		clk_set_rate(clk, 12000000);
> +		rc = clk_prepare_enable(clk);
> +		if (rc) {
> +			dev_err(&pdev->dev,
> +				"failed to enable tmclk: %d\n", rc);
> +			goto err_power_req;
> +		}
> +
> +		tegra_host->tmclk = clk;
> +	}
> +
>  	clk = devm_clk_get(mmc_dev(host->mmc), NULL);
>  	if (IS_ERR(clk)) {
>  		rc = PTR_ERR(clk);
> @@ -1654,6 +1693,7 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>  err_rst_get:
>  	clk_disable_unprepare(pltfm_host->clk);
>  err_clk_get:
> +	clk_disable_unprepare(tegra_host->tmclk);
>  err_power_req:
>  err_parse_dt:
>  	sdhci_pltfm_free(pdev);
> @@ -1671,6 +1711,7 @@ static int sdhci_tegra_remove(struct platform_device *pdev)
>  	reset_control_assert(tegra_host->rst);
>  	usleep_range(2000, 4000);
>  	clk_disable_unprepare(pltfm_host->clk);
> +	clk_disable_unprepare(tegra_host->tmclk);
>  
>  	sdhci_pltfm_free(pdev);
>  
> 

