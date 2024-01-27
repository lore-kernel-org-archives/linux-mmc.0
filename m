Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C07733F6
	for <linux-mmc@vger.kernel.org>; Sat, 27 Jan 2024 00:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706314821; cv=none; b=GQZz691lYP+fv3KzW0shlH4RpO7aszcmc8SIwxqx+Iw45EezkJKCveKZjnXXPLYJp1fRFE+LOV+qk4O4Pg+v3euwXceLHSejqjE5La1uQfTSHJ9Ulh3ssSKYU9WqeHQn62RgpdPTSglXDq4/YpS29NmyjxdKGn+whCJW4rhzLeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706314821; c=relaxed/simple;
	bh=dFn2ks6EacXxE3ISx+PVGru3tsQjDI5FXRhrLZ+AE6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SIU9Pzw9Vme4r9gSvKNqGJ+RZoK2YfPkDpqu7bbiSIDZRgr/eFZQer1r0P4/S+d+qdJWp1Rg0I/3C1Qp/O67xLejq7B53UvyrP6iRYs+2umLXK/izOw5vmygCXEyB5ol7kxeMjojx4wd7+CCd5x6RsiRVCbG0Wy6rXa3kQpUtxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pBOIqkl5; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pBOIqkl5"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5100cb238bcso1630383e87.3
        for <linux-mmc@vger.kernel.org>; Fri, 26 Jan 2024 16:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706314816; x=1706919616; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ofuXItHZiXctDb5vYJexyw4lWFm2o06QaWEWbHlsUFY=;
        b=pBOIqkl54M8xJ664Cr0wpalsghoMvF6s63n9XN3S0Qv0MVq3j17OvOzWz7jUQK6/KI
         Vo5oWlKOnHPZ8HWrgC4ciEaJVLIloaIuIYl+qFjy+166stenQ0Nqn/vOrlP6+B9PtTHz
         JXUjybQ+lbc1JF7nAg+hIrNUDb+OS141Vz6Pgla5x/cUyP81XdxY+O6LVcVMQDoOr0wd
         sKhqh9dD3bjO5PVBl9quo0VeYScKA7giAUFBXxlB/FQWEqN/KkpiRgMUtbuCCTsAh+Kh
         VbPjPHor97efBHQq2qxO1vnBZuEwvVMw6PImMlBIfnSIJdHoH9cAbCyomMtYZQuxbtcl
         naQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706314816; x=1706919616;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ofuXItHZiXctDb5vYJexyw4lWFm2o06QaWEWbHlsUFY=;
        b=LyRMI5vPTsNis08G6vVHNEEED2rF+4Wexth0DM8qphGAWtAG9ljNMZPZHHxE30wJw3
         dLq7md/S1iZlXwwTuEZkj10jNoHsitAocOu4QBTH7p0JaIZhWkkNvHgXb8WTs2y7qF4u
         VwiXm8q4aFStpdWP8kvJPM+6UMMG6PmSAc8+iotPhPYW0y3eWO150gSlt6P6AHhEre+U
         ZpjP3J6LhRz5V2ke9tjinSOkL0TfheppLnBRL4ApfQ0ZF3l7Pmq1rDhrpOSyUyUuQWaB
         gcPm5SUoYQez9YfrSRULhdeRtqKppWDdTVjvkFDrKkq8e/jJP0Ics7rO895EjoCeRsr2
         XXHQ==
X-Gm-Message-State: AOJu0Yy/XJjIcUxGoto7zDkeS3rV95t7PgUoSTh/Cvd8cNUy4FWuQ6je
	XxTQXa1LVGrlO52nOpGq7pE9Vsxt8FpqQCg21Y2X2aHAHGy/CLJ59V8MclrJgHY=
X-Google-Smtp-Source: AGHT+IGyvgr05EIrw1L+Y9U4iitEjJQ8+0O5OLxehL3iS289M5RLEqax89yMlhsUVY2qH3SITfm7pw==
X-Received: by 2002:ac2:4bc9:0:b0:510:893:f8c3 with SMTP id o9-20020ac24bc9000000b005100893f8c3mr412301lfq.20.1706314816586;
        Fri, 26 Jan 2024 16:20:16 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id x25-20020a19f619000000b0050e7f5cffa6sm325226lfe.273.2024.01.26.16.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 16:20:15 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 27 Jan 2024 01:19:51 +0100
Subject: [PATCH v2 4/9] mmc: moxart-mmc: Use sg_miter for PIO
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240127-mmc-proper-kmap-v2-4-d8e732aa97d1@linaro.org>
References: <20240127-mmc-proper-kmap-v2-0-d8e732aa97d1@linaro.org>
In-Reply-To: <20240127-mmc-proper-kmap-v2-0-d8e732aa97d1@linaro.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
 Ming Lei <ming.lei@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Nicolas Pitre <nico@fluxnic.net>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Angelo Dureghello <angelo.dureghello@timesys.com>
Cc: linux-mmc@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

Use the scatterlist memory iterator instead of just
dereferencing virtual memory using sg_virt().
This make highmem references work properly.

Suggested-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/linux-mmc/20240122073423.GA25859@lst.de/
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/moxart-mmc.c | 77 +++++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 43 deletions(-)

diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index 8ede4ce93271..b88d6dec209f 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -131,12 +131,10 @@ struct moxart_host {
 	struct dma_async_tx_descriptor	*tx_desc;
 	struct mmc_host			*mmc;
 	struct mmc_request		*mrq;
-	struct scatterlist		*cur_sg;
 	struct completion		dma_complete;
 	struct completion		pio_complete;
 
-	u32				num_sg;
-	u32				data_remain;
+	struct sg_mapping_iter		sg_miter;
 	u32				data_len;
 	u32				fifo_width;
 	u32				timeout;
@@ -148,35 +146,6 @@ struct moxart_host {
 	bool				is_removed;
 };
 
-static inline void moxart_init_sg(struct moxart_host *host,
-				  struct mmc_data *data)
-{
-	host->cur_sg = data->sg;
-	host->num_sg = data->sg_len;
-	host->data_remain = host->cur_sg->length;
-
-	if (host->data_remain > host->data_len)
-		host->data_remain = host->data_len;
-}
-
-static inline int moxart_next_sg(struct moxart_host *host)
-{
-	int remain;
-	struct mmc_data *data = host->mrq->cmd->data;
-
-	host->cur_sg++;
-	host->num_sg--;
-
-	if (host->num_sg > 0) {
-		host->data_remain = host->cur_sg->length;
-		remain = host->data_len - data->bytes_xfered;
-		if (remain > 0 && remain < host->data_remain)
-			host->data_remain = remain;
-	}
-
-	return host->num_sg;
-}
-
 static int moxart_wait_for_status(struct moxart_host *host,
 				  u32 mask, u32 *status)
 {
@@ -309,14 +278,28 @@ static void moxart_transfer_dma(struct mmc_data *data, struct moxart_host *host)
 
 static void moxart_transfer_pio(struct moxart_host *host)
 {
+	struct sg_mapping_iter *sgm = &host->sg_miter;
 	struct mmc_data *data = host->mrq->cmd->data;
 	u32 *sgp, len = 0, remain, status;
 
 	if (host->data_len == data->bytes_xfered)
 		return;
 
-	sgp = sg_virt(host->cur_sg);
-	remain = host->data_remain;
+	/*
+	 * By updating sgm->consumes this will get a proper pointer into the
+	 * buffer at any time.
+	 */
+	if (!sg_miter_next(sgm)) {
+		/* This shold not happen */
+		dev_err(mmc_dev(host->mmc), "ran out of scatterlist prematurely\n");
+		data->error = -EINVAL;
+		complete(&host->pio_complete);
+		return;
+	}
+	sgp = sgm->addr;
+	remain = sgm->length;
+	if (remain > host->data_len)
+		remain = host->data_len;
 
 	if (data->flags & MMC_DATA_WRITE) {
 		while (remain > 0) {
@@ -331,6 +314,7 @@ static void moxart_transfer_pio(struct moxart_host *host)
 				sgp++;
 				len += 4;
 			}
+			sgm->consumed += len;
 			remain -= len;
 		}
 
@@ -347,22 +331,22 @@ static void moxart_transfer_pio(struct moxart_host *host)
 				sgp++;
 				len += 4;
 			}
+			sgm->consumed += len;
 			remain -= len;
 		}
 	}
 
-	data->bytes_xfered += host->data_remain - remain;
-	host->data_remain = remain;
-
-	if (host->data_len != data->bytes_xfered)
-		moxart_next_sg(host);
-	else
+	data->bytes_xfered += sgm->consumed;
+	if (host->data_len == data->bytes_xfered) {
 		complete(&host->pio_complete);
+		return;
+	}
 }
 
 static void moxart_prepare_data(struct moxart_host *host)
 {
 	struct mmc_data *data = host->mrq->cmd->data;
+	unsigned int flags = SG_MITER_ATOMIC; /* Used from IRQ */
 	u32 datactrl;
 	int blksz_bits;
 
@@ -373,15 +357,19 @@ static void moxart_prepare_data(struct moxart_host *host)
 	blksz_bits = ffs(data->blksz) - 1;
 	BUG_ON(1 << blksz_bits != data->blksz);
 
-	moxart_init_sg(host, data);
-
 	datactrl = DCR_DATA_EN | (blksz_bits & DCR_BLK_SIZE);
 
-	if (data->flags & MMC_DATA_WRITE)
+	if (data->flags & MMC_DATA_WRITE) {
+		flags |= SG_MITER_FROM_SG;
 		datactrl |= DCR_DATA_WRITE;
+	} else {
+		flags |= SG_MITER_TO_SG;
+	}
 
 	if (moxart_use_dma(host))
 		datactrl |= DCR_DMA_EN;
+	else
+		sg_miter_start(&host->sg_miter, data->sg, data->sg_len, flags);
 
 	writel(DCR_DATA_FIFO_RESET, host->base + REG_DATA_CONTROL);
 	writel(MASK_DATA | FIFO_URUN | FIFO_ORUN, host->base + REG_CLEAR);
@@ -454,6 +442,9 @@ static void moxart_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	}
 
 request_done:
+	if (!moxart_use_dma(host))
+		sg_miter_stop(&host->sg_miter);
+
 	spin_unlock_irqrestore(&host->lock, flags);
 	mmc_request_done(host->mmc, mrq);
 }

-- 
2.34.1

