Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793477392;
	b=dFLKS+5msZP1DdgqWqcPojHoC2uCK8ncYO2+zv4vZ0RNPVEUUumdJESCPgxqgbTWEVur
	 XzMFv/tpbdBCcwc2oYzdRbRIEjG91ys8IiDByfY2Uj719fHkvM5CAw8D2m+waOVslpHkj
	 /TYhD2GtRRjj5ICzjec87SMkZvihXXoJttNzfnjm9p7it7Ctl1LgNbr1i9fVEo8poHIU7
	 q/qxGdea4gpslC4ISink2TfbwxPQzu/EyxlDMLGJK1wZnEgDqxMjz1NACJkzA5zAPIhZl
	 m7hCzeH6Nj1aqrigfzAy6K9dMSS28QJ5dlQ6cVi2SIIN9lZYiA12sshl2o0oTTn5Kww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793477392;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=lLEWRWhxY0X5Qhcbz/EtLWHCv/8fQ6WLPeE028PNRtE=;
	b=AF84QJIg7zvjyh1q2QTxB863yiJTRRZvV1sMl/a+YLIuZpUKLzE3hloDMS1MwMAXoZQp
	 aZqrW2rQ2ip1d5OOCCqpTG59B6SIplGWi8MNv7P92LXlidJosAf4haIECLPRoqjnuR0op
	 Tyhm1AQz1yVRXmXA2HM9uRsB6QQDoB+wTHL6fu67+t9hvTLyqvK6la9r06aBs/drwKQfp
	 g1XutXYRmdncK05tn1Jr0339vDwe2t+IaKyUi48GTpqYVma+xc2kBmUPJl5GB5v0VlEvh
	 C8435paLB+it2QgJrTBvDvutjWW4/0/xc4w5qdHjKfyh5M+ruArZYsAg0GC0onFcgdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CbtMv+6t;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1BA606A31C
	for <linux-mmc@vger.kernel.org>; Sat, 31 Oct 2026 20:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D1BA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CbtMv+6t
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e5378b281aso9983225ad.2
        for <linux-mmc@vger.kernel.org>; Sat, 31 Oct 2026 13:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793477391; x=1794082191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lLEWRWhxY0X5Qhcbz/EtLWHCv/8fQ6WLPeE028PNRtE=;
        b=CbtMv+6tVi+YwbO05VX4MX3xi17SxPRBMehNfhFsfSd5w5pGlIPYbV2XiMwoNAwOeA
         XVTxnlDZzPcDuacdcrm1zgvIrvsHJDqJH7BgrwjSJFMPKtJRaxt9huS4QGMPd+DoIGDh
         90K5VVSoBRXd8qNBcfxFuM9G0eai3WhF4VBVtYmYxqSBHyRfAa2ACmonrLG/zsEwOQoE
         ArtcUXG/HP1vWz6VMs+Skir18o2+SehT1oOwgWjUXktxg2f2Hgd/d4hCbS5qvMuHxMvL
         AbNj930SsDWHtx/YaQdZaAiZ66lonq4hnJBaN5qgVJfyzZ8B//j0Bqfuf++vGZ/MGhM8
         hQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793477391; x=1794082191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lLEWRWhxY0X5Qhcbz/EtLWHCv/8fQ6WLPeE028PNRtE=;
        b=THaAeCDi11U+CXx5vWfJ6Ape5Om8fXkEh7MMElP5JUxi4tKxCRd8oycaXD7xwRhxf7
         oHXgB+E1WBhWXfLKenxTCE8I4RR+VYGD+yFRdVfvgY0wShCMS5krqbNMacxXuWk7WRpO
         x9FU+i6FK1W2SEI1bSRgK1mc9of1F7HQHgSHFOUnW0SjtfQVNeBO+j0WVkNVkIU3wXFc
         mGw2qZlOLMVRkeIStZhkxHkG4aVisoFqIWegTXAh2Zse1b3y7l+vh/3dCI1p38c0hMLm
         9eimaCOaH+OQuqCGIX+7zSXc8WT8VaA4FwoFzXbZ5CGJkUmRJ++f887YUctYHT20BOK/
         LJoQ==
X-Gm-Message-State: AFq9FYInoCE1xbuSfzbFvW2G+G+GMPv2lSqcuFHAEStsJQqwCeH+MBcS
	7XpGGD+bee58z7YHQN6q4gWp8vznbAaKpascQT+3elw8srB7XVja4xZHSn8hVt4QsGYPXA==
