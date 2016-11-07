From: Jun Nie <jun.nie@linaro.org>
Subject: [PATCH v4 4/5] mmc: dw: Add fifo address property
Date: Mon,  7 Nov 2016 21:04:47 +0800
Message-ID: <1478523888-4524-5-git-send-email-jun.nie@linaro.org>
References: <1478523888-4524-1-git-send-email-jun.nie@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35467 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753160AbcKGNFX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Nov 2016 08:05:23 -0500
Received: by mail-pf0-f178.google.com with SMTP id i88so90775554pfk.2
        for <linux-mmc@vger.kernel.org>; Mon, 07 Nov 2016 05:05:22 -0800 (PST)
In-Reply-To: <1478523888-4524-1-git-send-email-jun.nie@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: shawn.guo@linaro.org, xie.baoyou@zte.com.cn
Cc: ulf.hansson@linaro.org, jh80.chung@samsung.com, jason.liu@linaro.org, linux-mmc@vger.kernel.org, Jun Nie <jun.nie@linaro.org>

The FIFO address may break default address assumption of 0x100
(version < 0x240A) and 0x200(version >= 0x240A) in current driver.
The new property is introduced to override fifo address via DT
node information.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/mmc/host/dw_mmc.c  | 6 +++++-
 include/linux/mmc/dw_mmc.h | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 1c9ee36..696b5e6 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2955,6 +2955,8 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 
 	of_property_read_u32(np, "card-detect-delay", &pdata->detect_delay_ms);
 
+	of_property_read_u32(np, "data-addr", &host->data_addr_override);
+
 	if (!of_property_read_u32(np, "clock-frequency", &clock_frequency))
 		pdata->bus_hz = clock_frequency;
 
@@ -3158,7 +3160,9 @@ int dw_mci_probe(struct dw_mci *host)
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
index f5af2bd..17cb95a 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -107,6 +107,7 @@ struct dw_mci_dma_slave {
  * @ciu_clk: Pointer to card interface unit clock instance.
  * @slot: Slots sharing this MMC controller.
  * @fifo_depth: depth of FIFO.
+ * @data_addr_override: override fifo reg offset with this value.
  * @data_shift: log2 of FIFO item size.
  * @part_buf_start: Start index in part_buf.
  * @part_buf_count: Bytes of partial data in part_buf.
@@ -154,6 +155,7 @@ struct dw_mci {
 	spinlock_t		irq_lock;
 	void __iomem		*regs;
 	void __iomem		*fifo_reg;
+	u32			data_addr_override;
 
 	struct scatterlist	*sg;
 	struct sg_mapping_iter	sg_miter;
-- 
1.9.1

