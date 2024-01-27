Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F86A17F4
	for <linux-mmc@vger.kernel.org>; Sat, 27 Jan 2024 00:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706314815; cv=none; b=kRhD6ZFMnBypDMG6IB4/Ix75RATOuVVgi3opca7ngbd8vtj+DKYA34Xxs82p9A/0PD0l4k5ozy920E/p8qtRh1HvQK3iH4zSW+tYWT4gi0ahNR6kapn57r6vEdhnY9lmgPq2qNFapteggcwuc0vndpKucbeVCgAN3MGCA5LighA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706314815; c=relaxed/simple;
	bh=jja+9BUfY3p7IJ0UBkje+VXn//Mt2abUDD8oxOrr20c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=io4/AqKgeOgdH1mvOh9Ef2E9xJlJ/rmPxoMOyTGfWVwj2054zkARyEYOKz8FuvlRIVaAsjc/G2lsO4ns/ET0m/Fv6Y2hvN+n6E/MPTsJbZZCXuG4spHOjgAEnAjChYo2yAhPSvVzDlJMVRf345pTeplMKMT2to1Inqm36d1fbcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hWdWawAa; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hWdWawAa"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5102a877d50so601665e87.0
        for <linux-mmc@vger.kernel.org>; Fri, 26 Jan 2024 16:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706314812; x=1706919612; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b+qf6Kmkzij/J63a/y1MVzoBzMnJtm5VXzLHR9Dn/dQ=;
        b=hWdWawAaSaItzBtqKbpQEAMuqfjIm5T8WPLYY6pnPzEsZnbwgwa7fBCC+4eEB7Edmr
         pbAZd7Bt7XE0xgoh3KfWuwItO/+cQ8kfm9infUbwzazIDoW/EzY/FlT5KfkwfwlIPGAX
         CoagdjgykEN3txTbffYLGO7Ac9581EG4OOfGAfQxy0q2Oa/MjGM2W8Zykty71nFinhXK
         2gOsiJraym3QeUL5UZzXMu8jSkas+v3MXfQXm9TVJ/xl748enJgde8c8Z/rp6pLPuaOE
         DpOdUJkWiTje7Iwc87R7DSLKd+foXPaOWYZHfWRv0TZo0vXd5oIpmU62VuuknYz99kyU
         9mwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706314812; x=1706919612;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+qf6Kmkzij/J63a/y1MVzoBzMnJtm5VXzLHR9Dn/dQ=;
        b=GzYXGFjXA/e4Er6/wadGPLyNlE78sxdll/r6m3AjBQP9Dm5lrFffgLxdLtykS8CMhx
         7bWJjyWIm3E04trYxnGhLbMbaCtINRRXDYQnJIpXzctRfDD60K/lcBNoKjfQr+HPnCPD
         Mebd+ZjtXGYbs6X6gXllIePgjksHHu/Wd0+kUHyhzoDVYV372mGg1qtPQ/3AAFixou74
         663FSEiDjrEkrWKqWof7lxivIJOUUzLb3b/ds38jQlnprNgxcApNSX+LFv1kMvKy5NEd
         fvoM5wGFT/Zyf2LoBtHO1GRi8tSlkqQmMqGdoaiPR9TaYps229HcXCKbvmTiylZkr44O
         49tw==
X-Gm-Message-State: AOJu0YyPQmRt+r0TPDzpKrgeCooxlici+/Kc0aBCPTZ9+Y9seczUm/xN
	WncMJIXOYFFLMwotroKXpTkX+NCEpYrVr12mp95XROxvrYe4Pj0wOBTiB6JYJFU=
X-Google-Smtp-Source: AGHT+IGXujxtRX891ftx+e1FMFa5nxtOLkCUmc0pj5Kz6Y/AmfxBMocPdT5qL8vfQz+W0W7Du3/Qvw==
X-Received: by 2002:a05:6512:48a:b0:50e:ca97:5afb with SMTP id v10-20020a056512048a00b0050eca975afbmr244799lfq.18.1706314811925;
        Fri, 26 Jan 2024 16:20:11 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id x25-20020a19f619000000b0050e7f5cffa6sm325226lfe.273.2024.01.26.16.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 16:20:11 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 27 Jan 2024 01:19:48 +0100
