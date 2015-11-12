From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] mmc: dw_mmc: use resource_size_t to store physical address
Date: Thu, 12 Nov 2015 15:14:23 +0100
Message-ID: <28102387.ALpaBHpim0@wuerfel>
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
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

The dw_mmc driver stores the physical address of the MMIO registers
in a pointer, which requires the use of type casts, and is actually
broken if anyone ever has this device on a 32-bit SoC in registers
above 4GB. Gcc warns about this possibility when the driver is built
with ARM LPAE enabled:

mmc/host/dw_mmc.c: In function 'dw_mci_edmac_start_dma':
mmc/host/dw_mmc.c:702:17: warning: cast from pointer to integer of different size
  cfg.dst_addr = (dma_addr_t)(host->phy_regs + fifo_offset);
                 ^
mmc/host/dw_mmc-pltfm.c: In function 'dw_mci_pltfm_register':
mmc/host/dw_mmc-pltfm.c:63:19: warning: cast to pointer from integer of different size
  host->phy_regs = (void *)(regs->start);

This changes the code to use resource_size_t, which gets rid of the
warning, the bug and the useless casts.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
>From the arm64 allmodconfig build reports

diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index 7e1d13b68b06..81bdeeb05a4d 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -60,7 +60,7 @@ int dw_mci_pltfm_register(struct platform_device *pdev,
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	/* Get registers' physical base address */
-	host->phy_regs = (void *)(regs->start);
+	host->phy_regs = regs->start;
 	host->regs = devm_ioremap_resource(&pdev->dev, regs);
 	if (IS_ERR(host->regs))
 		return PTR_ERR(host->regs);
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 7a6cedbe48a8..fb204ee6ff89 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -699,7 +699,7 @@ static int dw_mci_edmac_start_dma(struct dw_mci *host,
 	int ret = 0;
 
 	/* Set external dma config: burst size, burst width */
-	cfg.dst_addr = (dma_addr_t)(host->phy_regs + fifo_offset);
+	cfg.dst_addr = host->phy_regs + fifo_offset;
 	cfg.src_addr = cfg.dst_addr;
 	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index f67b2ec18e6d..7776afb0ffa5 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -172,7 +172,7 @@ struct dw_mci {
 	/* For edmac */
 	struct dw_mci_dma_slave *dms;
 	/* Registers's physical base address */
-	void                    *phy_regs;
+	resource_size_t		phy_regs;
 
 	u32			cmd_status;
 	u32			data_status;
