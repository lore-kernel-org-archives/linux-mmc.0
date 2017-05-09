From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v3 0/5] mmc: Improve/fix support for SDIO IRQs
Date: Tue,  9 May 2017 10:27:24 +0200
Message-ID: <1494318449-2591-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:33731 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752090AbdEII1h (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 May 2017 04:27:37 -0400
Received: by mail-wm0-f43.google.com with SMTP id n198so23288522wmg.0
        for <linux-mmc@vger.kernel.org>; Tue, 09 May 2017 01:27:36 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Brian Norris <briannorris@chromium.org>, Shawn Lin <shawn.lin@rock-chips.com>, Doug Anderson <dianders@google.com>

Changes in v3:
	- Added Tested/Reviewed-by tags from Dough. (Dough, I used your
	chromium.org email, please tell if you want me to change).
	- Updated change logs.
	- Some other minor changes, described in each patch history.

Changes in v2:
	- Folded in a new change, patch 1/5 to fix a race condition while
	processing SDIO IRQs.
	- Fixed review comments provided by Dough.
	- Updated change logs.
	- Small changes to how ->ack_sdio_irq() is being invoked, to simplify
	code.
	- Added a revert patch of the dw_mmc change for runtime PM issues, which
	was a quick fix for stable/fixes. 


Regressions for SDIO IRQs have been reported for dw_mmc, caused by enabling
runtime PM support for it. This series extends and improves the SDIO IRQs
support in the core, such that it also better suites the need for dw_mmc,
particulary around runtime PM.

To accomplish this a new method to process and signal SDIO IRQs are invented,
based on a work/workqueue, but built upon the existing support for
MMC_CAP2_SDIO_IRQ_NOTHREAD.

Next steps after this series is to convert the SDIO IRQ polling mechanism from
using the kthread to also use the work/workqueue method. Additonally we should
also try to migrate all host drivers supporting SDIO IRQ to use the new method
instead, which in the end would enable us to remove the old
mmc_signal_sdio_irq() API along with the ktread.


Ulf Hansson (5):
  mmc: core: Prevent processing SDIO IRQs when none is claimed
  mmc: sdio: Add API to manage SDIO IRQs from a workqueue
  mmc: dw_mmc: Convert to use MMC_CAP2_SDIO_IRQ_NOTHREAD for SDIO IRQs
  mmc: dw_mmc: Prevent runtime PM suspend when SDIO IRQs are enabled
  Revert "mmc: dw_mmc: Don't allow Runtime PM for SDIO cards"

 drivers/mmc/core/host.c     |  2 ++
 drivers/mmc/core/sdio_irq.c | 22 ++++++++++++++++++++--
 drivers/mmc/core/sdio_ops.h |  2 ++
 drivers/mmc/host/dw_mmc.c   | 42 +++++++++++++++++++++++++++++++-----------
 include/linux/mmc/host.h    |  3 +++
 5 files changed, 58 insertions(+), 13 deletions(-)

-- 
2.7.4

