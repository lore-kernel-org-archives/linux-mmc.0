Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AC22BEC3A
	for <linux-mmc@vger.kernel.org>; Wed,  8 Oct 2025 04:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759897538; cv=none; b=aXB+YHFMOfLJjTBW9wet0Aqm8X2cX5umtk/n6dC/f73Ol6IGSYrxeUcP0F4CsKO9QtEPoFe3aNy9fX6RV4a+h6gsUBjP1t0Xol3T8EfPJN07B+RsifXIenuu9jxpYkaYfkQ9ZcPK+qG7qNgpIr2E0VhaMUmalcicfx5VyRF9elc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759897538; c=relaxed/simple;
	bh=3Ao8jjoBvZBqtIVC8MLuT4qJo/yZzdO/7FeFgmIHd4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ABbpnQDgmPX0gh+V8YzIo/fDt5FlVAjcq1CWImVEcCG2klKF7oa27CsLp52VS8+cruTjp/DSrLJPh/RoMyH8CSnxkiV7wEUph8TJzA0Yy7WAJMHRKTB8RhvZf9FanuuZk+r1Q+5/GsUPc7YbAG9IX2JauSYt5lU8v7gNhj5Q2uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=X981XozF; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="X981XozF"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b3da3b34950so925736866b.3
        for <linux-mmc@vger.kernel.org>; Tue, 07 Oct 2025 21:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1759897535; x=1760502335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krVPS+tcjWILrBEvMprlBs9nTWS64bL3aDSTEllEXZo=;
        b=X981XozFPtxiTvt1xFuIxbC3iJWYGlMjGGditmLOem2yclKeRZEd8bJ512jqpUwGOv
         p+MFnvovM7VBRueD/Yj+wyJ64CjceUQVnTnwLRnx0bWCm/F13vfawFgBreXVnihDNWte
         UinQLB42teI/y5fiu+h1V0SuM9qwFl5a9vtUUKWGw9d9kbYwgZnciCw5UYQq8PfxVSKZ
         njGYOJLOgjGEm0yABDWWPjOqBBbae29Yj+xkwjFm4OZKVTLCGmVw615znEWbvYv+BFQ5
         XbVFj8sT2aa2lJe2pBhwBUv9jRQYbynAQtJ6/LdGGE+tftMUZUOvkmZl6HzqebXc47gM
         oXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759897535; x=1760502335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=krVPS+tcjWILrBEvMprlBs9nTWS64bL3aDSTEllEXZo=;
        b=nzuyb6SHTYVmJYtw/NMnMgqFLMfypGpipg2KgVY2koUulnj1wE9gEYDLP0JsrIIx2v
         RIHQ24edDsnUciuQRrolPJMx2XZDP80eY86VrYxqBNzqJurr9z7zUI5y3VNL5Li9HjnD
         Z83iqmC2YotV9x11oN+aaqX7RYjIx7pmLxO/xeSuFeoNvNLM6h5xiDrePeTIOo1JQICU
         gkq/pxndPVE+x9QfGf+znjbu3NSqI2MIi0gdjWx2X8nbfVCLGEbGm6radRW43gPpwe2p
         zkFnuE0fyYDXk6g3OeIDmlkWgmM/j++ZCZfifWFNxFL0kETWVlbAyIYSUeJqbnRfU981
         I2yg==
X-Forwarded-Encrypted: i=1; AJvYcCVGjAIyfcwu5tx7BfJQQfBJ3pEnZDYhYxAlXN2DZWY1RNslKKjcb0BSUBPHNbcwMKMvCJGuPIKEDOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlB53ceKLDUY+8B4GFUmr1pWtTvUZe4BewTtw0kbfC0G1LFU0Z
	lZTAsgiGDb4a7+vZEvmROFKKp22ygSSbzgTzPpaJUVhRcLY233g/thI3sfwSh/MHGBo=
