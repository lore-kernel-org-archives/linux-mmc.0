From: Jun Nie <jun.nie@linaro.org>
Subject: [PATCH 5/5] mmc: dw: Add fifo watermark quirk
Date: Mon, 24 Oct 2016 17:11:56 +0800
Message-ID: <1477300316-1420-6-git-send-email-jun.nie@linaro.org>
References: <1477300316-1420-1-git-send-email-jun.nie@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35249 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934500AbcJXJMg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2016 05:12:36 -0400
Received: by mail-pf0-f182.google.com with SMTP id s8so95424051pfj.2
        for <linux-mmc@vger.kernel.org>; Mon, 24 Oct 2016 02:12:36 -0700 (PDT)
In-Reply-To: <1477300316-1420-1-git-send-email-jun.nie@linaro.org>
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
 include/linux/mmc/dw_mmc.h |  1 +
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 9dcd6da..d746c4a 100644
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
@@ -2958,6 +2962,9 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 	of_property_read_u32(np, "fifo-addr-override",
 			     &host->fifo_addr_override);
 
+	if (of_get_property(np, "fifo-watermark-quirk", NULL))
+		host->wm_quirk = true;
+
 	if (!of_property_read_u32(np, "clock-frequency", &clock_frequency))
 		pdata->bus_hz = clock_frequency;
 
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index 4866ef5..e7cc584 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -156,6 +156,7 @@ struct dw_mci {
 	void __iomem		*regs;
 	void __iomem		*fifo_reg;
 	u32			fifo_addr_override;
+	u32			wm_quirk;
 
 	struct scatterlist	*sg;
 	struct sg_mapping_iter	sg_miter;
-- 
1.9.1

