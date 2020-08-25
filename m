Return-Path: <SRS0=3fsM=CD=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CEAC433E1
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Aug 2020 05:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC5D420737
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Aug 2020 05:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbgHYFdB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Aug 2020 01:33:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:31872 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728598AbgHYFdB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 25 Aug 2020 01:33:01 -0400
IronPort-SDR: smqwniMVlAQlQmFl22TXh4+zi7b7OUbN6iHimc2IsmRJsXtAs98Pm/bNRgDvvTCSRVnuJkTX+1
 XVscy66PFDvA==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="136109774"
X-IronPort-AV: E=Sophos;i="5.76,351,1592895600"; 
   d="scan'208";a="136109774"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 22:32:57 -0700
IronPort-SDR: 6HDv33q+eXku/Lw6nnQ8VmZ4KbrGcyjaEXqo/GRLUE8haygaOpqtCUJ4fxCLZIJNKQ3PlGaWJw
 MEY0nsPRKWeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,351,1592895600"; 
   d="scan'208";a="372928275"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by orsmga001.jf.intel.com with ESMTP; 24 Aug 2020 22:32:52 -0700
Subject: Re: HS400 tuning and presets
To:     Raul Rangel <rrangel@chromium.org>
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Kurtz <djkurtz@chromium.org>
References: <CAHQZ30ApB3BEzgLv=EtzB_Kpnsfsr7-s+JcYmyzXN3j7OF80-w@mail.gmail.com>
 <671d418f-f411-ad94-4469-b2f0eb6cd693@intel.com>
 <CAHQZ30CWXWJw50g-wMKRQr0Q6-rcE342O12J=aand9XtFY1CEA@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <bc8b1f28-3033-aa82-939a-856cb6e11f53@intel.com>
Date:   Tue, 25 Aug 2020 08:32:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHQZ30CWXWJw50g-wMKRQr0Q6-rcE342O12J=aand9XtFY1CEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 24/08/20 8:05 pm, Raul Rangel wrote:
> On Thu, Aug 20, 2020 at 2:56 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 20/08/20 1:56 am, Raul Rangel wrote:
>>> I noticed some odd things with the MMC/SDHCI code while debugging an
>>> HS400 tuning issue.
>>>
>>> 1) Is it expected that we never enable SDHCI_CTRL_PRESET_VAL_ENABLE
>>> for an eMMC running at HS200 or HS400?
>>
>> Seems like an oversight.  eMMC transfer modes are not supported by the SDHCI
>> specification, and many drivers use SDHCI_QUIRK2_PRESET_VALUE_BROKEN, so it
>> looks like it has never been noticeable.
>>
> 
> Thanks for the confirmation. I'll get a patch sent to fix it.
> 
>>> The flow for enabling HS400 is: Legacy -> HS200 -> Perform Tuning ->
>>> HS -> HS400.
>>> Looking at [sdhci_set_ios](https://source.chromium.org/chromiumos/chromiumos/codesearch/+/master:src/third_party/kernel/v5.4/drivers/mmc/host/sdhci.c;l=2019),
>>> it looks like it's responsible for enabling presets.
>>>
>>>     if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN) &&
>>>                     ((ios->timing == MMC_TIMING_UHS_SDR12) ||
>>>                      (ios->timing == MMC_TIMING_UHS_SDR25) ||
>>>                      (ios->timing == MMC_TIMING_UHS_SDR50) ||
>>>                      (ios->timing == MMC_TIMING_UHS_SDR104) ||
>>>                      (ios->timing == MMC_TIMING_UHS_DDR50) ||
>>>                      (ios->timing == MMC_TIMING_MMC_DDR52))) {
>>>             u16 preset;
>>>
>>>             sdhci_enable_preset_value(host, true);
>>>             preset = sdhci_get_preset_value(host);
>>>             ios->drv_type = (preset & SDHCI_PRESET_DRV_MASK)
>>>                     >> SDHCI_PRESET_DRV_SHIFT;
>>>     }
>>>
>>> MMC_TIMING_MMC_HS200 and MMC_TIMING_MMC_HS400 are missing from the
>>> conditions, so we never enable presets. This means that by default
>>> (only 2 controllers provide select_drive_strength) we use drive
>>> strength B for both the card and the controller.
>>>
>>>     int mmc_select_drive_strength(struct mmc_card *card, unsigned int max_dtr,
>>>                                   int card_drv_type, int *drv_type)
>>>     {
>>>             struct mmc_host *host = card->host;
>>>             int host_drv_type = SD_DRIVER_TYPE_B;
>>>
>>>             *drv_type = 0;
>>>
>>>             if (!host->ops->select_drive_strength)
>>>                     return 0;
>>>             ...
>>>     }
>>>
>>> Here is a trace log showing HS400 initialization: https://0paste.com/79874
>>>
>>> 2) When performing HS400 tuning we end up enabling presets.
>>> The re-tuning sequence is: HS400->DDR52->HS->HS200->Perform Tuning->HS->HS400
>>>
>>> So when we transition to DDR52 the code above enables presets. You can
>>> see this happening in this trace log: https://0paste.com/79875. Look
>>> at timestamp 1926.173800.
>>>
>>> This means that the card and controller have the potential to have
>>> mismatching drive strengths. This can be seen at timestamp
>>> 1926.175813.The HS200 preset on my controller is configured to A, but
>>> the card would be set up as B (if the controller didn't override
>>> select_drive_strength).
>>>
>>> Should we be enabling presets for HS200/HS400 (and potentially
>>> MMC_HS), or should we remove MMC_DDR52 from the condition above?
>>
>> The only things that matter are:
>> 1. don't break other drivers
>> 2. do make it work for your driver
>>
>> So we can't universally enable presets for HS200 and HS400, nor remove
>> MMC_DDR52, but we can do something to make it work for you.
>>
> 
> Makes sense. I'll see what direction I want to take.
> 
>>>
>>> It looks like 0dafa60eb2506 ("mmc: sdhci: also get preset value and
>>> driver type for MMC_DDR52") was the CL that added MMC_DDR52 to the
>>> condition.
>>>
>>> 3) How do we ensure that card drive strength and controller drive
>>> strength stay in sync when presets are enabled?
>>
>> Is that your requirement? Which driver is it?
> 
> We want to provide a knob for our OEMs so they can choose the best
> drive strength for their design. Right now for the AMD controller it's
> hard coded to A:
> https://source.chromium.org/chromiumos/chromiumos/codesearch/+/master:src/third_party/kernel/v5.4/drivers/mmc/host/sdhci-acpi.c;l=542
> 
> I was hoping to use the SDHCI presets to not introduce a non-standard
> convention of passing in the drive strength. I wasn't aware that the
> SDHCI driver doesn't use presets for eMMC. So maybe the path of least
> resistance is to add an ACPI property that is read by
> amd_select_drive_strength. Like `mmc_of_parse` does with
> `fixed-emmc-driver-type`. This ensures that both the card and
> controller drive strengths are set.
> 
> It looks like `host->fixed_drv_type` is only for the card. It doesn't
> set the same drive strength on the controller. Is this intentional?

