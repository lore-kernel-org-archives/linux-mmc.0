From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 9/9] mmc: meson-gx: remove member mrq from struct
 meson_host
Date: Thu, 16 Feb 2017 20:42:47 +0100
Message-ID: <c0ab75e0-4b95-2021-30ed-0a071c3f65bd@gmail.com>
References: <7d5263e2-9325-dedb-a5f6-954c4a09e977@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35660 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933233AbdBPTnO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Feb 2017 14:43:14 -0500
Received: by mail-wm0-f65.google.com with SMTP id u63so4670828wmu.2
        for <linux-mmc@vger.kernel.org>; Thu, 16 Feb 2017 11:43:13 -0800 (PST)
In-Reply-To: <7d5263e2-9325-dedb-a5f6-954c4a09e977@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Struct mmc_command includes a reference to the related mmc_request.
Therefore we don't have to store mrq separately in struct meson_host.
And we can remove some now unneeded WARN_ON's.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Acked-by: Kevin Hilman <khilman@baylibre.com>
---
v2:
- extended commit message
- added acked-by
---
 drivers/mmc/host/meson-gx-mmc.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index e7c3ac1c..3c35cf1f 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -122,7 +122,6 @@
 struct meson_host {
 	struct	device		*dev;
 	struct	mmc_host	*mmc;
-	struct	mmc_request	*mrq;
 	struct	mmc_command	*cmd;
 
 	spinlock_t lock;
@@ -412,9 +411,6 @@ static void meson_mmc_request_done(struct mmc_host *mmc,
 {
 	struct meson_host *host = mmc_priv(mmc);
 
-	WARN_ON(host->mrq != mrq);
-
-	host->mrq = NULL;
 	host->cmd = NULL;
 	mmc_request_done(host->mmc, mrq);
 }
@@ -521,13 +517,9 @@ static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct meson_host *host = mmc_priv(mmc);
 
-	WARN_ON(host->mrq != NULL);
-
 	/* Stop execution */
 	writel(0, host->regs + SD_EMMC_START);
 
-	host->mrq = mrq;
-
 	if (mrq->sbc)
 		meson_mmc_start_cmd(mmc, mrq->sbc);
 	else
@@ -551,7 +543,6 @@ static void meson_mmc_read_resp(struct mmc_host *mmc, struct mmc_command *cmd)
 static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 {
 	struct meson_host *host = dev_id;
-	struct mmc_request *mrq;
 	struct mmc_command *cmd;
 	u32 irq_en, status, raw_status;
 	irqreturn_t ret = IRQ_HANDLED;
@@ -561,11 +552,6 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 
 	cmd = host->cmd;
 
-	mrq = host->mrq;
-
-	if (WARN_ON(!mrq))
-		return IRQ_NONE;
-
 	if (WARN_ON(!cmd))
 		return IRQ_NONE;
 
@@ -612,7 +598,7 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	else  {
 		dev_warn(host->dev, "Unknown IRQ! status=0x%04x: MMC CMD%u arg=0x%08x flags=0x%08x stop=%d\n",
 			 status, cmd->opcode, cmd->arg,
-			 cmd->flags, mrq->stop ? 1 : 0);
+			 cmd->flags, cmd->mrq->stop ? 1 : 0);
 		if (cmd->data) {
 			struct mmc_data *data = cmd->data;
 
@@ -639,14 +625,10 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
 {
 	struct meson_host *host = dev_id;
-	struct mmc_request *mrq = host->mrq;
 	struct mmc_command *cmd = host->cmd;
 	struct mmc_data *data;
 	unsigned int xfer_bytes;
 
-	if (WARN_ON(!mrq))
-		return IRQ_NONE;
-
 	if (WARN_ON(!cmd))
 		return IRQ_NONE;
 
@@ -660,8 +642,8 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
 	}
 
 	meson_mmc_read_resp(host->mmc, cmd);
-	if (!data || !data->stop || mrq->sbc)
-		meson_mmc_request_done(host->mmc, mrq);
+	if (!data || !data->stop || cmd->mrq->sbc)
+		meson_mmc_request_done(host->mmc, cmd->mrq);
 	else
 		meson_mmc_start_cmd(host->mmc, data->stop);
 
-- 
2.11.1


