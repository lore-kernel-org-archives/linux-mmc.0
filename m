Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E851974E7
	for <linux-mmc@vger.kernel.org>; Thu,  6 Jun 2024 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717697844; cv=none; b=KDj0fq8vinFkQej8U6VeSldzdp/ByJQ56aSc4HaUJUIsiMj/V5XG4E8/S1bFdW+9aE+uvFcfmxjwNrsziZLIgINsmyDGTOJj2oyCF7rqzspO5u8wESnMlblqvi1cAo92xH2QE9kNemrVSge8jKo/ovpiTOQJ6H9+AHywYwkdBTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717697844; c=relaxed/simple;
	bh=ifLXgx/GpPNErFkpAYkWZX/ZzeVeUST+vMTIoCyuDMM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Je1D9JLh0Iw30ulezhcc21d17o407bm2r25azaWHKcIhz48wmXtusQieBnUvyHsSUJBnRfDbesH2kjCYc0J2TE0D486zyZne8buE/YnB6apiM2J4/8nZ2jEQDCbp1ctlqBrKXsMvaAh64XJCzj6vHn2LUsQ34edmy0F9xIfoF+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HcreXfAl; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HcreXfAl"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52b8f5d811aso1432595e87.3
        for <linux-mmc@vger.kernel.org>; Thu, 06 Jun 2024 11:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717697841; x=1718302641; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H5amHRXb5PdZ0rzdS6C8Kl6WZX52arp5wQE9c4pGKQs=;
        b=HcreXfAl9KaiXBkFk5QTw/OtbEQ9Al6XdiLhLsC59XpljUw4Es1inP2hgPu6gVR/ac
         B3YmGXEj/H76gjYjoF44SVRdl52IRPO1fmNCanbe3ub+PTXlA1YiKI7EiGjSwoVm4qXi
         Jia7fmSMncrR9swIR7Qr0EAiH5DY1jQztc7lahUVtCKiFSyPyMwgvhZxe7pox/YF+mIf
         qztCtsISsAvza4AYNEbeUnKo9Bul5gDl08THmH1iu50MDW2DfQ4aH9XhqTuSMCeMaM/U
         cBkP19ThHLUo7CQzyFj9usZGPCRo6wMHkTpJeSguvG78VStademYHJp8KFLDYFUb7xKc
         0igQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717697841; x=1718302641;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H5amHRXb5PdZ0rzdS6C8Kl6WZX52arp5wQE9c4pGKQs=;
        b=am7K3xQH3L5rzAYmN0oQwFPgaxtwOnI1a0E+tAmZd1YiE55zs/TmueEUhj81h/bVst
         IfXaqVKHDTZZBhjZ03E47d7NZrEDnnnEIDGsWqsqgiXf7/fxYy5LWiEpZRgd6jGSS/o2
         1jU8aXIzyGr0KS02lZOK5wal3cYK49xtj+LQgYgUBiDTvwFPeUOGPWdWqNRs97bgWKlL
         UCwGujQ5pzo/YvwKC+iFSr2604ckuKh8DNiLXqq1S7QjP0Jx2pvJo784sUm0J6f8YWLy
         jJTDhzp/H/NhE6PmWFcRQGMQ2oloilJxJ0CpnG67lacfgWZewLzq6eWwtXXVS0LrxpKC
         ixwQ==
X-Gm-Message-State: AOJu0Yw+vpbwEo2FLuPgB5XIVB3IMya4pu2P0LryZr9AWBP+wjG37qiw
	bHRwOJzTRsT+R/YQTiwOIVr3S8NTrfPgyt2Wz1sPQu15TKYscVR5AhygiDPpZ3Q=
X-Google-Smtp-Source: AGHT+IHDA3Uu6jTX7915IEHybKjNMXElzIG/Zx0My0rYqvT4QjzTvrvjQvXXmhZMjYcIXpxN/H9PMA==
X-Received: by 2002:a19:ca05:0:b0:51d:8756:33f3 with SMTP id 2adb3069b0e04-52bb9f8e1eemr257614e87.32.1717697840669;
        Thu, 06 Jun 2024 11:17:20 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bb434dda8sm263923e87.300.2024.06.06.11.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 11:17:20 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 06 Jun 2024 20:17:20 +0200
Subject: [PATCH] Revert "mmc: moxart-mmc: Use sg_miter for PIO"
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-mmc-moxart-revert-v1-1-a01c2f40de9c@linaro.org>
X-B4-Tracking: v=1; b=H4sIAC/9YWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMwMz3dzcZN3c/IrEohJdoPpUIJWUmmRhbJxkYJ6SnKQE1FdQlJqWWQE
 2Mzq2thYAeG4WMGMAAAA=
To: Ulf Hansson <ulf.hansson@linaro.org>, Sergei Antonov <saproj@gmail.com>
Cc: linux-mmc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.13.0

This reverts commit 3ee0e7c3e67cab83ffbbe7707b43df8d41c9fe47.

The patch is not working for unknown reasons and I would
need access to the hardware to fix the bug.

This shouldn't matter anyway: the Moxa Art is not expected
to use highmem, and sg_miter() is only necessary to have
to properly deal with highmem.

Reported-by: Sergei Antonov <saproj@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/moxart-mmc.c | 78 ++++++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 35 deletions(-)

diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index 9a5f75163aca..8ede4ce93271 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -131,10 +131,12 @@ struct moxart_host {
 	struct dma_async_tx_descriptor	*tx_desc;
 	struct mmc_host			*mmc;
 	struct mmc_request		*mrq;
+	struct scatterlist		*cur_sg;
 	struct completion		dma_complete;
 	struct completion		pio_complete;
 
-	struct sg_mapping_iter		sg_miter;
+	u32				num_sg;
+	u32				data_remain;
 	u32				data_len;
 	u32				fifo_width;
 	u32				timeout;
@@ -146,6 +148,35 @@ struct moxart_host {
 	bool				is_removed;
 };
 
+static inline void moxart_init_sg(struct moxart_host *host,
+				  struct mmc_data *data)
+{
+	host->cur_sg = data->sg;
+	host->num_sg = data->sg_len;
+	host->data_remain = host->cur_sg->length;
+
+	if (host->data_remain > host->data_len)
+		host->data_remain = host->data_len;
+}
+
+static inline int moxart_next_sg(struct moxart_host *host)
+{
+	int remain;
+	struct mmc_data *data = host->mrq->cmd->data;
+
+	host->cur_sg++;
+	host->num_sg--;
+
+	if (host->num_sg > 0) {
+		host->data_remain = host->cur_sg->length;
+		remain = host->data_len - data->bytes_xfered;
+		if (remain > 0 && remain < host->data_remain)
+			host->data_remain = remain;
+	}
+
+	return host->num_sg;
+}
+
 static int moxart_wait_for_status(struct moxart_host *host,
 				  u32 mask, u32 *status)
 {
@@ -278,29 +309,14 @@ static void moxart_transfer_dma(struct mmc_data *data, struct moxart_host *host)
 
 static void moxart_transfer_pio(struct moxart_host *host)
 {
-	struct sg_mapping_iter *sgm = &host->sg_miter;
 	struct mmc_data *data = host->mrq->cmd->data;
 	u32 *sgp, len = 0, remain, status;
 
 	if (host->data_len == data->bytes_xfered)
 		return;
 
-	/*
-	 * By updating sgm->consumes this will get a proper pointer into the
-	 * buffer at any time.
-	 */
-	if (!sg_miter_next(sgm)) {
-		/* This shold not happen */
-		dev_err(mmc_dev(host->mmc), "ran out of scatterlist prematurely\n");
-		data->error = -EINVAL;
-		complete(&host->pio_complete);
-		return;
-	}
-	sgp = sgm->addr;
-	remain = sgm->length;
-	if (remain > host->data_len)
-		remain = host->data_len;
-	sgm->consumed = 0;
+	sgp = sg_virt(host->cur_sg);
+	remain = host->data_remain;
 
 	if (data->flags & MMC_DATA_WRITE) {
 		while (remain > 0) {
@@ -315,7 +331,6 @@ static void moxart_transfer_pio(struct moxart_host *host)
 				sgp++;
 				len += 4;
 			}
-			sgm->consumed += len;
 			remain -= len;
 		}
 
@@ -332,22 +347,22 @@ static void moxart_transfer_pio(struct moxart_host *host)
 				sgp++;
 				len += 4;
 			}
-			sgm->consumed += len;
 			remain -= len;
 		}
 	}
 
-	data->bytes_xfered += sgm->consumed;
-	if (host->data_len == data->bytes_xfered) {
+	data->bytes_xfered += host->data_remain - remain;
+	host->data_remain = remain;
+
+	if (host->data_len != data->bytes_xfered)
+		moxart_next_sg(host);
+	else
 		complete(&host->pio_complete);
-		return;
-	}
 }
 
 static void moxart_prepare_data(struct moxart_host *host)
 {
 	struct mmc_data *data = host->mrq->cmd->data;
-	unsigned int flags = SG_MITER_ATOMIC; /* Used from IRQ */
 	u32 datactrl;
 	int blksz_bits;
 
@@ -358,19 +373,15 @@ static void moxart_prepare_data(struct moxart_host *host)
 	blksz_bits = ffs(data->blksz) - 1;
 	BUG_ON(1 << blksz_bits != data->blksz);
 
+	moxart_init_sg(host, data);
+
 	datactrl = DCR_DATA_EN | (blksz_bits & DCR_BLK_SIZE);
 
-	if (data->flags & MMC_DATA_WRITE) {
-		flags |= SG_MITER_FROM_SG;
+	if (data->flags & MMC_DATA_WRITE)
 		datactrl |= DCR_DATA_WRITE;
-	} else {
-		flags |= SG_MITER_TO_SG;
-	}
 
 	if (moxart_use_dma(host))
 		datactrl |= DCR_DMA_EN;
-	else
-		sg_miter_start(&host->sg_miter, data->sg, data->sg_len, flags);
 
 	writel(DCR_DATA_FIFO_RESET, host->base + REG_DATA_CONTROL);
 	writel(MASK_DATA | FIFO_URUN | FIFO_ORUN, host->base + REG_CLEAR);
@@ -443,9 +454,6 @@ static void moxart_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	}
 
 request_done:
-	if (!moxart_use_dma(host))
-		sg_miter_stop(&host->sg_miter);
-
 	spin_unlock_irqrestore(&host->lock, flags);
 	mmc_request_done(host->mmc, mrq);
 }

---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240606-mmc-moxart-revert-beb833b07dcb

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

