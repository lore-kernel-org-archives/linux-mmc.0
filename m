From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V4 00/11] mmc: Add Command Queue support
Date: Fri, 21 Jul 2017 12:49:33 +0300
Message-ID: <1500630584-22852-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:18623 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753547AbdGUJ4F (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 21 Jul 2017 05:56:05 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

Hi

Here is V4 of the hardware command queue patches without the software
command queue patches.


Changes since V3:
	Adjusted ...blk_end_request...() for new block status codes
	Fixed CQHCI transaction descriptor for "no DCMD" case

Changes since V2:
	Dropped patches that have been applied.
	Re-based
	Added "mmc: sdhci-pci: Add CQHCI support for Intel GLK"

Changes since V1:

	"Share mmc request array between partitions" is dependent
	on changes in "Introduce queue semantics", so added that
	and block fixes:

	Added "Fix is_waiting_last_req set incorrectly"
	Added "Fix cmd error reset failure path"
	Added "Use local var for mqrq_cur"
	Added "Introduce queue semantics"

Changes since RFC:

	Re-based on next.
	Added comment about command queue priority.
	Added some acks and reviews.


Adrian Hunter (10):
      mmc: core: Add mmc_retune_hold_now()
      mmc: core: Add members to mmc_request and mmc_data for CQE's
      mmc: host: Add CQE interface
      mmc: core: Turn off CQE before sending commands
      mmc: core: Add support for handling CQE requests
      mmc: mmc: Enable Command Queuing
      mmc: mmc: Enable CQE's
      mmc: block: Prepare CQE data
      mmc: block: Add CQE support
      mmc: sdhci-pci: Add CQHCI support for Intel GLK

Venkat Gopalakrishnan (1):
      mmc: cqhci: support for command queue enabled host

 drivers/mmc/core/block.c          |  240 +++++++-
 drivers/mmc/core/block.h          |    7 +
 drivers/mmc/core/bus.c            |    7 +
 drivers/mmc/core/core.c           |  156 ++++-
 drivers/mmc/core/host.c           |    6 +
 drivers/mmc/core/host.h           |    1 +
 drivers/mmc/core/mmc.c            |   30 +-
 drivers/mmc/core/queue.c          |  273 ++++++++-
 drivers/mmc/core/queue.h          |   42 +-
 drivers/mmc/host/Kconfig          |   14 +
 drivers/mmc/host/Makefile         |    1 +
 drivers/mmc/host/cqhci.c          | 1146 +++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/cqhci.h          |  240 ++++++++
 drivers/mmc/host/sdhci-pci-core.c |  153 ++++-
 include/linux/mmc/core.h          |   18 +-
 include/linux/mmc/host.h          |   24 +
 include/trace/events/mmc.h        |   36 +-
 17 files changed, 2354 insertions(+), 40 deletions(-)
 create mode 100644 drivers/mmc/host/cqhci.c
 create mode 100644 drivers/mmc/host/cqhci.h


Regards
Adrian
