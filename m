From: Jun Nie <jun.nie@linaro.org>
Subject: [PATCH v9 3/5] mmc: dw: Add fifo watermark alignment property
Date: Fri,  6 Jan 2017 12:24:44 +0800
Message-ID: <1483676686-17011-4-git-send-email-jun.nie@linaro.org>
References: <1483676686-17011-1-git-send-email-jun.nie@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33893 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937881AbdAFEZG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Jan 2017 23:25:06 -0500
Received: by mail-pf0-f181.google.com with SMTP id 127so11415595pfg.1
        for <linux-mmc@vger.kernel.org>; Thu, 05 Jan 2017 20:25:06 -0800 (PST)
In-Reply-To: <1483676686-17011-1-git-send-email-jun.nie@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, shawn.guo@linaro.org, xie.baoyou@zte.com.cn, devicetree@vger.kernel.org
Cc: ulf.hansson@linaro.org, jh80.chung@samsung.com, jason.liu@linaro.org, chen.chaokai@zte.com.cn, lai.binz@zte.com.cn, linux-mmc@vger.kernel.org, Jun Nie <jun.nie@linaro.org>

Data done irq is expected if data length is less than
watermark in PIO mode. But fifo watermark is requested
to be aligned with data length in some SoC so that TX/RX
irq can be generated with data done irq. Add the
watermark alignment to mark this requirement and force
fifo watermark setting accordingly.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
---
 drivers/mmc/host/dw_mmc.c  | 11 +++++++++--
 include/linux/mmc/dw_mmc.h |  3 +++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index b600170..e890a45 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1113,11 +1113,15 @@ static void dw_mci_submit_data(struct dw_mci *host, struct mmc_data *data)
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
@@ -2979,6 +2983,9 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 
 	of_property_read_u32(np, "data-addr", &host->data_addr_override);
 
+	if (of_get_property(np, "fifo-watermark-aligned", NULL))
+		host->wm_aligned = true;
+
 	if (!of_property_read_u32(np, "clock-frequency", &clock_frequency))
 		pdata->bus_hz = clock_frequency;
 
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index 1c09cca..cc7da85 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -114,6 +114,8 @@ struct dw_mci_dma_slave {
  * @slot: Slots sharing this MMC controller.
  * @fifo_depth: depth of FIFO.
  * @data_addr_override: override fifo reg offset with this value.
+ * @wm_aligned: force fifo watermark equal with data length in PIO mode.
+ *	Set as true if alignment is needed.
  * @data_shift: log2 of FIFO item size.
  * @part_buf_start: Start index in part_buf.
  * @part_buf_count: Bytes of partial data in part_buf.
@@ -162,6 +164,7 @@ struct dw_mci {
 	void __iomem		*regs;
 	void __iomem		*fifo_reg;
 	u32			data_addr_override;
+	bool			wm_aligned;
 
 	struct scatterlist	*sg;
 	struct sg_mapping_iter	sg_miter;
-- 
1.9.1

