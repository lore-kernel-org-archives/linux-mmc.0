From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 0/5] mmc: Improve/fix support for SDIO IRQs
Date: Wed, 19 Apr 2017 23:17:06 +0200
Message-ID: <1492636631-28254-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f172.google.com ([209.85.128.172]:35695 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966850AbdDSVRU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Apr 2017 17:17:20 -0400
Received: by mail-wr0-f172.google.com with SMTP id o21so23624067wrb.2
        for <linux-mmc@vger.kernel.org>; Wed, 19 Apr 2017 14:17:20 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Brian Norris <briannorris@chromium.org>, Shawn Lin <shawn.lin@rock-chips.com>, Doug Anderson <dianders@google.com>

Changes in v2:
	- Folded in a new change, patch 1/5 to fix a race condition while
	processing SDIO IRQs.
	- Fixed review comments provided by Dough.
	- Updated change logs.
	- Small changes to how ->ack_sdio_irq() is being invoked, to simplify
	code.
	- Added a revert patch of the dw_mmc change for runtime PM issues, which
	was a quick fix for stable/fixes. 

Some general description of the series:

Regressions for SDIO IRQs have been reported for dw_mmc, caused by enabling
runtime PM support for it.

This series extends and improves the SDIO IRQs support in the core, such that
it better suites the need for dw_mmc, particulary around runtime PM.

Do note, so far this is only compile tested. I would thus appreciate help in
testing and of course also in reviewing.


Ulf Hansson (5):
  mmc: core: Prevent processing SDIO IRQs when none is claimed
  mmc: sdio: Add API to manage SDIO IRQs from a workqueue
  mmc: dw_mmc: Convert to use MMC_CAP2_SDIO_IRQ_NOTHREAD for SDIO IRQs
  mmc: dw_mmc: Prevent runtime PM suspend when SDIO IRQs are enabled
  Revert "mmc: dw_mmc: Don't allow Runtime PM for SDIO cards"

 drivers/mmc/core/host.c     |  2 ++
 drivers/mmc/core/sdio_irq.c | 27 +++++++++++++++++++++++++--
 drivers/mmc/core/sdio_ops.h |  2 ++
 drivers/mmc/host/dw_mmc.c   | 44 ++++++++++++++++++++++++++++++++------------
 include/linux/mmc/host.h    |  3 +++
 5 files changed, 64 insertions(+), 14 deletions(-)

-- 
2.7.4

