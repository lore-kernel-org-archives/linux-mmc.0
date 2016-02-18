From: Vishal Thanki <vishalthanki@gmail.com>
Subject: omap_hsmmc: sdio: issue with generic wakeup IRQ handling
Date: Thu, 18 Feb 2016 19:27:52 +0100
Message-ID: <20160218182750.GA5948@c50.bag.software>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:34670 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423242AbcBRS14 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Feb 2016 13:27:56 -0500
Received: by mail-wm0-f45.google.com with SMTP id b205so37439624wmb.1
        for <linux-mmc@vger.kernel.org>; Thu, 18 Feb 2016 10:27:55 -0800 (PST)
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, afenkart@gmail.com

Hi,

On a custom built am335x based board, I am facing an issue mwifiex wifi
module which is connected to host via SDIO interface. I am using kernel
version 4.4.

The problem is related to the wifi "ext_scan" command getting timed out
over SDIO. This was working with old kernel (v4.0), but does not work on
kernel v4.4. I found the following commit is responsible for this
behavior.

=================================
5b83b2234be6733cfe22036c38031b2c890b3db8

mmc: omap_hsmmc: Change wake-up interrupt to use generic wakeirq 

We can now use generic wakeirq handling and remove the custom handling 
for the wake-up interrupts. 
=================================

There is no wifi issue if I revert the above mentioned commit on kernel
v4.4.

I see that before this commit, the wakeup IRQ handler was registered
within the omap_hsmmc.c itself with additional IRQF_TRIGGER_LOW flag.
But with the introduction to dev_pm_set_dedicated_wake_irq(), the
generic wakeup IRQ handler is registered which does not take the
IRQF_TRIGGER flag. I am not sure if that is the issue, but I added that
IRQF_TRIGGER_LOW flag in dev_pm_set_dedicated_wake_irq() while
registering a threaded IRQ handler, I could see the problem disappears.
However, this change is causing the infinite interrupts because the of
level triggered interrupt is not handled in generic wakeup IRQ handling
code (as it was done specially in omap_hsmmc.c code earlier). 

I am not much familiar with MMC/SDIO driver and I am not sure how to fix
this behavior. So any guidance would be really helpful.

Thanks,
Vishal
