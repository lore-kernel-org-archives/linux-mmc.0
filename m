From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 2/5] mmc: meson-gx: improve response reading
Date: Wed, 15 Mar 2017 20:33:57 +0100
Message-ID: <af4174c5-7d7e-340a-2d94-6b3ecd137941@gmail.com>
References: <f1f8dae2-e976-4d42-99dc-34d08cb3d628@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33208 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750774AbdCOTe7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Mar 2017 15:34:59 -0400
Received: by mail-wr0-f194.google.com with SMTP id g10so3276723wrg.0
        for <linux-mmc@vger.kernel.org>; Wed, 15 Mar 2017 12:34:58 -0700 (PDT)
In-Reply-To: <f1f8dae2-e976-4d42-99dc-34d08cb3d628@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Response is read in the main irq handler and in the threaded irq handler
as well. We can slightly improve this by reading the response
unconditionally at the beginning of the main irq handler only.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index f2d4486a..e675601e 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -573,6 +573,8 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 		goto out;
 	}
 
+	meson_mmc_read_resp(host->mmc, cmd);
+
 	cmd->error = 0;
 	if (status & IRQ_RXD_ERR_MASK) {
 		dev_dbg(host->dev, "Unhandled IRQ: RXD error\n");
@@ -619,10 +621,8 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	/* ack all (enabled) interrupts */
 	writel(status, host->regs + SD_EMMC_STATUS);
 
-	if (ret == IRQ_HANDLED) {
-		meson_mmc_read_resp(host->mmc, cmd);
+	if (ret == IRQ_HANDLED)
 		meson_mmc_request_done(host->mmc, cmd->mrq);
-	}
 
 	spin_unlock(&host->lock);
 	return ret;
@@ -647,7 +647,6 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
 		data->bytes_xfered = xfer_bytes;
 	}
 
-	meson_mmc_read_resp(host->mmc, cmd);
 	if (!data || !data->stop || cmd->mrq->sbc)
 		meson_mmc_request_done(host->mmc, cmd->mrq);
 	else
-- 
2.12.0


