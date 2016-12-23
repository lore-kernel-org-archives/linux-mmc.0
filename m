From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] MMC: meson: avoid possible NULL dereference
Date: Fri, 23 Dec 2016 16:01:08 +0100
Message-ID: <20161223150108.9229-1-xypron.glpk@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, Heinrich Schuchardt <xypron.glpk@gmx.de>
List-Id: linux-mmc@vger.kernel.org

No actual segmentation faults were observed but the coding is
at least inconsistent.

irqreturn_t meson_mmc_irq():

We should not dereference host before checking it.

meson_mmc_irq_thread():

If cmd or mrq are NULL we should not dereference them after
writing a warning.

Fixes: 51c5d8447bd7 MMC: meson: initial support for GX platforms
Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 drivers/mmc/host/meson-gx-mmc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index b352760c041e..09739352834c 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -578,13 +578,15 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 {
 	struct meson_host *host = dev_id;
 	struct mmc_request *mrq;
-	struct mmc_command *cmd = host->cmd;
+	struct mmc_command *cmd;
 	u32 irq_en, status, raw_status;
 	irqreturn_t ret = IRQ_HANDLED;
 
 	if (WARN_ON(!host))
 		return IRQ_NONE;
 
+	cmd = host->cmd;
+
 	mrq = host->mrq;
 
 	if (WARN_ON(!mrq))
@@ -670,10 +672,10 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
 	int ret = IRQ_HANDLED;
 
 	if (WARN_ON(!mrq))
-		ret = IRQ_NONE;
+		return IRQ_NONE;
 
 	if (WARN_ON(!cmd))
-		ret = IRQ_NONE;
+		return IRQ_NONE;
 
 	data = cmd->data;
 	if (data) {
-- 
2.11.0
