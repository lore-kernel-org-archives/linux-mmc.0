Return-Path: <SRS0=cOhd=DH=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC77CC2D0A8
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Sep 2020 07:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B724D2076E
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Sep 2020 07:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgI3H1K (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Sep 2020 03:27:10 -0400
Received: from mga14.intel.com ([192.55.52.115]:39495 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbgI3H1J (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 30 Sep 2020 03:27:09 -0400
IronPort-SDR: kOPivqv35TT++e1LA0spgbotjk4+Irn6Oa7BLXmFix0rWslMkbvxy3laMm/IFTwdIGAdy42pAQ
 GLpisdwzrnkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="161608251"
X-IronPort-AV: E=Sophos;i="5.77,321,1596524400"; 
   d="scan'208";a="161608251"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 00:27:09 -0700
IronPort-SDR: 2fPOYElloMKI7v5pX8NKHadw3mg3Rh/Jeqzqf6QMzdQU0eLLQKP/pg0kHsdYeCPSY+JWHARKFL
 SKh4ZDLDR1Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,321,1596524400"; 
   d="scan'208";a="457557986"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.190]) ([10.237.72.190])
  by orsmga004.jf.intel.com with ESMTP; 30 Sep 2020 00:27:04 -0700
Subject: Re: [PATCH 2/2] mmc: sdhci-acpi: AMDI0040: Allow changing HS200/HS400
 driver strength
To:     Raul E Rangel <rrangel@chromium.org>, linux-mmc@vger.kernel.org
Cc:     Shirish.S@amd.com, Akshu.Agrawal@amd.com,
        Nehal-bakulchandra.Shah@amd.com, chris.wang@amd.com,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20200928154718.1.Icc21d4b2f354e83e26e57e270dc952f5fe0b0a40@changeid>
 <20200928154718.2.Ic6b6031366f090393d00a53fd69e1ada31ceb29e@changeid>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <4e0f1360-e49b-dd66-05cf-8a95e16fc728@intel.com>
Date:   Wed, 30 Sep 2020 10:26:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200928154718.2.Ic6b6031366f090393d00a53fd69e1ada31ceb29e@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 29/09/20 12:59 am, Raul E Rangel wrote:
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

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
>  drivers/mmc/host/sdhci-acpi.c | 39 ++++++++++++++++++++++++++++++++---
>  1 file changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index d335a34ad05b3..5c9a041af5b4b 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -545,10 +545,43 @@ struct amd_sdhci_host {
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
> +	preset_driver_strength =
> +		(preset & SDHCI_PRESET_DRV_MASK) >> SDHCI_PRESET_DRV_SHIFT;
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
>  }
>  
>  static void sdhci_acpi_amd_hs400_dll(struct sdhci_host *host, bool enable)
> 