You would need to ask the author of the patch, but it seems reasonable to
assume it is intentional.

> 
>     static void mmc_select_driver_type(struct mmc_card *card)
>     {
>             int card_drv_type, drive_strength, drv_type = 0;
>             int fixed_drv_type = card->host->fixed_drv_type;
> 
>             card_drv_type = card->ext_csd.raw_driver_strength |
>                             mmc_driver_type_mask(0);
> 
>             if (fixed_drv_type >= 0) <--- Never updates drv_type
>                     drive_strength = card_drv_type &
> mmc_driver_type_mask(fixed_drv_type)
>                                      ? fixed_drv_type : 0;
>             else
>                     drive_strength = mmc_select_drive_strength(card,
> 
> card->ext_csd.hs200_max_dtr,
> 
> card_drv_type, &drv_type);
> 
>             card->drive_strength = drive_strength;
> 
>             if (drv_type)
>                     mmc_set_driver_type(card->host, drv_type);
>     }
> 
>>
>>> Right now mmc_select_driver_type is only called from
>>> `mmc_select_hs400es` and `mmc_select_hs200`. `mmc_select_driver_type
>>> doesn't currently take the timing into account when making a decision.
>>> Only two devices currently provide the `select_drive_strength`
>>> override, so we are setting the card to drive strength B for most
>>> controllers.
>>>
>>> Should we modify mmc_select_drive_strength to take in the target
>>> timing so it can return the correct card drive strength. We could then
>>> add an sdhci_select_drive_strength that queries the preset registers
>>> (if enabled) and returns the target drive strength.
>>>
>>> 4) Should we be calling `mmc_select_driver_type` from
>>> `mmc_hs400_to_hs200` and `mmc_hs200_to_hs400` during the transitions?
>>
>> The same driver strength continues to be used for HS200 and HS400 i.e.
>> card->driver_strength
>>
>>> Or do we not care?
>>>
>>> Sorry for the long email...
>>> Once I get some guidance, I can send some patches.
>>
>> Generally people first want to know what problem you are trying to solve.
> I was just thinking we need to keep the drive strengths in sync
> between controller and card.

AFAIK there is no general requirement for that.
