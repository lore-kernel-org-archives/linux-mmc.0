From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: sdhci: runtime suspend/resume on card insert/removal
Date: Mon, 14 Sep 2015 16:18:04 +0800
Message-ID: <20150914161804.101dfc55@xhacker>
References: <55F12CF8.50003@linaro.org>	<20150910153129.07adbe68@xhacker>
	<20150910080233.GH21084@n2100.arm.linux.org.uk>
	<20150910160402.3b78b5c6@xhacker>	<55F66874.2000609@linaro.org>
	<20150914142838.07ec6a07@xhacker>	<55F681AC.2010605@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:9042 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752223AbbINIWS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Sep 2015 04:22:18 -0400
In-Reply-To: <55F681AC.2010605@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, ulf.hansson@linaro.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, nico@fluxnic.net

On Mon, 14 Sep 2015 13:43:32 +0530
Vaibhav Hiremath <vaibhav.hiremath@linaro.org> wrote:

> 
> 
> On Monday 14 September 2015 11:58 AM, Jisheng Zhang wrote:
> > On Mon, 14 Sep 2015 11:55:56 +0530
> > Vaibhav Hiremath <vaibhav.hiremath@linaro.org> wrote:
> >
> >>
> >>
> >> On Thursday 10 September 2015 01:34 PM, Jisheng Zhang wrote:
> >>> Hi Russell,
> >>>
> >>> On Thu, 10 Sep 2015 09:02:33 +0100
> >>> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> >>>
> >>>> On Thu, Sep 10, 2015 at 03:31:29PM +0800, Jisheng Zhang wrote:
> >>>>> Hi Vaibhav,
> >>>>>
> >>>>> On Thu, 10 Sep 2015 12:40:48 +0530
> >>>>> Vaibhav Hiremath <vaibhav.hiremath@linaro.org> wrote:
> >>>>>
> >>>>>> Hi,
> >>>>>>
> >>>>>> During my testing of SDHCI-PXAV3 driver on Marvell's pxa1928
> >>>>>> based platform, I observed that runtime PM suspend/resume is having
> >>>>>> issues with card insertion and removal.
> >>>>>>
> >>>>>> Let me try to explain it using execution sequence -
> >>>>>>
> >>>>>> During boot:
> >>>>>>
> >>>>>> MMC SD card gets detected as expected.
> >>>>>>
> >>>>>> [    2.431012] mmc1: new high speed SDHC card at address 1234
> >>>>>> [    2.437235] mmcblk1: mmc1:1234 SA04G 3.63 GiB
> >>>>>> [    2.444841]  mmcblk1: p1
> >>>>>>
> >>>>>>
> >>>>>> Now after coming to the linux prompt, if card removal event occurs
> >>>>>> then the call sequence is -
> >>>>>>
> >>>>>>     sdhci_irq() -->
> >>>>>>      -> sdhci_thread_irq(): host->thread_isr - 0x80
> >>>>>>         -> sdhci_card_event()
> >>>>>>         -> mmc_detect_change()
> >>>>>>            --> _mmc_detect_change()
> >>>>>>                --->  mmc_sd_detect()
> >>>>>>                      mmc_sd_remove()
> >>>>>>                      mmc_remove_card()
> >>>>>>                      mmc_bus_remove()
> >>>>>>                      mmc_power_off()
> >>>>>>                      mmc_set_initial_state()
> >>>>>>                      sdhci_set_ios()
> >>>>>>                      ...
> >>>>>>           sdhci_pxav3_runtime_suspend()
> >>>>>>           sdhci_runtime_suspend_host()
> >>>>>>
> >>>>>>
> >>>>>> Till here everything looks perfect :) (if I got it right)
> >>>>>>
> >>>>>> Now on card insertion again, the expectation is, runtime resume should
> >>>>>> get called as part of interrupt trigger from the SDHCI controller on
> >>>>>> card insertion.
> >>>>>
> >>>>> AFAIK, card insertion => wakeup irq, this irq doesn't come from SDHCI
> >>>>
> >>>> Wakeup IRQs are what happens when the _system_ is in suspend, not
> >>>> when the device is runtime suspended.
> >>>
> >>> Oh, yes. Sorry for misleading, I didn't express myself clearly. What
> >>> I really means is that the card insertion/remove irq which could finally
> >>> cause sdhci host resumed.
> >>>
> >>
> >> So Jisheng,
> >>
> >> You are ok with above change, right?
> >
> > Nope. the above is just to clarify my mixing "wakeup IRQs" and the card
> > insertion/remove irq that brings sdhci host resumed.
> >
> > IMHO, your patch is still not necessary and perhaps wrong.
> >
> 
> Don't be in hurry to conclude,
> Let's understand the technical aspect fist.
> 
> 
> Let me clarify once again here,
> 
> 
> The card detect interrupt is coming from SDHCI controller itself,

But how the SDHCI controller generate CD interrupt when it's in runtime suspended
state, i.e clock gated or power gated?

> I have confirmed that the runtime PM is working perfectly fine,
> clock is gated/disabled on card removal.

But seems we still didn't know the sdhci host is clock gated or power gated.

> 
> 
> Clock Gating:
> =============
> #
> # devmem 0xd4282854
> 0x0000181B
> # [ 1318.948460] mmc1: card 1234 removed
> 
> #
> # devmem 0xd4282854
> 0x00001800
> #

Can you plz read the SDHCI host registers after this step? If the host is
clock gated, we should get "asynchronous external abort" in theory.

Thanks
