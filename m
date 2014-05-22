From: Tony Lindgren <tony@atomide.com>
Subject: Re: [mmc:mmc-next 79/96] drivers/mmc/host/omap_hsmmc.c:1841:30:
 error: 'struct dev_pm_info' has no member named 'runtime_status'
Date: Thu, 22 May 2014 07:24:02 -0700
Message-ID: <20140522142401.GA14489@atomide.com>
References: <537de770.ItHqmb5BpaXWIlXq%fengguang.wu@intel.com>
 <CAPDyKFoWABO-k9dh5AvhaJFoF-NRCBz1_G+fJ53MPnzBr42CfQ@mail.gmail.com>
 <86oayqq93b.fsf@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:51014 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750788AbaEVOYI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 May 2014 10:24:08 -0400
Content-Disposition: inline
In-Reply-To: <86oayqq93b.fsf@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Andreas Fenkart <afenkart@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, balajitk <balajitk@ti.com>

* Chris Ball <chris@printf.net> [140522 05:42]:
> Hi,
> 
> On Thu, May 22 2014, Ulf Hansson wrote:
> > I had a second look at Andreas Fenkart's patchset to enable SDIO irq
> > for omap. Those needs an additional iteration, since there are
> > unresolved dependencies to CONFIG_PM_RUNTIME (and possibly to other
> > Kconfigs as well). Apparently I had all the needed Kconfigs enabled
> > while I compile tested them. :-(

Did you find this out with make randconfig?

> > I tried out doing a local re-base, to remove the related omap patches.
> > If you remove the patches below you won't get any conflicts for
> > omap_hsmmc. Can you do that?
> >
> > Andreas:
> > mmc: omap_hsmmc: Enable SDIO interrupt
> > mmc: omap_hsmmc: enable wakeup event for sdio OMAP4
> > mmc: omap_hsmmc: Extend debugfs by SDIO IRQ handling, runtime state
> > mmc: omap_hsmmc: abort runtime suspend if pending sdio irq detected
> > mmc: omap_hsmmc: switch default/idle pinctrl states in runtime hooks
> > mmc: omap_hsmmc: Pin remux workaround to support SDIO interrupt on AM335x
> >
> > Balaji:
> > mmc: omap_hsmmc: use IS_ERR macro for error checking
> 
> Done.  Thanks!

Andreas, can you fix this ASAP? Would be nice to have those
working for v3.16 :)

Once you have updated patches available I'll include them
also to my randconfig builds. Unless the Kconfig options
are nested they are exposed after few builds typically.

Regards,

Tony
