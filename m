Return-Path: <SRS0=lEQw=EC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD471C388F9
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Oct 2020 13:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72C962076A
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Oct 2020 13:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440891AbgJ0NCd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 27 Oct 2020 09:02:33 -0400
Received: from mga12.intel.com ([192.55.52.136]:40922 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440804AbgJ0NCd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 27 Oct 2020 09:02:33 -0400
IronPort-SDR: etGgZYkFCOYcT0UEtb826S4RqTbMVB1B6djlOp4UCL9mXKG0nG1+nt6402142vVGxertHxVGJ4
 XkhwdmXcsWcw==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="147357249"
X-IronPort-AV: E=Sophos;i="5.77,423,1596524400"; 
   d="scan'208";a="147357249"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 06:02:08 -0700
IronPort-SDR: kHdz/ktvsii3t9245pqWNz7zKyJpzsg81WqSKMK6y085wpfSOdb1fFalG019Jm3Lx1XULnkx3f
 WH5D0+kPxr5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,423,1596524400"; 
   d="scan'208";a="468289779"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.94]) ([10.237.72.94])
  by orsmga004.jf.intel.com with ESMTP; 27 Oct 2020 06:02:05 -0700
Subject: Re: [PATCH v2] mmc: sdhci-acpi: AMDI0040: Allow changing HS200/HS400
 driver strength
To:     Victor Ding <victording@google.com>, linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Raul E Rangel <rrangel@chromium.org>,
        linux-mmc@vger.kernel.org
References: <20201027084612.528301-1-victording@google.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <468bfe68-6595-0792-0ccc-3971aeca5478@intel.com>
Date:   Tue, 27 Oct 2020 15:01:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201027084612.528301-1-victording@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 27/10/20 10:46 am, Victor Ding wrote:
> From: Raul E Rangel <rrangel@chromium.org>
> 
> This change will allow platform designers better control over signal
> integrity by allowing them to tune the HS200 and HS400 driver strengths.
> 
> The driver strength was previously hard coded to A to solve boot
> problems with certain platforms. This driver strength does not
> universally apply to all platforms so we need a knob to adjust it.
> 
> All older platforms currently have the SDR104 preset hard coded to A in
> the firmware. This means that switching from the hard coded value in
> the kernel to reading the SDR104 preset is a no-op for these platforms.
> Newer platforms will have properly set presets. So this change will
> support both new and old platforms.
> 
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> Signed-off-by: Victor Ding <victording@google.com>

Apart from unnecessary blank line after "return preset_driver_strength;"

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> ---
> 
> Changes in v2:
> By Victor Ding <victording@google.com>
>  - Rebased the patch by using FIELD_GET for preset value bit masks.
>  - (No functional changes).
> 
> The original patch was developed by Raul E Rangel.
> https://patchwork.kernel.org/project/linux-mmc/patch/20200928154718.2.Ic6b6031366f090393d00a53fd69e1ada31ceb29e@changeid/
> 
>  drivers/mmc/host/sdhci-acpi.c | 39 ++++++++++++++++++++++++++++++++---
>  1 file changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 54205e3be9e8..225cb34cf1b9 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -5,6 +5,7 @@
>   * Copyright (c) 2012, Intel Corporation.
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/init.h>
>  #include <linux/export.h>
>  #include <linux/module.h>
> @@ -545,10 +546,42 @@ struct amd_sdhci_host {
>  
>  static int amd_select_drive_strength(struct mmc_card *card,
>  				     unsigned int max_dtr, int host_drv,
> -				     int card_drv, int *drv_type)
> +				     int card_drv, int *host_driver_strength)
>  {
> -	*drv_type = MMC_SET_DRIVER_TYPE_A;
> -	return MMC_SET_DRIVER_TYPE_A;
> +	struct sdhci_host *host = mmc_priv(card->host);
> +	u16 preset, preset_driver_strength;
> +
> +	/*
> +	 * This method is only called by mmc_select_hs200 so we only need to
> +	 * read from the HS200 (SDR104) preset register.
> +	 *
> +	 * Firmware that has "invalid/default" presets return a driver strength
> +	 * of A. This matches the previously hard coded value.
> +	 */
> +	preset = sdhci_readw(host, SDHCI_PRESET_FOR_SDR104);
> +	preset_driver_strength = FIELD_GET(SDHCI_PRESET_DRV_MASK, preset);
> +
> +	/*
> +	 * We want the controller driver strength to match the card's driver
> +	 * strength so they have similar rise/fall times.
> +	 *
> +	 * The controller driver strength set by this method is sticky for all
> +	 * timings after this method is called. This unfortunately means that
> +	 * while HS400 tuning is in progress we end up with mismatched driver
> +	 * strengths between the controller and the card. HS400 tuning requires
> +	 * switching from HS400->DDR52->HS->HS200->HS400. So the driver mismatch
> +	 * happens while in DDR52 and HS modes. This has not been observed to
> +	 * cause problems. Enabling presets would fix this issue.
> +	 */
> +	*host_driver_strength = preset_driver_strength;
> +
> +	/*
> +	 * The resulting card driver strength is only set when switching the
> +	 * card's timing to HS200 or HS400. The card will use the default driver
> +	 * strength (B) for any other mode.
> +	 */
> +	return preset_driver_strength;
> +

Unnecessary blank line.

>  }
>  
>  static void sdhci_acpi_amd_hs400_dll(struct sdhci_host *host, bool enable)
> 

