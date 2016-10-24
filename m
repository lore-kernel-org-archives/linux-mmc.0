From: Jun Nie <jun.nie@linaro.org>
Subject: [PATCH 4/5] mmc: dw: Add fifo address override property
Date: Mon, 24 Oct 2016 17:11:55 +0800
Message-ID: <1477300316-1420-5-git-send-email-jun.nie@linaro.org>
References: <1477300316-1420-1-git-send-email-jun.nie@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33038 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934500AbcJXJMa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2016 05:12:30 -0400
Received: by mail-pf0-f172.google.com with SMTP id 128so95652053pfz.0
        for <linux-mmc@vger.kernel.org>; Mon, 24 Oct 2016 02:12:30 -0700 (PDT)
In-Reply-To: <1477300316-1420-1-git-send-email-jun.nie@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: shawn.guo@linaro.org, xie.baoyou@zte.com.cn
Cc: ulf.hansson@linaro.org, jh80.chung@samsung.com, jason.liu@linaro.org, linux-mmc@vger.kernel.org, Jun Nie <jun.nie@linaro.org>

The FIFO address of version 0x210A conflict with assumption that
0x100(version < 0x240A) and 0x200(version >= 0x240A) in some dw mmc
implementation. So this property serves as a workaround to set fifo
address with value provided by DT node.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/mmc/host/dw_mmc.c  | 6 ++++++
 include/linux/mmc/dw_mmc.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 1c9ee36..9dcd6da 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2955,6 +2955,9 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 
 	of_property_read_u32(np, "card-detect-delay", &pdata->detect_delay_ms);
 
+	of_property_read_u32(np, "fifo-addr-override",
+			     &host->fifo_addr_override);
+
 	if (!of_property_read_u32(np, "clock-frequency", &clock_frequency))
 		pdata->bus_hz = clock_frequency;
 
@@ -3163,6 +3166,9 @@ int dw_mci_probe(struct dw_mci *host)
 	else
 		host->fifo_reg = host->regs + DATA_240A_OFFSET;
 
+	if (host->fifo_addr_override)
+		host->fifo_reg = host->regs + host->fifo_addr_override;
+
 	tasklet_init(&host->tasklet, dw_mci_tasklet_func, (unsigned long)host);
 	ret = devm_request_irq(host->dev, host->irq, dw_mci_interrupt,
 			       host->irq_flags, "dw-mci", host);
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index f5af2bd..4866ef5 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -107,6 +107,7 @@ struct dw_mci_dma_slave {
  * @ciu_clk: Pointer to card interface unit clock instance.
  * @slot: Slots sharing this MMC controller.
  * @fifo_depth: depth of FIFO.
+ * @fifo_addr_override: override fifo reg offset with this value.
  * @data_shift: log2 of FIFO item size.
  * @part_buf_start: Start index in part_buf.
  * @part_buf_count: Bytes of partial data in part_buf.
@@ -154,6 +155,7 @@ struct dw_mci {
 	spinlock_t		irq_lock;
 	void __iomem		*regs;
 	void __iomem		*fifo_reg;
+	u32			fifo_addr_override;
 
 	struct scatterlist	*sg;
 	struct sg_mapping_iter	sg_miter;
-- 
1.9.1

