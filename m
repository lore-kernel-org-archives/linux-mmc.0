From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [mmc:mmc-next 79/96] drivers/mmc/host/omap_hsmmc.c:1841:30:
 error: 'struct dev_pm_info' has no member named 'runtime_status'
Date: Thu, 22 May 2014 14:39:14 +0200
Message-ID: <CAPDyKFoWABO-k9dh5AvhaJFoF-NRCBz1_G+fJ53MPnzBr42CfQ@mail.gmail.com>
References: <537de770.ItHqmb5BpaXWIlXq%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:57223 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250AbaEVMjO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 May 2014 08:39:14 -0400
Received: by mail-qg0-f50.google.com with SMTP id z60so5433102qgd.23
        for <linux-mmc@vger.kernel.org>; Thu, 22 May 2014 05:39:14 -0700 (PDT)
In-Reply-To: <537de770.ItHqmb5BpaXWIlXq%fengguang.wu@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: Andreas Fenkart <afenkart@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, balajitk <balajitk@ti.com>

On 22 May 2014 14:02, kbuild test robot <fengguang.wu@intel.com> wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git mmc-next
> head:   830bb78ad0985cc44246fcd6f6c1fdddd04c5abb
> commit: f6a903a75eff1eb6d53703543b1674da211b0b28 [79/96] mmc: omap_hsmmc: Extend debugfs by SDIO IRQ handling, runtime state
> config: make ARCH=m68k allmodconfig
>
> All error/warnings:
>
>    drivers/mmc/host/omap_hsmmc.c: In function 'omap_hsmmc_regs_show':
>>> drivers/mmc/host/omap_hsmmc.c:1841:30: error: 'struct dev_pm_info' has no member named 'runtime_status'
>
> vim +1841 drivers/mmc/host/omap_hsmmc.c
>
>   1835          if (mmc->caps & MMC_CAP_SDIO_IRQ) {
>   1836                  seq_printf(s, "sdio irq \t%s\n",
>   1837                             (host->flags & HSMMC_SDIO_IRQ_ENABLED) ?  "enabled"
>   1838                             : "disabled");
>   1839          }
>   1840
>> 1841          suspended = host->dev->power.runtime_status != RPM_ACTIVE;
>   1842          seq_printf(s, "runtime state\t%s\n", (suspended ?  "idle" : "active"));
>   1843
>   1844          seq_printf(s, "ctx_loss:\t%d\n", host->context_loss);
>
> ---
> 0-DAY kernel build testing backend              Open Source Technology Center
> http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation

Hi Chris,

I had a second look at Andreas Fenkart's patchset to enable SDIO irq
for omap. Those needs an additional iteration, since there are
unresolved dependencies to CONFIG_PM_RUNTIME (and possibly to other
Kconfigs as well). Apparently I had all the needed Kconfigs enabled
while I compile tested them. :-(

I tried out doing a local re-base, to remove the related omap patches.
If you remove the patches below you won't get any conflicts for
omap_hsmmc. Can you do that?

Andreas:
mmc: omap_hsmmc: Enable SDIO interrupt
mmc: omap_hsmmc: enable wakeup event for sdio OMAP4
mmc: omap_hsmmc: Extend debugfs by SDIO IRQ handling, runtime state
mmc: omap_hsmmc: abort runtime suspend if pending sdio irq detected
mmc: omap_hsmmc: switch default/idle pinctrl states in runtime hooks
mmc: omap_hsmmc: Pin remux workaround to support SDIO interrupt on AM335x

Balaji:
mmc: omap_hsmmc: use IS_ERR macro for error checking

Kind regards
Uffe
