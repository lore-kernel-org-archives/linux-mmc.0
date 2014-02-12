From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: brcm 4329 problems
Date: Wed, 12 Feb 2014 11:01:21 +0100
Message-ID: <CAPDyKFqqcrcX6tp68b_cVYHTGysQ401isshvaS3SYjAzZs_j8w@mail.gmail.com>
References: <20140203153239.GL26684@n2100.arm.linux.org.uk>
	<52F00021.6070904@broadcom.com>
	<20140203210450.GN26684@n2100.arm.linux.org.uk>
	<52F14F7E.9040900@broadcom.com>
	<20140205153824.GS26684@n2100.arm.linux.org.uk>
	<20140208215927.GA5276@n2100.arm.linux.org.uk>
	<52F744C9.7040804@broadcom.com>
	<20140209205917.GO26684@n2100.arm.linux.org.uk>
	<20140209232708.GA25900@n2100.arm.linux.org.uk>
	<CAA+hA=SEoXfSN19z1vLpiLDh8Mo3Qty4cU2HOGJska70dT5Cew@mail.gmail.com>
	<20140210140346.GW26684@n2100.arm.linux.org.uk>
	<CAA+hA=Si4k0A5_-ve0oh8FKxCGDg5pD_M=Z4g2Ca7UWJaeq6Rw@mail.gmail.com>
	<CAPDyKForrmFr9ycEz5+10G2e1ifWt+hySPfy+AieUL3gWRCX=g@mail.gmail.com>
	<CAA+hA=TFq_1V6EihBApTi5yXmb+mkCxa1S4pmEaJ=ssOCprSaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:45231 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbaBLKBW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Feb 2014 05:01:22 -0500
Received: by mail-qc0-f173.google.com with SMTP id i8so15083633qcq.32
        for <linux-mmc@vger.kernel.org>; Wed, 12 Feb 2014 02:01:21 -0800 (PST)
In-Reply-To: <CAA+hA=TFq_1V6EihBApTi5yXmb+mkCxa1S4pmEaJ=ssOCprSaw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <dongas86@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Arend van Spriel <arend@broadcom.com>, Chris Ball <chris@printf.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, brcm80211-dev-list@broadcom.com

