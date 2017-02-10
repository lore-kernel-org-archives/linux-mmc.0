From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 00/39] mmc: Add Command Queue support
Date: Fri, 10 Feb 2017 14:55:13 +0200
Message-ID: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:60562 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751027AbdBJNS1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 10 Feb 2017 08:18:27 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

Hi

Here are patches to enable hardware command queue (Command Queue Engine
or CQE) and software command queue.

Ritesh Harjani graciously agreed the use of their driver which has been
re-named CQHCI to match the JEDEC specification and has some more features
added.

The first 13 patches enable software command queue.  Earlier versions have
been submitted before.

The hardware command queue patches are now functionally complete, enabling
all block requests (read/write/discard/flush) as well as re-tuning and
recovery.

The patches can also be found here:

	http://git.infradead.org/users/ahunter/linux-sdhci.git/shortlog/refs/heads/cqe


Adrian Hunter (38):
      mmc: block: Use local var for mqrq_cur
      mmc: queue: Share mmc request array between partitions
      mmc: block: Introduce queue semantics
      mmc: core: Do not prepare a new request twice
      mmc: mmc: Add functions to enable / disable the Command Queue
      mmc: mmc_test: Disable Command Queue while mmc_test is used
      mmc: block: Disable Command Queue while RPMB is used
      mmc: core: Export mmc_retune_hold() and mmc_retune_release()
      mmc: queue: Add a function to control wake-up on new requests
      mmc: block: Change mmc_apply_rel_rw() to get block address from the request
      mmc: block: Factor out data preparation
      mmc: block: Add Software Command Queuing
      mmc: mmc: Enable Software Command Queuing
      mmc: core: Factor out debug prints from mmc_start_request()
      mmc: core: Factor out mrq preparation from mmc_start_request()
      mmc: core: Add mmc_retune_hold_now()
      mmc: core: Add members to mmc_request and mmc_data for CQE's
      mmc: host: Add CQE interface
      mmc: core: Turn off CQE before sending commands
      mmc: core: Add support for handling CQE requests
      mmc: mmc: Enable CQE's
      mmc: block: Prepare CQE data
      mmc: block: Add CQE support
      mmc: sdhci: Improve debug print format
      mmc: sdhci: Add response register to register dump
      mmc: sdhci: Improve register dump print format
      mmc: sdhci: Export sdhci_dumpregs
      mmc: sdhci: Get rid of 'extern' in header file
      mmc: sdhci: Add sdhci_cleanup_host
      mmc: sdhci: Factor out sdhci_set_default_irqs
      mmc: sdhci: Add CQE support
      mmc: sdhci-pci: Let devices define how to add the host
      mmc: sdhci-pci: Do not use suspend/resume callbacks with runtime pm
      mmc: sdhci-pci: Conditionally compile pm sleep functions
      mmc: sdhci-pci: Let suspend/resume callbacks replace default callbacks
      mmc: sdhci-pci: Add runtime suspend/resume callbacks
      mmc: sdhci-pci: Move a function to avoid later forward declaration
      mmc: sdhci-pci: Add CQHCI support for Intel GLK

Venkat Gopalakrishnan (1):
      mmc: cqhci: support for command queue enabled host

 Documentation/mmc/mmc-dev-attrs.txt  |    1 +
 drivers/mmc/core/block.c             | 1021 ++++++++++++++++++++++++++----
 drivers/mmc/core/block.h             |    7 +
 drivers/mmc/core/bus.c               |    7 +
 drivers/mmc/core/core.c              |  212 ++++++-
 drivers/mmc/core/host.c              |    8 +
 drivers/mmc/core/host.h              |    1 +
 drivers/mmc/core/mmc.c               |   41 +-
 drivers/mmc/core/mmc_ops.c           |   28 +
 drivers/mmc/core/mmc_ops.h           |    2 +
 drivers/mmc/core/mmc_test.c          |   22 +-
 drivers/mmc/core/queue.c             |  630 +++++++++++++++----
 drivers/mmc/core/queue.h             |   68 +-
 drivers/mmc/host/Kconfig             |   14 +
 drivers/mmc/host/Makefile            |    1 +
 drivers/mmc/host/cqhci.c             | 1148 ++++++++++++++++++++++++++++++++++
 drivers/mmc/host/cqhci.h             |  228 +++++++
 drivers/mmc/host/sdhci-pci-core.c    |  499 ++++++++++-----
 drivers/mmc/host/sdhci-pci-o2micro.c |    4 +-
 drivers/mmc/host/sdhci-pci.h         |   11 +
 drivers/mmc/host/sdhci.c             |  324 +++++++---
 drivers/mmc/host/sdhci.h             |   54 +-
 include/linux/mmc/card.h             |    8 +
 include/linux/mmc/core.h             |   20 +-
 include/linux/mmc/host.h             |   25 +
 include/trace/events/mmc.h           |   17 +-
 26 files changed, 3871 insertions(+), 530 deletions(-)
 create mode 100644 drivers/mmc/host/cqhci.c
 create mode 100644 drivers/mmc/host/cqhci.h


Regards
Adrian
