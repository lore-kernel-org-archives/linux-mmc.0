From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V1 00/18] mmc: Add Command Queue support
Date: Mon,  6 Mar 2017 11:10:55 +0200
Message-ID: <1488791473-24981-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:15177 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753299AbdCFJRQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 6 Mar 2017 04:17:16 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

Hi

Here are the hardware command queue patches without the software command
queue patches or sdhci patches.


Changes since RFC:

	Re-based on next.
	Added comment about command queue priority.
	Added some acks and reviews.


Adrian Hunter (17):
      mmc: queue: Share mmc request array between partitions
      mmc: mmc: Add functions to enable / disable the Command Queue
      mmc: mmc_test: Disable Command Queue while mmc_test is used
      mmc: block: Disable Command Queue while RPMB is used
      mmc: block: Change mmc_apply_rel_rw() to get block address from the request
      mmc: block: Factor out data preparation
      mmc: core: Factor out debug prints from mmc_start_request()
      mmc: core: Factor out mrq preparation from mmc_start_request()
      mmc: core: Add mmc_retune_hold_now()
      mmc: core: Add members to mmc_request and mmc_data for CQE's
      mmc: host: Add CQE interface
      mmc: core: Turn off CQE before sending commands
      mmc: core: Add support for handling CQE requests
      mmc: mmc: Enable Command Queuing
      mmc: mmc: Enable CQE's
      mmc: block: Prepare CQE data
      mmc: block: Add CQE support

Venkat Gopalakrishnan (1):
      mmc: cqhci: support for command queue enabled host

 Documentation/mmc/mmc-dev-attrs.txt |    1 +
 drivers/mmc/core/block.c            |  435 ++++++++++---
 drivers/mmc/core/block.h            |    7 +
 drivers/mmc/core/bus.c              |    7 +
 drivers/mmc/core/core.c             |  203 ++++++-
 drivers/mmc/core/host.c             |    6 +
 drivers/mmc/core/host.h             |    1 +
 drivers/mmc/core/mmc.c              |   39 +-
 drivers/mmc/core/mmc_ops.c          |   28 +
 drivers/mmc/core/mmc_ops.h          |    2 +
 drivers/mmc/core/mmc_test.c         |   14 +
 drivers/mmc/core/queue.c            |  535 +++++++++++++---
 drivers/mmc/core/queue.h            |   45 +-
 drivers/mmc/host/Kconfig            |   13 +
 drivers/mmc/host/Makefile           |    1 +
 drivers/mmc/host/cqhci.c            | 1148 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/cqhci.h            |  240 ++++++++
 include/linux/mmc/card.h            |    8 +
 include/linux/mmc/core.h            |   19 +-
 include/linux/mmc/host.h            |   24 +
 include/trace/events/mmc.h          |   17 +-
 21 files changed, 2585 insertions(+), 208 deletions(-)
 create mode 100644 drivers/mmc/host/cqhci.c
 create mode 100644 drivers/mmc/host/cqhci.h


Regards
Adrian
