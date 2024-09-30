Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD990184527;
	Mon, 30 Sep 2024 22:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727736565; cv=none; b=HVpUbhxrIxbdLmc3rgy9Hj2t10aS9r64hLtAA3GhF36RChA5v6+TOUNgYdGCgpV5l67TqL/D7KTeXmZiJrFodXP/e2r2V98SMR+RjDCJPHNZl6X8RRGTWzoROB7lDXcv/yjG6OeQipWuj1fT+Yhg9DnbAtoQB8QnSDXQMPxT+XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727736565; c=relaxed/simple;
	bh=7beLImfiluII2Fa9nkM9GIIxG++SJvby8fZ0yUcC9eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZJC4LXJzg6HSldoZy5eaYI5PWyc4Kb8mj6sVGLea3g5y7fJQdL58G0t9JuTQV5B6wrR2TAjMuXYAC9CUE6VFKtobzbO/fywdugUliXoy+qgLkXiJ9yBBB5W8M45G59sVB8VyF5HcZhhefvgTXXvhmYATO2SlmU0DNDxu2EzJYLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTP1cYkX; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTP1cYkX"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7db4c1a54easo3068021a12.1;
        Mon, 30 Sep 2024 15:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727736563; x=1728341363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skvYEbeiJmt7JWU7QhjcNmw9hjLxF9pjRq94Mk/8yjI=;
        b=ZTP1cYkXmpoeZnz4XewQqJYv9ncXUDUnLWWgH1W8lxaAl9v5ySvkYKsBsasbVD9pzW
         yJXuMaPDlcgA5VAmauOUVU+Fa3i+H83TJmOPA7CR4C6Np3rRW+KMgLmc9SFYuUan9NTW
         WWJ3MQOQIwBGeB6QTIJ/RzZPhkmgZc4iuGsGhWvnT5/nV0p3xOBQS3lgE6gkgKUgzLRM
         gEBSLOhz+FEZEe2iym/5wGRf3Pr/wTVyxJz06tz5xmIy3ZhcLC+LUBWB5Qlr2qvAITnL
         Usr7py0TfcMLlNmccgdNY38vAtHFXnd/doJNfw42qDwjSQrLNxH1ZHCrb9zGV52N6Bgi
         rCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727736563; x=1728341363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=skvYEbeiJmt7JWU7QhjcNmw9hjLxF9pjRq94Mk/8yjI=;
        b=PnCG6uGX3A/NBJvfJY2gh2+0EuartyQ3w+s2szK62jtwmumMiMSoGnaG6LClT3OXGD
         gJVudAURjSxIkChGR3zt28/KIyuzj9uud4itIwSizGso5QTUsRr0rQGhbCisvFPmH6wG
         ri9lfRIqPZF3mWR10rwVJoq+5HaY0IHfDHzb5tk7JaMhK0B+iEUImG8W9n/nr+pbF3DI
         wHtpJR2cW2tGqdKsRZDbHKk3O9DsBqxqRfJ9XdCzU0YuNBNdCRcvcxIFjuxy7L4WTkBn
         CZdFqkqN8ODy0np7ARdjYJCmQ4SrrNLT1muzhUXw9v5AqOMqV5G7UNKAqft4BEn/ElKO
         Emww==
X-Forwarded-Encrypted: i=1; AJvYcCU/fZ2WPP/BneZK6XFPb1D6ZWa1GAcnsocavZMdfbW8+3+m2HihzYKqUuMd7ZbWYmY/2VaqJBCke718dHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0rmNwIeSZovwaVEkGwTEZy7Vl/n9sjJqoyflnkQ3lr6TmPx1W
	sAB25vmtbmGgM7fRS7bwTF23vnCO2fB3naC0YJQbaJO/idaEJLYIyG8NHzMy
X-Google-Smtp-Source: AGHT+IF/baAIksfObpO4d/Xeo/VELBA77lvmXKRc0oDEsxehbkabpfd0djPIxu6XGEybAlbj2bEx1Q==
X-Received: by 2002:a05:6a20:e188:b0:1d2:e78d:214a with SMTP id adf61e73a8af0-1d4fa7d0f19mr19113109637.44.1727736563173;
        Mon, 30 Sep 2024 15:49:23 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db2b391bsm7029528a12.22.2024.09.30.15.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 15:49:22 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Chaotian Jing <chaotian.jing@mediatek.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCH 1/3] mmc: mtk-sd: use devm_mmc_alloc_host
Date: Mon, 30 Sep 2024 15:49:17 -0700
Message-ID: <20240930224919.355359-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930224919.355359-1-rosenp@gmail.com>
References: <20240930224919.355359-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows removing several gotos.

Also fixed some wrong ones.

Added dev_err_probe where EPROBE_DEFER is possible.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/mmc/host/mtk-sd.c | 55 ++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 35 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 89018b6c97b9..c607312dfe07 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2736,20 +2736,18 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	}
 
 	/* Allocate MMC host for this device */
