From: Jun Nie <jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v9 2/5] mmc: dw: Add fifo address property
Date: Fri,  6 Jan 2017 12:24:43 +0800
Message-ID: <1483676686-17011-3-git-send-email-jun.nie@linaro.org>
References: <1483676686-17011-1-git-send-email-jun.nie@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1483676686-17011-1-git-send-email-jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, xie.baoyou-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, jason.liu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, chen.chaokai-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org, lai.binz-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jun Nie <jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

The FIFO address may break default address assumption of 0x100
(version < 0x240A) and 0x200(version >= 0x240A) in current driver.
The new property is introduced to override fifo address via DT
node information.

Signed-off-by: Jun Nie <jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Reviewed-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---
 drivers/mmc/host/dw_mmc.c  | 6 +++++-
 include/linux/mmc/dw_mmc.h | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index b44306b..b600170 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2977,6 +2977,8 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 
 	of_property_read_u32(np, "card-detect-delay", &pdata->detect_delay_ms);
 
+	of_property_read_u32(np, "data-addr", &host->data_addr_override);
+
 	if (!of_property_read_u32(np, "clock-frequency", &clock_frequency))
 		pdata->bus_hz = clock_frequency;
 
@@ -3180,7 +3182,9 @@ int dw_mci_probe(struct dw_mci *host)
 	host->verid = SDMMC_GET_VERID(mci_readl(host, VERID));
 	dev_info(host->dev, "Version ID is %04x\n", host->verid);
 
-	if (host->verid < DW_MMC_240A)
+	if (host->data_addr_override)
+		host->fifo_reg = host->regs + host->data_addr_override;
+	else if (host->verid < DW_MMC_240A)
 		host->fifo_reg = host->regs + DATA_OFFSET;
 	else
 		host->fifo_reg = host->regs + DATA_240A_OFFSET;
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index 15db6f8..1c09cca 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -113,6 +113,7 @@ struct dw_mci_dma_slave {
  * @ciu_clk: Pointer to card interface unit clock instance.
  * @slot: Slots sharing this MMC controller.
  * @fifo_depth: depth of FIFO.
+ * @data_addr_override: override fifo reg offset with this value.
  * @data_shift: log2 of FIFO item size.
  * @part_buf_start: Start index in part_buf.
  * @part_buf_count: Bytes of partial data in part_buf.
@@ -160,6 +161,7 @@ struct dw_mci {
 	spinlock_t		irq_lock;
 	void __iomem		*regs;
 	void __iomem		*fifo_reg;
+	u32			data_addr_override;
 
 	struct scatterlist	*sg;
 	struct sg_mapping_iter	sg_miter;
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
