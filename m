From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V5 00/13] mmc: Add Command Queue support
Date: Tue, 22 Aug 2017 13:22:09 +0200
Message-ID: <CAPDyKFqxS1HmOiMxZ6cktkyQwNXRTtuB0hgqOam8G-UnnOxQwQ@mail.gmail.com>
References: <1502366898-23691-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35520 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932350AbdHVLWN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Aug 2017 07:22:13 -0400
Received: by mail-qk0-f174.google.com with SMTP id 130so60852722qkg.2
        for <linux-mmc@vger.kernel.org>; Tue, 22 Aug 2017 04:22:12 -0700 (PDT)
In-Reply-To: <1502366898-23691-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

On 10 August 2017 at 14:08, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Hi
>
> Here is V5 of the hardware command queue patches without the software
> command queue patches.

I have queued up a subset of this series for next, for those changes I
have replied separately.

However to also simplify for people to test and to get some build
reports from 0-build, I have published a cmdq branch in my mmc tree.
The branch is not intended to stay that long-term, it is just as an
intermediate step to help to find any further issues.

Kind regards
Uffe

>
> HW CMDQ offers 25% - 50% better random multi-threaded I/O.  I see a slight
> 2% drop in sequential read speed but no change to sequential write.
>
>
> Changes since V4:
>       mmc: core: Add mmc_retune_hold_now()
>         Add explanation to commit message.
>       mmc: host: Add CQE interface
>         Add comments to callback declarations.
>       mmc: core: Turn off CQE before sending commands
>         Add explanation to commit message.
>       mmc: core: Add support for handling CQE requests
>         Add comments as requested by Ulf.
>       mmc: core: Remove unused MMC_CAP2_PACKED_CMD
>         New patch.
>       mmc: mmc: Enable Command Queuing
>         Adjust for removal of MMC_CAP2_PACKED_CMD.
>         Add a comment about Packed Commands.
>       mmc: mmc: Enable CQE's
>         Remove un-necessary check for MMC_CAP2_CQE
>       mmc: block: Use local variables in mmc_blk_data_prep()
>         New patch.
>       mmc: block: Prepare CQE data
>         Adjust due to "mmc: block: Use local variables in mmc_blk_data_prep()"
>         Remove priority setting.
>         Add explanation to commit message.
>       mmc: cqhci: support for command queue enabled host
>         Fix transfer descriptor setting in cqhci_set_tran_desc() for 32-bit DMA
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
> Adrian Hunter (12):
>       mmc: core: Add mmc_retune_hold_now()
>       mmc: core: Add members to mmc_request and mmc_data for CQE's
>       mmc: host: Add CQE interface
>       mmc: core: Turn off CQE before sending commands
>       mmc: core: Add support for handling CQE requests
>       mmc: core: Remove unused MMC_CAP2_PACKED_CMD
>       mmc: mmc: Enable Command Queuing
>       mmc: mmc: Enable CQE's
>       mmc: block: Use local variables in mmc_blk_data_prep()
>       mmc: block: Prepare CQE data
>       mmc: block: Add CQE support
>       mmc: sdhci-pci: Add CQHCI support for Intel GLK
>
> Venkat Gopalakrishnan (1):
>       mmc: cqhci: support for command queue enabled host
>
>  drivers/mmc/core/block.c          |  238 +++++++-
>  drivers/mmc/core/block.h          |    7 +
>  drivers/mmc/core/bus.c            |    7 +
>  drivers/mmc/core/core.c           |  178 +++++-
>  drivers/mmc/core/host.c           |    6 +
>  drivers/mmc/core/host.h           |    1 +
>  drivers/mmc/core/mmc.c            |   42 +-
>  drivers/mmc/core/queue.c          |  273 ++++++++-
>  drivers/mmc/core/queue.h          |   42 +-
>  drivers/mmc/host/Kconfig          |   14 +
>  drivers/mmc/host/Makefile         |    1 +
>  drivers/mmc/host/cqhci.c          | 1154 +++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/cqhci.h          |  240 ++++++++
>  drivers/mmc/host/sdhci-pci-core.c |  153 ++++-
>  include/linux/mmc/core.h          |   18 +-
>  include/linux/mmc/host.h          |   63 +-
>  include/trace/events/mmc.h        |   36 +-
>  17 files changed, 2412 insertions(+), 61 deletions(-)
>  create mode 100644 drivers/mmc/host/cqhci.c
>  create mode 100644 drivers/mmc/host/cqhci.h
>
>
> Regards
> Adrian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
