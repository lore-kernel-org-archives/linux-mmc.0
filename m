From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: rtsx: add card power off during probe
Date: Wed, 17 Sep 2014 21:29:01 +0200
Message-ID: <CAPDyKFrbMaDxU3VkhMO63+tLRMipKPqGvYC5cT2PTeVU1CTTQg@mail.gmail.com>
References: <1410485999-10939-1-git-send-email-micky_ching@realsil.com.cn>
	<CAPDyKFqcbK9OuQXbegignwiS7rz3L8resQ7Jfc8WvqXEKTcWVA@mail.gmail.com>
	<54195036.2010409@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:59455 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756075AbaIQT3D (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Sep 2014 15:29:03 -0400
Received: by mail-qa0-f54.google.com with SMTP id v10so2523867qac.27
        for <linux-mmc@vger.kernel.org>; Wed, 17 Sep 2014 12:29:01 -0700 (PDT)
In-Reply-To: <54195036.2010409@realsil.com.cn>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: micky <micky_ching@realsil.com.cn>
Cc: Chris Ball <chris@printf.net>, Samuel Ortiz <sameo@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Carpenter <dan.carpenter@oracle.com>, "driverdev-devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Roger <rogerable@realtek.com>, Wei WANG <wei_wang@realsil.com.cn>

On 17 September 2014 11:11, micky <micky_ching@realsil.com.cn> wrote:
> On 09/17/2014 02:01 AM, Ulf Hansson wrote:
>>
>> On 12 September 2014 03:39,  <micky_ching@realsil.com.cn> wrote:
>>>
>>> From: Roger Tseng <rogerable@realtek.com>
>>>
>>> Some platform have both UEFI driver and MFD/mmc driver, if entering
>>> linux while card in the slot, the card power is already on, and rtsx-mmc
>>> driver have no chance to make card power off. This will lead UHSI card
>>> failed to enter UHSI mode.
>>>
>>> It is hard to control the UEFI driver leaving state, so we power off the
>>> card power during probe.
>>>
>>> Signed-off-by: Roger Tseng <rogerable@realtek.com>
>>> Signed-off-by: Micky Ching <micky_ching@realsil.com.cn>
>>> ---
>>>   drivers/mmc/host/rtsx_pci_sdmmc.c |    7 ++++++-
>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c
>>> b/drivers/mmc/host/rtsx_pci_sdmmc.c
>>> index dfde4a2..57b0796 100644
>>> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
>>> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
>>> @@ -1341,8 +1341,13 @@ static int rtsx_pci_sdmmc_drv_probe(struct
>>> platform_device *pdev)
>>>          host->pcr = pcr;
>>>          host->mmc = mmc;
>>>          host->pdev = pdev;
>>> -       host->power_state = SDMMC_POWER_OFF;
>>>          INIT_WORK(&host->work, sd_request);
>>> +       sd_power_off(host);
>>> +       /*
>>> +        * ref: SD spec 3.01: 6.4.1.2 Power On or Power Cycle
>>> +        */
>>> +       usleep_range(1000, 2000);
>>> +
>>
>> This won't work in cases were you power off eMMC cards, unless you can
>> do a full power cycle - cut both VCC and VCCQ. Can you?
>
> Hi Uffe,
>
> VCCQ will poweroff at the same time.

In that case, don't forget to enable MMC_CAP2_FULL_PWR_CYCLE.

>
> if MMC_CAP2_NO_PRESCAN_POWERUP enable, will call mmc_power_off() at start,
> then it will check ios.power_mode, but the state is MMC_POWER_OFF and just
> return.

Uhh, that's right! So, I wonder why we invokes mmc_power_off() from
that path at all.

Hmm, I think we should change the behavior in mmc_start_host(), like below:
1) Add a "MMC_POWER_UNDEFINED" state which is what the power state
should be assigned to at allocation.
2 ) From mmc_start_host(), invoke mmc_power_off() when
MMC_CAP2_NO_PRESCAN_POWERUP and MMC_CAP2_FULL_PWR_CYCLE is set.

Would that work?

Kind regards
Uffe

> Best Regards.
> micky.
>
>> There are also another option you might want to use,
>> MMC_CAP2_NO_PRESCAN_POWERUP. But again, it must only be used for those
>> hosts that you are able to do a full power cycle for.
>>
>> Kind regards
>> Uffe
>>
>>>          platform_set_drvdata(pdev, host);
>>>          pcr->slots[RTSX_SD_CARD].p_dev = pdev;
>>>          pcr->slots[RTSX_SD_CARD].card_event = rtsx_pci_sdmmc_card_event;
>>> --
>>> 1.7.9.5
>>>
>> .
>>
>
