From: Chao Xu <caesarxuchao@gmail.com>
Subject: Re: wl1271: sdio: is fine-grained runtime_pm possible?
Date: Tue, 14 Jan 2014 16:12:01 -0600
Message-ID: <CAKZq+rc5Tg+L02-x8hEWUEYoyXmtPg=Mg7scp8bj79u=fqqYcg@mail.gmail.com>
References: <CAKZq+rdaCivZTFSTGt9_Q+3KFE9Ft0XfmWZ=1Vr7QcDDs9=Muw@mail.gmail.com>
	<867ga39raz.fsf@void.printf.net>
	<CAKZq+rf8HAhtjNw3CHPp2C0a2mv0d-zgN6VgdqC5rt4ysOkcpQ@mail.gmail.com>
	<CAPDyKFoyn=PChen-1daxjrH=k+Wuju0T9r5a3HQz5ytch0-LZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:51048 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbaANWMD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Jan 2014 17:12:03 -0500
Received: by mail-qa0-f42.google.com with SMTP id k4so230099qaq.15
        for <linux-mmc@vger.kernel.org>; Tue, 14 Jan 2014 14:12:01 -0800 (PST)
In-Reply-To: <CAPDyKFoyn=PChen-1daxjrH=k+Wuju0T9r5a3HQz5ytch0-LZg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, Luciano Coelho <luciano.coelho@intel.com>, Ohad Ben-Cohen <ohad@wizery.com>, linux-mmc <linux-mmc@vger.kernel.org>

Thank you, Ulf. See below.

On Tue, Jan 14, 2014 at 2:36 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 14 January 2014 05:46, Chao Xu <caesarxuchao@gmail.com> wrote:
>> Hi Chris,
>>
>> Thank you for your comments!
>>
>> I'm only familiar with OMAP4 chip. I can't speak for other devices.
>> AFAIK, if configured properly, even after pm_runtiem_put() is called,
>> sdio on OMAP4 can generate wake-up events when interrupts occur, so
>> that CPU _will_ receive the interrupts. So everything should work as
>> long as the driver calls pm_runtime_get() before handling the IRQ,
>> which involves reading/writing registers.
>
> So, then it would be interesting to understand how the WLAN chip is
> being powered? Can you tell us?
>
I check the Pandaboard datasheet (Figure13. PandaBoard WLAN/Bluetooth
Interface Block Diagram). On the WLAN chip there is a WLAN_EN pin,
which is connected to a gpio. As long as that gpio pin is high, the
WLAN chip is powered on. So IMHO, powering up the WLAN chip is a
separate issue from powering up the sdio.
> I would guess you have three entities of where runtime PM can be
> interesting in these scenarios.
>
> 1. The sdio core layer uses runtime PM to let SDIO func drivers decide
> whether the WLAN chip shall be powered or not.
> mmc_sdio_runtime_suspend() and mmc_sdio_runtime_resume() are doing the
> actual work for cutting and restoring the power.
>
> 2. The mmc host driver. Depending on hardware design; but very likely
> you are able to handle runtime PM separate from the sdio core. The
> important part is how you implement SDIO irqs. Since once your host
> driver has put it's device into runtime suspend state, you can not
> trust the controller to fetch the SDIO irqs. Some has solved this by
> re-routing SDIO irq line (DAT1) to a GPIO irq while entering
> runtime_suspend state, some have a complete separate line for SDIO irq
> so the mmc controller don't need to bother about SDIO irqs at all.
>
OMAP4's spec also mentions that one should use GPIO to monitor the
state of DAT1 pin if the power domain is off. So my takeaway is that
through various tricks, SDIO irqs can be fetched when it's in runtime
suspend state. And thus we can enable fine-grain runtime PM in mmc
host driver, at least for omap_hsmmc.
> For omap_hsmmc, I think runtime PM could be decoupled from the
> host_ops->enable|disable, and instead use an autosuspend timeout,
> similar how mmci is doing. Additionally, omap_hsmmc could likely do
> clock gating in it ->runtime_suspend and ungating in it's
> ->runtime_resume, to save more power when inactive.
I take a quick look at mmci.c. Its runtime PM is what I think
fine-grain. But I get confused. Why doesn't mmci worry about missing
irq when it's powered off? Does it have a seperate sdio irq line as
you mentioned above?
> 3. If the WLAN chip supports some kind of low power mode, those shall
> be handled from the SDIO func driver. Depending on what mode it
> supports it might be feasible to use runtime PM.
>
Per Figure13 in Pandaboard datasheet, wl1271 uses GPIO53 as the
WLAN_IRQ. So it doesn't use sdio to interrupt cpu. So I think when
running on Pandaboard, the func driver can safely disable the sdio
when it's not reading/writing through sdio.
>
> Maybe I missed some parts, that is outside my knowledge of existing
> hardware designs.
>
> Kind regards
> Ulf Hansson
>
>>
>> I'm not an expert about WLAN devices. But my understanding is wl1271
>> merely uses sdio as the way to talk to cpu. So turning off sdio
>> doesn't mean turning off the entire WLAN device, am I right? What I'm
>> suggesting here is turning off sdio when it's not used, not the entire
>> WLAN device.
>>
>> Thanks again.
>>
>> On Mon, Jan 13, 2014 at 9:27 PM, Chris Ball <chris@printf.net> wrote:
>>> Hi,
>>>
>>> On Tue, Jan 14 2014, Chao Xu wrote:
>>>> The patch "SDIO Runtime PM Support" implements the pm for wl12xx
>>>> driver this way: the power for sdio is on whenever the WLAN interface
>>>> is on, and the power is down only when the interface is down.
>>>> Is it possible to do pm in a more fine-grained way, such as only
>>>> turning on the power when reading/writing through sdio? An example is
>>>> the mmc_blk_issue_rq() in drivers/mmc/card/block.c, where the host is
>>>> released when there are no more requests. And in turn the host driver,
>>>> such as omap_hsmmc.c, calls pm_runtime_put_autosuspend().
>>>> Is there any fundamental argument against doing fine-grained runtime
>>>> pm for sdio? Or is it just too much trouble for too little power
>>>> saved?
>>>> Thank you!
>>>
>>> I feel like I must be missing something, but:
>>>
>>> Network devices generate interrupts when you have new network activity
>>> to process, and to generate an interrupt they need to be turned on.
>>>
>>> How would you avoid having the WLAN device be unpowered while someone
>>> is trying to talk to you?
>>>
>>> - Chris.
>>> --
>>> Chris Ball   <chris@printf.net>   <http://printf.net/>
>>
>>
>>
>> --
>> Regards,
>> Chao Xu
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards,
Chao Xu
