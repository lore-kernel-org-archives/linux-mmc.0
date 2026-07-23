Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CA64570ED
	for <linux-mmc@vger.kernel.org>; Thu, 23 Jul 2026 15:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784819455; cv=none; b=CSByGuWrOuSOUutOhzBY0jFxghrzsyyCaZePcbpc8FFgjLhKXL98ATqGGT3fO0HzMgI/EfjuiNxbxqpWI60LEd3hVbDpx2vZglsSe+pgfAKDbwTZtjrPlQTdGTzjjSUzg6ScqBhfXIIN4orzWTKIfu42nswGPuthZT30iQb0DQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784819455; c=relaxed/simple;
	bh=TDnNhsZCsOjMY2p9gRI5oZYVtNC+ieEcnjl+s0uQiZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3gzWQV1hBSr7TtJH8Lpd56k62w5lJY9lnU8zKuwH0FP8COiJL7wtSpnaw+r5EKxZjy/JLItTAhtA4+EbLbZG4NpizhmIFC4FRikkl/jtdVwqL23N6p0nkW/BiU10ZQOSt5IXPaD+JwrbwHNsQHBZ5DbEdncNBFbVGkUM/mlfCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edCeUIjK; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edCeUIjK"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47ddf7b09aaso525548f8f.3
        for <linux-mmc@vger.kernel.org>; Thu, 23 Jul 2026 08:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784819434; x=1785424234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yd4EqDzsPzJqXPT51e5I52t0lUhvJ2cMaJqJVuffjUQ=;
        b=edCeUIjKz7IriNqdVw1rLBayjEBQ5RWKK3ELGiuQSmoQLtkKDME8oI/hi13wfp9BO9
         f4W4Wa7TqEyszXNnZEeeQHEXGkwv8q4y15nDkdbK+11XjpGiJXN0bvIzoKZYnqb6jb6M
         Rq3A1yIp62rbRPjwEVPKMQtu6dH6MoQ3705sPdR3BBKfzZXTcrpatMFMmD47ANU46Y9M
         FUqdnEiack1EjG7y4/RD/IZ4lZd/oplxEUt0h/g21qLTbfSYzZMfg/SeI4UVOphznYNb
         eMI8hOMT8iloH5VcObGZkTcqjgjznjTWGT9c+StqZX0M+Y9E8VW3ZHVvU2+m1qtMdncR
         4hMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784819434; x=1785424234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yd4EqDzsPzJqXPT51e5I52t0lUhvJ2cMaJqJVuffjUQ=;
        b=O2nHGlQpce007U6pLbi8hRgHRyXzt13pjdryEkFa0F6srP/6FFTn0ksWowA3QGUOc2
         /z2e/FJ3C30Iy2E9Wu4xM/PQ3uxfDwXqXA3ifXsDbN2pLFHwawnV3/j7y9hxJxTCrttv
         EeSvBD+wLRDk8qdLNp8vHEgFiip5hdMrecuZ+2oZfTj20s3DAE9v+Yf8I93e+yuEGFOy
         jiUI60ziuJZEHJZPlmsZn08HBHpYLAJqqT/6pqNDSyMx0Kf4dZVLd04W9WtbFPj42WTN
         CmSDjtzTECrEZEcKZIKyu95Z6e+xFqh4E4cyKN2/gqk1hYvmqwTCEN1fKIZ5xAijeZL6
         /Hlw==
X-Forwarded-Encrypted: i=1; AHgh+RrTOUuK5O/atsR1BmrWflkszGYL+buRgadLLOZgt81xnD50mqPh38ULA8dRv6E/+myeREZnixTOEg8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh9B7nzck0NadRNWmM10M+8CiGbex8mfWDwJrCoVcgLBrkjRpD
	SfzO+V/ulTSlf6VTEbQB9IDKSuvlEOXAmAjYEHsFuoHRO9WoB3t3U9un
X-Gm-Gg: AR+sD12yDU8sf2CFzaLlLIbV4AXRV/37n9gT8Cayf5RfSfQEbdNdcWyDJHwPjGoFJJL
	EnDh/wkd1VumLJUBJ/d2VjPmLXH65LVovMTnS4LRZ/a0dvT+1UjU+4bDS7+SMDMmm7M8MAbairA
	YxAyyaOtHKHAD4dpKA2PWHcb94GMWZc8ihgK2GcGcgVSXrhMXKKE6c08KV3asplbCzaqKKHK6uf
	ZwGMo8H/KODHuVDbn0jA+P3bZNUXgzdwinlSRGn7/3jniijgPYKtDxCkEB8qhmUdS10y/xw05lx
	Rux/6Okf6K3KiUGpKySFW9dT2cePDnfRdmO2T6qdBX/ZNkRiLYjSa9rL/R3wPqpjAbFCMhUKRgC
	cbKSljTlfDB/dT876Kz99mMzWCEE3nW4jpIbLwpnSa42TgAsJx81bC6PGhwz+X8ZgwI2AycGydC
	RlA/fb5HCpbZBUxifBLZUkJ6Se7QOR7+U5ucp7dA==
