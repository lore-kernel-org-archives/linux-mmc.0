From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v3 9/10] mmc: meson-gx: remove member mrq from struct
 meson_host
Date: Sat, 18 Feb 2017 14:23:29 +0100
Message-ID: <d54707b2-194a-ea91-f0a5-42c1d1928e8d@gmail.com>
References: <583f6496-68a9-b8e1-6b25-1f073f819a3c@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36777 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753035AbdBRN1O (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 18 Feb 2017 08:27:14 -0500
Received: by mail-wm0-f66.google.com with SMTP id r18so6864337wmd.3
        for <linux-mmc@vger.kernel.org>; Sat, 18 Feb 2017 05:26:44 -0800 (PST)
In-Reply-To: <583f6496-68a9-b8e1-6b25-1f073f819a3c@gmail.com>
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
v3:
- rebased
---
 drivers/mmc/host/meson-gx-mmc.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index e904b0a5..5281014e 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -122,7 +122,6 @@
 struct meson_host {
 	struct	device		*dev;
 	struct	mmc_host	*mmc;
-	struct	mmc_request	*mrq;
 	struct	mmc_command	*cmd;
 
 	spinlock_t lock;
@@ -416,9 +415,6 @@ static void meson_mmc_request_done(struct mmc_host *mmc,
 {
 	struct meson_host *host = mmc_priv(mmc);
 
-	WARN_ON(host->mrq != mrq);
-
-	host->mrq = NULL;
 	host->cmd = NULL;
 	mmc_request_done(host->mmc, mrq);
 }
@@ -525,13 +521,9 @@ static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
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
@@ -555,7 +547,6 @@ static void meson_mmc_read_resp(struct mmc_host *mmc, struct mmc_command *cmd)
 static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 {
 	struct meson_host *host = dev_id;
-	struct mmc_request *mrq;
 	struct mmc_command *cmd;
 	u32 irq_en, status, raw_status;
 	irqreturn_t ret = IRQ_HANDLED;
@@ -565,11 +556,6 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 
 	cmd = host->cmd;
 
-	mrq = host->mrq;
-
-	if (WARN_ON(!mrq))
-		return IRQ_NONE;
-
 	if (WARN_ON(!cmd))
 		return IRQ_NONE;
 
@@ -616,7 +602,7 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	else  {
 		dev_warn(host->dev, "Unknown IRQ! status=0x%04x: MMC CMD%u arg=0x%08x flags=0x%08x stop=%d\n",
 			 status, cmd->opcode, cmd->arg,
-			 cmd->flags, mrq->stop ? 1 : 0);
+			 cmd->flags, cmd->mrq->stop ? 1 : 0);
 		if (cmd->data) {
 			struct mmc_data *data = cmd->data;
 
@@ -643,14 +629,10 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
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
 
@@ -664,8 +646,8 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
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


