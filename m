From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] drivers/mfd: Add realtek pcie card reader driver
Date: Mon, 13 Aug 2012 13:06:21 +0000
Message-ID: <201208131306.21248.arnd@arndb.de>
References: <1344823586-2956-1-git-send-email-wei_wang@realsil.com.cn>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:55722 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665Ab2HMNGr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Aug 2012 09:06:47 -0400
In-Reply-To: <1344823586-2956-1-git-send-email-wei_wang@realsil.com.cn>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: wei_wang@realsil.com.cn
Cc: gregkh@linuxfoundation.org, devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, sameo@linux.intel.com, bp@alien8.de, aaron.lu@amd.com

On Monday 13 August 2012, wei_wang@realsil.com.cn wrote:
> From: Wei WANG <wei_wang@realsil.com.cn>
> 
> Realtek PCI-E card reader driver adapts requests from upper-level
> sdmmc/memstick layer to the real physical card reader.
> 
> Signed-off-by: Wei WANG <wei_wang@realsil.com.cn>

Hi,

This looks pretty good overall, I'm generally happy with how you have
changed the structure. Looking at some of the details now:

> +
> +static const struct pcr_ops rts5209_pcr_ops = {
> +	.extra_init_hw = rts5209_extra_init_hw,
> +	.optimize_phy = rts5209_optimize_phy,
> +	.turn_on_led = rts5209_turn_on_led,
> +	.turn_off_led = rts5209_turn_off_led,
> +	.enable_auto_blink = rts5209_enable_auto_blink,
> +	.disable_auto_blink = rts5209_disable_auto_blink,
> +};
> ...
> +
> +static const struct pcr_ops rts5229_pcr_ops = {
> +	.extra_init_hw = rts5229_extra_init_hw,
> +	.optimize_phy = rts5229_optimize_phy,
> +	.turn_on_led = rts5229_turn_on_led,
> +	.turn_off_led = rts5229_turn_off_led,
> +	.enable_auto_blink = rts5229_enable_auto_blink,
> +	.disable_auto_blink = rts5229_disable_auto_blink,
> +};

Doing this separation is fine for two or three variants, especially
since the code behind them is not very big. If it becomes likely
that there will be many more variants, you should consider moving
them into separate files.

> +void rtsx_pci_start_run(struct rtsx_pcr *pcr)
> +{
> +	/* If pci device removed, don't queue idle work any more */
> +	if (pcr->remove_pci)
> +		return;
> +
> +	if (pcr->state != PDEV_STAT_RUN) {
> +		pcr->state = PDEV_STAT_RUN;
> +		pcr->ops->enable_auto_blink(pcr);
> +	}
> +
> +	cancel_delayed_work(&pcr->idle_work);
> +	queue_delayed_work(workqueue, &pcr->idle_work, msecs_to_jiffies(200));
> +}
> +EXPORT_SYMBOL_GPL(rtsx_pci_start_run);

Let me make sure I understand the logic here: When you send a command to
the driver, you turn on the blinking LED and then set a timer to turn
it off again after 200 ms, unless another command comes in, right?

This is slightly more overhead than I think you should have here.
Doing mod_timer() on a timer function might be better if you have a lot
of commands calling into rtsx_pci_start_run. Since you currently
require a mutex to be held when disabling the blinking, you might
need to schedule a work queue without timer from that timer function
though, or alternatively change the code to not require the mutex.

	Arnd
