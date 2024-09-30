Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8144218C925;
	Mon, 30 Sep 2024 22:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727736566; cv=none; b=RgyFR96nDzVlKcL8qaTJVE7V1xx7yIvS+RUa3UH/37LcPh4NY8EIIK2FeenB9K7ld9grymxS8aPZSwbDTBPirTAHdE8CdmZDtQnhM4wunzbwB8o3sqsmBifQIjRd7JM+SVsNm0fxdPlO9anvYLvuwTvj9B3gS7ekOxWhPA6L1dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727736566; c=relaxed/simple;
	bh=3Ga0pMcYTazUGfOy5XosUE5WnrMAU2JB2bWuVVb68j8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FeOdLje+t173ogV7so7ZD+LKoMBt2GTNFLxEsLkjSywDotCTfLMwG1QilY9GemXBejIQ144dmrTb14EScxauPsQIfKntguO3qnjdCQSBmbhXJn1PNRaq4Jw9NzmM12TIIpvnb0S/9cCB6sZQK8RKSu0ecDkfep0uTp7Ly0+mgs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ManilrdF; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ManilrdF"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-718e6299191so2588514b3a.2;
        Mon, 30 Sep 2024 15:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727736564; x=1728341364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0LZHtqzBnIuZo9WgI5XN+fZbaiOF80rdjBOKI8JpkM=;
        b=ManilrdFR6J0GdgnKB73TpUhTVNEd3qCddXfKkhBXVW18P23HUkVr5ypMGMiV3Vdlg
         T08dxK5qHU+1TiqR5XqlU8D4O+GIKb/Q90SuU1gBMt6AjQYpbejDPknCjni0+OC6DhjA
         RxXdSy/OY7navmTzP76D1pqzSJJYhTwl0Mu6eGdqWOp3c6iyDGKG0pH4WK2h3fbv2dRk
         Zf+Z8aRD0pslDkK1AENbQ61HhMEPh7o1D5wS0lzEz9yEsQDhtpoxu3MjIGy1qeTo6D2b
         nOydNhv0wtp7GCUG9s7+Rf9TBfHr4TXMm2msckIXzOpOkr0hido4PiqL9PFzFN14mEnp
         EwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727736564; x=1728341364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V0LZHtqzBnIuZo9WgI5XN+fZbaiOF80rdjBOKI8JpkM=;
        b=kBev/kJAJzrhqLDpxfZZyeWy1/umDXGCn9Qfbs8gN6zVQWF1CPgH++9E/f61id0gI3
         FFUYFSKpcHjPxAffE4mbhn1PMy4ITqcT4V/LNe/kpnRjxLqBKtugCLPNPDRPmqJEIQOK
         v152sy45aUdcOEDEhVmHSnoD+ui95uskZeaCF5tY91itqktFRoOmt89WoCU+tNwyWv0+
         KNqEwxtcMlBB/aTFTMG+wOEoTrfHU9pLEEPJDbJ3T0LM3nbym8xCNjABotnCPQCGdLc8
         UNf9n4cSxjIJSSC03qlmxmm6mURfeEBJVPmv3tHOoZlupnKh7J8sX9/w1qUXucDXqqF/
         uP6w==
X-Forwarded-Encrypted: i=1; AJvYcCUS+Anpe78fhZE41Ef/EkwMiiQvp15Bhvrz/tgAA8LXFvmR9G0vOIcFf9csoxCN7JTM3aC6gTy4SQrc7js=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw+veskMJePY9lFfuAOUeZnqsRW8z0DxjjSZRKAn25n2c+fBdI
	aEESlA5twqNAsKuD+7EghhnkA2xMwNYpYbvYJuof2kxL1vfC0tw7GoZUp95i
X-Google-Smtp-Source: AGHT+IF6EvgE3gl8ueVWIB0I3k9SSFxraUPAgWsvgxyqSPIjf5c8FhCRNnG4kbQalUudlk0nUl/+bQ==
X-Received: by 2002:a05:6a20:d48b:b0:1cf:4ad8:83b9 with SMTP id adf61e73a8af0-1d4fa7dfa7amr21216746637.43.1727736564582;
        Mon, 30 Sep 2024 15:49:24 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db2b391bsm7029528a12.22.2024.09.30.15.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 15:49:24 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Chaotian Jing <chaotian.jing@mediatek.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCH 2/3] mmc: mtd-sd: use devm_platform_ioremap_resource
Date: Mon, 30 Sep 2024 15:49:18 -0700
Message-ID: <20240930224919.355359-3-rosenp@gmail.com>
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

My guess is some automated tool missed this transformation. Now looks
clearer as do what's happening. Also allows removal of struct resource.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/mmc/host/mtk-sd.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index c607312dfe07..4be13b9c2d71 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2727,7 +2727,6 @@ static int msdc_drv_probe(struct platform_device *pdev)
 {
 	struct mmc_host *mmc;
 	struct msdc_host *host;
-	struct resource *res;
 	int ret;
 
 	if (!pdev->dev.of_node) {
@@ -2749,12 +2748,9 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	if (IS_ERR(host->base))
 		return PTR_ERR(host->base);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (res) {
-		host->top_base = devm_ioremap_resource(&pdev->dev, res);
-		if (IS_ERR(host->top_base))
-			host->top_base = NULL;
-	}
+	host->top_base = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(host->top_base))
+		host->top_base = NULL;
 
 	ret = mmc_regulator_get_supply(mmc);
 	if (ret)
-- 
2.46.2

