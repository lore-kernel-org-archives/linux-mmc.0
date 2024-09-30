Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD565199250;
	Mon, 30 Sep 2024 22:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727736568; cv=none; b=VKKtwlt+/ER12MZPpINDOANN0sbR3BnXvXw5AOWfdQZZ9i6tfE1HgmymVcQJ39GFwQXpTGv0AzRLCWkXk54h6NgjO5PoqVmc3KdYCYuts8sucCggMXilySlSH4l5kzPAuC8kgUclpO6rPSQwuVtV4wp9cZZbfQBG9ag2AGSSV7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727736568; c=relaxed/simple;
	bh=Gq0meupMf4uNZynkIrN+2DXwDY4YMP79KPdl4VGKl7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=keHqxyrrlZi9WI4ktRp6OLe3L239uH1YMRlE9ePmSpoR8z6UUik53pcYkjXTe7mPueXK9mFgalqrhNxlpyVRVTaNQWBzGhXLVQPQVzS3UORDKI/C788lNI89IyOSL1558OoQ1PKeCZW+yKiaS/oV7g4ZS0bHt0N9z1aHOkzWEhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nV/n1isp; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nV/n1isp"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7198de684a7so3373203b3a.2;
        Mon, 30 Sep 2024 15:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727736566; x=1728341366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+VM5TZSFztMjLb3KAfFJRsMesVIdyYR2yr/sMtsQkw=;
        b=nV/n1ispH4SQ1Gomn/sodYQ5cNtz/IhRyYoe8yW/iIaZXHxl6UWJYg3PWiYPCdfznB
         nR+yQg+uSE0ZwYuuV/B3oOzyPLBYpW4NiP7sDJ1MiaReAF1E9bMQ6d/Vtxchfx5Q9rjM
         xaAO+JvGOzcETxXfI834bnLIstGTBB9NmmdmATuHJGh7ksvGCeVSC/o3pNbIuZvgF3zH
         cPgmSxWWTNrjKLQhqsPJ2pLaWnsEY3S+5VrHVTQWOvpOPsp5Tvf/3GT1SLPYJ6HeyPcs
         +SSMpvjIM4kKaXxQfrTKXZnp5/de1yodaVEtpmAZkGsCk4VTQCFppI+em+F7brzHtG6x
         zihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727736566; x=1728341366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+VM5TZSFztMjLb3KAfFJRsMesVIdyYR2yr/sMtsQkw=;
        b=L6ElCdHz2xXd2RAxrcuDWa96mbT8dPewZnGZrWT2hbypoULeqLi6g32oMxDfvfnBNj
         gfngAna2Cq1yPfnf8ep1RXg2KYm/OLaEI+r8Fnjlheve55xwF5GEMheHAp6mqcQugvL/
         UyvlOScbyyx12lfWZAUlB1QItdOSTrO7ddzFC5Qw1Sj7m6NWG3DvzGPQkbeRiyfURooP
         so2qnvgj0lN0lyL9ofx6DZRxiYqdyGk2lLsRjMJlA6q77iWaqX2iMyuOErgU2Iz+Pc/v
         eOzdA3CTwGC478Munanq/3LUfhphBDAQrLBJOoMkAcI9eyKudT1977rchx7feMj0AVjn
         RXFw==
X-Forwarded-Encrypted: i=1; AJvYcCU9KRlHOXFgFzjehJfyjedfPvLWrB0xbNW1lClqKt0yVu4W4P/CApQwISjFQEnI1TBXaDFARxU7l2Dd/So=@vger.kernel.org
X-Gm-Message-State: AOJu0YxITHNkyxUZINOCI/4TqSrboAu9ZE7VlgHGXZZS7KqSJpK8IbUN
	RcAKwy2MSvyJTTA4kyu8RzdkYOnLxEgZnxtZxGFMRzP8wgIBneQAxphwWGoS
X-Google-Smtp-Source: AGHT+IHB+v9R3OPGcEtIwwUWx+aIIBEO/ORAGhDYlWynhw4/iVHFD/CvPXAdYHoa+7TwSGXOYGMmSQ==
X-Received: by 2002:a05:6300:4041:b0:1cf:3a0a:ae45 with SMTP id adf61e73a8af0-1d4fa7ae36emr22105311637.35.1727736566076;
        Mon, 30 Sep 2024 15:49:26 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db2b391bsm7029528a12.22.2024.09.30.15.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 15:49:25 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Chaotian Jing <chaotian.jing@mediatek.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCH 3/3] mmc: mtk-sd: fix devm_clk_get_optional usage
Date: Mon, 30 Sep 2024 15:49:19 -0700
Message-ID: <20240930224919.355359-4-rosenp@gmail.com>
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

This already returns NULL when not found. However, it can return
EPROBE_DEFER and should thus return here.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/mmc/host/mtk-sd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 4be13b9c2d71..b02cbae96e89 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2769,9 +2769,8 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	if (!(mmc->caps2 & MMC_CAP2_NO_MMC)) {
 		host->crypto_clk = devm_clk_get_optional(&pdev->dev, "crypto");
 		if (IS_ERR(host->crypto_clk))
-			host->crypto_clk = NULL;
-		else
-			mmc->caps2 |= MMC_CAP2_CRYPTO;
+			return PTR_ERR(host->crypto_clk);
+		mmc->caps2 |= MMC_CAP2_CRYPTO;
 	}
 
 	host->irq = platform_get_irq(pdev, 0);
-- 
2.46.2

