From: Jun Nie <jun.nie@linaro.org>
Subject: [PATCH v2 5/5] mmc: dw: Add fifo watermark quirk
Date: Fri, 28 Oct 2016 10:37:09 +0800
Message-ID: <1477622229-32060-6-git-send-email-jun.nie@linaro.org>
References: <1477622229-32060-1-git-send-email-jun.nie@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35124 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034365AbcJ1Chm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Oct 2016 22:37:42 -0400
Received: by mail-pf0-f181.google.com with SMTP id s8so28284352pfj.2
        for <linux-mmc@vger.kernel.org>; Thu, 27 Oct 2016 19:37:41 -0700 (PDT)
In-Reply-To: <1477622229-32060-1-git-send-email-jun.nie@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: shawn.guo@linaro.org, xie.baoyou@zte.com.cn
Cc: ulf.hansson@linaro.org, jh80.chung@samsung.com, jason.liu@linaro.org, linux-mmc@vger.kernel.org, Jun Nie <jun.nie@linaro.org>

Data done irq is expected if data length is less than
watermark in PIO mode. But fifo watermark is requested
to be aligned with data length in some SoC so that TX/RX
irq can be generated with data done irq. Add the
watermark quirk to mark this requirement and force
fifo watermark setting accordingly.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/mmc/host/dw_mmc.c  | 11 +++++++++--
 include/linux/mmc/dw_mmc.h |  2 ++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 24ae05b6..e0f49cc 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1111,11 +1111,15 @@ static void dw_mci_submit_data(struct dw_mci *host, struct mmc_data *data)
 		mci_writel(host, CTRL, temp);
 
 		/*
-		 * Use the initial fifoth_val for PIO mode.
+		 * Use the initial fifoth_val for PIO mode. If wm_quirk
+		 * is set, we set watermark same as data size.
 		 * If next issued data may be transfered by DMA mode,
 		 * prev_blksz should be invalidated.
 		 */
-		mci_writel(host, FIFOTH, host->fifoth_val);
+		if (host->wm_quirk)
+			dw_mci_adjust_fifoth(host, data);
+		else
+			mci_writel(host, FIFOTH, host->fifoth_val);
 		host->prev_blksz = 0;
 	} else {
 		/*
@@ -2957,6 +2961,9 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 
 	of_property_read_u32(np, "fifo-addr", &host->fifo_addr_override);
 
+	if (of_get_property(np, "fifo-watermark-quirk", NULL))
+		host->wm_quirk = true;
+
 	if (!of_property_read_u32(np, "clock-frequency", &clock_frequency))
 		pdata->bus_hz = clock_frequency;
 
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index 4866ef5..2ccfd9c 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -108,6 +108,7 @@ struct dw_mci_dma_slave {
  * @slot: Slots sharing this MMC controller.
  * @fifo_depth: depth of FIFO.
  * @fifo_addr_override: override fifo reg offset with this value.
+ * @wm_quirk: force fifo watermark equal with data length in PIO mode.
  * @data_shift: log2 of FIFO item size.
  * @part_buf_start: Start index in part_buf.
  * @part_buf_count: Bytes of partial data in part_buf.
@@ -156,6 +157,7 @@ struct dw_mci {
 	void __iomem		*regs;
 	void __iomem		*fifo_reg;
 	u32			fifo_addr_override;
+	u32			wm_quirk;
 
 	struct scatterlist	*sg;
 	struct sg_mapping_iter	sg_miter;
-- 
1.9.1