X-Gm-Gg: ASbGncsm8J9I8XffyIDn98E4FNUVrb4GiylpPeBImlnrSKRyScTMVXIL3jbD84G81v7
	zuc+6WTVjl8jAlGu/UPkayqrgzRaPEgzdDDl/XjKCTR6R4MbAlea7rb0osSy3DYwQ9QlCFlx6eb
	b4krUs+B7/Gy5D4/pvGEeWQIUdO77f8LlBd286WZVUhSMHuF/4ebe8ihi7WsW7yn+SbfoA69Uw7
	Z9kRPDW9Qot9Hbx3ivpEk3jOZyid7xeakhokzp0YsA7z671xfw5HATjmCoXPPl2pgx5dqqgkF2H
	DNn+dYZdN8eYF84y4dNJwJdDzulu/ELapu5IpECK6qGZP4t17Hu5y66Aqm/NXacaZXeynCRlyoj
	WkJTrZazjKh8hKVx9kA/wMfGU6QFYI9ReVmq7ecyic4Hm7ZT/6cUGQadbvvhrlAN8QswJ4K7fem
	s=
X-Google-Smtp-Source: AGHT+IEWNGUd2OZUlsC69nHjiF4VLGxKkwz/yIUFi5UKCe5EfHzFMpRTzUw4PGXAnxeWFWWemf2FfQ==
X-Received: by 2002:a17:907:948f:b0:b40:e7ee:b5ec with SMTP id a640c23a62f3a-b50ac6c92d4mr212093266b.59.1759897535287;
        Tue, 07 Oct 2025 21:25:35 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865e77427sm1583124466b.36.2025.10.07.21.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 21:25:34 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: wsa+renesas@sang-engineering.com,
	ulf.hansson@linaro.org,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 2/3] mmc: renesas_sdhi: Switch to SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() and pm_ptr()
Date: Wed,  8 Oct 2025 07:25:24 +0300
Message-ID: <20251008042526.3312597-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008042526.3312597-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251008042526.3312597-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

SET_SYSTEM_SLEEP_PM_OPS() and SET_RUNTIME_PM_OPS() are deprecated now
and require __maybe_unused protection against unused function warnings.
The usage of pm_ptr() and SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() allows
the compiler to see the functions, thus suppressing the warning. Thus
drop the __maybe_unused markings.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 11 +++++------
 drivers/mmc/host/tmio_mmc.h                   |  2 --
 drivers/mmc/host/tmio_mmc_core.c              |  2 --
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 9e3ed0bcddd6..7ceb7b977a0b 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -599,18 +599,17 @@ static int renesas_sdhi_internal_dmac_probe(struct platform_device *pdev)
 }
 
 static const struct dev_pm_ops renesas_sdhi_internal_dmac_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(tmio_mmc_host_runtime_suspend,
-			   tmio_mmc_host_runtime_resume,
-			   NULL)
+	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	RUNTIME_PM_OPS(tmio_mmc_host_runtime_suspend,
+		       tmio_mmc_host_runtime_resume,
+		       NULL)
 };
 
 static struct platform_driver renesas_internal_dmac_sdhi_driver = {
 	.driver		= {
 		.name	= "renesas_sdhi_internal_dmac",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-		.pm	= &renesas_sdhi_internal_dmac_dev_pm_ops,
+		.pm	= pm_ptr(&renesas_sdhi_internal_dmac_dev_pm_ops),
 		.of_match_table = renesas_sdhi_internal_dmac_of_match,
 	},
 	.probe		= renesas_sdhi_internal_dmac_probe,
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index c8cdb1c0722e..b9de03325c58 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -209,10 +209,8 @@ void tmio_mmc_enable_mmc_irqs(struct tmio_mmc_host *host, u32 i);
 void tmio_mmc_disable_mmc_irqs(struct tmio_mmc_host *host, u32 i);
 irqreturn_t tmio_mmc_irq(int irq, void *devid);
 
-#ifdef CONFIG_PM
 int tmio_mmc_host_runtime_suspend(struct device *dev);
 int tmio_mmc_host_runtime_resume(struct device *dev);
-#endif
 
 static inline u16 sd_ctrl_read16(struct tmio_mmc_host *host, int addr)
 {
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 775e0d9353d5..8be642f737c7 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1286,7 +1286,6 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
 }
 EXPORT_SYMBOL_GPL(tmio_mmc_host_remove);
 
-#ifdef CONFIG_PM
 static int tmio_mmc_clk_enable(struct tmio_mmc_host *host)
 {
 	if (!host->clk_enable)
@@ -1331,7 +1330,6 @@ int tmio_mmc_host_runtime_resume(struct device *dev)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tmio_mmc_host_runtime_resume);
-#endif
 
 MODULE_DESCRIPTION("TMIO MMC core driver");
 MODULE_LICENSE("GPL v2");
-- 
2.43.0

