From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 4/6] mmc: meson-gx: improve response reading
Date: Wed, 22 Mar 2017 22:33:50 +0100
Message-ID: <c0a6dab5-933a-1d37-cc90-bc39d9e58d6c@gmail.com>
References: <8bf58a83-d8d7-615c-c89b-87a62a3c9c40@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34906 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753671AbdCVVeR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Mar 2017 17:34:17 -0400
Received: by mail-wm0-f65.google.com with SMTP id z133so13143718wmb.2
        for <linux-mmc@vger.kernel.org>; Wed, 22 Mar 2017 14:34:16 -0700 (PDT)
In-Reply-To: <8bf58a83-d8d7-615c-c89b-87a62a3c9c40@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Response reading can be slightly improved by doing it in just one place.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 8bf3eb54..c4ddd820 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -562,6 +562,8 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 		goto out;
 	}
 
+	meson_mmc_read_resp(host->mmc, cmd);
+
 	cmd->error = 0;
 	if (status & IRQ_RXD_ERR_MASK) {
 		dev_dbg(host->dev, "Unhandled IRQ: RXD error\n");
@@ -608,10 +610,8 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	/* ack all (enabled) interrupts */
 	writel(status, host->regs + SD_EMMC_STATUS);
 
-	if (ret == IRQ_HANDLED) {
-		meson_mmc_read_resp(host->mmc, cmd);
+	if (ret == IRQ_HANDLED)
 		meson_mmc_request_done(host->mmc, cmd->mrq);
-	}
 
 	spin_unlock(&host->lock);
 	return ret;
@@ -636,7 +636,6 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
 		data->bytes_xfered = xfer_bytes;
 	}
 
-	meson_mmc_read_resp(host->mmc, cmd);
 	if (!data || !data->stop || cmd->mrq->sbc)
 		meson_mmc_request_done(host->mmc, cmd->mrq);
 	else
-- 
2.12.0


