From: Richard Zhu <r65037@freescale.com>
Subject: [PATCH 5/9] sdhci-5:add the 32BIT_CMD_TRANS_COMBINATION quirk to
	support FSl eSDHC
Date: Wed, 1 Sep 2010 17:48:14 +0800
Message-ID: <1283334494-12678-1-git-send-email-r65037@freescale.com>
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

The FSL's eSDHC have one 32bit register that combine the two
16bit Transfer Mode and Command registers.
Add this quirk to let SW driver to support FSL's eSDHC.

Signed-off-by: Richard Zhu <r65037@freescale.com>
---
 drivers/mmc/host/sdhci.c |   25 +++++++++++++++++++++++--
 drivers/mmc/host/sdhci.h |    2 ++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e58939a..70b7f9d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -932,7 +932,22 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 
 	sdhci_writel(host, cmd->arg, SDHCI_ARGUMENT);
 
-	sdhci_set_transfer_mode(host, cmd->data);
+	if (host->quirks & SDHCI_QUIRK_32BIT_CMD_TRANS_COMBINATION) {
+		/* Set up the transfer mode */
+		if (cmd->data != NULL) {
+			mask = SDHCI_TRNS_BLK_CNT_EN;
+			if (cmd->data->blocks > 1)
+				mask |= SDHCI_TRNS_MULTI;
+			if (cmd->data->flags & MMC_DATA_READ)
+				mask |= SDHCI_TRNS_READ;
+			else
+				mask &= ~SDHCI_TRNS_READ;
+			if (host->flags & SDHCI_REQ_USE_DMA)
+				mask |= SDHCI_TRNS_DMA;
+		}
+
+	} else
+		sdhci_set_transfer_mode(host, cmd->data);
 
 	if ((cmd->flags & MMC_RSP_136) && (cmd->flags & MMC_RSP_BUSY)) {
 		printk(KERN_ERR "%s: Unsupported response type!\n",
@@ -958,7 +973,13 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	if (cmd->data)
 		flags |= SDHCI_CMD_DATA;
 
-	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
+	if (host->quirks & SDHCI_QUIRK_32BIT_CMD_TRANS_COMBINATION) {
+		mask |= SDHCI_MAKE_CMD(cmd->opcode, flags) << 16;
+
+		sdhci_writel(host, mask, SDHCI_TRANSFER_MODE);
+	} else
+		sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags),
+				SDHCI_COMMAND);
 }
 
 static void sdhci_finish_command(struct sdhci_host *host)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 37e9e3e..bb98378 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -247,6 +247,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12		(1<<28)
 /* Controller doesn't have the standard Host Control registor */
 #define SDHCI_QUIRK_NONSTANDARD_HOST_CTL 		(1<<29)
+/* Controller has the CMD and TRANS MODE combination */
+#define SDHCI_QUIRK_32BIT_CMD_TRANS_COMBINATION 	(1<<30)
 
 	int			irq;		/* Device IRQ */
 	void __iomem *		ioaddr;		/* Mapped address */
-- 
1.7.0
