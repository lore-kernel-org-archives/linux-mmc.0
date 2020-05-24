Return-Path: <SRS0=G4HJ=7G=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B68C433DF
	for <linux-mmc@archiver.kernel.org>; Sun, 24 May 2020 15:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB21D207CB
	for <linux-mmc@archiver.kernel.org>; Sun, 24 May 2020 15:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387453AbgEXPdG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 24 May 2020 11:33:06 -0400
Received: from mga04.intel.com ([192.55.52.120]:4655 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728879AbgEXPdG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 24 May 2020 11:33:06 -0400
IronPort-SDR: 3YwnvRi7lHSeMg/V31Qk3vZ37k7uZ9Npe3RNM16el3I4KrGcNXwmPILoea8GwC7HNhZZXzTgmq
 xnWM1HJpms5A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2020 08:33:06 -0700
IronPort-SDR: QrK45m7zkqwMl8XRO5Mfaqz70ESsi8VKLD55T6xbt2A38ozJiTIaPwCWhwV2nvnjwQiK5lcLoI
 A5UliBJzU+yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,430,1583222400"; 
   d="scan'208";a="413277405"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.157]) ([10.237.72.157])
  by orsmga004.jf.intel.com with ESMTP; 24 May 2020 08:33:03 -0700
Subject: Re: [PATCH] sdhci: tegra: Avoid reading autocal timeout values when
 not applicable
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        ulf.hansson@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com
Cc:     digetx@gmail.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
References: <1590005337-1087-1-git-send-email-skomatineni@nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <c29287da-a497-8b5e-7275-d2254ee4fb7e@intel.com>
Date:   Sun, 24 May 2020 18:33:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1590005337-1087-1-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 20/05/20 11:08 pm, Sowjanya Komatineni wrote:
> When auto calibration timeouts, calibration is disabled and fail-safe
> drive strength values are programmed based on the signal voltage.
> 
> Different fail-safe drive strength values based on voltage are
> applicable only for SoCs supporting 3V3 and 1V8 pad controls.
> 
> So, this patch avoids reading these properties from the device tree
> for SoCs not using pad controls and the warning of missing properties
> will not show up on these SoC platforms.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-tegra.c | 57 ++++++++++++++++++++++++------------------
>  1 file changed, 33 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 3e2c510..141b49b 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -605,6 +605,39 @@ static void tegra_sdhci_parse_pad_autocal_dt(struct sdhci_host *host)
>  		autocal->pull_down_1v8 = 0;
>  
>  	err = device_property_read_u32(host->mmc->parent,
> +			"nvidia,pad-autocal-pull-up-offset-sdr104",
> +			&autocal->pull_up_sdr104);
> +	if (err)
> +		autocal->pull_up_sdr104 = autocal->pull_up_1v8;
> +
> +	err = device_property_read_u32(host->mmc->parent,
> +			"nvidia,pad-autocal-pull-down-offset-sdr104",
> +			&autocal->pull_down_sdr104);
> +	if (err)
> +		autocal->pull_down_sdr104 = autocal->pull_down_1v8;
> +
> +	err = device_property_read_u32(host->mmc->parent,
> +			"nvidia,pad-autocal-pull-up-offset-hs400",
> +			&autocal->pull_up_hs400);
> +	if (err)
> +		autocal->pull_up_hs400 = autocal->pull_up_1v8;
> +
> +	err = device_property_read_u32(host->mmc->parent,
> +			"nvidia,pad-autocal-pull-down-offset-hs400",
> +			&autocal->pull_down_hs400);
> +	if (err)
> +		autocal->pull_down_hs400 = autocal->pull_down_1v8;
> +
> +	/*
> +	 * Different fail-safe drive strength values based on the signaling
> +	 * voltage are applicable for SoCs supporting 3V3 and 1V8 pad controls.
> +	 * So, avoid reading below device tree properies for SoCs that don't
> +	 * have NVQUIRK_NEEDS_PAD_CONTROL.
> +	 */
> +	if (!(tegra_host->soc_data->nvquirks & NVQUIRK_NEEDS_PAD_CONTROL))
> +		return;
> +
> +	err = device_property_read_u32(host->mmc->parent,
>  			"nvidia,pad-autocal-pull-up-offset-3v3-timeout",
>  			&autocal->pull_up_3v3_timeout);
>  	if (err) {
> @@ -647,30 +680,6 @@ static void tegra_sdhci_parse_pad_autocal_dt(struct sdhci_host *host)
>  				mmc_hostname(host->mmc));
>  		autocal->pull_down_1v8_timeout = 0;
>  	}
> -
> -	err = device_property_read_u32(host->mmc->parent,
> -			"nvidia,pad-autocal-pull-up-offset-sdr104",
> -			&autocal->pull_up_sdr104);
> -	if (err)
> -		autocal->pull_up_sdr104 = autocal->pull_up_1v8;
> -
> -	err = device_property_read_u32(host->mmc->parent,
> -			"nvidia,pad-autocal-pull-down-offset-sdr104",
> -			&autocal->pull_down_sdr104);
> -	if (err)
> -		autocal->pull_down_sdr104 = autocal->pull_down_1v8;
> -
> -	err = device_property_read_u32(host->mmc->parent,
> -			"nvidia,pad-autocal-pull-up-offset-hs400",
> -			&autocal->pull_up_hs400);
> -	if (err)
> -		autocal->pull_up_hs400 = autocal->pull_up_1v8;
> -
> -	err = device_property_read_u32(host->mmc->parent,
> -			"nvidia,pad-autocal-pull-down-offset-hs400",
> -			&autocal->pull_down_hs400);
> -	if (err)
> -		autocal->pull_down_hs400 = autocal->pull_down_1v8;
>  }
>  
>  static void tegra_sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
> 

