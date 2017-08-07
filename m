From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V4 00/11] mmc: Add Command Queue support
Date: Mon, 7 Aug 2017 15:41:36 +0200
Message-ID: <CAPDyKFpSq+nNCud=XmnQN_s5Hjfh1LVrA=5enwOw1PrN=n8-yw@mail.gmail.com>
References: <1500630584-22852-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:38884 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751408AbdHGNli (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Aug 2017 09:41:38 -0400
Received: by mail-qk0-f181.google.com with SMTP id x191so2542901qka.5
        for <linux-mmc@vger.kernel.org>; Mon, 07 Aug 2017 06:41:38 -0700 (PDT)
In-Reply-To: <1500630584-22852-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

On 21 July 2017 at 11:49, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Hi
>
> Here is V4 of the hardware command queue patches without the software
> command queue patches.

Adrian, again apologize for the delay.

I am reviewing the series now and my intent is to provide comments on
each change separately during the week.

However, a couple of overall thoughts:

*) Could you please post some fresh performance measurements, such we
can get some real proof on why CMDQ is worth to be merged? If not
increased throughput, perhaps we can show some decreased I/O requests
latency!?

**) I have spoken to Linus W offlist - and he is still working on the
blkmq port. Although we first need to continue with the
re-factorization of the mmc block/core code, to minimize the bad
impact of our big mmc claim host lock. We should expect a
re-submission of his series quite soonish. However, it's also likely
that we need yet another round of re-factoring, before we can complete
the port to blkmq.

***) The reason for bringing up **), is of course because I think
deploying CMDQ support would be better done on top of the blkmq
interface as it's better suited for these kind of device types. My
goal is to reach a better maintenance situation, using more modern mmc
block code. We have spoken about this before, however of course I also
don't want to delay the CMDQ series. Anyway, let's move forward and
see what path we end up taking.

>
>
> Changes since V3:
>         Adjusted ...blk_end_request...() for new block status codes
>         Fixed CQHCI transaction descriptor for "no DCMD" case
>
> Changes since V2:
>         Dropped patches that have been applied.
>         Re-based
>         Added "mmc: sdhci-pci: Add CQHCI support for Intel GLK"
>
> Changes since V1:
>
>         "Share mmc request array between partitions" is dependent
>         on changes in "Introduce queue semantics", so added that
>         and block fixes:
>
>         Added "Fix is_waiting_last_req set incorrectly"
>         Added "Fix cmd error reset failure path"
>         Added "Use local var for mqrq_cur"
>         Added "Introduce queue semantics"
>
> Changes since RFC:
>
>         Re-based on next.
>         Added comment about command queue priority.
>         Added some acks and reviews.
>
>
> Adrian Hunter (10):
>       mmc: core: Add mmc_retune_hold_now()
>       mmc: core: Add members to mmc_request and mmc_data for CQE's
>       mmc: host: Add CQE interface
>       mmc: core: Turn off CQE before sending commands
>       mmc: core: Add support for handling CQE requests
>       mmc: mmc: Enable Command Queuing
>       mmc: mmc: Enable CQE's
>       mmc: block: Prepare CQE data
>       mmc: block: Add CQE support
>       mmc: sdhci-pci: Add CQHCI support for Intel GLK
>
> Venkat Gopalakrishnan (1):
>       mmc: cqhci: support for command queue enabled host
>
>  drivers/mmc/core/block.c          |  240 +++++++-
>  drivers/mmc/core/block.h          |    7 +
>  drivers/mmc/core/bus.c            |    7 +
>  drivers/mmc/core/core.c           |  156 ++++-
>  drivers/mmc/core/host.c           |    6 +
>  drivers/mmc/core/host.h           |    1 +
>  drivers/mmc/core/mmc.c            |   30 +-
>  drivers/mmc/core/queue.c          |  273 ++++++++-
>  drivers/mmc/core/queue.h          |   42 +-
>  drivers/mmc/host/Kconfig          |   14 +
>  drivers/mmc/host/Makefile         |    1 +
>  drivers/mmc/host/cqhci.c          | 1146 +++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/cqhci.h          |  240 ++++++++
>  drivers/mmc/host/sdhci-pci-core.c |  153 ++++-
>  include/linux/mmc/core.h          |   18 +-
>  include/linux/mmc/host.h          |   24 +
>  include/trace/events/mmc.h        |   36 +-
>  17 files changed, 2354 insertions(+), 40 deletions(-)
>  create mode 100644 drivers/mmc/host/cqhci.c
>  create mode 100644 drivers/mmc/host/cqhci.h
>
>
> Regards
> Adrian

Kind regards
Uffe