X-Gm-Gg: AYBFou0830kdOtlviYgFKC9pxSNuT4ps61Ia5mn0G+LC3GDnZqMiZS5ok3K+opNvoFv
	DvmCyZqhrK4qx6z2neCA8XkiH8YuYJt7FDFzrjnNJ6UuXEk0oKw3uJoTlkM37GB49W4mrc17a1J
	Cn4gpdEtxduCDypNYpF2X+Fl9cjPHK+dkG2tVzRq7UIcmqGcHocBgyAp+DavuxL9pfkQbOuC6t4
	5sGVb9HrbZXzjZ7z1laHDrXU+p+ijz/jjVBl4bnSc5RumR+CATmTzWWxphouLLc4zYl5tQLJrGR
	wDXOJS2OoDCxi91rCKi+iBocU53SJZEGfeEgs9Qrxsc1X8qEo14STp9TmLczJZFatIroopwFS7h
	67yRaGEn+eJMG9bfNy6K/x5udUONQkKnabM3rQPhZY4HxhvPKtTmmK+sbkXvArVGRZ+M33mtMWD
	ldo1OJ9tpXNsVLr8YPKpuj8acI0A2xy3ClqsKsp79P170NBbV3QrY5tPbjjqDIN7LxFBMuyDoWn
	t9CXWdzpa41UjYnipJcqxLelYo5DC9cjvJ7MIPP0IhxnPGGBFOu3vbY8NAv2BZGLP3BImvpN3xs
	hqZPNiXtpZ7xqq+8CW8GyGu/BoxZmKdX4VEH0Yi74qp9KRaVyoU=
X-Received: by 2002:a17:903:1a08:b0:2e5:54b9:6b37 with SMTP id d9443c01a7336-2eb364bbb41mr60052995ad.28.1793477390781;
        Sat, 31 Oct 2026 13:09:50 -0700 (PDT)
