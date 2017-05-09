From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v3 1/5] mmc: core: Prevent processing SDIO IRQs when none is claimed
Date: Tue,  9 May 2017 10:27:25 +0200
Message-ID: <1494318449-2591-2-git-send-email-ulf.hansson@linaro.org>
References: <1494318449-2591-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f171.google.com ([209.85.128.171]:32771 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752024AbdEII1i (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 May 2017 04:27:38 -0400
Received: by mail-wr0-f171.google.com with SMTP id w50so63345298wrc.0
        for <linux-mmc@vger.kernel.org>; Tue, 09 May 2017 01:27:37 -0700 (PDT)
In-Reply-To: <1494318449-2591-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Brian Norris <briannorris@chromium.org>, Shawn Lin <shawn.lin@rock-chips.com>, Doug Anderson <dianders@google.com>

In cases when MMC_CAP2_SDIO_IRQ_NOTHREAD is set, there is a minor window
for when the mmc host could call sdio_run_irqs(), while in fact an SDIO
func driver could have decided to released the SDIO IRQ via a call to
sdio_release_irq(). In this scenario, processing of the SDIO IRQs are done
even if there is none IRQ claimed, which is not what we want.

To prevent this from happen, close the window by validating that at least
one SDIO IRQs is claimed, before deciding to process them.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 drivers/mmc/core/sdio_irq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index 6d4b720..44d9c86 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -95,8 +95,10 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
 void sdio_run_irqs(struct mmc_host *host)
 {
 	mmc_claim_host(host);
-	host->sdio_irq_pending = true;
-	process_sdio_pending_irqs(host);
+	if (host->sdio_irqs) {
+		host->sdio_irq_pending = true;
+		process_sdio_pending_irqs(host);
+	}
 	mmc_release_host(host);
 }
 EXPORT_SYMBOL_GPL(sdio_run_irqs);
-- 
2.7.4

