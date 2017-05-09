From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v3 4/5] mmc: dw_mmc: Prevent runtime PM suspend when SDIO IRQs are enabled
Date: Tue,  9 May 2017 10:27:28 +0200
Message-ID: <1494318449-2591-5-git-send-email-ulf.hansson@linaro.org>
References: <1494318449-2591-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f178.google.com ([209.85.128.178]:32804 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752024AbdEII1m (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 May 2017 04:27:42 -0400
Received: by mail-wr0-f178.google.com with SMTP id w50so63346618wrc.0
        for <linux-mmc@vger.kernel.org>; Tue, 09 May 2017 01:27:41 -0700 (PDT)
In-Reply-To: <1494318449-2591-1-git-send-email-ulf.hansson@linaro.org>
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
Tested-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
	- Don't add include of pm_runtime.h as it's already there.

---
 drivers/mmc/host/dw_mmc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 635d76c..454b847 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1664,8 +1664,15 @@ static void __dw_mci_enable_sdio_irq(struct dw_mci_slot *slot, int enb)
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