Received: from ArchLinux-E5-Server.lan ([240e:3a2:ac01:77c0:1:3024:80c:fbbb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb38e9633fsm16660465ad.0.2026.10.31.13.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 13:09:49 -0700 (PDT)
From: ZHENPENG YUAN <yuanzhenpeng210@gmail.com>
To: linux-mmc@vger.kernel.org,
	ulfh@kernel.org
Cc: martin.blumenstingl@googlemail.com,
	neil.armstrong@linaro.org,
	khilman@baylibre.com,
	jbrunet@baylibre.com,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ZHENPENG YUAN <yuanzhenpeng210@gmail.com>
Subject: [RFC PATCH] mmc: meson-mx-sdhc: add DMA bounce buffer support
Date: Sun,  1 Nov 2026 04:09:25 +0800
Message-ID: <20261031200925.3364-1-yuanzhenpeng210@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Meson MX SDHC controller uses a single DMA address for each
transfer. Since the driver leaves max_segs at the MMC core default
of 1, large I/O requests are split into single-segment requests,
typically 4 KiB each.

On an Amlogic S805, this limits eMMC sequential read throughput
to approximately 15 MiB/s despite using HS200 timing.

Add a 128 KiB DMA bounce buffer for multi-segment requests and
advertise up to 64 scatterlist segments. Single-segment requests
continue to use direct DMA. If buffer allocation fails, fall back
to the original single-segment limit.

Testing on a Xunlei OneCloud (Meson8b, Samsung 8GME4R eMMC)
running Linux 7.3.1:

  Block size       Before       After
  4 KiB            14.47        14.69 MiB/s
  64 KiB           15.06        63.21 MiB/s
  128 KiB          15.08        75.13 MiB/s
  1 MiB            15.07        75.93 MiB/s

For a 128 MiB sequential read, block requests decreased from
32768 to 1024.

Direct I/O SHA256 readback verification and fio CRC32C write
verification passed. No MMC errors were observed.

Assisted-by: LLM
Signed-off-by: ZHENPENG YUAN <yuanzhenpeng210@gmail.com>
---
 drivers/mmc/host/meson-mx-sdhc-mmc.c | 165 ++++++++++++++++++++++++---
 1 file changed, 149 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/meson-mx-sdhc-mmc.c b/drivers/mmc/host/meson-mx-sdhc-mmc.c
index fb49ea712..c62583a80 100644
--- a/drivers/mmc/host/meson-mx-sdhc-mmc.c
+++ b/drivers/mmc/host/meson-mx-sdhc-mmc.c
@@ -16,6 +16,7 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/scatterlist.h>
 #include <linux/types.h>
 
 #include <linux/mmc/host.h>
@@ -29,6 +30,12 @@
 #define MESON_SDHC_MAX_BLK_SIZE					512
 #define MESON_SDHC_NUM_TUNING_TRIES				10
 
+/*
+ * A 128 KiB request spans at most 33 pages when it is not page aligned.
+ * The extra entries give the block layer room to merge a full request.
+ */
+#define MESON_SDHC_MAX_SEGS					64
+
 #define MESON_SDHC_WAIT_CMD_READY_SLEEP_US			1
 #define MESON_SDHC_WAIT_CMD_READY_TIMEOUT_US			100000
 #define MESON_SDHC_WAIT_BEFORE_SEND_SLEEP_US			1
@@ -48,6 +55,17 @@ struct meson_mx_sdhc_host {
 	struct mmc_command		*cmd;
 	int				error;
 
+	/*
+	 * The controller has a single DMA address register, so requests that
+	 * are not physically contiguous have to be bounced through this
+	 * buffer.
+	 */
+	void				*bounce_buf;
+	size_t				bounce_buf_size;
+	dma_addr_t			dma_addr;
+	unsigned int			dma_len;
+	bool				dma_bounce;
+
 	struct regmap			*regmap;
 
 	struct clk			*pclk;
@@ -220,8 +238,7 @@ static void meson_mx_sdhc_start_cmd(struct mmc_host *mmc,
 			   FIELD_PREP(MESON_SDHC_CTRL_PACK_LEN, pack_len));
 
 	if (cmd->data)
-		regmap_write(host->regmap, MESON_SDHC_ADDR,
-			     sg_dma_address(cmd->data->sg));
+		regmap_write(host->regmap, MESON_SDHC_ADDR, host->dma_addr);
 
 	meson_mx_sdhc_wait_cmd_ready(mmc);
 
@@ -362,32 +379,97 @@ static void meson_mx_sdhc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 static int meson_mx_sdhc_map_dma(struct mmc_host *mmc, struct mmc_request *mrq)
 {
+	struct meson_mx_sdhc_host *host = mmc_priv(mmc);
 	struct mmc_data *data = mrq->data;
-	unsigned int dma_len;
+	enum dma_data_direction dir;
+	struct scatterlist *sg;
+	unsigned int len, total_len;
+	int i, nents;
 
 	if (!data)
 		return 0;
 
-	dma_len = dma_map_sg(mmc_dev(mmc), data->sg, data->sg_len,
-			     mmc_get_dma_dir(data));
-	if (!dma_len) {
-		dev_err(mmc_dev(mmc), "dma_map_sg failed\n");
+	dir = mmc_get_dma_dir(data);
+	len = data->blocks * data->blksz;
+	host->dma_len = len;
+	host->dma_bounce = false;
+
+	/*
+	 * A request that consists of a single scatterlist entry is already
+	 * contiguous from the controller's point of view and can be
+	 * programmed directly.  This is also the only case where transfers
+	 * larger than the advertised max_req_size may occur (SDIO).
+	 */
+	if (data->sg_len == 1 && data->sg->length >= len) {
+		nents = dma_map_sg(mmc_dev(mmc), data->sg, data->sg_len, dir);
+		if (!nents) {
+			dev_err(mmc_dev(mmc), "dma_map_sg failed\n");
+			return -ENOMEM;
+		}
+
+		host->dma_addr = sg_dma_address(data->sg);
+		return 0;
+	}
+
+	total_len = 0;
+	for_each_sg(data->sg, sg, data->sg_len, i)
+		total_len += sg->length;
+
+	if (!host->bounce_buf || len > host->bounce_buf_size ||
+	    total_len < len) {
+		dev_err(mmc_dev(mmc),
+			"cannot DMA %u bytes in %u segments\n",
+			len, data->sg_len);
+		return -EINVAL;
+	}
+
+	if (dir == DMA_TO_DEVICE) {
+		if (sg_copy_to_buffer(data->sg, data->sg_len, host->bounce_buf,
+				      len) != len) {
+			dev_err(mmc_dev(mmc),
+				"failed to copy data into the bounce buffer\n");
+			return -EIO;
+		}
+	}
+
+	host->dma_addr = dma_map_single(mmc_dev(mmc), host->bounce_buf, len,
+					dir);
+	if (dma_mapping_error(mmc_dev(mmc), host->dma_addr)) {
+		dev_err(mmc_dev(mmc), "dma_map_single failed\n");
 		return -ENOMEM;
 	}
 
+	host->dma_bounce = true;
+
 	return 0;
 }
 
+static void meson_mx_sdhc_unmap_dma(struct meson_mx_sdhc_host *host,
+				    struct mmc_data *data)
+{
+	struct device *dev = mmc_dev(host->mmc);
+
+	if (host->dma_bounce) {
+		dma_unmap_single(dev, host->dma_addr, host->dma_len,
+				 mmc_get_dma_dir(data));
+		host->dma_bounce = false;
+	} else {
+		dma_unmap_sg(dev, data->sg, data->sg_len,
+			     mmc_get_dma_dir(data));
+	}
+}
+
 static void meson_mx_sdhc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct meson_mx_sdhc_host *host = mmc_priv(mmc);
 	struct mmc_command *cmd = mrq->cmd;
+	int ret = 0;
 
 	if (!host->error)
-		host->error = meson_mx_sdhc_map_dma(mmc, mrq);
+		ret = meson_mx_sdhc_map_dma(mmc, mrq);
 
-	if (host->error) {
-		cmd->error = host->error;
+	if (host->error || ret) {
+		cmd->error = host->error ? host->error : ret;
 		mmc_request_done(mmc, mrq);
 		return;
 	}
@@ -596,11 +678,6 @@ static irqreturn_t meson_mx_sdhc_irq_thread(int irq, void *irq_data)
 			regmap_update_bits(host->regmap, MESON_SDHC_PDMA, val,
 					   val);
 		}
-
-		dma_unmap_sg(mmc_dev(host->mmc), cmd->data->sg,
-			     cmd->data->sg_len, mmc_get_dma_dir(cmd->data));
-
-		cmd->data->bytes_xfered = cmd->data->blksz * cmd->data->blocks;
 	}
 
 	meson_mx_sdhc_wait_cmd_ready(host->mmc);
@@ -625,6 +702,40 @@ static irqreturn_t meson_mx_sdhc_irq_thread(int irq, void *irq_data)
 		 */
 		meson_mx_sdhc_clear_fifo(host->mmc);
 
+	if (cmd->data) {
+		struct mmc_data *data = cmd->data;
+		size_t len = data->blksz * data->blocks;
+		bool bounced = host->dma_bounce;
+
+		/*
+		 * Unmap the data after the controller has been quiesced so
+		 * that neither the reset nor the FIFO flush can race with an
+		 * ongoing DMA transfer.  dma_unmap_single() (for bounced
+		 * reads) also invalidates the CPU caches, so the copy below
+		 * sees the data written by the controller.
+		 */
+		meson_mx_sdhc_unmap_dma(host, data);
+
+		if (!data->error) {
+			if (bounced && data->flags & MMC_DATA_READ) {
+				size_t copied;
+
+				copied = sg_copy_from_buffer(data->sg,
+							     data->sg_len,
+							     host->bounce_buf,
+							     len);
+				if (copied != len) {
+					dev_err(mmc_dev(host->mmc),
+						"failed to copy data from the bounce buffer\n");
+					data->error = -EIO;
+				}
+			}
+
+			if (!data->error)
+				data->bytes_xfered = len;
+		}
+	}
+
 	meson_mx_sdhc_request_done(host);
 
 	return IRQ_HANDLED;
@@ -813,8 +924,17 @@ static int meson_mx_sdhc_probe(struct platform_device *pdev)
 
 	mmc->max_req_size = SZ_128K;
 	mmc->max_seg_size = mmc->max_req_size;
-	mmc->max_blk_count = FIELD_GET(MESON_SDHC_SEND_TOTAL_PACK, ~0);
 	mmc->max_blk_size = MESON_SDHC_MAX_BLK_SIZE;
+	/*
+	 * The controller has a single DMA address register.  Allowing the
+	 * block layer to merge more segments is only safe because requests
+	 * consisting of multiple segments are bounced through a contiguous
+	 * buffer.  Keep every request within max_req_size so that it always
+	 * fits into that buffer; SDIO uses max_blk_count to split transfers
+	 * as well.
+	 */
+	mmc->max_blk_count = mmc->max_req_size / mmc->max_blk_size;
+	mmc->max_segs = MESON_SDHC_MAX_SEGS;
 	mmc->max_busy_timeout = 30 * MSEC_PER_SEC;
 	mmc->f_min = clk_round_rate(host->sd_clk, 1);
 	mmc->f_max = clk_round_rate(host->sd_clk, ULONG_MAX);
@@ -823,6 +943,19 @@ static int meson_mx_sdhc_probe(struct platform_device *pdev)
 	mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_HW_RESET;
 	mmc->ops = &meson_mx_sdhc_ops;
 
+	host->bounce_buf = devm_kmalloc(dev, mmc->max_req_size, GFP_KERNEL);
+	if (host->bounce_buf) {
+		host->bounce_buf_size = mmc->max_req_size;
+	} else {
+		/*
+		 * Without the bounce buffer only physically contiguous
+		 * requests can be handled, so fall back to the old limit.
+		 */
+		mmc->max_segs = 1;
+		dev_warn(dev,
+			 "failed to allocate the DMA bounce buffer, using single-segment transfers\n");
+	}
+
 	ret = mmc_of_parse(mmc);
 	if (ret)
 		goto err_disable_pclk;
-- 
2.56.0

