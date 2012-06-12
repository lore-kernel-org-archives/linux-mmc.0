From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: mmc_cd_gpio_request() failed request_threaded_irq()
Date: Tue, 12 Jun 2012 23:24:02 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1206122323040.6800@axis700.grange>
References: <87aa09xcd6.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:59919 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753854Ab2FLVYE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jun 2012 17:24:04 -0400
In-Reply-To: <87aa09xcd6.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: kuninori.morimoto.gx@renesas.com
Cc: linux-mmc@vger.kernel.org

On Mon, 11 Jun 2012, kuninori.morimoto.gx@renesas.com wrote:

> Hi all
> 
> I noticed that mmc_cd_gpio_request() failed on request_threaded_irq().
> Now, I'm using v3.5-rc2 kernel.
> 
> current ${LINUX}/drivers/mmc/core/cd-gpio.c :: mmc_cd_gpio_request() uses
> 
> request_threaded_irq(irq, NULL, mmc_cd_gpio_irqt,
> 		   IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> 		   cd->label, host);
> 
> It doesn't have hander (2nd is NULL), and flag doesn't have IRQF_ONESHOT.
> Then, it run  request_threaded_irq() -> __setup_irq()
> and, it got this error.
> 
> pr_err("Threaded irq requested with handler=NULL and !ONESHOT for irq %d\n",
> 	irq);
> 
> I'm not sure detail of it, but maybe from this commit
> 
> -------------------------------------------
> commit 1c6c69525b40eb76de8adf039409722015927dc3
> Author: Thomas Gleixner <tglx@linutronix.de>
> Date:   Thu Apr 19 10:35:17 2012 +0200
> 
>     genirq: Reject bogus threaded irq requests

Also see this thread: https://lkml.org/lkml/2012/6/12/151

For now you can add an IRQF_ONESHOT flag to the call.

Thanks
Guennadi

>     
>     Requesting a threaded interrupt without a primary handler and without
>     IRQF_ONESHOT set is dangerous.
>     
>     The core will use the default primary handler for it, which merily
>     wakes the thread. For a level type interrupt this results in an
>     interrupt storm, because the interrupt line is reenabled after the
>     primary handler runs. The device has still the line asserted, which
>     brings us back into the primary handler.
>     ...
> ------------------------------------------
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
