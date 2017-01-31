From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 4/9] mmc: meson-gx: improve meson_mmc_irq_thread
Date: Tue, 31 Jan 2017 21:58:09 +0100
Message-ID: <f7316bf1-1a3c-fe98-c676-442957acb09e@gmail.com>
References: <24e8bf35-50ce-270d-c0aa-12bb90d2e3d8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33996 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750933AbdAaVH0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Jan 2017 16:07:26 -0500
Received: by mail-wm0-f66.google.com with SMTP id c85so947589wmi.1
        for <linux-mmc@vger.kernel.org>; Tue, 31 Jan 2017 13:07:20 -0800 (PST)
In-Reply-To: <24e8bf35-50ce-270d-c0aa-12bb90d2e3d8@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, linux-mmc@vger.kernel.org

Remove unneeded variable ret and simplify the if block.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 529a4f22..4ce4c640 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -670,7 +670,6 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
 	struct mmc_command *cmd = host->cmd;
 	struct mmc_data *data;
 	unsigned int xfer_bytes;
-	int ret = IRQ_HANDLED;
 
 	if (WARN_ON(!mrq))
 		return IRQ_NONE;
@@ -679,14 +678,12 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	data = cmd->data;
-	if (data) {
+	if (data && data->flags & MMC_DATA_READ) {
 		xfer_bytes = data->blksz * data->blocks;
-		if (data->flags & MMC_DATA_READ) {
-			WARN_ON(xfer_bytes > host->bounce_buf_size);
-			sg_copy_from_buffer(data->sg, data->sg_len,
-					    host->bounce_buf, xfer_bytes);
-			data->bytes_xfered = xfer_bytes;
-		}
+		WARN_ON(xfer_bytes > host->bounce_buf_size);
+		sg_copy_from_buffer(data->sg, data->sg_len,
+				    host->bounce_buf, xfer_bytes);
+		data->bytes_xfered = xfer_bytes;
 	}
 
 	meson_mmc_read_resp(host->mmc, cmd);
@@ -695,7 +692,7 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
 	else
 		meson_mmc_start_cmd(host->mmc, data->stop);
 
-	return ret;
+	return IRQ_HANDLED;
 }
 
 /*
-- 
2.11.0


