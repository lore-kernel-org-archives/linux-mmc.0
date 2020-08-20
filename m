Return-Path: <SRS0=808J=B6=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5FFC433DF
	for <linux-mmc@archiver.kernel.org>; Thu, 20 Aug 2020 08:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D3CF2075E
	for <linux-mmc@archiver.kernel.org>; Thu, 20 Aug 2020 08:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgHTI4T (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 20 Aug 2020 04:56:19 -0400
Received: from mga04.intel.com ([192.55.52.120]:53887 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgHTI4S (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 20 Aug 2020 04:56:18 -0400
IronPort-SDR: FgKbVFea8Ytpd3S4R4Rrf7MFyZku8IxhBIg/mTc7bX2Xz7SIahGsCyrd7MK3v4JLEL41xgYx3W
 rnl8RsdGnI4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="152675669"
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="152675669"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 01:56:17 -0700
IronPort-SDR: UF5iSQUJjAO3bb/1hARBlKXodHS9VbU2swzQZB9GpkKUANw9olTnwkNwH1NbBkGpCrrXkVjce0
 QEHb2yGN7Pnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="311044485"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by orsmga002.jf.intel.com with ESMTP; 20 Aug 2020 01:56:13 -0700
Subject: Re: HS400 tuning and presets
To:     Raul Rangel <rrangel@chromium.org>, linux-mmc@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Kurtz <djkurtz@chromium.org>
References: <CAHQZ30ApB3BEzgLv=EtzB_Kpnsfsr7-s+JcYmyzXN3j7OF80-w@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <671d418f-f411-ad94-4469-b2f0eb6cd693@intel.com>
Date:   Thu, 20 Aug 2020 11:55:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHQZ30ApB3BEzgLv=EtzB_Kpnsfsr7-s+JcYmyzXN3j7OF80-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 20/08/20 1:56 am, Raul Rangel wrote:
> I noticed some odd things with the MMC/SDHCI code while debugging an
> HS400 tuning issue.
> 
> 1) Is it expected that we never enable SDHCI_CTRL_PRESET_VAL_ENABLE
> for an eMMC running at HS200 or HS400?

Seems like an oversight.  eMMC transfer modes are not supported by the SDHCI
specification, and many drivers use SDHCI_QUIRK2_PRESET_VALUE_BROKEN, so it
looks like it has never been noticeable.

> The flow for enabling HS400 is: Legacy -> HS200 -> Perform Tuning ->
> HS -> HS400.
> Looking at [sdhci_set_ios](https://source.chromium.org/chromiumos/chromiumos/codesearch/+/master:src/third_party/kernel/v5.4/drivers/mmc/host/sdhci.c;l=2019),
> it looks like it's responsible for enabling presets.
> 
>     if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN) &&
>                     ((ios->timing == MMC_TIMING_UHS_SDR12) ||
>                      (ios->timing == MMC_TIMING_UHS_SDR25) ||
>                      (ios->timing == MMC_TIMING_UHS_SDR50) ||
>                      (ios->timing == MMC_TIMING_UHS_SDR104) ||
>                      (ios->timing == MMC_TIMING_UHS_DDR50) ||
>                      (ios->timing == MMC_TIMING_MMC_DDR52))) {
>             u16 preset;
> 
>             sdhci_enable_preset_value(host, true);
>             preset = sdhci_get_preset_value(host);
>             ios->drv_type = (preset & SDHCI_PRESET_DRV_MASK)
>                     >> SDHCI_PRESET_DRV_SHIFT;
>     }
> 
> MMC_TIMING_MMC_HS200 and MMC_TIMING_MMC_HS400 are missing from the
> conditions, so we never enable presets. This means that by default
> (only 2 controllers provide select_drive_strength) we use drive
> strength B for both the card and the controller.
> 
>     int mmc_select_drive_strength(struct mmc_card *card, unsigned int max_dtr,
>                                   int card_drv_type, int *drv_type)
>     {
>             struct mmc_host *host = card->host;
>             int host_drv_type = SD_DRIVER_TYPE_B;
> 
>             *drv_type = 0;
> 
>             if (!host->ops->select_drive_strength)
>                     return 0;
>             ...
>     }
> 
> Here is a trace log showing HS400 initialization: https://0paste.com/79874
> 
> 2) When performing HS400 tuning we end up enabling presets.
> The re-tuning sequence is: HS400->DDR52->HS->HS200->Perform Tuning->HS->HS400
> 
> So when we transition to DDR52 the code above enables presets. You can
> see this happening in this trace log: https://0paste.com/79875. Look
> at timestamp 1926.173800.
> 
> This means that the card and controller have the potential to have
> mismatching drive strengths. This can be seen at timestamp
> 1926.175813.The HS200 preset on my controller is configured to A, but
> the card would be set up as B (if the controller didn't override
> select_drive_strength).
> 
> Should we be enabling presets for HS200/HS400 (and potentially
> MMC_HS), or should we remove MMC_DDR52 from the condition above?

The only things that matter are:
1. don't break other drivers
2. do make it work for your driver

So we can't universally enable presets for HS200 and HS400, nor remove
MMC_DDR52, but we can do something to make it work for you.

> 
> It looks like 0dafa60eb2506 ("mmc: sdhci: also get preset value and
> driver type for MMC_DDR52") was the CL that added MMC_DDR52 to the
> condition.
> 
> 3) How do we ensure that card drive strength and controller drive
> strength stay in sync when presets are enabled?

Is that your requirement? Which driver is it?

> Right now mmc_select_driver_type is only called from
> `mmc_select_hs400es` and `mmc_select_hs200`. `mmc_select_driver_type
> doesn't currently take the timing into account when making a decision.
> Only two devices currently provide the `select_drive_strength`
> override, so we are setting the card to drive strength B for most
> controllers.
> 
> Should we modify mmc_select_drive_strength to take in the target
> timing so it can return the correct card drive strength. We could then
> add an sdhci_select_drive_strength that queries the preset registers
> (if enabled) and returns the target drive strength.
> 
> 4) Should we be calling `mmc_select_driver_type` from
> `mmc_hs400_to_hs200` and `mmc_hs200_to_hs400` during the transitions?

The same driver strength continues to be used for HS200 and HS400 i.e.
card->driver_strength

> Or do we not care?
> 
> Sorry for the long email...
> Once I get some guidance, I can send some patches.

Generally people first want to know what problem you are trying to solve.