X-Received: by 2002:a5d:64e6:0:b0:47f:80d1:be1d with SMTP id ffacd0b85a97d-47f8d4b8c3cmr4868180f8f.0.1784819434240;
        Thu, 23 Jul 2026 08:10:34 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:f073:32ed:a057:cd3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb81dcsm15886823f8f.12.2026.07.23.08.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 08:10:33 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v22 08/13] mmc: renesas_sdhi: Add optional axis/axim reset controls
Date: Thu, 23 Jul 2026 16:10:12 +0100
Message-ID: <20260723151024.318918-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723151024.318918-1-biju.das.jz@bp.renesas.com>
References: <20260723151024.318918-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The RZ/G3L SoC has axis/axim resets compared to other SoCs.

Add two optional reset controls, rstc_axis and rstc_axim, to the
renesas_sdhi struct. Both are acquired at probe time using
devm_reset_control_get_optional_exclusive_deasserted() with the
"axis" and "axim" reset names respectively.

Include them alongside the existing rstc in bulk reset/assert/deassert
operations: triggered together in renesas_sdhi_reset(), and managed
via reset_control_bulk_assert/deassert() in the suspend and resume
paths, replacing the previous single-control calls.

Being optional, these resets are a no-op on platforms that do not
provide them, so existing behaviour is preserved.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v21->v22:
 * No change.
v20->v21:
 * No change.
v19->v20:
 * Fixed the ordering of resets in suspend/resume paths.
V18->v19:
 * No change.
v17->v18:
 * Fixed ordering of reset in renesas_sdhi_reset().
v1->v17:
 * No change.
---
 drivers/mmc/host/renesas_sdhi.h      |  2 ++
 drivers/mmc/host/renesas_sdhi_core.c | 26 +++++++++++++++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index db147af9068c..a085a4cb2e38 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -101,6 +101,8 @@ struct renesas_sdhi {
 	unsigned int tap_set;
 
 	struct reset_control *rstc;
+	struct reset_control *rstc_axis;
+	struct reset_control *rstc_axim;
 	struct tmio_mmc_host *host;
 	struct regulator_dev *rdev;
 };
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 638bbc990096..6d8f32e2fc38 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -641,6 +641,8 @@ static void renesas_sdhi_reset(struct tmio_mmc_host *host, bool preserve)
 				sd_status = sd_ctrl_read32(host, CTL_SD_STATUS);
 
 			reset_control_reset(priv->rstc);
+			reset_control_reset(priv->rstc_axim);
+			reset_control_reset(priv->rstc_axis);
 			/* Unknown why but without polling reset status, it will hang */
 			read_poll_timeout(reset_control_status, ret, ret == 0, 1, 100,
 					  false, priv->rstc);
@@ -1155,6 +1157,14 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	if (IS_ERR(priv->rstc))
 		return PTR_ERR(priv->rstc);
 
+	priv->rstc_axim = devm_reset_control_get_optional_exclusive_deasserted(&pdev->dev, "axim");
+	if (IS_ERR(priv->rstc_axim))
+		return PTR_ERR(priv->rstc_axim);
+
+	priv->rstc_axis = devm_reset_control_get_optional_exclusive_deasserted(&pdev->dev, "axis");
+	if (IS_ERR(priv->rstc_axis))
+		return PTR_ERR(priv->rstc_axis);
+
 	priv->pinctrl = devm_pinctrl_get(&pdev->dev);
 	if (!IS_ERR(priv->pinctrl)) {
 		priv->pins_default = pinctrl_lookup_state(priv->pinctrl,
@@ -1384,13 +1394,18 @@ int renesas_sdhi_suspend(struct device *dev)
 {
 	struct tmio_mmc_host *host = dev_get_drvdata(dev);
 	struct renesas_sdhi *priv = host_to_priv(host);
+	struct reset_control_bulk_data resets[] = {
+		{ .rstc = priv->rstc_axis },
+		{ .rstc = priv->rstc_axim },
+		{ .rstc = priv->rstc },
+	};
 	int ret;
 
 	ret = pm_runtime_force_suspend(dev);
 	if (ret)
 		return ret;
 
-	ret = reset_control_assert(priv->rstc);
+	ret = reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
 	if (ret)
 		pm_runtime_force_resume(dev);
 
@@ -1402,15 +1417,20 @@ int renesas_sdhi_resume(struct device *dev)
 {
 	struct tmio_mmc_host *host = dev_get_drvdata(dev);
 	struct renesas_sdhi *priv = host_to_priv(host);
+	struct reset_control_bulk_data resets[] = {
+		{ .rstc = priv->rstc_axis },
+		{ .rstc = priv->rstc_axim },
+		{ .rstc = priv->rstc },
+	};
 	int ret;
 
-	ret = reset_control_deassert(priv->rstc);
+	ret = reset_control_bulk_deassert(ARRAY_SIZE(resets), resets);
 	if (ret)
 		return ret;
 
 	ret = pm_runtime_force_resume(dev);
 	if (ret)
-		reset_control_assert(priv->rstc);
+		reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
 
 	return ret;
 }
-- 
2.43.0

