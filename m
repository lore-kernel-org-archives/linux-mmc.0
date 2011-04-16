From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] mmc: sdhci: add support for pre_req and post_req
Date: Sun, 17 Apr 2011 00:48:36 +0800
Message-ID: <1302972516-8673-1-git-send-email-shawn.guo@linaro.org>
References: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.212.179]:45867 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472Ab1DPQnl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 16 Apr 2011 12:43:41 -0400
Received: by pxi2 with SMTP id 2so2283232pxi.10
        for <linux-mmc@vger.kernel.org>; Sat, 16 Apr 2011 09:43:40 -0700 (PDT)
In-Reply-To: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, patches@linaro.org, cjb@laptop.org, per.forlin@linaro.org, Shawn Guo <shawn.guo@linaro.org>

pre_req() runs dma_map_sg() post_req() runs dma_unmap_sg.
If not calling pre_req() before sdhci_request(), request()
will prepare the cache just like it did it before.
It is optional to use pre_req() and post_req().

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
I worked out the patch by referring to Per's patch below.

 omap_hsmmc: add support for pre_req and post_req

It adds pre_req and post_req support for sdhci based host drivers to
work with Per's non-blocking optimization.  But I only have imx esdhc
based hardware to test.  Unfortunately, I can not measure the
performance gain using mmc_test, because the current esdhc driver on
mainline fails on the test.  So I just did a quick test using 'dd',
but sadly, I did not see noticeable performance gain here.  The
followings are possible reasons I can think of right away.

* The patch did not add pre_req and post_req correctly.  Please help
  review to catch the mistakes if any.
* The imx esdhc driver uses SDHCI_SDMA (max_segs is 1) than SDHCI_ADAM
  (max_segs is 128), due to the broken ADMA support on imx esdhc.  So
  can people holding other sdhci based hardware give a try on the
  patch?

Hopefully, I can find some time to have a close look at the mmc_test
failure and the broken ADMA with imx esdhc.

Regards,
Shawn

 drivers/mmc/host/sdhci.c  |   95 ++++++++++++++++++++++++++++++++++++++------
 include/linux/mmc/sdhci.h |    7 +++
 2 files changed, 89 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9e15f41..becce9a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -408,6 +408,44 @@ static void sdhci_set_adma_desc(u8 *desc, u32 addr, int len, unsigned cmd)
 	dataddr[0] = cpu_to_le32(addr);
 }
 
+static int sdhci_pre_dma_transfer(struct sdhci_host *host,
+				  struct mmc_data *data,
+				  struct sdhci_next *next)
+{
+	int sg_count;
+
+	if (!next && data->host_cookie &&
+	    data->host_cookie != host->next_data.cookie) {
+		printk(KERN_WARNING "[%s] invalid cookie: data->host_cookie %d"
+		       " host->next_data.cookie %d\n",
+		       __func__, data->host_cookie, host->next_data.cookie);
+		data->host_cookie = 0;
+	}
+
+	/* Check if next job is already prepared */
+	if (next ||
+	    (!next && data->host_cookie != host->next_data.cookie)) {
+		sg_count = dma_map_sg(mmc_dev(host->mmc), data->sg,
+				      data->sg_len,
+				      (data->flags & MMC_DATA_WRITE) ?
+				      DMA_TO_DEVICE : DMA_FROM_DEVICE);
+	} else {
+		sg_count = host->next_data.sg_count;
+		host->next_data.sg_count = 0;
+	}
+
+	if (sg_count == 0)
+		return -EINVAL;
+
+	if (next) {
+		next->sg_count = sg_count;
+		data->host_cookie = ++next->cookie < 0 ? 1 : next->cookie;
+	} else
+		host->sg_count = sg_count;
+
+	return sg_count;
+}
+
 static int sdhci_adma_table_pre(struct sdhci_host *host,
 	struct mmc_data *data)
 {
@@ -445,9 +483,8 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
 		goto fail;
 	BUG_ON(host->align_addr & 0x3);
 
-	host->sg_count = dma_map_sg(mmc_dev(host->mmc),
-		data->sg, data->sg_len, direction);
-	if (host->sg_count == 0)
+	host->sg_count = sdhci_pre_dma_transfer(host, data, NULL);
+	if (host->sg_count < 0)
 		goto unmap_align;
 
 	desc = host->adma_desc;
@@ -587,8 +624,9 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 		}
 	}
 
