From: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: RE: [PATCH 0/5] mmc: Soft Command queue implementation for eMMC5.1
 device
Date: Thu, 2 Apr 2015 10:52:09 +0000
Message-ID: <17296D9F8FF2234F831FC3DF505A87A911C49E08@shsmsx102.ccr.corp.intel.com>
References: <20150317110955.GA17141@intel.com>
 <282CEDFCBC30114F83C499CB8F2ED5333FA64788@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:27790 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750711AbbDBKwN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Apr 2015 06:52:13 -0400
In-Reply-To: <282CEDFCBC30114F83C499CB8F2ED5333FA64788@SACMBXIP01.sdcorp.global.sandisk.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alex Lemberg <Alex.Lemberg@sandisk.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>

Thanks Alex for review.

>From my understanding, if host->areq == areq, then means the areq is the current running request. By this way, driver will clear the executable ready bit in slots and continue to find the next one. So the task with the same ID won't be executed at the same time.

+	do {
+		id = find_first_bit(&slots, mq->qdepth);
+		if (id < mq->qdepth) {
+			areq = &mq->mqrq[id].mmc_active;
+			if (host->areq == areq)
+				goto next;
.....
......
+next:
+		__clear_bit(id, &slots);
+	} while (status);

I also prepared patch set v1, which won't send CMD13 to poll cmdq ready during a cmdq request is executing by CMD46/47. Will send them out later.

Thanks
Chuanxiao

> -----Original Message-----
> From: Alex Lemberg [mailto:Alex.Lemberg@sandisk.com]
> Sent: Thursday, April 02, 2015 4:57 PM
> To: Dong, Chuanxiao; linux-mmc@vger.kernel.org
> Cc: Yuliy Izrailov
> Subject: RE: [PATCH 0/5] mmc: Soft Command queue implementation for
> eMMC5.1 device
> 
> Hi Chuanxiao,
> 
> 
> > -----Original Message-----
> > From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> > owner@vger.kernel.org] On Behalf Of Chuanxiao Dong
> > Sent: Tuesday, March 17, 2015 1:10 PM
> > To: linux-mmc@vger.kernel.org
> > Subject: [PATCH 0/5] mmc: Soft Command queue implementation for
> > eMMC5.1 device
> >
> > Hello
> >
> > This serial of patches can implement the eMMC5.1 device command queue
> > feature even a host controller doesn't support CMDQ. Several weeks ago
> > I submitted RFC patches for review and collected some review comments.
> > Right now these comments are fixed thus I submit again as the offical
> > patches. Please have a review.
> 
> Thanks for sending the new patch.
> We have reviewed and see issues still exists like in previous patch version.
> The driver flow where request with the same TID is executed right after
> completing its data transfer, is still possible.
> We suspect that the new solution is not covering the case of driver thread
> context switch, Specifically the following condition in block.c:
> 
> +			if (host->areq == areq)
> +				goto next;
> 
> 
> Thanks,
> Alex
> 
> >
> > Chuanxiao Dong (5):
> >   mmc: replace sbc to precmd and add postcmd
> >   mmc: host: add runtime PM for host class dev
> >   mmc: queue: change mqrq_cur and mqrq_pre to mq qdepth
> >   mmc: core: add support for CMDQ feature in MMC Core stack
> >   mmc: sdhci: add SW CMDQ support for SDHCI host
> >
> >  drivers/mmc/card/block.c      |  538
> > ++++++++++++++++++++++++++++++++++++++---
> >  drivers/mmc/card/queue.c      |  213 ++++++++--------
> >  drivers/mmc/card/queue.h      |   14 +-
> >  drivers/mmc/core/core.c       |   85 ++++++-
> >  drivers/mmc/core/host.c       |   13 +
> >  drivers/mmc/core/mmc.c        |   37 ++-
> >  drivers/mmc/host/dw_mmc.c     |    8 +-
> >  drivers/mmc/host/mmci.c       |   14 +-
> >  drivers/mmc/host/omap_hsmmc.c |   18 +-
> >  drivers/mmc/host/sdhci-acpi.c |    1 -
> >  drivers/mmc/host/sdhci-pci.c  |    1 -
> >  drivers/mmc/host/sdhci.c      |  137 +++++++++--
> >  drivers/mmc/host/sdhci.h      |    1 +
> >  include/linux/mmc/card.h      |    3 +
> >  include/linux/mmc/core.h      |    5 +-
> >  include/linux/mmc/host.h      |    5 +
> >  include/linux/mmc/mmc.h       |   21 ++
> >  include/linux/mmc/pm.h        |    1 +
> >  18 files changed, 911 insertions(+), 204 deletions(-)
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc"
> > in the body of a message to majordomo@vger.kernel.org More majordomo
> > info at http://vger.kernel.org/majordomo-info.html
