From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mmc: mxcmmc: fix bug that may block a data transfer forever.
Date: Wed, 19 Sep 2012 01:52:34 -0400
Message-ID: <m3wqzqimot.fsf@pullcord.laptop.org>
References: <1347014617-16238-1-git-send-email-javier.martin@vista-silicon.com>
	<20120910074753.GX18243@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57370 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753981Ab2ISFwQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 19 Sep 2012 01:52:16 -0400
In-Reply-To: <20120910074753.GX18243@pengutronix.de> (Sascha Hauer's message
	of "Mon, 10 Sep 2012 09:47:54 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Javier Martin <javier.martin@vista-silicon.com>, linux-mmc@vger.kernel.org, viresh.linux@gmail.com, g.liakhovetski@gmx.de, vinod.koul@linux.intel.com, fabio.estevam@freescale.com, gcembed@gmail.com

Hi,

On Mon, Sep 10 2012, Sascha Hauer wrote:
> On Fri, Sep 07, 2012 at 12:43:37PM +0200, Javier Martin wrote:
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
>> 
>> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
>> ---
>> Changes since v1:
>>  - Use DMA callbacks for reading and MMC irqs for writing instead
>>  of monitoring both irqs for each transfer.
>>  - Increase timeout to 10 seconds to give enough time to slow cards.
>> 
>
> Looks good now, thanks.
>
> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Thanks, queued in mmc-next for 3.7.  Vinod, would be good to add your
Reviewed-by if you're happy with this patch now.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
