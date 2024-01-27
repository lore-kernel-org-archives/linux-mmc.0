Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733ADEA8
	for <linux-mmc@vger.kernel.org>; Sat, 27 Jan 2024 00:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706314824; cv=none; b=RBYnRy/vcl4lTKzPtY0nmOfBaMAhUDnNu4O0iU4YT2yVqrYlFqqIZfdb9KkZJb663nsk8Mjxu7ASFyMyvmfShLYVvoxxbq1MX4fyemjAFue8QKdmQLXwXZPQky1cyegxBFqCiZwVleggLdu4FZb4nKB4EQxksCM04JP+X0I5XwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706314824; c=relaxed/simple;
	bh=11tgqTYTTcAC/xg5mxKcSDPSUwbnuZsCql+ezd70tYo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K1eh2ytIWY+kMPFAHuCc+vkWaQK7zl/y4mUEEVwcIH5am5WQtVH+JK07CpeqEKCmnG36dH6UQsItK6wI5dTsTjh7hCwvySWc7l/mP6fjoBfxKVvLm1ZlqnjHEWEyVf2OrR1HMdHPxEIADm2aKKw015vSx2yy7GpE/+Nkm9sB6Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M4fXkVNu; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M4fXkVNu"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5102a2e4b7bso1090302e87.1
        for <linux-mmc@vger.kernel.org>; Fri, 26 Jan 2024 16:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706314820; x=1706919620; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OF+atUpH2jGXdb8/KiqqDPha8EDyadeWwvv8sbSBzHk=;
        b=M4fXkVNuCAPPcn7ZXSnRL8SP3zLpOJUqHIoVJrAlQHMP/rMy56qtbN3Fv6Tql1/8EB
         0mlcxFm9YsXFRA3+Axi1L/hqrUjVA/DzmaNIdFAcsMj5rYdVFGsSdHHugnLGl6IP+Sb5
         BBFdcxXGrmamiWLVTt453/IrL3XDDzfFa4rl+ONwLG/1Md6KYe2HEtiK86GlfXQrKAjk
         ErDQ1Ox8BUgCYAvCJ4QGwlrg8Lgcy+oOMs/3W2robN5rZhtdV6e9DiTRbdwpUh+VTt60
         WDWq9cJGsPBrvZkxrzsrAMwgwn54tb1O2zJdNBUxji30qdVNKH/U0VLyhpUAT2rzJSKD
         UIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706314820; x=1706919620;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OF+atUpH2jGXdb8/KiqqDPha8EDyadeWwvv8sbSBzHk=;
        b=OVKlET+Kq7WFjfigcUClJ14l6SvoK9OuMCNDBUpXD189zhVVH9qshM2+UaENTFDJ4T
         IVEY2QUg5OBb29oN7JT4tEXUUYCHoKRy7qZthXxWKc7CL2LtQ957uEyfvNqbnImPgI5m
         cOY+2KCXyRltRRHWCfCk7tYuHUP+R0lxxJV6XDuK492pYNVhjggTCf183hzRanlgyuQ/
         8L4hqqwGptlxvKbt7pgOYMVwrns2pswTZB4ZyENOFnKxJkycJMLBIg81VtX/ctSs/VmG
         QZRTcKY7JcL7aEtYUu9J3160H75MLwCJ0IWNRWwdEkUJzOXBfX6r1tPSenIpJqEwqcFW
         hXfg==
X-Gm-Message-State: AOJu0Yx7MNxqb8ZIj89Q1WC0genZ/6blkEQQpXDVPC1isTN4xzGU2Bhg
	CV7CSO7B0tRC8ngBMzAd0shnTwNZrgd+6ZgvS5Y2hdClN7pBurESSqJ+hlc3/CM=
X-Google-Smtp-Source: AGHT+IGu2Zjg0R7ovqlG5rze1HiowsVGljfHEkvyIteXZVo1ZS9Bo68Lc0U++8crpiCyQbpFoddHYg==
X-Received: by 2002:a05:6512:2204:b0:510:27f2:2621 with SMTP id h4-20020a056512220400b0051027f22621mr224564lfu.23.1706314820506;
        Fri, 26 Jan 2024 16:20:20 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id x25-20020a19f619000000b0050e7f5cffa6sm325226lfe.273.2024.01.26.16.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 16:20:20 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 27 Jan 2024 01:19:55 +0100
Subject: [PATCH v2 8/9] mmc: sdhci-esdhc-mcf: Use sg_miter for swapping
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240127-mmc-proper-kmap-v2-8-d8e732aa97d1@linaro.org>
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

Use sg_miter iterator instead of sg_virt() and custom code
to loop over the scatterlist. The memory iterator will do
bounce buffering if the page happens to be located in high memory,
which the driver may or may not be using.

Suggested-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/linux-mmc/20240122073423.GA25859@lst.de/
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/sdhci-esdhc-mcf.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-mcf.c b/drivers/mmc/host/sdhci-esdhc-mcf.c
index a07f8333cd6b..1909a11fd065 100644
--- a/drivers/mmc/host/sdhci-esdhc-mcf.c
+++ b/drivers/mmc/host/sdhci-esdhc-mcf.c
@@ -299,9 +299,8 @@ static void esdhc_mcf_pltfm_set_bus_width(struct sdhci_host *host, int width)
 static void esdhc_mcf_request_done(struct sdhci_host *host,
 				   struct mmc_request *mrq)
 {
-	struct scatterlist *sg;
+	struct sg_mapping_iter sgm;
 	u32 *buffer;
-	int i;
 
 	if (!mrq->data || !mrq->data->bytes_xfered)
 		goto exit_done;
@@ -313,10 +312,13 @@ static void esdhc_mcf_request_done(struct sdhci_host *host,
 	 * On mcf5441x there is no hw sdma option/flag to select the dma
 	 * transfer endiannes. A swap after the transfer is needed.
 	 */
-	for_each_sg(mrq->data->sg, sg, mrq->data->sg_len, i) {
-		buffer = (u32 *)sg_virt(sg);
-		esdhc_mcf_buffer_swap32(buffer, sg->length);
+	sg_miter_start(&sgm, mrq->data->sg, mrq->data->sg_len,
+		       SG_MITER_TO_SG | SG_MITER_FROM_SG);
+	while (sg_miter_next(&sgm)) {
+		buffer = sgm.addr;
+		esdhc_mcf_buffer_swap32(buffer, sgm.length);
 	}
+	sg_miter_stop(&sgm);
 
 exit_done:
 	mmc_request_done(host->mmc, mrq);

-- 
2.34.1

