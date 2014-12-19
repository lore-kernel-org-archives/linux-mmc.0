From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC PATCH 0/5]mmc: Soft Command queue implementation for eMMC5.1 device
Date: Fri, 19 Dec 2014 10:02:11 +0100
Message-ID: <CAPDyKFp+a+6suhommHuxJ1TnaV6tr9EdB8_Ut543FjHFwUYrLw@mail.gmail.com>
References: <20141219080442.GA3775@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:61440 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752378AbaLSJCM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Dec 2014 04:02:12 -0500
Received: by mail-qa0-f41.google.com with SMTP id s7so310225qap.28
        for <linux-mmc@vger.kernel.org>; Fri, 19 Dec 2014 01:02:11 -0800 (PST)
In-Reply-To: <20141219080442.GA3775@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 19 December 2014 at 09:04, Chuanxiao Dong <chuanxiao.dong@intel.com> wrote:
> Hello,
>
> Seems community already have some implementation for the eMMC5.1 device command
> queue feature, but that require the eMMC host controller to support CMDQ. In my
> platform, I don't have this kind of eMMC host controller but I have a
> Samsung eMMC5.1 device which can support the Command queue.
>
> With this limitation, I have to let eMMC host controller to manually send the
> CMD44/45/13/46/47. So in this way, more commands are needed for an I/O request,
> more interrupts/schedule are needed in driver.
>
> Even this way have some more software overhead, but it can still use the eMMC5.1
> device Command queue feature. After test with the iozone command:
> "iozone -zec -t 4 -i0 -i2 -F iozonefile1 iozonefile2 iozonefile3 iozonefile4 -+n
> -I -r 4k -s 500m -O -R -+r -+D" to test random performance, I saw a performance
> improvment for random read on my eMMC5.1 device:
>
>                 Random read
> SW CMDQ:        5544.6
> Normal Read:    3993.05

Thanks for the patchset Chuanxiao! I will spend some time reviewing
this in more detail as soon as I can.

One important point though, before I start reviewing. I would like the
"Normal read" to be performed for a host driver supporting the
asynchronous mmc request feature. Currently sdhci don't support this,
but there is patch suggesting to add this which you might want to
use/review.
https://www.marc.info/?l=linux-mmc&m=141811588607432&w=2

Kind regards
Uffe

>
> So I want to send this serial patches as RFC patch for reviewing
>
>
> Chuanxiao Dong (5):
>   mmc: replace sbc to precmd and add postcmd
>   mmc: host: add runtime PM for host class dev
>   mmc: queue: change mqrq_cur and mqrq_pre to mq qdepth
>   mmc: core: add support for CMDQ feature in MMC Core stack
>   mmc: sdhci: add SW CMDQ support for CHT SDHCI host
>
>  drivers/mmc/card/block.c      |  538 ++++++++++++++++++++++++++++++++++++++---
>  drivers/mmc/card/queue.c      |  213 ++++++++--------
>  drivers/mmc/card/queue.h      |   14 +-
>  drivers/mmc/core/core.c       |   78 +++++-
>  drivers/mmc/core/host.c       |   14 ++
>  drivers/mmc/core/mmc.c        |   43 +++-
>  drivers/mmc/host/dw_mmc.c     |    8 +-
>  drivers/mmc/host/mmci.c       |   14 +-
>  drivers/mmc/host/omap_hsmmc.c |   18 +-
>  drivers/mmc/host/sdhci-acpi.c |    1 -
>  drivers/mmc/host/sdhci-pci.c  |    1 -
>  drivers/mmc/host/sdhci.c      |  137 +++++++++--
>  include/linux/mmc/card.h      |    3 +
>  include/linux/mmc/core.h      |    5 +-
>  include/linux/mmc/host.h      |    5 +
>  include/linux/mmc/mmc.h       |   21 ++
>  include/linux/mmc/pm.h        |    1 +
>  include/linux/mmc/sdhci.h     |    1 +
>  18 files changed, 909 insertions(+), 206 deletions(-)
>
> --
> 1.7.10.4
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