-	mmc = mmc_alloc_host(sizeof(struct msdc_host), &pdev->dev);
+	mmc = devm_mmc_alloc_host(&pdev->dev, sizeof(struct msdc_host));
 	if (!mmc)
 		return -ENOMEM;
 
 	host = mmc_priv(mmc);
 	ret = mmc_of_parse(mmc);
 	if (ret)
-		goto host_free;
+		return ret;
 
 	host->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(host->base)) {
-		ret = PTR_ERR(host->base);
-		goto host_free;
-	}
+	if (IS_ERR(host->base))
+		return PTR_ERR(host->base);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	if (res) {
@@ -2760,18 +2758,16 @@ static int msdc_drv_probe(struct platform_device *pdev)
 
 	ret = mmc_regulator_get_supply(mmc);
 	if (ret)
-		goto host_free;
+		return ret;
 
 	ret = msdc_of_clock_parse(pdev, host);
 	if (ret)
-		goto host_free;
+		return ret;
 
 	host->reset = devm_reset_control_get_optional_exclusive(&pdev->dev,
 								"hrst");
-	if (IS_ERR(host->reset)) {
-		ret = PTR_ERR(host->reset);
-		goto host_free;
-	}
+	if (IS_ERR(host->reset))
+		return PTR_ERR(host->reset);
 
 	/* only eMMC has crypto property */
 	if (!(mmc->caps2 & MMC_CAP2_NO_MMC)) {
@@ -2783,30 +2779,24 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	}
 
 	host->irq = platform_get_irq(pdev, 0);
-	if (host->irq < 0) {
-		ret = host->irq;
-		goto host_free;
-	}
+	if (host->irq < 0)
+		return host->irq;
 
 	host->pinctrl = devm_pinctrl_get(&pdev->dev);
-	if (IS_ERR(host->pinctrl)) {
-		ret = PTR_ERR(host->pinctrl);
-		dev_err(&pdev->dev, "Cannot find pinctrl!\n");
-		goto host_free;
-	}
+	if (IS_ERR(host->pinctrl))
+		return dev_err_probe(&pdev->dev, PTR_ERR(host->pinctrl),
+				     "Cannot find pinctrl");
 
 	host->pins_default = pinctrl_lookup_state(host->pinctrl, "default");
 	if (IS_ERR(host->pins_default)) {
-		ret = PTR_ERR(host->pins_default);
 		dev_err(&pdev->dev, "Cannot find pinctrl default!\n");
-		goto host_free;
+		return PTR_ERR(host->pins_default);
 	}
 
 	host->pins_uhs = pinctrl_lookup_state(host->pinctrl, "state_uhs");
 	if (IS_ERR(host->pins_uhs)) {
-		ret = PTR_ERR(host->pins_uhs);
 		dev_err(&pdev->dev, "Cannot find pinctrl uhs!\n");
-		goto host_free;
+		return PTR_ERR(host->pins_uhs);
 	}
 
 	/* Support for SDIO eint irq ? */
@@ -2895,14 +2885,14 @@ static int msdc_drv_probe(struct platform_device *pdev)
 					     GFP_KERNEL);
 		if (!host->cq_host) {
 			ret = -ENOMEM;
-			goto host_free;
+			goto release_mem;
 		}
 		host->cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
 		host->cq_host->mmio = host->base + 0x800;
 		host->cq_host->ops = &msdc_cmdq_ops;
 		ret = cqhci_init(host->cq_host, mmc, true);
 		if (ret)
-			goto host_free;
+			goto release_mem;
 		mmc->max_segs = 128;
 		/* cqhci 16bit length */
 		/* 0 size, means 65536 so we don't have to -1 here */
@@ -2939,11 +2929,8 @@ static int msdc_drv_probe(struct platform_device *pdev)
 			host->dma.gpd, host->dma.gpd_addr);
 	if (host->dma.bd)
 		dma_free_coherent(&pdev->dev,
-			MAX_BD_NUM * sizeof(struct mt_bdma_desc),
-			host->dma.bd, host->dma.bd_addr);
-host_free:
-	mmc_free_host(mmc);
-
+				  MAX_BD_NUM * sizeof(struct mt_bdma_desc),
+				  host->dma.bd, host->dma.bd_addr);
 	return ret;
 }
 
@@ -2968,9 +2955,7 @@ static void msdc_drv_remove(struct platform_device *pdev)
 			2 * sizeof(struct mt_gpdma_desc),
 			host->dma.gpd, host->dma.gpd_addr);
 	dma_free_coherent(&pdev->dev, MAX_BD_NUM * sizeof(struct mt_bdma_desc),
-			host->dma.bd, host->dma.bd_addr);
-
-	mmc_free_host(mmc);
+			  host->dma.bd, host->dma.bd_addr);
 }
 
 static void msdc_save_reg(struct msdc_host *host)
-- 
2.46.2

