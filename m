Return-Path: <SRS0=cOhd=DH=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C53C2D0A8
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Sep 2020 07:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C879B2075F
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Sep 2020 07:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbgI3H0Z (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Sep 2020 03:26:25 -0400
Received: from mga01.intel.com ([192.55.52.88]:12016 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbgI3H0Z (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 30 Sep 2020 03:26:25 -0400
IronPort-SDR: eHQb5E+wkBym6MQo1n/1FZ5MwXP1M1ZFlIFBO2yfv7Bh+OAP9mNoooxY05tHrR35Uzq7HkvNQo
 Grb87LHiMcqQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="180539113"
X-IronPort-AV: E=Sophos;i="5.77,321,1596524400"; 
   d="scan'208";a="180539113"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 00:26:23 -0700
IronPort-SDR: gv7aeCEP2U8IHDXCg30udvRgJTs+JWm+5IGsLBUxCrvR5up3NMNDd0kIETVu628S/ixK9WA40E
 iQ3gluPfMgkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,321,1596524400"; 
   d="scan'208";a="457557859"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.190]) ([10.237.72.190])
  by orsmga004.jf.intel.com with ESMTP; 30 Sep 2020 00:26:18 -0700
Subject: Re: [PATCH 1/2] mmc: sdhci-acpi: AMDI0040: Set
 SDHCI_QUIRK2_PRESET_VALUE_BROKEN
To:     Raul E Rangel <rrangel@chromium.org>, linux-mmc@vger.kernel.org
Cc:     Shirish.S@amd.com, Akshu.Agrawal@amd.com,
        Nehal-bakulchandra.Shah@amd.com, chris.wang@amd.com,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20200928154718.1.Icc21d4b2f354e83e26e57e270dc952f5fe0b0a40@changeid>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <5094f730-ab5c-b0e4-677d-e53d3e42b52e@intel.com>
Date:   Wed, 30 Sep 2020 10:25:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200928154718.1.Icc21d4b2f354e83e26e57e270dc952f5fe0b0a40@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 29/09/20 12:59 am, Raul E Rangel wrote:
> This change fixes HS400 tuning for devices with invalid presets.
> 
> SDHCI presets are not currently used for eMMC HS/HS200/HS400, but are
> used for DDR52. The HS400 retuning sequence is:
> 
>     HS400->DDR52->HS->HS200->Perform Tuning->HS->HS400
> 
> This means that when HS400 tuning happens, we transition through DDR52
> for a very brief period. This causes presets to be enabled
> unintentionally and stay enabled when transitioning back to HS200 or
> HS400. Some firmware has invalid presets, so we end up with driver
> strengths that can cause I/O problems.
> 
> Fixes: 34597a3f60b1 ("mmc: sdhci-acpi: Add support for ACPI HID of AMD Controller with HS400")
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> I decided to abandon adding the preset_value_support for now. Enabling
> presets for the AMD controller currently results in using invalid
> presets for HS400. This is because sdhci_get_preset_value is using a
> non-standard HS400 register that the AMD controller does not support.
> 
> I think preset_value_support also needs more thought. Since HS400
> re-tuning requires switching to HS, DDR52, and HS200, if one of those
> timings is not in the list, we would need to disable presets.
> 
> I chose this approach to avoid any additional complexity.
> 
>  drivers/mmc/host/sdhci-acpi.c | 37 +++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 284cba11e2795..d335a34ad05b3 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -662,6 +662,43 @@ static int sdhci_acpi_emmc_amd_probe_slot(struct platform_device *pdev,
>  	    (host->mmc->caps & MMC_CAP_1_8V_DDR))
>  		host->mmc->caps2 = MMC_CAP2_HS400_1_8V;
>  
> +	/*
> +	 * There are two types of presets out in the wild:
> +	 * 1) Default/broken presets.
> +	 *    These presets have two sets of problems:
> +	 *    a) The clock divisor for SDR12, SDR25, and SDR50 is too small.
> +	 *       This results in clock frequencies that are 2x higher than
> +	 *       acceptable. i.e., SDR12 = 25 MHz, SDR25 = 50 MHz, SDR50 =
> +	 *       100 MHz.x
> +	 *    b) The HS200 and HS400 driver strengths don't match.
> +	 *       By default, the SDR104 preset register has a driver strength of
> +	 *       A, but the (internal) HS400 preset register has a driver
> +	 *       strength of B. As part of initializing HS400, HS200 tuning
> +	 *       needs to be performed. Having different driver strengths
> +	 *       between tuning and operation is wrong. It results in different
> +	 *       rise/fall times that lead to incorrect sampling.
> +	 * 2) Firmware with properly initialized presets.
> +	 *    These presets have proper clock divisors. i.e., SDR12 => 12MHz,
> +	 *    SDR25 => 25 MHz, SDR50 => 50 MHz. Additionally the HS200 and
> +	 *    HS400 preset driver strengths match.
> +	 *
> +	 *    Enabling presets for HS400 doesn't work for the following reasons:
> +	 *    1) sdhci_set_ios has a hard coded list of timings that are used
> +	 *       to determine if presets should be enabled.
> +	 *    2) sdhci_get_preset_value is using a non-standard register to
> +	 *       read out HS400 presets. The AMD controller doesn't support this
> +	 *       non-standard register. In fact, it doesn't expose the HS400
> +	 *       preset register anywhere in the SDHCI memory map. This results
> +	 *       in reading a garbage value and using the wrong presets.
> +	 *
> +	 *       Since HS400 and HS200 presets must be identical, we could
> +	 *       instead use the the SDR104 preset register.
> +	 *
> +	 *    If the above issues are resolved we could remove this quirk for
> +	 *    firmware that that has valid presets (i.e., SDR12 <= 12 MHz).
> +	 */
> +	host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
> +
>  	host->mmc_host_ops.select_drive_strength = amd_select_drive_strength;
>  	host->mmc_host_ops.set_ios = amd_set_ios;
>  	host->mmc_host_ops.execute_tuning = amd_sdhci_execute_tuning;
> 

