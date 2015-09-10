From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: sdhci: runtime suspend/resume on card insert/removal
Date: Thu, 10 Sep 2015 16:04:02 +0800
Message-ID: <20150910160402.3b78b5c6@xhacker>
References: <55F12CF8.50003@linaro.org>	<20150910153129.07adbe68@xhacker>
	<20150910080233.GH21084@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:13911 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751242AbbIJIIN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Sep 2015 04:08:13 -0400
In-Reply-To: <20150910080233.GH21084@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>, ulf.hansson@linaro.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, nico@fluxnic.net

Hi Russell,

On Thu, 10 Sep 2015 09:02:33 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Thu, Sep 10, 2015 at 03:31:29PM +0800, Jisheng Zhang wrote:
> > Hi Vaibhav,
> > 
> > On Thu, 10 Sep 2015 12:40:48 +0530
> > Vaibhav Hiremath <vaibhav.hiremath@linaro.org> wrote:
> > 
> > > Hi,
> > > 
> > > During my testing of SDHCI-PXAV3 driver on Marvell's pxa1928
> > > based platform, I observed that runtime PM suspend/resume is having
> > > issues with card insertion and removal.
> > > 
> > > Let me try to explain it using execution sequence -
> > > 
> > > During boot:
> > > 
> > > MMC SD card gets detected as expected.
> > > 
> > > [    2.431012] mmc1: new high speed SDHC card at address 1234
> > > [    2.437235] mmcblk1: mmc1:1234 SA04G 3.63 GiB
> > > [    2.444841]  mmcblk1: p1
> > > 
> > > 
> > > Now after coming to the linux prompt, if card removal event occurs
> > > then the call sequence is -
> > > 
> > >   sdhci_irq() -->
> > >    -> sdhci_thread_irq(): host->thread_isr - 0x80
> > >       -> sdhci_card_event()
> > >       -> mmc_detect_change()
> > >          --> _mmc_detect_change()
> > >              --->  mmc_sd_detect()
> > >                    mmc_sd_remove()
> > >                    mmc_remove_card()
> > >                    mmc_bus_remove()
> > >                    mmc_power_off()
> > >                    mmc_set_initial_state()
> > >                    sdhci_set_ios()
> > >                    ...
> > >         sdhci_pxav3_runtime_suspend()
> > >         sdhci_runtime_suspend_host()
> > > 
> > > 
> > > Till here everything looks perfect :) (if I got it right)
> > > 
> > > Now on card insertion again, the expectation is, runtime resume should
> > > get called as part of interrupt trigger from the SDHCI controller on
> > > card insertion.
> > 
> > AFAIK, card insertion => wakeup irq, this irq doesn't come from SDHCI
> 
> Wakeup IRQs are what happens when the _system_ is in suspend, not
> when the device is runtime suspended.

Oh, yes. Sorry for misleading, I didn't express myself clearly. What
I really means is that the card insertion/remove irq which could finally
cause sdhci host resumed.

Thanks for clarification,
Jisheng

