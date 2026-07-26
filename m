Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD8E377AA3
	for <linux-mmc@vger.kernel.org>; Sun, 26 Jul 2026 21:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785103066; cv=none; b=SnfJY6ZWvBqCNRvGCOWH6xd9i2A06U5YQutoQN/o4Rh+umc7CPpMaP7bkInLuQWZyXbDFcT+LOfIeZf9mBlcNoExI3iI1cuvOrEuMpwpyQl9m7ibolQFj7FGmkXijxYVu8BOtg9oFs8VUf/6Pv3pPfFA5tnpAgMEo3Vxsw8KI7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785103066; c=relaxed/simple;
	bh=ISbei8wuwbwd+qsDwqxaJvR+/sHMQY8pYWaHZpMoAdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P/WmL0sM/ezcO/tUzv3ugHRCz6g+SC4HIpVfCEVb0+mqVsRusjvBRkQfcpwMEY1zg1qZiT5+ZkAMEa1GkYsE1xdPurIA7Op0O6JZENNHVieE+3disyXWKRVXvEHEIiCScMgyoIIgcZ3AitN36R83a5R22ElE8qsAVbPqs8C21xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmQQTK04; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmQQTK04"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38e08baf860so2099019a91.2
        for <linux-mmc@vger.kernel.org>; Sun, 26 Jul 2026 14:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785103065; x=1785707865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tqWCtESQQ2bWbP4HQOrXWNhHPb+LXu076IiCVmal7Vw=;
        b=GmQQTK04Im+bO4fjyi2mpEi32fSnN7aTF9fyGlfYp9K3mqemtaeK+jMuWVI3OXUkUD
         ISEBDGxuHg4gcDDwgqULTKRCx53M2MTxuXh9QDImQdWwodgGbcT65GUpQyNtcqg/ycx/
         hUE4J3+g5jz0eHsw8D7eaGHDcTf8VQMbghOEKGdsTgN2TDAR3uDeY0R9J3rwPBAOfr/c
         xjk6kWFJUj14OCfknthbH9G0I/MwLZZRugboadUdtlaBTz8aJcN2WK9fMlTEKoDDTrBc
         Hj0yjWzZsPUuQbWuvYaPi5kp/iDVNCmFh15YwYD6kWNtWMMHIuYwa8oIMTK/DsP4aQ42
         3hTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785103065; x=1785707865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tqWCtESQQ2bWbP4HQOrXWNhHPb+LXu076IiCVmal7Vw=;
        b=NtxyZyCQSt3YIjKk8RJ3G+cUetYUlpzeiWX6g/bsTFp7MANSt0hSQg31MHeU0U/vq3
         db50g5P/0CHAzJDEwBQc+drTIxoafKnju3dMsyt5c7QtlGb/AvZPmJ9S+j8u6SXCpWY+
         0k9I8xH4MIz9k1xQuYdi/DahxfqraE6Hyhc23p1iSvfLxcYhumlRVYrAEyDWPkEOcgRI
         M70KrTwoVYIjLD8l1npd5AHXPKcEiPpaHkGZinTIQl8DGUU231qk42leNzj2pn9xqu/w
         U0552L3ekeRAqn216rLvfPm1l3eLX4Je3wjl1eM89CqZqsyuv002xBy4i78l7dmJEj4G
         TBZA==
X-Gm-Message-State: AOJu0YwUHKlDQF/HhIeF5G6BmMq3ioS1RfuaOBg8+SNtRziIkE1eRZR2
	ThKfwRkJ750BbgFD9Y+8M+lozeHfem3BnGtrTn8u1MKs8+bhXZr9eTYJnqxHRg==
X-Gm-Gg: AR+sD10tDjOiRN1roX+TFx0Cf42+iF83IgLCFuA35yQuehikJQqfOVUVQNWxrtRPcti
	BVqzhxk/E2YwO0Ie8WUAPgazaIEjEAgI0wCKWmSQB9unrkmu5nlFQu/YfdWeNimFGAH8cY5hxP8
	Koy3aQDffTltb9JQbKnSqOIxWG7wM1btQNFP7OzJeeWKZqS23hgibfnSVzIr+NJzJc1kiEsdGAT
	6KNXWbtHo2ajTu93sDfH8UXjMcoNFGBufXBZx5VAuhbxVFrUVlqvJFhxQcfwFitgivuvei3Mu4d
	OCC7H6vtuxLN1JATbHSRLpW5OFFlJKb4eWzV8oWq3oTgpPGXe/BFqLPXf92eubH8C+WMfZ5T41P
	2sVtBloqDGOc5jrb2/QieANObFEAlcsDIhmioZonizxC2kJBXRxDOmQQ0oSYeVaAm3BXYt4oxio
	X9i6mEM2PzB2AXiIKyHVg8PlghPyc813y71mSFQHB8LTRInHOO65dqmE/NvkhFvSEXaXRFcOT00
	WIgDO6h7fW/6RmuJkNvdhInVmRSZq/iwQ3vXTesUtnC1l9+qPVk4QM=
X-Received: by 2002:a17:90b:53ce:b0:38d:a150:ee04 with SMTP id 98e67ed59e1d1-38f2965eb5emr5493758a91.30.1785103064721;
        Sun, 26 Jul 2026 14:57:44 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f2913c891sm2022788a91.0.2026.07.26.14.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 14:57:42 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulfh@kernel.org>,
	linux-omap@vger.kernel.org (open list:OMAP HS MMC SUPPORT),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mmc: omap_hsmmc: use platform_get_irq_optional for wake IRQ
Date: Sun, 26 Jul 2026 14:57:40 -0700
Message-ID: <20260726215740.34574-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace irq_of_parse_and_map() with platform_get_irq_optional() to
get the wake IRQ. This is a more portable approach that works with
both DT and non-DT platforms, and follows the modern platform API
conventions for optional IRQ resources.

The wake IRQ is now fetched earlier in the probe function alongside
the main IRQ, and the -EPROBE_DEFER case is handled properly before
the deferred probe can be triggered.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/mmc/host/omap_hsmmc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 58c881f2725b..4b5589157c59 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1764,7 +1764,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	struct mmc_host *mmc;
 	struct omap_hsmmc_host *host = NULL;
 	struct resource *res;
-	int ret, irq;
+	int ret, irq, wake_irq;
 	const struct of_device_id *match;
 	const struct omap_mmc_of_data *data;
 	void __iomem *base;
@@ -1792,6 +1792,11 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
+	wake_irq = platform_get_irq_optional(pdev, 1);
+	if (wake_irq == -EPROBE_DEFER)
+		return wake_irq;
+	wake_irq = max(wake_irq, 0);
+
 	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
@@ -1811,6 +1816,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	host->use_dma	= 1;
 	host->dma_ch	= -1;
 	host->irq	= irq;
+	host->wake_irq	= wake_irq;
 	host->mapbase	= res->start + pdata->reg_offset;
 	host->base	= base + pdata->reg_offset;
 	host->power_mode = MMC_POWER_OFF;
@@ -1820,9 +1826,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, host);
 
-	if (pdev->dev.of_node)
-		host->wake_irq = irq_of_parse_and_map(pdev->dev.of_node, 1);
-
 	mmc->ops	= &omap_hsmmc_ops;
 
 	mmc->f_min = OMAP_MMC_MIN_CLOCK;
-- 
2.55.0

