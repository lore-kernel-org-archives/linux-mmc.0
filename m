From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 4/5] mmc: dw_mmc: Prevent runtime PM suspend when SDIO IRQs are enabled
Date: Wed, 19 Apr 2017 23:17:10 +0200
Message-ID: <1492636631-28254-5-git-send-email-ulf.hansson@linaro.org>
References: <1492636631-28254-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38239 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967454AbdDSVRZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Apr 2017 17:17:25 -0400
Received: by mail-wm0-f46.google.com with SMTP id r190so32697172wme.1
        for <linux-mmc@vger.kernel.org>; Wed, 19 Apr 2017 14:17:24 -0700 (PDT)
In-Reply-To: <1492636631-28254-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Brian Norris <briannorris@chromium.org>, Shawn Lin <shawn.lin@rock-chips.com>, Doug Anderson <dianders@google.com>

To be able to handle SDIO IRQs the dw_mmc device needs to be powered and
providing clock to the SDIO card. Therefore, we must not allow the device
to be runtime PM suspended while SDIO IRQs are enabled.

To fix this, let's increase the runtime PM usage count while the mmc core
enables SDIO IRQs. Later when the mmc core tells dw_mmc to disable SDIO
IRQs, we drop the usage count to again allow runtime PM suspend.

This now becomes the default behaviour for dw_mmc. In cases where SDIO IRQs
can be re-routed as GPIO wake-ups during runtime PM suspend, one could
potentially allow runtime PM suspend. However, that will have to be
addressed as a separate change on top of this one.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/dw_mmc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 635d76c..c14a36b 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -39,6 +39,7 @@
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/mmc/slot-gpio.h>
+#include <linux/pm_runtime.h>
 
 #include "dw_mmc.h"
 
@@ -1664,8 +1665,15 @@ static void __dw_mci_enable_sdio_irq(struct dw_mci_slot *slot, int enb)
 static void dw_mci_enable_sdio_irq(struct mmc_host *mmc, int enb)
 {
 	struct dw_mci_slot *slot = mmc_priv(mmc);
+	struct dw_mci *host = slot->host;
 
 	__dw_mci_enable_sdio_irq(slot, enb);
+
+	/* Avoid runtime suspending the device when SDIO IRQ is enabled */
+	if (enb)
+		pm_runtime_get_noresume(host->dev);
+	else
+		pm_runtime_put_noidle(host->dev);
 }
 
 static void dw_mci_ack_sdio_irq(struct mmc_host *mmc)
-- 
2.7.4

