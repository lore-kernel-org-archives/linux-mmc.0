From: Jun Nie <jun.nie@linaro.org>
Subject: [PATCH v6 5/5] mmc: dw: Add fifo watermark alignment property
Date: Fri, 18 Nov 2016 14:29:15 +0800
Message-ID: <1479450555-19047-6-git-send-email-jun.nie@linaro.org>
References: <1479450555-19047-1-git-send-email-jun.nie@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35589 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751613AbcKRG3l (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2016 01:29:41 -0500
Received: by mail-pf0-f177.google.com with SMTP id i88so53056404pfk.2
        for <linux-mmc@vger.kernel.org>; Thu, 17 Nov 2016 22:29:40 -0800 (PST)
In-Reply-To: <1479450555-19047-1-git-send-email-jun.nie@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: shawn.guo@linaro.org, xie.baoyou@zte.com.cn
Cc: ulf.hansson@linaro.org, jh80.chung@samsung.com, jason.liu@linaro.org, chen.chaokai@zte.com.cn, lai.binz@zte.com.cn, linux-mmc@vger.kernel.org, Jun Nie <jun.nie@linaro.org>

Data done irq is expected if data length is less than
watermark in PIO mode. But fifo watermark is requested
to be aligned with data length in some SoC so that TX/RX
irq can be generated with data done irq. Add the
watermark alignment to mark this requirement and force
fifo watermark setting accordingly.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/mmc/host/dw_mmc.c  | 11 +++++++++--
 include/linux/mmc/dw_mmc.h |  3 +++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 696b5e6..6d85ca6 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1111,11 +1111,15 @@ static void dw_mci_submit_data(struct dw_mci *host, struct mmc_data *data)
 		mci_writel(host, CTRL, temp);
 
 		/*
-		 * Use the initial fifoth_val for PIO mode.
+		 * Use the initial fifoth_val for PIO mode. If wm_algined
+		 * is set, we set watermark same as data size.
 		 * If next issued data may be transfered by DMA mode,
 		 * prev_blksz should be invalidated.
 		 */
-		mci_writel(host, FIFOTH, host->fifoth_val);
+		if (host->wm_aligned)
+			dw_mci_adjust_fifoth(host, data);
+		else
+			mci_writel(host, FIFOTH, host->fifoth_val);
 		host->prev_blksz = 0;
 	} else {
 		/*
@@ -2957,6 +2961,9 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 
 	of_property_read_u32(np, "data-addr", &host->data_addr_override);
 
+	if (of_get_property(np, "fifo-watermark-aligned", NULL))
+		host->wm_aligned = true;
+
 	if (!of_property_read_u32(np, "clock-frequency", &clock_frequency))
 		pdata->bus_hz = clock_frequency;
 
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index 17cb95a..ee4bb30 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -108,6 +108,8 @@ struct dw_mci_dma_slave {
  * @slot: Slots sharing this MMC controller.
  * @fifo_depth: depth of FIFO.
  * @data_addr_override: override fifo reg offset with this value.
+ * @wm_aligned: force fifo watermark equal with data length in PIO mode.
+ *	Set as true if alignment is needed.
  * @data_shift: log2 of FIFO item size.
  * @part_buf_start: Start index in part_buf.
  * @part_buf_count: Bytes of partial data in part_buf.
@@ -156,6 +158,7 @@ struct dw_mci {
 	void __iomem		*regs;
 	void __iomem		*fifo_reg;
 	u32			data_addr_override;
+	bool			wm_aligned;
 
 	struct scatterlist	*sg;
 	struct sg_mapping_iter	sg_miter;
-- 
1.9.1

