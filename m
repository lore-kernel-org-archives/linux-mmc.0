From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-of-at91: fix wakeup issue when using runtime pm
Date: Tue, 8 Mar 2016 22:56:31 +0100
Message-ID: <CAPDyKFpDHooacBrTXQzinO4U10SeoedybN5HZ5y1bwbO-F04ug@mail.gmail.com>
References: <20160212120415.GJ14937@odux.rfo.atmel.com>
	<1455357400-32145-1-git-send-email-ludovic.desroches@atmel.com>
	<CAPDyKFroVY0ZdqPScpGiJ8Y_QhhZ7asf0R0MzSx0WzVi5c2neg@mail.gmail.com>
	<20160216152204.GE2607@odux.rfo.atmel.com>
	<20160217103515.GM2607@odux.rfo.atmel.com>
	<CAPDyKFpovsOMVSxifefFcvHFoNL-AaBH_tbWbN7QRQqv2hrSnw@mail.gmail.com>
	<20160304134830.GG2690@odux.rfo.atmel.com>
	<CAPDyKFrDmWGiMF2fOt1kGyp03mRiTV2ug-i3mg=yYr5UF=WLeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:34511 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbcCHV4c (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Mar 2016 16:56:32 -0500
Received: by mail-wm0-f51.google.com with SMTP id p65so168071957wmp.1
        for <linux-mmc@vger.kernel.org>; Tue, 08 Mar 2016 13:56:31 -0800 (PST)
In-Reply-To: <CAPDyKFrDmWGiMF2fOt1kGyp03mRiTV2ug-i3mg=yYr5UF=WLeQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Nicolas Ferre <nicolas.ferre@atmel.com>

+Ludovic

On 8 March 2016 at 22:54, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 4 March 2016 at 14:48, Ludovic Desroches <ludovic.desroches@atmel.com> wrote:
>> Hi Ulf,
>>
>> On Fri, Mar 04, 2016 at 10:09:37AM +0100, Ulf Hansson wrote:
>>> On 17 February 2016 at 11:35, Ludovic Desroches
>>
>> [snip]
>>
>>> > I am wondering if I should take account of sdio irq enabled or not here.
>>> >
>>> > I have a sdio device which drives me crazy because of power management.
>>> > The driver of this device is in staging, it is wilc1000. It seems that I
>>> > am stuck because the sdio irq are not received. If I don't disable the
>>> > clock of the controller (hclock), I should receive the sdio IRQ as I
>>> > receive card detect ones, isn't it?
>>> >
>>> > It doesn't work, it seems I have also to not disabled mainck and gck
>>> > which are clocks needed to generate the clock sent to the sdio device.
>>> > If none of the clocks have to be disabled, where it has to be managed?
>>>
>>> That's a typical issue for SDIO IRQs, especially when the controller
>>> HW manages IRQs (there are other ways to deal with SDIO IRQs as well).
>>>
>>> Currently, the simplest way to deal with this in the driver is to do a
>>> pm_runtime_get_sync() when the SDIO IRQ gets enabled, and
>>> pm_runtime_put() when it gets disabled.
>>
>> Which driver? sdio device driver or controller driver?
>
> In the mmc controller driver.
>
>>
>>> >
>>> > Do I have to anticipate this use case in the driver of my sdhci
>>> > controller or does it have to be managed in the sdio device driver? They
>>> > are using sdio_claim/release_host to suspend or resume the host but
>>> > maybe they use it in a bad way.
>>>
>>> The wilc100 SDIO func driver should *not* keep the host claimed to
>>> deal with SDIO irqs. Only when it configures them.
>>>
>>> Instead, you need to deal with this in the sdhci driver, when you get
>>> the call to enable/disable SDIO IRQs.
>>>
>>
>> Do you mean in sdhci_enable_sdio_irq?
>
> I am not sure exactly where to check. As it may be depending on the
> sdhci variant and the SoC you probably need to deal with this in
> non-common sdhci code.
>
>>
>>> Moreover, from a system PM point of view. If the wilc100 SDIO func
>>> driver wants the platform to wake up on SDIO IRQs, it needs to set
>>> MMC_PM_KEEP_POWER and MMC_PM_WAKE_SDIO_IRQ from its ->suspend()
>>> callback.
>>>
>>> In that way, your sdhci driver can act accordingly from its system PM
>>> callbacks. In other words, depending on MMC_PM_KEEP_POWER and
>>> MMC_PM_WAKE_SDIO_IRQ to *not* call pm_runtime_force_suspend().
>>>
>>
>> Ok, it makes sense.
>>
>>
>> Coming back to the initial discussion and patch which were motivated by
>> the fact that after runtime suspend I can't wake-up on card detect event,
>> I have the feeling we don't have the same assumption about runtime PM.
>>
>> From what you and Adrian told me, I should not use runtime PM if I have
>> no way to wake-up. In your minds, the way to wake-up is to use an
>> externel GPIO because the controller will be 'totally' disabled, isn't it?
>
> I agree to the first part here.
>
> Although, as you also have the option to use polling for card detect,
> this actually means you don't really *need* to have a wakeup
> configured. Especially in the case where you don't have GPIO card
> detect.
>
> In that way, *all* the clocks can gated in between the polling
> attempts, thus you will save power even in the polling mode
> configuration and when runtime PM is enabled.
>
>>
>> On my side, runtime PM allows me to save power when the sdhci controller
>> is not used. If I can disable two clocks out of three, I should use
>> runtime PM. Do you agree?
>>
>> If not, tell me how I can convince you :) Otherwise, next step is to rework
>> my patch but I think I have no other solution that not calling
>> sdhci_runtime_suspend_host if I expect to use the card detect irq of the
>> controller.
>
> So, to summarize.
>
> I think the best fix is to add a clever check in ->probe() and then
> enable polling when you can't rely on GPIO card detect IRQ.
>
> Moreover, to have a robust solution, you also need to clear
> SDHCI_QUIRK_BROKEN_CARD_DETECTION for your sdhci variant, as otherwise
> the "broken-cd" DT binding could wrongly be used for this variant.
>
> Does that make sense?
>
> Kind regards
> Uffe
