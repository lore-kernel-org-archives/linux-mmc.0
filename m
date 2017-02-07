From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v3 4/9] mmc: meson-gx: improve meson_mmc_irq_thread
Date: Tue, 7 Feb 2017 22:34:41 +0100
Message-ID: <21f34e8d-471d-375b-cb9d-6b551d6b03fe@gmail.com>
References: <0991d40b-e05b-2fcb-9ee4-7b529448de69@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36823 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932313AbdBGVoE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Feb 2017 16:44:04 -0500
Received: by mail-wm0-f65.google.com with SMTP id r18so30810907wmd.3
        for <linux-mmc@vger.kernel.org>; Tue, 07 Feb 2017 13:44:04 -0800 (PST)
In-Reply-To: <0991d40b-e05b-2fcb-9ee4-7b529448de69@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Remove unneeded variable ret and simplify the if block.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Acked-by: Kevin Hilman <khilman@baylibre.com>
---
v3:
- no changes
---
 drivers/mmc/host/meson-gx-mmc.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index d6a4dfae..dd7f936c 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -666,7 +666,6 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
 	struct mmc_command *cmd = host->cmd;
 	struct mmc_data *data;
 	unsigned int xfer_bytes;
-	int ret = IRQ_HANDLED;
 
 	if (WARN_ON(!mrq))
 		return IRQ_NONE;
@@ -675,14 +674,12 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
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
@@ -691,7 +688,7 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
 	else
 		meson_mmc_start_cmd(host->mmc, data->stop);
 
-	return ret;
+	return IRQ_HANDLED;
 }
 
 /*
-- 
2.11.0


