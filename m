From: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: RE: [RFC PATCH 0/5]mmc: Soft Command queue implementation for
 eMMC5.1 device
Date: Fri, 13 Feb 2015 00:33:18 +0000
Message-ID: <17296D9F8FF2234F831FC3DF505A87A911BFFE99@shsmsx102.ccr.corp.intel.com>
References: <20141219080442.GA3775@intel.com>
 <282CEDFCBC30114F83C499CB8F2ED5333EDFA356@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:55015 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751540AbbBMAdX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Feb 2015 19:33:23 -0500
In-Reply-To: <282CEDFCBC30114F83C499CB8F2ED5333EDFA356@SACMBXIP02.sdcorp.global.sandisk.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alex Lemberg <Alex.Lemberg@sandisk.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>

Hi Alex,

Can you please point me to the 5.1 spec which has the description of "" ready for execution" for each task should be cleared by the device only when the last data block has been fully transferred over the eMMC bus."? From my side, I have a draft version which I didn't find the similar description.

The current logical in driver is after receiving the command complete interrupt of CMD46/47, driver will send another CMD13 to check the ready for execution task without waiting for any data transfer complete interrupt. If it is as you mentioned, the ready for execution bit won't be cleared until the data transfer complete interrupt is received, right?

So far with the Samsung eMMC which is the only one I have, I didn't see issue with this logical.

Thanks
Chuanxiao

> -----Original Message-----
> From: Alex Lemberg [mailto:Alex.Lemberg@sandisk.com]
> Sent: Wednesday, February 11, 2015 10:01 PM
> To: Dong, Chuanxiao
> Cc: linux-mmc@vger.kernel.org; Yuliy Izrailov
> Subject: RE: [RFC PATCH 0/5]mmc: Soft Command queue implementation for
> eMMC5.1 device
> 
> Hi Chuanxiao,
> 
> I have a question from the review of your SW CMDQ driver code.
> 
> From the eMMC5.1 spec, the  "ready for execution" for each task should be
> cleared by the device only when the last data block has been fully transferred
> over the eMMC bus.
> 
> However, from the code, I can recognize the following suspected case:
> 
> 1. Host sends CMD44/45 commands for TID#0 2. Host sends CMD13 (QSR)  ->
> returned TID#0 ready for execution 3. Host sends CMD46 for TID#0 4. During
> the data transfer, host may send CMD13 (QSR)  -> returned TID#0 ready for
> execution (which is true since data is still in transfer) 5. Host sends CMD46 for
> TID#0 (same as sent in bullet#3) - which is a problem.
> 
> Please advise if my assumption above is correct.
> 
> Thanks,
> Alex
> 
> 
> > -----Original Message-----
> > From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> > owner@vger.kernel.org] On Behalf Of Chuanxiao Dong
> > Sent: Friday, December 19, 2014 10:05 AM
> > To: linux-mmc@vger.kernel.org
> > Subject: [RFC PATCH 0/5]mmc: Soft Command queue implementation for
> > eMMC5.1 device
> >
> > Hello,
> >
> > Seems community already have some implementation for the eMMC5.1
> > device command queue feature, but that require the eMMC host
> > controller to support CMDQ. In my platform, I don't have this kind of
> > eMMC host controller but I have a Samsung eMMC5.1 device which can
> support the Command queue.
> >
> > With this limitation, I have to let eMMC host controller to manually
> > send the CMD44/45/13/46/47. So in this way, more commands are needed
> > for an I/O request, more interrupts/schedule are needed in driver.
> >
> > Even this way have some more software overhead, but it can still use
> > the
> > eMMC5.1 device Command queue feature. After test with the iozone
> > command:
> > "iozone -zec -t 4 -i0 -i2 -F iozonefile1 iozonefile2 iozonefile3
> > iozonefile4 -+n -I -r 4k -s 500m -O -R -+r -+D" to test random
> > performance, I saw a performance improvment for random read on my
> eMMC5.1 device:
> >
> > 		Random read
> > SW CMDQ:	5544.6
> > Normal Read:	3993.05
> >
> > So I want to send this serial patches as RFC patch for reviewing
> >
> >
> > Chuanxiao Dong (5):
> >   mmc: replace sbc to precmd and add postcmd
> >   mmc: host: add runtime PM for host class dev
> >   mmc: queue: change mqrq_cur and mqrq_pre to mq qdepth
> >   mmc: core: add support for CMDQ feature in MMC Core stack
> >   mmc: sdhci: add SW CMDQ support for CHT SDHCI host
> >
> >  drivers/mmc/card/block.c      |  538
> > ++++++++++++++++++++++++++++++++++++++---
> >  drivers/mmc/card/queue.c      |  213 ++++++++--------
> >  drivers/mmc/card/queue.h      |   14 +-
> >  drivers/mmc/core/core.c       |   78 +++++-
> >  drivers/mmc/core/host.c       |   14 ++
> >  drivers/mmc/core/mmc.c        |   43 +++-
> >  drivers/mmc/host/dw_mmc.c     |    8 +-
> >  drivers/mmc/host/mmci.c       |   14 +-
> >  drivers/mmc/host/omap_hsmmc.c |   18 +-
> >  drivers/mmc/host/sdhci-acpi.c |    1 -
> >  drivers/mmc/host/sdhci-pci.c  |    1 -
> >  drivers/mmc/host/sdhci.c      |  137 +++++++++--
> >  include/linux/mmc/card.h      |    3 +
> >  include/linux/mmc/core.h      |    5 +-
> >  include/linux/mmc/host.h      |    5 +
> >  include/linux/mmc/mmc.h       |   21 ++
> >  include/linux/mmc/pm.h        |    1 +
> >  include/linux/mmc/sdhci.h     |    1 +
> >  18 files changed, 909 insertions(+), 206 deletions(-)
> >
> > --
> > 1.7.10.4
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc"
> > in the body of a message to majordomo@vger.kernel.org More majordomo
> > info at http://vger.kernel.org/majordomo-info.html
