From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH v4 00/12] mmc: use nonblock mmc requests to minimize latency
Date: Thu, 16 Jun 2011 19:09:25 +0530
Message-ID: <BANLkTi=v7nOaDmdUr2FscNtou-5vRhhmyw@mail.gmail.com>
References: <1306360653-6196-1-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:43371 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751502Ab1FPNj1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 16 Jun 2011 09:39:27 -0400
In-Reply-To: <1306360653-6196-1-git-send-email-per.forlin@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, linaro-dev <linaro-dev@lists.linaro.org>, David Vrabel <david.vrabel@csr.com>, Chris Ball <cjb@laptop.org>

On Thu, May 26, 2011 at 3:27 AM, Per Forlin <per.forlin@linaro.org> wro=
te:
> How significant is the cache maintenance over head?
> It depends, the eMMC are much faster now
> compared to a few years ago and cache maintenance cost more due to
> multiple cache levels and speculative cache pre-fetch. In relation th=
e
> cost for handling the caches have increased and is now a bottle neck
> dealing with fast eMMC together with DMA.
>
> The intention for introducing none blocking mmc requests is to minimi=
ze the
> time between a mmc request ends and another mmc request starts. In th=
e
> current implementation the MMC controller is idle when dma_map_sg and
> dma_unmap_sg is processing. Introducing none blocking mmc request mak=
es it
> possible to prepare the caches for next job parallel with an active
> mmc request.
>
> This is done by making the issue_rw_rq() none blocking.
> The increase in throughput is proportional to the time it takes to
> prepare (major part of preparations is dma_map_sg and dma_unmap_sg)
> a request and how fast the memory is. The faster the MMC/SD is
> the more significant the prepare request time becomes. Measurements o=
n U5500
> and Panda on eMMC and SD shows significant performance gain for large
> reads when running DMA mode. In the PIO case the performance is uncha=
nged.
>
> There are two optional hooks pre_req() and post_req() that the host d=
river
> may implement in order to move work to before and after the actual mm=
c_request
> function is called. In the DMA case pre_req() may do dma_map_sg() and=
 prepare
> the dma descriptor and post_req runs the dma_unmap_sg.
>
> Details on measurements from IOZone and mmc_test:
> https://wiki.linaro.org/WorkingGroups/Kernel/Specs/StoragePerfMMC-asy=
nc-req
>
> Changes since v3:
> =A0* Based on 2.6.39-rc7
> =A0* Add error check for testlist in mmc_test.c
> =A0* Resolve in mmc-queue-thread that caused the mmc-thread to miss a=
 wakeup.
> =A0* Move parallel request handling to core.c. This simplifies the in=
terface
> =A0 from 4 public functions to 1. This also gives access for SDIO to =
use the
> =A0 same functionallity, even though the function is not tuned for th=
e SDIO
> =A0 execution flow yet.
>
> Per Forlin (12):
> =A0mmc: add none blocking mmc request function
> =A0omap_hsmmc: use original sg_len for dma_unmap_sg
> =A0omap_hsmmc: add support for pre_req and post_req
> =A0mmci: implement pre_req() and post_req()
> =A0mmc: mmc_test: add debugfs file to list all tests
> =A0mmc: mmc_test: add test for none blocking transfers
> =A0mmc: add member in mmc queue struct to hold request data
> =A0mmc: add a block request prepare function
> =A0mmc: move error code in mmc_block_issue_rw_rq to a separate functi=
on.
> =A0mmc: add a second mmc queue request member
> =A0mmc: test: add random fault injection in core.c
> =A0mmc: add handling for two parallel block requests in issue_rw_rq
>
> =A0drivers/mmc/card/block.c =A0 =A0 =A0| =A0452 +++++++++++++++++++++=
++++----------------
> =A0drivers/mmc/card/mmc_test.c =A0 | =A0361 +++++++++++++++++++++++++=
+++++++-
> =A0drivers/mmc/card/queue.c =A0 =A0 =A0| =A0184 +++++++++++------
> =A0drivers/mmc/card/queue.h =A0 =A0 =A0| =A0 32 +++-
> =A0drivers/mmc/core/core.c =A0 =A0 =A0 | =A0165 ++++++++++++++-
> =A0drivers/mmc/core/debugfs.c =A0 =A0| =A0 =A05 +
> =A0drivers/mmc/host/mmci.c =A0 =A0 =A0 | =A0146 ++++++++++++--
> =A0drivers/mmc/host/mmci.h =A0 =A0 =A0 | =A0 =A08 +
> =A0drivers/mmc/host/omap_hsmmc.c | =A0 90 ++++++++-
> =A0include/linux/mmc/core.h =A0 =A0 =A0| =A0 =A06 +-
> =A0include/linux/mmc/host.h =A0 =A0 =A0| =A0 19 ++
> =A0lib/Kconfig.debug =A0 =A0 =A0 =A0 =A0 =A0 | =A0 11 +
> =A012 files changed, 1187 insertions(+), 292 deletions(-)
>

Nitpick.. The mmc_test.c changes should be at the end of the series,
after the async feature is available.

Regards,
Venkat.
