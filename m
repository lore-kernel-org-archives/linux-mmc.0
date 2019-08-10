From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/2] mmc: jz4740: Code cleanup
Date: Sat, 10 Aug 2019 14:16:07 +0200
Message-ID: <20190810121608.24145-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, od@zcrc.me, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-mmc@vger.kernel.org

Fix wrong code indentation which made the code hard to read, and fix
return with value in void function.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/mmc/host/jz4740_mmc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index ffdbfaadd3f2..59f81e8afcce 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -186,9 +186,9 @@ static void jz4740_mmc_write_irq_reg(struct jz4740_mmc_host *host,
 				     uint32_t val)
 {
 	if (host->version >= JZ_MMC_JZ4780)
-		return writel(val, host->base + JZ_REG_MMC_IREG);
+		writel(val, host->base + JZ_REG_MMC_IREG);
 	else
-		return writew(val, host->base + JZ_REG_MMC_IREG);
+		writew(val, host->base + JZ_REG_MMC_IREG);
 }
 
 static uint32_t jz4740_mmc_read_irq_reg(struct jz4740_mmc_host *host)
@@ -820,14 +820,14 @@ static irqreturn_t jz_mmc_irq(int irq, void *devid)
 			del_timer(&host->timeout_timer);
 
 			if (status & JZ_MMC_STATUS_TIMEOUT_RES) {
-					cmd->error = -ETIMEDOUT;
+				cmd->error = -ETIMEDOUT;
 			} else if (status & JZ_MMC_STATUS_CRC_RES_ERR) {
-					cmd->error = -EIO;
+				cmd->error = -EIO;
 			} else if (status & (JZ_MMC_STATUS_CRC_READ_ERROR |
 				    JZ_MMC_STATUS_CRC_WRITE_ERROR)) {
-					if (cmd->data)
-							cmd->data->error = -EIO;
-					cmd->error = -EIO;
+				if (cmd->data)
+					cmd->data->error = -EIO;
+				cmd->error = -EIO;
 			}
 
 			jz4740_mmc_set_irq_enabled(host, irq_reg, false);
-- 
2.21.0.593.g511ec345e18
