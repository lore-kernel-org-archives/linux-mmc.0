From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/3] mmc: Improve/fix support for SDIO IRQs
Date: Tue, 18 Apr 2017 14:32:01 +0200
Message-ID: <1492518724-30511-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:34855 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753110AbdDRMcI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Apr 2017 08:32:08 -0400
Received: by mail-wm0-f45.google.com with SMTP id w64so55109622wma.0
        for <linux-mmc@vger.kernel.org>; Tue, 18 Apr 2017 05:32:08 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Brian Norris <briannorris@chromium.org>, Shawn Lin <shawn.lin@rock-chips.com>, Doug Anderson <dianders@google.com>

Regressions for SDIO IRQs have been reported for dw_mmc, caused by enabling
runtime PM support for it.

This series extends and improves the SDIO IRQs support in the core, such that
it better suites the need for dw_mmc, particulary around runtime PM.

Do note, so far this is only compile tested. I would thus appreciate help in
testing and of course also in reviewing.

I am not sure this is material for stable, so perhaps we anyway should pick up
Dough's earlier quick fix for dw_mmc. Thoughts?


Ulf Hansson (3):
  mmc: sdio: Add API to manage SDIO IRQs from a workqueue
  mmc: dw_mmc: Convert to use MMC_CAP2_SDIO_IRQ_NOTHREAD for SDIO IRQs
  mmc: dw_mmc: Prevent runtime PM suspend when SDIO IRQs are enabled

 drivers/mmc/core/host.c     |  2 ++
 drivers/mmc/core/sdio_irq.c | 32 ++++++++++++++++++++++++++++++--
 drivers/mmc/core/sdio_ops.h |  2 ++
 drivers/mmc/host/dw_mmc.c   | 37 ++++++++++++++++++++++++++++++++++---
 include/linux/mmc/host.h    |  3 +++
 5 files changed, 71 insertions(+), 5 deletions(-)

-- 
2.7.4

