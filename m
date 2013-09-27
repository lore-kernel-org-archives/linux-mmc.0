From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] mmc: omap_hsmmc: Enable SDIO interrupt
Date: Fri, 27 Sep 2013 14:10:02 -0700
Message-ID: <20130927211001.GG8949@atomide.com>
References: <20130925234544.3745.55170.stgit@localhost>
 <20130925234740.3745.50637.stgit@localhost>
 <CALtMJEBKbbpM47uhM-KeSRHRkM5CJkgBx4kFq4j+GG9sKXEfag@mail.gmail.com>
 <20130926141936.GE8949@atomide.com>
 <CALtMJEDKxTcaNHmrVqMv7tznxB0uqYxuOix+ks+Bs_huiOCL4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57407 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797Ab3I0VKF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Sep 2013 17:10:05 -0400
Content-Disposition: inline
In-Reply-To: <CALtMJEDKxTcaNHmrVqMv7tznxB0uqYxuOix+ks+Bs_huiOCL4A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, linux-omap <linux-omap@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Balaji T K <balajitk@ti.com>

* Andreas Fenkart <afenkart@gmail.com> [130926 23:46]:
> 
> It's what Balaji already pointed out.
> 
> +   /* no transfer running, need to signal cirq if */
> +   if (host->sdio_irq_en)
> +       irq_mask |= CIRQ_EN;
> 
> 
> omap_hsmmc_request_done calls omap_hsmmc_disable_irq
> 
> imagine this case:
> 1. host issues transfer from host->card (e.g. get RSSI)
> 2. at end of this transfer, SDIO IRQ are being masked
> 3. card wants to reply, raises an SDIO IRQ
> 4. nothing happens, since in 2. SDIO IRQ are masked
> 
> I verified this with my 88W8787 card. It is a problem

OK thanks makes sense. 

> Something like this but shorter as a comment:
> 
> /*
>  * Must not touch registers while fclk if off, otherwise SIGBUS.
>  * Card will still wake up upon SDIO IRQ, and we'll complete
>  * the request in pm_runtime_resume
>  */
> 
> Another interpretation of your code could be:
> 
> /* Sorry I'm having Siesta right now, try later */

Well the clocking issue should be already handled by the
runtime PM, otherwise we have a bug somewhere. I'm almost
certain that no special handling is needed for register
access beyond runtime PM, but it would probably be best
if you could test it.

> Compatible section you mean, that sounds to good to me.
> But do we know platform have the deficiency?
> 
> There used to be an if statement like this in one of your previous
> patches.
> 
> +   if (match) {
> +       mmc->caps |= MMC_CAP_SDIO_IRQ;
> +       if (of_find_property(host->dev->of_node,
> +                    "ti,quirk-swakeup-missing", NULL)) {
> +           /* no wakeup from deeper power states, use polling */
> +           mmc->caps &= ~MMC_CAP_SDIO_IRQ;
> +       }
> +   }
> 
> Either or is needed, otherwise existing platforms will break, and will have
> to apply patches on top of yours to reenable polling (e.g. beaglebone)

Yes, let's merge the necessary tweaks to this patch before
applying. The SDIO interrupt should work during runtime
for all omaps, so maybe we should just ensure that runtime
PM keeps those omaps from going to deeper idle modes for
now.

Regards,

Tony
