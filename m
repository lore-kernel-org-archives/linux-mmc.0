From: javier Martin <javier.martin@vista-silicon.com>
Subject: Re: [PATCH v2] mmc: mxcmmc: fix bug that may block a data transfer forever.
Date: Fri, 14 Sep 2012 14:50:11 +0200
Message-ID: <CACKLOr0FSG=v8+Fz=USqWhXSC9t9JoqFczi1r51k_uixYBK-Ew@mail.gmail.com>
References: <1347014617-16238-1-git-send-email-javier.martin@vista-silicon.com>
	<1347591157.1943.5.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:52442 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756422Ab2INMuP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Sep 2012 08:50:15 -0400
Received: by weyx8 with SMTP id x8so2369083wey.19
        for <linux-mmc@vger.kernel.org>; Fri, 14 Sep 2012 05:50:11 -0700 (PDT)
In-Reply-To: <1347591157.1943.5.camel@vkoul-udesk3>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: linux-mmc@vger.kernel.org, viresh.linux@gmail.com, g.liakhovetski@gmx.de, s.hauer@pengutronix.de, cjb@laptop.org, fabio.estevam@freescale.com, gcembed@gmail.com

Hi Vinod,

On 14 September 2012 04:52, Vinod Koul <vinod.koul@linux.intel.com> wrote:
> On Fri, 2012-09-07 at 12:43 +0200, Javier Martin wrote:
>>
>> The problem can be easily reproduced using a script that loops
>> copying a file in an SD card to another place in the same SD card
>> and its related to read transfers. This only happens with DMA enabled.
>>
>> This is related to the fact that, when reading, an MMC irq signals
>> the fact that all data from the SD card has been copied to the
>> internal buffers. However, it doesn't signal whether the DMA transfer
>> that is in charge of moving data from these internal buffers to RAM
>> has finished or not. Thus, calling dmaengine_terminate_all() in the
>> MMC irq routine can cancel an ongoing DMA transfer leaving some data
>> in the internal buffers that produces an accumulative effect which,
>> in the end, blocks a read data transfer forever.
>>
>> The following patch watches DMA irq for reading and MMC irqs for
>> writing transfers. The 'dangerous' usage of dmaengine_terminate_all()
>> is removed and a timeout of 10 seconds is added so that the MMC won't
>> block forever anymore.
> For a normal transactions why should you call dmaengine_terminate_all().

Agree. In fact, this patch fixes that.

> This should be called when you doing abort or cleanup in some erranous
> situation.

After this patch, dmaengine_terminate_all() will only be called if a
DMA transfer lasts more than 10 seconds, which is an explicit
error/abort that can happen sometimes (ie. when an SD card is worn
out).

> why was it called in first place?

I don't know, because I didn't write the original support but it's not
relevant because this patch removes the incorrect use of
dmaengine_terminate_all().

Since you took the time to review the patch, could you please give me
your ack too in case you find everything seems fine?

Regards.
-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
