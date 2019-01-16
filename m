From: Mathieu Malaterre <malat@debian.org>
Subject: [PATCH] mmc: Annotate implicit fall through in jz_mmc_irq_worker
Date: Wed, 16 Jan 2019 20:52:19 +0100
Message-ID: <20190116195219.2897-1-malat@debian.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mathieu Malaterre <malat@debian.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
these places in the code produced warnings (W=1).

This commit removes the following warnings:

  drivers/mmc/host/jz4740_mmc.c:745:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
  drivers/mmc/host/jz4740_mmc.c:779:3: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/mmc/host/jz4740_mmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 33215d66afa2..a1df8bc0b964 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -743,6 +743,7 @@ static irqreturn_t jz_mmc_irq_worker(int irq, void *devid)
 			break;
 
 		jz_mmc_prepare_data_transfer(host);
+		/* fall through */
 
 	case JZ4740_MMC_STATE_TRANSFER_DATA:
 		if (host->use_dma) {
@@ -777,6 +778,7 @@ static irqreturn_t jz_mmc_irq_worker(int irq, void *devid)
 			break;
 		}
 		jz4740_mmc_write_irq_reg(host, JZ_MMC_IRQ_DATA_TRAN_DONE);
+		/* fall through */
 
 	case JZ4740_MMC_STATE_SEND_STOP:
 		if (!req->stop)
-- 
2.19.2
