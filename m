From: Richard Zhu <r65037@freescale.com>
Subject: [PATCH 4/9] sdhci-4:add make_blksz api to support FSl eSDHC
Date: Wed, 1 Sep 2010 17:47:59 +0800
Message-ID: <1283334479-12643-1-git-send-email-r65037@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mmc@vger.kernel.org
Cc: Richard Zhu <r65037@freescale.com>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: linux-mmc@vger.kernel.org

Add make_blksz api to support FSL eSDHC, because that FSL's eSDHC
don't have the standard BLOCK ATTR register, add this api to
configure the blksz properly.

Signed-off-by: Richard Zhu <r65037@freescale.com>
---
 drivers/mmc/host/sdhci.c |    9 ++++++++-
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 2bfe738..e58939a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -650,6 +650,7 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_data *data)
 {
 	u8 count;
 	u8 ctrl;
+	u16 blk_sz;
 	int ret;
 
 	WARN_ON(host->data);
@@ -809,7 +810,13 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_data *data)
 	sdhci_set_transfer_irqs(host);
 
 	/* We do not handle DMA boundaries, so set it to max (512 KiB) */
-	sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, data->blksz), SDHCI_BLOCK_SIZE);
+	if (host->ops->make_blksz)
+		blk_sz = host->ops->make_blksz(data->blksz);
+	else
+		blk_sz = SDHCI_MAKE_BLKSZ(7, data->blksz);
+
+	sdhci_writew(host, blk_sz, SDHCI_BLOCK_SIZE);
+
 	sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
 }
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 029ab0e..37e9e3e 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -326,6 +326,7 @@ struct sdhci_ops {
 	unsigned int	(*get_min_clock)(struct sdhci_host *host);
 	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
 	unsigned int	(*get_ro)(struct sdhci_host *host);
+	u16 		(*make_blksz)(u16 blk_sz);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.7.0