On 12 February 2014 04:06, Dong Aisheng <dongas86@gmail.com> wrote:
> On Tue, Feb 11, 2014 at 5:00 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 11 February 2014 08:33, Dong Aisheng <dongas86@gmail.com> wrote:
>>> On Mon, Feb 10, 2014 at 10:03 PM, Russell King - ARM Linux
>>> <linux@arm.linux.org.uk> wrote:
>>>> On Mon, Feb 10, 2014 at 02:50:42PM +0800, Dong Aisheng wrote:
>>>>> On Mon, Feb 10, 2014 at 7:27 AM, Russell King - ARM Linux
>>>>> <linux@arm.linux.org.uk> wrote:
>>>>> > On Sun, Feb 09, 2014 at 08:59:17PM +0000, Russell King - ARM Linux wrote:
>>>>> >> On Sun, Feb 09, 2014 at 10:05:13AM +0100, Arend van Spriel wrote:
>>>>> >> > Yeah. I did not mention this, but indeed the first log you provided
>>>>> >> > already made that clear (to me). In your last log the driver sends an UP
>>>>> >> > command to the firmware on which no response is given. So I was hoping
>>>>> >> > the forensics file (which is firmware console buffer) would show an
>>>>> >> > error message of some kind. Also that is not the case. Have to come up
>>>>> >> > with new ideas about what is going wrong here.
>>>>> >>
>>>>> >> I'm chasing a theory at the moment, but it's being complicated by the
>>>>> >> driver oopsing on unload...
>>>>> >
>>>>> > Theory proven.
>>>>> >
>>>>> > May I first take the time to apologise to Arend for wasting his time with
>>>>> > this issue; the issue is not the Broadcom driver, but the SDHCI driver.
>>>>> >
>>>>> > My theory was that it's the sdhci driver causing the problems...  My
>>>>> > suspicions were first raised when I read through various SDHCI driver
>>>>> > functions such as the set_ios methods when chasing down a problem with
>>>>> > UHS-1 SD cards, and later when I was reading it's interrupt handling
>>>>> > code.
>>>>> >
>>>>> > The driver looks very much like a patchwork quilt of different hacks,
>>>>> > all trying to co-operate with each other in the semblence of something
>>>>> > working - the result is something which does stuff in ways that the SD
>>>>> > card spec doesn't allow, but also does some pretty stupid things when
>>>>> > you have a SDIO device attached.
>>>>> >
>>>>> > The SDIO problems become pretty obvious when you see this log:
>>>>> >
>>>>> > [   51.112923] brcmfmac: brcmf_fil_cmd_int_set cmd=2, value=0
>>>>> > [   51.112937] brcmfmac: brcmf_proto_bcdc_set_dcmd Enter, cmd 2 len 4
>>>>> > [   51.112946] brcmfmac: brcmf_proto_bcdc_msg Enter
>>>>> > [   51.112981] brcmfmac: brcmf_sdio_bus_sleep request WAKE currently WAKE
>>>>> > [   51.112989] brcmfmac: brcmf_sdio_clkctl Enter
>>>>> > [   51.113498] brcmfmac: brcmf_proto_bcdc_cmplt Enter
>>>>> > [   51.128501] brcmfmac: brcmf_sdio_bus_watchdog idle
>>>>> > [   51.128522] brcmfmac: brcmf_sdio_bus_sleep request SLEEP currently WAKE
>>>>> > [   51.128532] brcmfmac: brcmf_sdio_clkctl Enter
>>>>> > [   51.128540] brcmfmac: brcmf_sdio_htclk Enter
>>>>> > [   51.128549] brcmfmac: brcmf_sdiod_regwb addr:0x0001000e, data:0x00
>>>>> > [   51.128560] brcmfmac: brcmf_sdiod_request_data rw=1, func=1, addr=0x1000e, nbytes=1
>>>>> > [   51.128645] brcmfmac: brcmf_sdio_htclk CLKCTL: turned OFF
>>>>> > [   51.128655] brcmfmac: brcmf_sdio_sdclk Enter
>>>>> > [   51.128667] brcmfmac: brcmf_sdio_clkctl 3 -> 0
>>>>> > [   51.180385] mmc0: runtime suspend
>>>>> > [   53.112272] brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout
>>>>> > [   53.118290] brcmfmac: brcmf_sdio_bus_sleep request WAKE currently WAKE
>>>>> > [   53.118302] brcmfmac: brcmf_sdio_clkctl Enter
>>>>> > [   53.118312] brcmfmac: brcmf_sdio_sdclk Enter
>>>>> > [   53.118319] brcmfmac: brcmf_sdio_htclk Enter
>>>>> > [   53.118329] brcmfmac: brcmf_sdiod_regwb addr:0x0001000e, data:0x10
>>>>> > [   53.118341] brcmfmac: brcmf_sdiod_request_data rw=1, func=1, addr=0x1000e, nbytes=1
>>>>> > [   53.118537] sdhci-esdhc-imx 2190000.usdhc: desired SD clock: 50000000, actual: 49500000
>>>>> > [   53.118550] mmc0: esdhc_pltfm_set_clock: CLK on
>>>>> > [   53.119723] sdhci-esdhc-imx 2190000.usdhc: change pinctrl state for uhs 0
>>>>> > [   53.125880] mmc0: sdio irq enabled: 007f0003 007f0003
>>>>> > [   53.125898] mmc0: runtime resume
>>>>> > [   53.125910] mmc0: card irq raised
>>>>> > [   53.125925] mmc0: sdio irq disabled: 007f0103 007f0103
>>>>> > [   53.126030] brcmfmac: brcmf_sdiod_regrb addr:0x0001000e
>>>>> > [   53.126055] brcmfmac: brcmf_sdiod_request_data rw=0, func=1, addr=0x1000e, nbytes=1
>>>>> >
>>>>> > The values printed in "sdio irq *abled" are the INT_ENABLE and SIGNAL_ENABLE
>>>>> > register values immediately before the stated action is taken bit 8 is
>>>>> > the interrupt enable for card interrupts.  Earlier in the log, SDIO card
>>>>> > interrupts were enabled (one was handled immediately before the above
>>>>> > broadcom cmd=2 message was sent.
>>>>> >
>>>>> > Yep, that's right - at 51.180385, the SDIO host has /all/ interrupts
>>>>> > disabled by a runtime suspend - including any interrupt from the card.
>>>>> > The brcmfmac driver times out after 2 seconds having sent the "up"
>>>>> > command, and re-awakens the host, which is runtime resumed at 53.125898,
>>>>> > enabling the SDIO card interrupt at that time.
>>>>> >
>>>>> > And lo and behold - the card has an interrupt pending!  Too bad, we're
>>>>> > too late for the driver to forward the interrupt to the SDIO interrupt
>>>>> > thread and get it to the driver before the time-out is processed.
>>>>> >
>>>>> > Here's the proof - the above messages came from:
>>>>> >
>>>>> > int sdhci_runtime_suspend_host(struct sdhci_host *host)
>>>>> > {
>>>>> >         unsigned long flags;
>>>>> >         int ret = 0;
>>>>> >
>>>>> > printk(KERN_DEBUG "%s: runtime suspend\n",
>>>>> >         mmc_hostname(host->mmc));
>>>>> > ...
>>>>> >         spin_lock_irqsave(&host->lock, flags);
>>>>> >         sdhci_mask_irqs(host, SDHCI_INT_ALL_MASK);
>>>>> >         spin_unlock_irqrestore(&host->lock, flags);
>>>>> >
>>>>> > int sdhci_runtime_resume_host(struct sdhci_host *host)
>>>>> > {
>>>>> >         unsigned long flags;
>>>>> >         int ret = 0, host_flags = host->flags;
>>>>> > ...
>>>>> >         /* Enable SDIO IRQ */
>>>>> >         if ((host->flags & SDHCI_SDIO_IRQ_ENABLED))
>>>>> >                 sdhci_enable_sdio_irq_nolock(host, true);
>>>>> >
>>>>> >         /* Enable Card Detection */
>>>>> >         sdhci_enable_card_detection(host);
>>>>> >
>>>>> > printk(KERN_DEBUG "%s: runtime resume\n",
>>>>> >         mmc_hostname(host->mmc));
>>>>> >         spin_unlock_irqrestore(&host->lock, flags);
>>>>> >
>>>>> >         return ret;
>>>>> > }
>>>>> > EXPORT_SYMBOL_GPL(sdhci_runtime_resume_host);
>>>>> >
>>>>> > To me, it looks like SDHCI needs a major rework...  And there needs to
>>>>> > be some recognition that - maybe - leaving SDIO interrupts enabled even
>>>>> > though we may want the host to enter a low power mode is something that's
>>>>> > really very very desirable...
>>>>> >
>>>>>
>>>>> I'm not quite clear about your issue.
>>>>> But it seems your issue is caused by runtime pm disabling the
>>>>> interrupt & clocks as you said.
>>>>>
>>>>> Can you try the patch i mentioned here:
>>>>> http://www.spinics.net/lists/linux-mmc/msg24764.html
>>>>>
>>>>> That will prevent the host to do runtime pm for SDIO devices.
>>>>
>>>> Why not allow runtime PM at the host level, but still allow the
>>>> interrupt to be received?  Doesn't it make sense to allow PM even with
>>>> SDIO cards in place?
>>>>
>>>
>>> It depends on both host and card that 1) if host is able to detect
>>> SDIO interrupts without clock
>>> and 2) if the card is able to send interrupt to host without clock.
>>> If any one of both can't do that, we may need to tell host to not
>>> do runtime suspend to prevent the clock from being disabled.
>>> Or the SDIO interrupt may not work.
>>>
>>> The IMX esdhc/usdhc can not detect the SDIO interrupts sent from card
>>> if the clock is disabled.
>>
>> So you are saying you have no option to reroute the DAT1 line to a
>> GPIO irq, right? I guess that would be SOC specific.
>
> I think IMX can support reroute the DAT1 line to GPIO altough i've not tried.
> We have to extend the common sdhci driver to support it.
> Actually with some special hack, IMX can also detect SDIO irq without clock by
> using Wakeup Event Enable On Card Interrupt since the wakeup feature
> does not need clock.
> It's quite similar as using GPIO way, the difference is using which
> interrupt(gpio or sdhci itself)
> to enable the clock for the later card interrupt detect.
> The drawback is it does need a lot special and SoC specific hacks in
> common sdhci driver.
> Comparing simply disabling runtime pm way, I'm not so willing to do that.

