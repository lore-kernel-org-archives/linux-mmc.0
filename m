From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] MMC: meson: don't use priv host structure before we verify it
Date: Mon, 22 Aug 2016 16:52:25 +0800
Message-ID: <1471855945-16264-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:39986 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754491AbcHVI4v (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Aug 2016 04:56:51 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@baylibre.com>, linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

The code of meson_mmc_irq is going to use mmeson_host
before the santity check of WARN_ON. I believe this's not
the code's intention, fix it.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/meson-gxbb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/meson-gxbb.c b/drivers/mmc/host/meson-gxbb.c
index 10eac41..bb60535 100644
--- a/drivers/mmc/host/meson-gxbb.c
+++ b/drivers/mmc/host/meson-gxbb.c
@@ -626,7 +626,7 @@ static int meson_mmc_read_resp(struct mmc_host *mmc, struct mmc_command *cmd)
 static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 {
 	struct meson_host *host = dev_id;
-	struct mmc_request *mrq = host->mrq;
+	struct mmc_request *mrq;
 	struct mmc_command *cmd = host->cmd;
 	u32 irq_en, status, raw_status;
 	irqreturn_t ret = IRQ_HANDLED;
@@ -634,6 +634,8 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	if (WARN_ON(!host))
 		return IRQ_NONE;
 
+	mrq = host->mrq;
+
 	if (WARN_ON(!mrq))
 		return IRQ_NONE;
 
-- 
2.3.7


