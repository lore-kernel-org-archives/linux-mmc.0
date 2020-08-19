Return-Path: <SRS0=2cKM=B5=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4313AC433DF
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Aug 2020 09:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28DE0207DE
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Aug 2020 09:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgHSJFw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 19 Aug 2020 05:05:52 -0400
Received: from mga17.intel.com ([192.55.52.151]:15408 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbgHSJFv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 19 Aug 2020 05:05:51 -0400
IronPort-SDR: c/iDZ7DxXZx7Gph+5KnhayxSpru5AnoQ29Y9uHdSXem+qpUtxF/roqm92NiC0nO/ZaM2EAvf70
 6BTu7hknqeqQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="135142503"
X-IronPort-AV: E=Sophos;i="5.76,330,1592895600"; 
   d="scan'208";a="135142503"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 02:05:34 -0700
IronPort-SDR: HlCZaYJtG0bXOgLYMEH3+ka4B1mypIN62Gv2IXSj00ZKBL7BcjMhGqoCkJ0GZ5lr4M5sHkmtgB
 YhNGq/9NcIaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,330,1592895600"; 
   d="scan'208";a="320411698"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by fmsmga004.fm.intel.com with ESMTP; 19 Aug 2020 02:05:31 -0700
Subject: Re: [PATCH] mmc: sdhci-acpi: Fix HS400 tuning for AMDI0040
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     Nehal-bakulchandra.Shah@amd.com, chris.wang@amd.com,
        Akshu.Agrawal@amd.com, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
References: <20200818162900.1.Ie8f0689ec9f449203328b37409d1cf06b565f331@changeid>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <9bdadb87-67e2-305e-5dfc-7d0981dc2405@intel.com>
Date:   Wed, 19 Aug 2020 12:04:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818162900.1.Ie8f0689ec9f449203328b37409d1cf06b565f331@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 19/08/20 1:31 am, Raul E Rangel wrote:
> The AMD eMMC Controller can only use the tuned clock while in HS200 and
> HS400 mode. If we switch to a different mode, we need to disable the
> tuned clock. If we have previously performed tuning and switch back to
> HS200 or HS400, we can re-enable the tuned clock.
> 
> Previously the tuned clock was not getting disabled when switching to
> DDR52 which is part of the HS400 tuning sequence.
> 
> Fixes: 34597a3f60b1 ("mmc: sdhci-acpi: Add support for ACPI HID of AMD Controller with HS400")
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>

If you make amd_sdhci_execute_tuning() static as the robot pointed out:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
>  drivers/mmc/host/sdhci-acpi.c | 68 +++++++++++++++++++++++++++++------
>  1 file changed, 58 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 48ecbd0b180d8..5a30920ef595f 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -535,6 +535,11 @@ static const struct sdhci_acpi_slot sdhci_acpi_slot_qcom_sd = {
>  	.caps    = MMC_CAP_NONREMOVABLE,
>  };
>  
> +struct amd_sdhci_host {
> +	bool	tuned_clock;
> +	bool	dll_enabled;
> +};
> +
>  /* AMD sdhci reset dll register. */
>  #define SDHCI_AMD_RESET_DLL_REGISTER    0x908
>  
> @@ -555,26 +560,67 @@ static void sdhci_acpi_amd_hs400_dll(struct sdhci_host *host)
>  }
>  
>  /*
> - * For AMD Platform it is required to disable the tuning
> - * bit first controller to bring to HS Mode from HS200
> - * mode, later enable to tune to HS400 mode.
> + * The initialization sequence for HS400 is:
> + *     HS->HS200->Perform Tuning->HS->HS400
> + *
> + * The re-tuning sequence is:
> + *     HS400->DDR52->HS->HS200->Perform Tuning->HS->HS400
> + *
> + * The AMD eMMC Controller can only use the tuned clock while in HS200 and HS400
> + * mode. If we switch to a different mode, we need to disable the tuned clock.
> + * If we have previously performed tuning and switch back to HS200 or
> + * HS400, we can re-enable the tuned clock.
> + *
>   */
>  static void amd_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_acpi_host *acpi_host = sdhci_priv(host);
> +	struct amd_sdhci_host *amd_host = sdhci_acpi_priv(acpi_host);
>  	unsigned int old_timing = host->timing;
> +	u16 val;
>  
>  	sdhci_set_ios(mmc, ios);
> -	if (old_timing == MMC_TIMING_MMC_HS200 &&
> -	    ios->timing == MMC_TIMING_MMC_HS)
> -		sdhci_writew(host, 0x9, SDHCI_HOST_CONTROL2);
> -	if (old_timing != MMC_TIMING_MMC_HS400 &&
> -	    ios->timing == MMC_TIMING_MMC_HS400) {
> -		sdhci_writew(host, 0x80, SDHCI_HOST_CONTROL2);
> -		sdhci_acpi_amd_hs400_dll(host);
> +
> +	if (old_timing != host->timing && amd_host->tuned_clock) {
> +		if (host->timing == MMC_TIMING_MMC_HS400 ||
> +		    host->timing == MMC_TIMING_MMC_HS200) {
> +			val = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +			val |= SDHCI_CTRL_TUNED_CLK;
> +			sdhci_writew(host, val, SDHCI_HOST_CONTROL2);
> +		} else {
> +			val = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +			val &= ~SDHCI_CTRL_TUNED_CLK;
> +			sdhci_writew(host, val, SDHCI_HOST_CONTROL2);
> +		}
> +
> +		/* DLL is only required for HS400 */
> +		if (host->timing == MMC_TIMING_MMC_HS400 &&
> +		    !amd_host->dll_enabled) {
> +			trace_printk("%s: Enabling DLL\n", __func__);
> +			sdhci_acpi_amd_hs400_dll(host);
> +			amd_host->dll_enabled = true;
> +		}
>  	}
>  }
>  
> +int amd_sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
> +{
> +	int err;
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_acpi_host *acpi_host = sdhci_priv(host);
> +	struct amd_sdhci_host *amd_host = sdhci_acpi_priv(acpi_host);
> +
> +	amd_host->tuned_clock = false;
> +
> +	err = sdhci_execute_tuning(mmc, opcode);
> +
> +	if (!err && !host->tuning_err)
> +		amd_host->tuned_clock = true;
> +
> +	return err;
> +}
> +
>  static const struct sdhci_ops sdhci_acpi_ops_amd = {
>  	.set_clock	= sdhci_set_clock,
>  	.set_bus_width	= sdhci_set_bus_width,
> @@ -602,6 +648,7 @@ static int sdhci_acpi_emmc_amd_probe_slot(struct platform_device *pdev,
>  
>  	host->mmc_host_ops.select_drive_strength = amd_select_drive_strength;
>  	host->mmc_host_ops.set_ios = amd_set_ios;
> +	host->mmc_host_ops.execute_tuning = amd_sdhci_execute_tuning;
>  	return 0;
>  }
>  
> @@ -613,6 +660,7 @@ static const struct sdhci_acpi_slot sdhci_acpi_slot_amd_emmc = {
>  			  SDHCI_QUIRK_32BIT_ADMA_SIZE,
>  	.quirks2	= SDHCI_QUIRK2_BROKEN_64_BIT_DMA,
>  	.probe_slot     = sdhci_acpi_emmc_amd_probe_slot,
> +	.priv_size	= sizeof(struct amd_sdhci_host),
>  };
>  
>  struct sdhci_acpi_uid_slot {
> 