-	dma_unmap_sg(mmc_dev(host->mmc), data->sg,
-		data->sg_len, direction);
+	if (!data->host_cookie)
+		dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
+			     direction);
 }
 
 static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_data *data)
@@ -757,11 +795,7 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_data *data)
 		} else {
 			int sg_cnt;
 
-			sg_cnt = dma_map_sg(mmc_dev(host->mmc),
-					data->sg, data->sg_len,
-					(data->flags & MMC_DATA_READ) ?
-						DMA_FROM_DEVICE :
-						DMA_TO_DEVICE);
+			sg_cnt = sdhci_pre_dma_transfer(host, data, NULL);
 			if (sg_cnt == 0) {
 				/*
 				 * This only happens when someone fed
@@ -850,9 +884,11 @@ static void sdhci_finish_data(struct sdhci_host *host)
 		if (host->flags & SDHCI_USE_ADMA)
 			sdhci_adma_table_post(host, data);
 		else {
-			dma_unmap_sg(mmc_dev(host->mmc), data->sg,
-				data->sg_len, (data->flags & MMC_DATA_READ) ?
-					DMA_FROM_DEVICE : DMA_TO_DEVICE);
+			if (!data->host_cookie)
+				dma_unmap_sg(mmc_dev(host->mmc), data->sg,
+					     data->sg_len,
+					     (data->flags & MMC_DATA_READ) ?
+					     DMA_FROM_DEVICE : DMA_TO_DEVICE);
 		}
 	}
 
@@ -1116,6 +1152,35 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned short power)
  *                                                                           *
 \*****************************************************************************/
 
+static void sdhci_pre_req(struct mmc_host *mmc, struct mmc_request *mrq,
+			  bool is_first_req)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	if (mrq->data->host_cookie) {
+		mrq->data->host_cookie = 0;
+		return;
+	}
+
+	if (host->flags & SDHCI_REQ_USE_DMA)
+		if (sdhci_pre_dma_transfer(host, mrq->data, &host->next_data) < 0)
+			mrq->data->host_cookie = 0;
+}
+
+static void sdhci_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
+			   int err)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct mmc_data *data = mrq->data;
+
+	if (host->flags & SDHCI_REQ_USE_DMA) {
+		dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
+			     (data->flags & MMC_DATA_WRITE) ?
+			     DMA_TO_DEVICE : DMA_FROM_DEVICE);
+		data->host_cookie = 0;
+	}
+}
+
 static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct sdhci_host *host;
@@ -1285,6 +1350,8 @@ out:
 }
 
 static const struct mmc_host_ops sdhci_ops = {
+	.pre_req	= sdhci_pre_req,
+	.post_req	= sdhci_post_req,
 	.request	= sdhci_request,
 	.set_ios	= sdhci_set_ios,
 	.get_ro		= sdhci_get_ro,
@@ -1867,6 +1934,8 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (caps & SDHCI_TIMEOUT_CLK_UNIT)
 		host->timeout_clk *= 1000;
 
+	host->next_data.cookie = 1;
+
 	/*
 	 * Set host parameters.
 	 */
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 83bd9f7..924e84b 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -17,6 +17,11 @@
 #include <linux/io.h>
 #include <linux/mmc/host.h>
 
+struct sdhci_next {
+	unsigned int sg_count;
+	s32 cookie;
+};
+
 struct sdhci_host {
 	/* Data set by hardware interface driver */
 	const char *hw_name;	/* Hardware bus name */
@@ -145,6 +150,8 @@ struct sdhci_host {
 	unsigned int            ocr_avail_sd;
 	unsigned int            ocr_avail_mmc;
 
+	struct sdhci_next next_data;
+
 	unsigned long private[0] ____cacheline_aligned;
 };
 #endif /* __SDHCI_H */
-- 
1.7.4.1

