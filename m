From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH v3 00/12] mmc: use nonblock mmc requests to minimize latency
Date: Mon, 9 May 2011 14:34:58 +0200
Message-ID: <BANLkTikid1yHh6AdgOeqy7NqS8D=W0SWTw@mail.gmail.com>
References: <1304795706-27308-1-git-send-email-per.forlin@linaro.org>
	<0F831E97-0168-4CD5-985C-4965BFF816A0@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59386 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352Ab1EIMfA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 May 2011 08:35:00 -0400
In-Reply-To: <0F831E97-0168-4CD5-985C-4965BFF816A0@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>, Chris Ball <cjb@laptop.org>

On 9 May 2011 04:05, Philip Rakity <prakity@marvell.com> wrote:
>
> Hi Per,
>
> We noticed on some of our systems if we ADMA or SDMA and a bounce buf=
fer it is significantly faster then SDMA.
>
I have not done work with ADMA or SDMA. Where should I look to read
more about it?
Are these the right places. DMA iop-dma.c and imx-sdma.c, MMC: sdhci.c.

> I believe ADMA will do large transfers. =A0Another data point.
>
> Philip
Thanks,
Per

>
> On May 7, 2011, at 12:14 PM, Per Forlin wrote:
>
>> How significant is the cache maintenance over head?
>> It depends, the eMMC are much faster now
>> compared to a few years ago and cache maintenance cost more due to
>> multiple cache levels and speculative cache pre-fetch. In relation t=
he
>> cost for handling the caches have increased and is now a bottle neck
>> dealing with fast eMMC together with DMA.
>>
>> The intention for introducing none blocking mmc requests is to minim=
ize the
>> time between a mmc request ends and another mmc request starts. In t=
he
>> current implementation the MMC controller is idle when dma_map_sg an=
d
>> dma_unmap_sg is processing. Introducing none blocking mmc request ma=
kes it
>> possible to prepare the caches for next job parallel with an active
>> mmc request.
>>
>> This is done by making the issue_rw_rq() none blocking.
>> The increase in throughput is proportional to the time it takes to
>> prepare (major part of preparations is dma_map_sg and dma_unmap_sg)
>> a request and how fast the memory is. The faster the MMC/SD is
>> the more significant the prepare request time becomes. Measurements =
on U5500
>> and Panda on eMMC and SD shows significant performance gain for for =
large
>> reads when running DMA mode. In the PIO case the performance is unch=
anged.
>>
>> There are two optional hooks pre_req() and post_req() that the host =
driver
>> may implement in order to move work to before and after the actual m=
mc_request
>> function is called. In the DMA case pre_req() may do dma_map_sg() an=
d prepare
>> the dma descriptor and post_req runs the dma_unmap_sg.
>>
>> Details on measurements from IOZone and mmc_test:
>> https://wiki.linaro.org/WorkingGroups/Kernel/Specs/StoragePerfMMC-as=
ync-req
>>
>> Under consideration:
>> * Make pre_req and post_req private to core.c.
>> * Generalize implementation and make it available for SDIO.
>>
>> Changes since v2:
>> * Fix compile warnings in core.c and block.c
>> * Simplify max transfer size in mmc_test
>> * set TASK_RUNNING in queue.c before issue_req()
>>
>> Per Forlin (12):
>> =A0mmc: add none blocking mmc request function
>> =A0mmc: mmc_test: add debugfs file to list all tests
>> =A0mmc: mmc_test: add test for none blocking transfers
>> =A0mmc: add member in mmc queue struct to hold request data
>> =A0mmc: add a block request prepare function
>> =A0mmc: move error code in mmc_block_issue_rw_rq to a separate funct=
ion.
>> =A0mmc: add a second mmc queue request member
>> =A0mmc: add handling for two parallel block requests in issue_rw_rq
>> =A0mmc: test: add random fault injection in core.c
>> =A0omap_hsmmc: use original sg_len for dma_unmap_sg
>> =A0omap_hsmmc: add support for pre_req and post_req
>> =A0mmci: implement pre_req() and post_req()
>>
>> drivers/mmc/card/block.c =A0 =A0 =A0| =A0493 +++++++++++++++++++++++=
++++--------------
>> drivers/mmc/card/mmc_test.c =A0 | =A0340 +++++++++++++++++++++++++++=
-
>> drivers/mmc/card/queue.c =A0 =A0 =A0| =A0180 ++++++++++------
>> drivers/mmc/card/queue.h =A0 =A0 =A0| =A0 31 ++-
>> drivers/mmc/core/core.c =A0 =A0 =A0 | =A0132 ++++++++++-
>> drivers/mmc/core/debugfs.c =A0 =A0| =A0 =A05 +
>> drivers/mmc/host/mmci.c =A0 =A0 =A0 | =A0146 +++++++++++-
>> drivers/mmc/host/mmci.h =A0 =A0 =A0 | =A0 =A08 +
>> drivers/mmc/host/omap_hsmmc.c | =A0 90 +++++++-
>> include/linux/mmc/core.h =A0 =A0 =A0| =A0 =A09 +-
>> include/linux/mmc/host.h =A0 =A0 =A0| =A0 13 +-
>> lib/Kconfig.debug =A0 =A0 =A0 =A0 =A0 =A0 | =A0 11 +
>> 12 files changed, 1174 insertions(+), 284 deletions(-)
>>
>> --
>> 1.7.4.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