I understand the complexity needed for this, although if you have a
look how Andreas Fenkart's solution for omap_hsmmc, I think it became
quite nice. Not sure how much extra effort is needed to adopt it for
sdhci.

If you go with the solution of disabling runtime PM while SDIO irq is
enabled, it's consequences will be that the power domain which the
device resides in can't be dropped. That may, depending on SOC design,
have really bad impact on power.

On the other hand, some SDIO func drivers seems broken and at the
moment it may be considered more important to fix them. We could
handle the optimization for power save as a follow up step instead?

>
> And i'm also afraid it may cause performance drop since i have to:
> 1) sdio interrupt -> sdhci_irq enter-> disable card interrupt->
> runtime_pm_get (enable clock in async way)
> ->sdhci_irq exist
> (after clock is enabled sdio interrupt will be detected again)
> 2) sdhci irq -> read sdio interrupt status -> sdio_signal_irq...

I suppose there will be a autosuspend timeout, thus this sequence is
only relevant once the device is in runtime suspend state. Certainly
there will be an extra latency to fetch the first SDIO irq, but I
don't think performance as such will be effected.

Additionally, maybe we can use mmc_signal_sdio_irq() from the GPIO irq
handler, thus picking up the IRQ a bit sooner than waiting for the
sdhci controller to pick it up. That could work, right?

>
> Comparing to original way(2), steps 1 is the extra cost.
> Not sure how many performance will drop since i still have not tried it.
>
>>
>>> So we need such quirk to not allow runtime PM for SDIO cards.
>>> Doesn't it make sense?
>>
>> Yes, I think so. But, maybe it should be configurable to use it?
>>
>
> Well, true, it should be configurable.
>
> Regards
> Dong Aisheng
>
>> Kind regards
>> Uffe
>>
>>>
>>> Regards
>>> Dong Aisheng
>>>
>>>> Once I get imx-drm off my plate, I'm going to put some work into
>>>> rewriting the sdhci driver mess in a much cleaner way - we can't go on
>>>> putting hacks on top of what's already there, it's already a total mess.
>>>>
>>>> --
>>>> FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
>>>> in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
>>>> Estimate before purchase was "up to 13.2Mbit".
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