Subject: [PATCH v2 1/9] mmc: davinci_mmc: Use sg_miter for PIO
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240127-mmc-proper-kmap-v2-1-d8e732aa97d1@linaro.org>
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
 drivers/mmc/host/davinci_mmc.c | 61 +++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 33 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index ee3b1a4e0848..c46577305138 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -180,12 +180,6 @@ struct mmc_davinci_host {
 #define DAVINCI_MMC_DATADIR_WRITE	2
 	unsigned char data_dir;
 
-	/* buffer is used during PIO of one scatterlist segment, and
-	 * is updated along with buffer_bytes_left.  bytes_left applies
-	 * to all N blocks of the PIO transfer.
-	 */
-	u8 *buffer;
-	u32 buffer_bytes_left;
 	u32 bytes_left;
 
 	struct dma_chan *dma_tx;
@@ -196,8 +190,8 @@ struct mmc_davinci_host {
 	bool active_request;
 
 	/* For PIO we walk scatterlists one segment at a time. */
+	struct sg_mapping_iter sg_miter;
 	unsigned int		sg_len;
-	struct scatterlist *sg;
 
 	/* Version of the MMC/SD controller */
 	u8 version;
@@ -213,30 +207,24 @@ struct mmc_davinci_host {
 static irqreturn_t mmc_davinci_irq(int irq, void *dev_id);
 
 /* PIO only */
-static void mmc_davinci_sg_to_buf(struct mmc_davinci_host *host)
-{
-	host->buffer_bytes_left = sg_dma_len(host->sg);
-	host->buffer = sg_virt(host->sg);
-	if (host->buffer_bytes_left > host->bytes_left)
-		host->buffer_bytes_left = host->bytes_left;
-}
-
 static void davinci_fifo_data_trans(struct mmc_davinci_host *host,
 					unsigned int n)
 {
+	struct sg_mapping_iter *sgm = &host->sg_miter;
+	size_t sglen;
 	u8 *p;
 	unsigned int i;
 
-	if (host->buffer_bytes_left == 0) {
-		host->sg = sg_next(host->data->sg);
-		mmc_davinci_sg_to_buf(host);
+	/*
+	 * By adjusting sgm->consumed this will give a pointer to the
+	 * current index into the sgm.
+	 */
+	if (!sg_miter_next(sgm)) {
+		dev_err(mmc_dev(host->mmc), "ran out of sglist prematurely\n");
+		return;
 	}
-
-	p = host->buffer;
-	if (n > host->buffer_bytes_left)
-		n = host->buffer_bytes_left;
-	host->buffer_bytes_left -= n;
-	host->bytes_left -= n;
+	p = sgm->addr;
+	sglen = sgm->length;
 
 	/* NOTE:  we never transfer more than rw_threshold bytes
 	 * to/from the fifo here; there's no I/O overlap.
@@ -261,7 +249,9 @@ static void davinci_fifo_data_trans(struct mmc_davinci_host *host,
 			p = p + (n & 3);
 		}
 	}
-	host->buffer = p;
+
+	sgm->consumed = n;
+	host->bytes_left -= n;
 }
 
 static void mmc_davinci_start_command(struct mmc_davinci_host *host,
@@ -517,6 +507,7 @@ mmc_davinci_prepare_data(struct mmc_davinci_host *host, struct mmc_request *req)
 	int fifo_lev = (rw_threshold == 32) ? MMCFIFOCTL_FIFOLEV : 0;
 	int timeout;
 	struct mmc_data *data = req->data;
+	unsigned int flags = SG_MITER_ATOMIC; /* Used from IRQ */
 
 	if (host->version == MMC_CTLR_VERSION_2)
 		fifo_lev = (rw_threshold == 64) ? MMCFIFOCTL_FIFOLEV : 0;
@@ -545,12 +536,14 @@ mmc_davinci_prepare_data(struct mmc_davinci_host *host, struct mmc_request *req)
 
 	/* Configure the FIFO */
 	if (data->flags & MMC_DATA_WRITE) {
+		flags |= SG_MITER_FROM_SG;
 		host->data_dir = DAVINCI_MMC_DATADIR_WRITE;
 		writel(fifo_lev | MMCFIFOCTL_FIFODIR_WR | MMCFIFOCTL_FIFORST,
 			host->base + DAVINCI_MMCFIFOCTL);
 		writel(fifo_lev | MMCFIFOCTL_FIFODIR_WR,
 			host->base + DAVINCI_MMCFIFOCTL);
 	} else {
+		flags |= SG_MITER_TO_SG;
 		host->data_dir = DAVINCI_MMC_DATADIR_READ;
 		writel(fifo_lev | MMCFIFOCTL_FIFODIR_RD | MMCFIFOCTL_FIFORST,
 			host->base + DAVINCI_MMCFIFOCTL);
@@ -558,7 +551,6 @@ mmc_davinci_prepare_data(struct mmc_davinci_host *host, struct mmc_request *req)
 			host->base + DAVINCI_MMCFIFOCTL);
 	}
 
-	host->buffer = NULL;
 	host->bytes_left = data->blocks * data->blksz;
 
 	/* For now we try to use DMA whenever we won't need partial FIFO
@@ -576,8 +568,7 @@ mmc_davinci_prepare_data(struct mmc_davinci_host *host, struct mmc_request *req)
 	} else {
 		/* Revert to CPU Copy */
 		host->sg_len = data->sg_len;
-		host->sg = host->data->sg;
-		mmc_davinci_sg_to_buf(host);
+		sg_miter_start(&host->sg_miter, data->sg, data->sg_len, flags);
 	}
 }
 
@@ -843,6 +834,8 @@ davinci_abort_data(struct mmc_davinci_host *host, struct mmc_data *data)
 {
 	mmc_davinci_reset_ctrl(host, 1);
 	mmc_davinci_reset_ctrl(host, 0);
+	if (!host->do_dma)
+		sg_miter_stop(&host->sg_miter);
 }
 
 static irqreturn_t mmc_davinci_sdio_irq(int irq, void *dev_id)
@@ -919,11 +912,13 @@ static irqreturn_t mmc_davinci_irq(int irq, void *dev_id)
 	if (qstatus & MMCST0_DATDNE) {
 		/* All blocks sent/received, and CRC checks passed */
 		if (data != NULL) {
-			if ((host->do_dma == 0) && (host->bytes_left > 0)) {
-				/* if datasize < rw_threshold
-				 * no RX ints are generated
-				 */
-				davinci_fifo_data_trans(host, host->bytes_left);
+			if (!host->do_dma) {
+				if (host->bytes_left > 0)
+					/* if datasize < rw_threshold
+					 * no RX ints are generated
+					 */
+					davinci_fifo_data_trans(host, host->bytes_left);
+				sg_miter_stop(&host->sg_miter);
 			}
 			end_transfer = 1;
 			data->bytes_xfered = data->blocks * data->blksz;

-- 
2.34.1

