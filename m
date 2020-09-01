Return-Path: <SRS0=T3o1=CK=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E33C433E6
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Sep 2020 12:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6436207BC
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Sep 2020 12:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgIAMXf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 1 Sep 2020 08:23:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:29629 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727924AbgIAMUk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 1 Sep 2020 08:20:40 -0400
IronPort-SDR: +Y58Nfe+2xzVBuQxPOE+vtsc1+Wo1uJ+KW23QY3mC6uaplk7FjyWZLJbjtBUXRxPQAzoqV5Vyh
 b+zDFGALAmHg==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="154663713"
X-IronPort-AV: E=Sophos;i="5.76,379,1592895600"; 
   d="scan'208";a="154663713"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 05:20:15 -0700
IronPort-SDR: zK7OorMoSOaxzYDHEAlRJHlcn2R5hw3H7mViMqe8GXURp2ENj082eqMQvZvaO5zr/iL5lfA63X
 mLFakkxiBMtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,379,1592895600"; 
   d="scan'208";a="502221986"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by fmsmga005.fm.intel.com with ESMTP; 01 Sep 2020 05:20:08 -0700
Subject: Re: [PATCH] mmc: sdhci-acpi: Clear amd_sdhci_host on reset
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     Nehal-bakulchandra.Shah@amd.com, chris.wang@amd.com,
        Akshu.Agrawal@amd.com, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
References: <20200831150517.1.I93c78bfc6575771bb653c9d3fca5eb018a08417d@changeid>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <99bd9e1a-7062-83d5-8416-9aef53d2eda0@intel.com>
Date:   Tue, 1 Sep 2020 15:19:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200831150517.1.I93c78bfc6575771bb653c9d3fca5eb018a08417d@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 1/09/20 12:10 am, Raul E Rangel wrote:
> commit 61d7437ed1390 ("mmc: sdhci-acpi: Fix HS400 tuning for AMDI0040")
> broke resume for HS400. When the system suspends the eMMC controller is
> powered down. So on resume we need to reinitialize the controller.
> amd_sdhci_host was not getting cleared, so the DLL was never re-enabled
> on resume. This results in HS400 being non-functional.
> 
> This change clears the tuned_clock flag, clears the dll_enabled flag and
> disables the DLL on reset.
> 
> Fixes: 61d7437ed1390 ("mmc: sdhci-acpi: Fix HS400 tuning for AMDI0040")
> 
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> - Performed 100+ suspend/resume cycles without issue.
> - Also verified tuning continues to work.
> 
>  drivers/mmc/host/sdhci-acpi.c | 31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 962f074ca1742..284cba11e2795 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -551,12 +551,18 @@ static int amd_select_drive_strength(struct mmc_card *card,
>  	return MMC_SET_DRIVER_TYPE_A;
>  }
>  
> -static void sdhci_acpi_amd_hs400_dll(struct sdhci_host *host)
> +static void sdhci_acpi_amd_hs400_dll(struct sdhci_host *host, bool enable)
>  {
> +	struct sdhci_acpi_host *acpi_host = sdhci_priv(host);
> +	struct amd_sdhci_host *amd_host = sdhci_acpi_priv(acpi_host);
> +
>  	/* AMD Platform requires dll setting */
>  	sdhci_writel(host, 0x40003210, SDHCI_AMD_RESET_DLL_REGISTER);
>  	usleep_range(10, 20);
> -	sdhci_writel(host, 0x40033210, SDHCI_AMD_RESET_DLL_REGISTER);
> +	if (enable)
> +		sdhci_writel(host, 0x40033210, SDHCI_AMD_RESET_DLL_REGISTER);
> +
> +	amd_host->dll_enabled = enable;
>  }
>  
>  /*
> @@ -596,10 +602,8 @@ static void amd_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  
>  		/* DLL is only required for HS400 */
>  		if (host->timing == MMC_TIMING_MMC_HS400 &&
> -		    !amd_host->dll_enabled) {
> -			sdhci_acpi_amd_hs400_dll(host);
> -			amd_host->dll_enabled = true;
> -		}
> +		    !amd_host->dll_enabled)
> +			sdhci_acpi_amd_hs400_dll(host, true);
>  	}
>  }
>  
> @@ -620,10 +624,23 @@ static int amd_sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  	return err;
>  }
>  
> +static void amd_sdhci_reset(struct sdhci_host *host, u8 mask)
> +{
> +	struct sdhci_acpi_host *acpi_host = sdhci_priv(host);
> +	struct amd_sdhci_host *amd_host = sdhci_acpi_priv(acpi_host);
> +
> +	if (mask & SDHCI_RESET_ALL) {
> +		amd_host->tuned_clock = false;
> +		sdhci_acpi_amd_hs400_dll(host, false);
> +	}
> +
> +	sdhci_reset(host, mask);
> +}
> +
>  static const struct sdhci_ops sdhci_acpi_ops_amd = {
>  	.set_clock	= sdhci_set_clock,
>  	.set_bus_width	= sdhci_set_bus_width,
> -	.reset		= sdhci_reset,
> +	.reset		= amd_sdhci_reset,
>  	.set_uhs_signaling = sdhci_set_uhs_signaling,
>  };
>  
> 

