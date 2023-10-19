Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EEFCDB482
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Oct 2023 16:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbjJSQ71 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Oct 2023 12:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235465AbjJSQ70 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Oct 2023 12:59:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42284131
        for <linux-mmc@vger.kernel.org>; Thu, 19 Oct 2023 09:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697734763; x=1729270763;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=U5l8EMoeFClPUXQoTsPciKJNyr3KpYQ2NHd/ubIZX90=;
  b=n7mKjKzJYdl7VzOcpCocavAwd4UebvvjlkVECD8Y92uVZjSEHy7TAeYQ
   2Q83xIQwU7+jeNVGxstx0HSOy8y+3XnDYURvY5MVpYJ2wFHTyk/ZwfhMl
   qs3/u8cl9tdm4pvSJ9ue2/+VJtsKaxzHcb/KeHv4cXHH7wUsPgibxWAXu
   bZV1p61+USFIfCna0SXtsJ7g2+s+jXmFXrJPBL13d2qhFfoVeBLcPkf96
   qK9oAvV4kpO4XnpFVW2xQcdsBHKCu0W9UfPiwzgensl+Q02+LcnzWG3uc
   R0syA1V5pk7owgxtUzu9c5fHmdyFSz91HPkzJ1Kjzi4gdRBOdjng6OgkK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="365657289"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="365657289"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 09:59:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="5050701"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.39.14])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 09:59:22 -0700
Message-ID: <4bf5699e-c89c-455a-9e74-415509faf055@intel.com>
Date:   Thu, 19 Oct 2023 19:59:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: host: sdhci-esdhc-imx: let usr to config the wakeup
 for gpio cd pin through sysfs
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Bough Chen <haibo.chen@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
References: <20231017073129.1406748-1-haibo.chen@nxp.com>
 <CAPDyKFrffRvM51ZSzEffH9iHOWr7A0tu_e7aub7GiXdG49-iNA@mail.gmail.com>
 <DB7PR04MB40100BAA35662C888819E05590D5A@DB7PR04MB4010.eurprd04.prod.outlook.com>
 <CAPDyKFpvvk_yiUWKfxTAWwsDvEG6PS8rSv6kpmE5emANzYe_AA@mail.gmail.com>
 <4bcb3eb7-e204-4aef-bebc-575627d58127@intel.com>
 <CAPDyKFohqPexaKvsi091KqGj2WQYSQgx0Dr5g2x+bSZ2j71zHg@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAPDyKFohqPexaKvsi091KqGj2WQYSQgx0Dr5g2x+bSZ2j71zHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 19/10/23 18:24, Ulf Hansson wrote:
> On Thu, 19 Oct 2023 at 16:48, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 18/10/23 17:42, Ulf Hansson wrote:
>>> On Wed, 18 Oct 2023 at 04:07, Bough Chen <haibo.chen@nxp.com> wrote:
>>>>
>>>>> -----Original Message-----
>>>>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>>>> Sent: 2023年10月17日 19:35
>>>>> To: Bough Chen <haibo.chen@nxp.com>
>>>>> Cc: adrian.hunter@intel.com; linux-mmc@vger.kernel.org; dl-linux-imx
>>>>> <linux-imx@nxp.com>; shawnguo@kernel.org; s.hauer@pengutronix.de;
>>>>> kernel@pengutronix.de; festevam@gmail.com
>>>>> Subject: Re: [PATCH] mmc: host: sdhci-esdhc-imx: let usr to config the wakeup
>>>>> for gpio cd pin through sysfs
>>>>>
>>>>> On Tue, 17 Oct 2023 at 09:26, <haibo.chen@nxp.com> wrote:
>>>>>>
>>>>>> From: Haibo Chen <haibo.chen@nxp.com>
>>>>>>
>>>>>> Currently default enable the gpio cd pin wakeup, this will waste power
>>>>>> after system suspend if usr do not need this cd pin wakeup feature.
>>>>>> Now let usr to config the wakeup for gpio cd pin through sysfs.
>>>>>>
>>>>>> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
>>>>>> ---
>>>>>>  drivers/mmc/host/sdhci-esdhc-imx.c | 14 ++++++++++----
>>>>>>  1 file changed, 10 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
>>>>>> b/drivers/mmc/host/sdhci-esdhc-imx.c
>>>>>> index 40a6e2f8145a..2e46648344ba 100644
>>>>>> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
>>>>>> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
>>>>>> @@ -1797,9 +1797,12 @@ static int sdhci_esdhc_imx_probe(struct
>>>>> platform_device *pdev)
>>>>>>         /*
>>>>>>          * Setup the wakeup capability here, let user to decide
>>>>>>          * whether need to enable this wakeup through sysfs interface.
>>>>>> +        * First check the SDIO device, second check the gpio CD pin.
>>>>>>          */
>>>>>> -       if ((host->mmc->pm_caps & MMC_PM_KEEP_POWER) &&
>>>>>> -                       (host->mmc->pm_caps &
>>>>> MMC_PM_WAKE_SDIO_IRQ))
>>>>>> +       if (((host->mmc->pm_caps & MMC_PM_KEEP_POWER) &&
>>>>>> +                       (host->mmc->pm_caps &
>>>>> MMC_PM_WAKE_SDIO_IRQ)) ||
>>>>>> +           ((host->mmc->caps & MMC_CAP_CD_WAKE) &&
>>>>>> +                        host->mmc->slot.cd_irq >= 0))
>>>>>>                 device_set_wakeup_capable(&pdev->dev, true);
>>>>>
>>>>> If the wakeup is GPIO based, it doesn't mean that the device is wakeup capable,
>>>>> so this is wrong.
>>>>>
>>>>> In principle this must be managed through the GPIO irqchip driver instead.
>>>>
>>>> Yes, I know GPIO and USDHC are different device, combine GPIO wakeup to USDHC is not that reasonable.
>>>> I send this patch because I notice there is similar code in sdhci-pci-core.c, refer to sdhci_pci_suspend_host()
>>>>
>>>> Seems PCI subsystem combine GPIO wakeup to PCI controller.
>>>
>>> Good point! I am not sure that is the correct way to do it either, but
>>> maybe it's fine for PCI based devices. Adrian probably knows this
>>> better.
>>
>> PCI / ACPI layers handle configuration of wakeup signaling, so a
>> device will be put to the appropriate power state.  It won't be
>> forced to be "on" by registering a wakeup source.
>>
> 
> Okay, I see.
> 
> So you are saying that PCI bus/layers are aware of the GPIO pin/irq
> being used for wakeup for the device in question?

No, it is more like PCI / ACPI take care of most things but the
wakeup framework provides sysfs wakeup API.  We can add that and
use it to determine if wakeup is enabled (by the user) to then
enable the CD GPIO IRQ wakeup.  That way, the sysfs wakeup API is
on the correct device, and the user doesn't need to know anything
about GPIO.

