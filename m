From: Chris Ball <chris@printf.net>
Subject: Re: [mmc:mmc-next 79/96] drivers/mmc/host/omap_hsmmc.c:1841:30: error: 'struct dev_pm_info' has no member named 'runtime_status'
Date: Thu, 22 May 2014 13:41:28 +0100
Message-ID: <86oayqq93b.fsf@void.printf.net>
References: <537de770.ItHqmb5BpaXWIlXq%fengguang.wu@intel.com>
	<CAPDyKFoWABO-k9dh5AvhaJFoF-NRCBz1_G+fJ53MPnzBr42CfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:48086 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038AbaEVMlb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 22 May 2014 08:41:31 -0400
In-Reply-To: <CAPDyKFoWABO-k9dh5AvhaJFoF-NRCBz1_G+fJ53MPnzBr42CfQ@mail.gmail.com>
	(Ulf Hansson's message of "Thu, 22 May 2014 14:39:14 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Andreas Fenkart <afenkart@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, balajitk <balajitk@ti.com>

Hi,

On Thu, May 22 2014, Ulf Hansson wrote:
> I had a second look at Andreas Fenkart's patchset to enable SDIO irq
> for omap. Those needs an additional iteration, since there are
> unresolved dependencies to CONFIG_PM_RUNTIME (and possibly to other
> Kconfigs as well). Apparently I had all the needed Kconfigs enabled
> while I compile tested them. :-(
>
> I tried out doing a local re-base, to remove the related omap patches.
> If you remove the patches below you won't get any conflicts for
> omap_hsmmc. Can you do that?
>
> Andreas:
> mmc: omap_hsmmc: Enable SDIO interrupt
> mmc: omap_hsmmc: enable wakeup event for sdio OMAP4
> mmc: omap_hsmmc: Extend debugfs by SDIO IRQ handling, runtime state
> mmc: omap_hsmmc: abort runtime suspend if pending sdio irq detected
> mmc: omap_hsmmc: switch default/idle pinctrl states in runtime hooks
> mmc: omap_hsmmc: Pin remux workaround to support SDIO interrupt on AM335x
>
> Balaji:
> mmc: omap_hsmmc: use IS_ERR macro for error checking

Done.  Thanks!

- Chris.
-- 
Chris Ball   <http://printf.net/>
