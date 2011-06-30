From: "Poddar, Sourav" <sourav.poddar@ti.com>
Subject: Re: [PATCH v8 00/12] use nonblock mmc requests to minimize latency
Date: Thu, 30 Jun 2011 18:06:39 +0530
Message-ID: <BANLkTinSt3D+5r9bOL5rTjw5BiuiSDvGvA@mail.gmail.com>
References: <1309248717-14606-1-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:44509 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751031Ab1F3Mgl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 30 Jun 2011 08:36:41 -0400
In-Reply-To: <1309248717-14606-1-git-send-email-per.forlin@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: linaro-dev@lists.linaro.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Nickolay Nickolaev <nicknickolaev@gmail.com>, Venkatraman S <svenkatr@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Chris Ball <cjb@laptop.org>

On Tue, Jun 28, 2011 at 1:41 PM, Per Forlin <per.forlin@linaro.org> wro=
te:
> How significant is the cache maintenance over head?
> It depends, the eMMC are much faster now
> compared to a few years ago and cache maintenance cost more due to
> multiple cache levels and speculative cache pre-fetch. In relation th=
e
> cost for handling the caches have increased and is now a bottle neck
> dealing with fast eMMC together with DMA.
>
> The intention for introducing non-blocking mmc requests is to minimiz=
e the
> time between a mmc request ends and another mmc request starts. In th=
e
> current implementation the MMC controller is idle when dma_map_sg and
> dma_unmap_sg is processing. Introducing non-blocking mmc request make=
s it
> possible to prepare the caches for next job in parallel to an active
> mmc request.
>
> This is done by making the issue_rw_rq() non-blocking.
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
> Changes since v7:
> =A0* rebase on mmc-next, on top of Russell's updated error handling.
> =A0* Clarify description of mmc_start_req()
> =A0* Resolve compile without CONFIG_DMA_ENIGNE issue for mmci
> =A0* Add mmc test to measure how performance is affected by sg length
> =A0* Add missing wait_for_busy in mmc_test non-blocking test. This ca=
ll got lost
> =A0 in v4 of this patchset when refactoring mmc_start_req.
> =A0* Add sub-prefix (core block queue) to relevant patches.
>
> Per Forlin (12):
> =A0mmc: core: add non-blocking mmc request function
> =A0omap_hsmmc: add support for pre_req and post_req
> =A0mmci: implement pre_req() and post_req()
> =A0mmc: mmc_test: add debugfs file to list all tests
> =A0mmc: mmc_test: add test for non-blocking transfers
> =A0mmc: mmc_test: test to measure how sg_len affect performance
> =A0mmc: block: add member in mmc queue struct to hold request data
> =A0mmc: block: add a block request prepare function
> =A0mmc: block: move error code in issue_rw_rq to a separate function.
> =A0mmc: queue: add a second mmc queue request member
> =A0mmc: core: add random fault injection
> =A0mmc: block: add handling for two parallel block requests in
> =A0 =A0issue_rw_rq
>
> =A0drivers/mmc/card/block.c =A0 =A0 =A0| =A0505 +++++++++++++++++++++=
+++-----------------
> =A0drivers/mmc/card/mmc_test.c =A0 | =A0491 +++++++++++++++++++++++++=
+++++++++++++--
> =A0drivers/mmc/card/queue.c =A0 =A0 =A0| =A0184 ++++++++++------
> =A0drivers/mmc/card/queue.h =A0 =A0 =A0| =A0 33 ++-
> =A0drivers/mmc/core/core.c =A0 =A0 =A0 | =A0167 +++++++++++++-
> =A0drivers/mmc/core/debugfs.c =A0 =A0| =A0 =A05 +
> =A0drivers/mmc/host/mmci.c =A0 =A0 =A0 | =A0147 +++++++++++-
> =A0drivers/mmc/host/mmci.h =A0 =A0 =A0 | =A0 =A08 +
> =A0drivers/mmc/host/omap_hsmmc.c | =A0 87 +++++++-
> =A0include/linux/mmc/core.h =A0 =A0 =A0| =A0 =A06 +-
> =A0include/linux/mmc/host.h =A0 =A0 =A0| =A0 24 ++
> =A0lib/Kconfig.debug =A0 =A0 =A0 =A0 =A0 =A0 | =A0 11 +
> =A012 files changed, 1345 insertions(+), 323 deletions(-)



Boot tested on Omap4430 Blaze board.

Tested-by: Sourav Poddar<sourav.poddar@ti.com>
