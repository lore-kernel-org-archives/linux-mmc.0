Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886B04F85A6
	for <linux-mmc@vger.kernel.org>; Mon, 19 Oct 2026 13:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792418033; cv=none; b=WBvp91aoM0CqYb6EFU5HbLoNeTRPawnEAbgivOCCwrkmCRfk302Oe2il7I9tXdtbAOCQhvRzypu6jBtMyCFVf8w/HwnDGo9YsvdeNudoe4a6rydUIV3++DA4rq5lE2OdduqYzxHud7qM9Ht12cpscCyiU0mFpkr3WzPMRqDTXa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792418033; c=relaxed/simple;
	bh=zsoRutJnx4JOxfaFJBrKcctpwUrhOWkjDKLwKrTyt+A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=N8R6XPYQenzrjF84BqPKEa841iTFDJBzWZco1if0vSHelH2cYDLVJh9cIncEv0pW3a4QrRtQp2WNoxR8C34wLjwZGlHYykcfBVQvikUPzkaLb4jVINkooGfDyohbwVaP8zF8SrZelonzAIm9Mb0urtI367ehH/sTHsGWI0xc8Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SeoXrWKi; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeoXrWKi"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ab7b8e6fc2so282261a91.3
        for <linux-mmc@vger.kernel.org>; Mon, 19 Oct 2026 06:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792418032; x=1793022832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OZf5l3nm0qL9va+rXssexyiV+xjPumJIrkIx3ruN0bU=;
        b=SeoXrWKirbXBeNeSjS1nnmPbYH0YJ9yPBcBM2W5HSIN98o9CfpW1oppwLQhOqGKWa9
         7p1Ag89cZOLotss2IegljDWpEA2j3bn89gBqL/DbuGCgzpaJbc/0MV6F14YkMOcU8LBH
         sMhX7CEFMk3YdSo0Xoi9iBuj7TcTfHy/4k5zD9LgVB76TFVAGwja8w/5DBB92rvBt4Mq
         At1vSmGb8zul80TgeLSQLuxsyiBI597ONxGWt3Obco2OTwiAKYaLWlveVdnaSgOvNSij
         xT4AoEj+uCE/ocucYtTFBiI3w7IYEm4svhQHkZP8wRetKolKBD9yT615Oz5GBBNQjNY3
         tC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792418032; x=1793022832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OZf5l3nm0qL9va+rXssexyiV+xjPumJIrkIx3ruN0bU=;
        b=mtUHZ5+sggDEpVFldk99VuL5ohh1IFv5P+AzlDMO7+noI82wivdESRfTt9c4JcBlRh
         C1Ca8bx2qDMqgqCxK4/GyGV1X0nEYf91faVzv6GA23guPUd5sinT5Js6S/XhS8pJZjfG
         rtgV8Sv6l88iLOqlWlD4bOMZ/YuDa9RiqOwGx0cgj20ByoxMgBlbUkEWzMOs7yGlTdIk
         EQnt9JtFBl616Pj7zuy+PdJNHBmsUFjzDp6w+mP8lsgiDaRGKoGgSf2br+tgODLIGnnk
         3o+Mx3m4glK0WW+6u0pN37PGdbI1ZyJGI8nlz4u7C3Y8giapsaq8wGBowHUMODMsLsca
         FbeA==
X-Forwarded-Encrypted: i=1; AKwUvBx81d/iA149PCuXTveDwbjRBI4SsHyx1q/MBjG8lw1MgWJwLNC5q6kYSBE8wsUq8YcaASRMsHW6CWE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLrPrl/I0Z8K9hfmpFvpdP6Qr5l6Bkd+YIZ1kkic3eczwUuEyej
	K2lec/q8rCPWoLc3jOOgcewnAwQl/GKxaTZvzzjTE37Ev937U/CXMx1a
X-Gm-Gg: AYBFou1fsn8oYl5CSY1sDAAi5U5twlSKaCnlVkQc0ymLYtG6Z6ykDg9cQxpFRggAq4H
	nvLAfTlAUFq/iCBHKONdhOv2AiYGO9db/BTbl7dEu74s8+exjfk5EwUGjlxWbr+VQrk8NEltsHB
	Ti3ddqqHPlBkbDVR5PLBJS3SuuPUAVYyxN35CYv25QFrt0AKsDkDdgZRnxQOUp1si7r9M/6NvrS
	LGUn0Di7ykwYFYaZKu0vjKIEaFRcbGxnR/wj9bbBPEbX0PHPDrq9WA0SXHr0bCy7C4+kDBrD1WX
	ZAdZpb9guG9NwSFOVjXxYQ8QqWAMItxS0AUdC+HeMGAJeED3irMxbdzsWkY5i0LiqcSt6cMoIEB
	QxoaAajFy1lJjGM2vLIeZAkxi6aMDK/KlA0V3BS1I2SO6pboBJMQNzk04SjVUQOWZeTzb/bbXx/
	ezYzc0rTVd5722D9WHpHWj0w5/5QWMPpqivdemEXQDDktzmkrQa91FDLrmcc4A2yEe/JDJ8ROzI
	t6X3nNFOWZGHTz+ow==
X-Received: by 2002:a17:90b:39ad:b0:3a6:e61f:749d with SMTP id 98e67ed59e1d1-3acee27aa63mr10757870a91.1.1792418031830;
        Mon, 19 Oct 2026 06:53:51 -0700 (PDT)
Received: from LSSP.an0.nb ([2001:da8:7001:22:db98:829a:1281:5d10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac9474b52fsm23337328a91.9.2026.10.19.06.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:53:51 -0700 (PDT)
From: Guanxin Li <bruceli20040604@gmail.com>
To: Alexey Charkov <alchark@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Guanxin Li <bruceli20040604@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: wmt-sdmmc: release DMA descriptors after stopping the host
Date: Mon, 19 Oct 2026 21:53:07 +0800
Message-ID: <20261019135307.2074577-1-bruceli20040604@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wmt_mci_remove() currently frees the DMA descriptor buffer before calling
mmc_remove_host() and freeing the controller IRQs. The controller may still
be using the descriptors, and an interrupt handler may still access them
during this window.

Stop the MMC host and free both IRQs before releasing the DMA buffer to
prevent DMA or interrupt accesses to the freed memory during device removal.

Signed-off-by: Guanxin Li <bruceli20040604@gmail.com>
---
 drivers/mmc/host/wmt-sdmmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
index 489daee4f4fc..c44befabc909 100644
--- a/drivers/mmc/host/wmt-sdmmc.c
+++ b/drivers/mmc/host/wmt-sdmmc.c
@@ -896,14 +896,14 @@ static void wmt_mci_remove(struct platform_device *pdev)
 	writeb(0xFF, priv->sdmmc_base + SDMMC_STS1);
 
 	/* release the dma buffers */
-	dma_free_coherent(&pdev->dev, priv->mmc->max_blk_count * 16,
-			  priv->dma_desc_buffer, priv->dma_desc_device_addr);
+
 
 	mmc_remove_host(mmc);
 
 	free_irq(priv->irq_regular, priv);
 	free_irq(priv->irq_dma, priv);
-
+	dma_free_coherent(&pdev->dev, priv->mmc->max_blk_count * 16,
+			  priv->dma_desc_buffer, priv->dma_desc_device_addr);
 	iounmap(priv->sdmmc_base);
 
 	clk_disable_unprepare(priv->clk_sdmmc);
-- 
2.43.0

