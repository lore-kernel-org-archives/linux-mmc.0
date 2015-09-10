From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: sdhci: runtime suspend/resume on card insert/removal
Date: Thu, 10 Sep 2015 15:31:29 +0800
Message-ID: <20150910153129.07adbe68@xhacker>
References: <55F12CF8.50003@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:4632 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753132AbbIJHfe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Sep 2015 03:35:34 -0400
In-Reply-To: <55F12CF8.50003@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, nico@fluxnic.net, ulf.hansson@linaro.org

Hi Vaibhav,

On Thu, 10 Sep 2015 12:40:48 +0530
Vaibhav Hiremath <vaibhav.hiremath@linaro.org> wrote:

> Hi,
> 
> During my testing of SDHCI-PXAV3 driver on Marvell's pxa1928
> based platform, I observed that runtime PM suspend/resume is having
> issues with card insertion and removal.
> 
> Let me try to explain it using execution sequence -
> 
> During boot:
> 
> MMC SD card gets detected as expected.
> 
> [    2.431012] mmc1: new high speed SDHC card at address 1234
> [    2.437235] mmcblk1: mmc1:1234 SA04G 3.63 GiB
> [    2.444841]  mmcblk1: p1
> 
> 
> Now after coming to the linux prompt, if card removal event occurs
> then the call sequence is -
> 
>   sdhci_irq() -->
>    -> sdhci_thread_irq(): host->thread_isr - 0x80
>       -> sdhci_card_event()
>       -> mmc_detect_change()
>          --> _mmc_detect_change()
>              --->  mmc_sd_detect()
>                    mmc_sd_remove()
>                    mmc_remove_card()
>                    mmc_bus_remove()
>                    mmc_power_off()
>                    mmc_set_initial_state()
>                    sdhci_set_ios()
>                    ...
>         sdhci_pxav3_runtime_suspend()
>         sdhci_runtime_suspend_host()
> 
> 
> Till here everything looks perfect :) (if I got it right)
> 
> Now on card insertion again, the expectation is, runtime resume should
> get called as part of interrupt trigger from the SDHCI controller on
> card insertion.

AFAIK, card insertion => wakeup irq, this irq doesn't come from SDHCI
controller itself because SDHCI controller is runtime suspended, clk gated
or power gated. So the wakeup irq should come from other always on components.
Take Marvell berlin SoC as an example:

there's gpio for sdcard detect, card insertion => trigger cd gpio interrupt
=>resume sdhci host etc.

If your changes work, the I guess your SDHCI host are not clk gated or
power gated during runtime suspended.

Thanks,
Jisheng

> 
> But what I am observing here is, no interrupt is generated, as it is
> not enabled at all. And the reason being sdhci_runtime_suspend_host()
> 
> 
> int sdhci_runtime_suspend_host(struct sdhci_host *host)
> {
>      ....
>      spin_lock_irqsave(&host->lock, flags);
>      host->ier &= SDHCI_INT_CARD_INT;
>      sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
>      sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
>      spin_unlock_irqrestore(&host->lock, flags);
>      ...
> }
> 
> 
> In my case, I see SDHCI_INT_CARD_INT is not ON and with above step
> we are not ensuring that it is enabled either.
> Also we are not enabling card insertion and removal interrupts.
> 
> I have done following change to the code -
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 418f381..3129292 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2783,9 +2783,12 @@ int sdhci_runtime_suspend_host(struct sdhci_host 
> *host)
>          mmc_retune_needed(host->mmc);
> 
>          spin_lock_irqsave(&host->lock, flags);
> -       host->ier &= SDHCI_INT_CARD_INT;
> +
> +       host->flags |= SDHCI_SDIO_IRQ_ENABLED;
> +       host->ier |= SDHCI_INT_CARD_INT;
>          sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
>          sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
> +
>          spin_unlock_irqrestore(&host->lock, flags);
> 
>          synchronize_hardirq(host->irq);
> 
> 
> 
> And things started working as expected.
> The execution sequence of irq and sdhci_runtime_resume
> both looks ok to me.
> 
> Card insertion event =
> 
>   sdhci_irq() -->
>    -> sdhci_thread_irq: host->thread_isr - 40
>       --> sdhci_card_event()
>       -->  mmc_detect_change()
>            ---> _mmc_detect_change()
>        ...
>   -> sdhci_pxav3_runtime_resume()
>      --> sdhci_do_set_ios:1438
> 
> 
> 
> I see card getting enumerated as expected -
> 
> [   15.116098] mmc1: mmc_rescan_try_freq: trying to init card at 400000 Hz
> [   15.356473] mmc1: new high speed SDHC card at address 1234
> [   15.363962] mmcblk1: mmc1:1234 SA04G 3.63 GiB
> [   15.371043] sdhci_thread_irq:2642 host->thread_isr - 100
> [   15.376492]  mmcblk1: p1
> 
> 
> I believe (based on my understanding) the change I have done is right.
> I am not sure how other platforms using sdhci.c working so far,
> probably no runtime_pm support? Not sure though
> 
> Please let me know if I am missing something here.
> And not, and everyone is ok with this, I will submit the patch fixing
> this issue.
> 
> 
> Thanks,
> Vaibhav
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

