From: Kyungmin Park <kmpark-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH v8 00/12] use nonblock mmc requests to minimize latency
Date: Tue, 28 Jun 2011 18:54:50 +0900
Message-ID: <BANLkTinzOj-Uw3o__2=kHYqHwMW1BtAktQ@mail.gmail.com>
References: <1309248717-14606-1-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1309248717-14606-1-git-send-email-per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Per Forlin <per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

This patches are tested on samsung exynos4 platform.

Acked-by: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

On Tue, Jun 28, 2011 at 5:11 PM, Per Forlin <per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> How significant is the cache maintenance over head?
> It depends, the eMMC are much faster now
> compared to a few years ago and cache maintenance cost more due to
> multiple cache levels and speculative cache pre-fetch. In relation the
> cost for handling the caches have increased and is now a bottle neck
> dealing with fast eMMC together with DMA.
>
> The intention for introducing non-blocking mmc requests is to minimize the
> time between a mmc request ends and another mmc request starts. In the
> current implementation the MMC controller is idle when dma_map_sg and
> dma_unmap_sg is processing. Introducing non-blocking mmc request makes it
> possible to prepare the caches for next job in parallel to an active
> mmc request.
>
> This is done by making the issue_rw_rq() non-blocking.
> The increase in throughput is proportional to the time it takes to
> prepare (major part of preparations is dma_map_sg and dma_unmap_sg)
> a request and how fast the memory is. The faster the MMC/SD is
> the more significant the prepare request time becomes. Measurements on U5=
500
> and Panda on eMMC and SD shows significant performance gain for large
> reads when running DMA mode. In the PIO case the performance is unchanged.
>
> There are two optional hooks pre_req() and post_req() that the host driver
> may implement in order to move work to before and after the actual mmc_re=
quest
> function is called. In the DMA case pre_req() may do dma_map_sg() and pre=
pare
> the dma descriptor and post_req runs the dma_unmap_sg.
>
> Details on measurements from IOZone and mmc_test:
> https://wiki.linaro.org/WorkingGroups/Kernel/Specs/StoragePerfMMC-async-r=
eq
>
> Changes since v7:
> =A0* rebase on mmc-next, on top of Russell's updated error handling.
> =A0* Clarify description of mmc_start_req()
> =A0* Resolve compile without CONFIG_DMA_ENIGNE issue for mmci
> =A0* Add mmc test to measure how performance is affected by sg length
> =A0* Add missing wait_for_busy in mmc_test non-blocking test. This call g=
ot lost
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
> =A0drivers/mmc/card/block.c =A0 =A0 =A0| =A0505 ++++++++++++++++++++++++-=
----------------
> =A0drivers/mmc/card/mmc_test.c =A0 | =A0491 +++++++++++++++++++++++++++++=
+++++++++--
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
>
> --
> 1.7.4.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
