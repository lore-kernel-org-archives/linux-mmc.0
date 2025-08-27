Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE96341ACC
	for <linux-mmc@vger.kernel.org>; Wed, 27 Aug 2025 10:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756289568; cv=none; b=KngO2rRODVofnjsFMIs2gBLYySIXwfeVtzQIYeRe05jYzLg3SSCSkSi3WssXIXKzJyFVJDYQn+FwhbI4wPl6Rhz4O8a2Hzvg0HQ7Cj7zlPE/hqTvGRYOwmv7ELHpdNZqLwjRPx+himJHNJ4RAh6nt3DjBA10HZBTO9kpABp9ht8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756289568; c=relaxed/simple;
	bh=bY5WwNBO5PYBaHej1taD178LBagbsiubDKZnbEwku/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZKMdaVuWLr03Fihoyuy7fRHk1wNF0Kln48VNOEQbiCRduId1nEHLroX8u44mO/k/C5lM71BqXCvWwW5JC5RaMBMavV57jahyS6JZPGvtlcD8XsUHJt4oMng2xRUqE03TOIOB6r6AIaUN3fhMGn/UWTP/5/1zrmy6QCYgxc+LpuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=AUHUz7qX; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="AUHUz7qX"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3c763484ccdso446131f8f.0
        for <linux-mmc@vger.kernel.org>; Wed, 27 Aug 2025 03:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1756289565; x=1756894365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zFRtIOMOlVt9quw+Zl7Xq2CuHJgjIAx5v9rbJeyHOIg=;
        b=AUHUz7qX7k3OX0FZaTiedX7VsKw0X5XwyxbfliHkg/LAQ49166TDpNXFSIK7MraP/1
         ECSVtWudeDId513sLEUyzTlyGV2Pn+vFPNaMTLVvaUcZwkDFoB8v17CzYfgik+BP/KNM
         7MyUzt2C/6WutCG6Wg8KiwvNTYJNo7rYmJvFk4A6GGtAvXuh9kdoB6McwNb06+k7ojoi
         niydO3bp+vazgasMMQTvt7GUGRn0HC0lb84cjrq5iwtjkezy7kGy6KT6kTV36lcJzNPN
         cyF5+RBdHGLgOKP432e83Rgqbbg5B8DzJKikMqkz/CXUODWmpwLuOO6AkMaGVctDgbYT
         0MoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756289565; x=1756894365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zFRtIOMOlVt9quw+Zl7Xq2CuHJgjIAx5v9rbJeyHOIg=;
        b=PUia2opX5YEMK5hx/1MJdlDXvnlLZ4LjWlAsOw4/7JH3GfJRonJmuMdGu03I6BMnVJ
         kyBz0q1ODICGhD3+MbyHxzvOGfgVcG9PtPmM8hMnowFPmIWhNPYgpCcUu4fUaskZ9USV
         H30sYNtnP5cS9sHmWX9llyAw2gnvfqKRsomn42sXhPaJsqxnitv3NZQrC4BIVhrXpGaz
         vDoVOmJ9IUT3/Oupa1uhXxW2JKtF7IMCGiXgehb3AP1owybQIyMscWRm+LDSXCPgyB5a
         FcO6pXKpLG4VDiZd6j0nNbWdAlFPo9uIwmAIuNFPtd3AoM5ggoyfZwmJcm5fu6oEkpQ4
         IbxA==
X-Forwarded-Encrypted: i=1; AJvYcCUd1GBXS5KnxNP4pXEB2QJXnI5LNRLI4EYJbvp8nOmQdUnaLYX2KGRJhpSEiClhEEncYixKEhClrEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUYjekFjNy2EPHp88QxPFSwYpekk3PL14ZlaO+bo6ZBtMIkVoX
	2dkcMIKBNX13OJmhr56ZrqNX0bk1p1LC3OzU4r9T5Kvv/GntI95TQ7yLRPPSE0XNvOA=
X-Gm-Gg: ASbGncvCtsABIvWcT6J1PMCbGZ6RmSwxOtkKD2GqntrE4xB/s7x50PCTFx1NABqLic9
	3Yje0eR3dj1cW1P3hw8/a/PWbovpjbKeWtOM4jf3ltdFAuBSQtHAAtLZEih0N4bK78NglzxE5Fj
	va6YOhlaklXUczIQnzOhR9iKhHyO+U+eG50H9FFwBghZ/QLDjo/JSG8T9Io1KxdEVxPn6P4XwBc
	2/BCmaW/LtU70D9T70Qwlr0vvs2mAQlbnZTkEZqJ/mGJ0Q7ZEh4uXAivEn0K7qqOu297PZAvZpJ
	geOkDJnKknuRbO/o5QnswK/J+Wt5Ofy9KQw0M6ORHt4t+sSM3Bq1rYFvfvUXRtgQKevM5nMpnIJ
	Mtt7dOONWKRd9uhbKzBYIbLXnjFuXzPsKEFHN2LoLI+cDqgLKhfOS16dqt+SpkxzTS5HZYRzVxX
	4nWmPzfw==
X-Google-Smtp-Source: AGHT+IFzs67UoFo90c1/HL7nb+kD26OHdiYBdB60ODimSjNKeSnFTxsbkfwxtdbIw0bNW/Jnt6XESg==
X-Received: by 2002:a05:6000:2381:b0:3c2:e033:3994 with SMTP id ffacd0b85a97d-3cbb15cbc3emr3992816f8f.26.1756289564746;
        Wed, 27 Aug 2025 03:12:44 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6103:4200:a5a4:15e6:5b6a:a96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cc890b178bsm2695660f8f.52.2025.08.27.03.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 03:12:44 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: ulf.hansson@linaro.org,
	mathieu.poirier@linaro.org,
	rafael.j.wysocki@intel.com,
	wsa+renesas@sang-engineering.com,
	rafael@kernel.org
Cc: claudiu.beznea@tuxon.dev,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH] mmc: sdio: Drop dev_pm_domain_detach() call
Date: Wed, 27 Aug 2025 13:12:36 +0300
Message-ID: <20250827101236.927313-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Starting with commit f99508074e78 ("PM: domains: Detach on
device_unbind_cleanup()"), there is no longer a need to call
dev_pm_domain_detach() in the bus remove function. The
device_unbind_cleanup() function now handles this to avoid
invoking devres cleanup handlers while the PM domain is
powered off, which could otherwise lead to failures as
described in the above-mentioned commit.

Drop the explicit dev_pm_domain_detach() call and rely instead
on the flags passed to dev_pm_domain_attach() to power off the
domain.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/mmc/core/sdio_bus.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 656601754966..10799772494a 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -200,7 +200,6 @@ static int sdio_bus_probe(struct device *dev)
 	atomic_dec(&func->card->sdio_funcs_probed);
 	if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
 		pm_runtime_put_noidle(dev);
-	dev_pm_domain_detach(dev, false);
 	return ret;
 }
 
@@ -231,8 +230,6 @@ static void sdio_bus_remove(struct device *dev)
 	/* Then undo the runtime PM settings in sdio_bus_probe() */
 	if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
 		pm_runtime_put_sync(dev);
-
-	dev_pm_domain_detach(dev, false);
 }
 
 static const struct dev_pm_ops sdio_bus_pm_ops = {
-- 
2.43.0

