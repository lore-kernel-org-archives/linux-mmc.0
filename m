Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E0B3C945B
	for <linux-mmc@vger.kernel.org>; Thu,  9 Jul 2026 19:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783625368; cv=none; b=Ts+JFZnZBtHcT54WnhBkZwkXUyNJewbJQtP/sYGa+q1ejaK+9/qDaAm9YLlWw3POoTnGBk9++mIpzVmpIhYQr9Pr35Iu6Cjnnz68/G+Pxw2sgbqRe6m5/57/mBmXBhwL9h7wiiRTnB6pN/vFLAk7dUHYEvGjDTU0QAwNJTxWk/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783625368; c=relaxed/simple;
	bh=Wn4Q3EZ1aFHKfu8Y1hBRWVblqN3RQEiYCtG3Y1MjM+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JbN+ChgC4nEw0Brmv0Fo5AMYIopzW7RJN/63iKPcOqkz6wVl87/VL+eyX2Am2OXwyWlPR8xefr4KJbyYXKxd8BNRUENzHZjEWIKDAFvQErDL4K/2jTVzQcBzCsDHu1uer6mKJWXuyVUkX9AbCaG2UXFoVpFJZ/k9PqhAzkJtKXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAwCHN6T; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAwCHN6T"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493f0ae9572so597485e9.3
        for <linux-mmc@vger.kernel.org>; Thu, 09 Jul 2026 12:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783625364; x=1784230164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lA+pI55huEOc5hP5X5/iANo9UgMcNey8WP6aeqwaoLg=;
        b=nAwCHN6TZI+kBlR8QSyTeRj8rKGbNDgCfAkQuK+VB9MeC5LcGopev8v6v7ZNuF9Fyw
         2vfr7g8hf3yHOCT9X05JX4k0IS7YX1XPKoU5Dp0s3yBCyfM9VQll10/a4cDtYdpdgYzq
         vfDsFT45XkoX3aeAwo3KCiaqeZ1HTD8PiB/+M8vSpevP0K7/KIwWevthH/Tj+QnbdrKy
         4Fbkb3o2OUUVmzbUQf8Zxu2qa3Js4mIAL3TtPuDlPLvB1RWsklq6efeu40AlEMlZkk0O
         yYh/iAr2rLut99L7a7qlWGn1nz7ju0lrR4kxyFJ2ewKqFXOebpTRPEHg2H9+4acg2DsJ
         Vpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783625364; x=1784230164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lA+pI55huEOc5hP5X5/iANo9UgMcNey8WP6aeqwaoLg=;
        b=RH65DnfmTUj+00XUg2Rtsl1TX5UBWiseiYXnUn1ChYFWlT/vK8ChFuW4rt0ksmEEYO
         0HEeCriEhg3R6JO6nzTih2Pdtf/ZXeiumYLrj5nlhA0437eutiGarnb4YQI+7yp3HjfY
         Kp/Ft3e6GobY3yfgOWpVj51tFXREM5Y098man/u3VONakdOlH458Ewl16ebx2LSmK6Al
         DXnJXQUXSD8fRJ13SO5J7g9NZ/93Drial4KSwlCj1p9Nzm18QXCsXzMGHoi5+O8c9mA8
         rt/aZZ4JccM+zXR4rPixaNcFmxH7aygA9ROMUi2yQdKHbew+RERFd4n/UyaH26yOb2nu
         XC9w==
X-Forwarded-Encrypted: i=1; AHgh+Ro+TtTDLkzAI0CnF/Uwc8yMLZ+rumuKTDr+uO4SEm+3geGEDS4oH5Fey6jtBz6F63yqDA1ogrQ6IJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWM9TgCzq0yJQxUy5DjgjY3aw28+JWoiBOOoaVk94k5LYE2w9t
	RQ8iHEWCTCd7784inIc0OI8q8/nzN/AJRkyM71pJpyYbgLwIoTwKdlFZ
X-Gm-Gg: AfdE7cmJyl3Yih8K017CYoyEzGh7vhrfEC2eiWuXKDN9VOtt0yLagSCu2byHkZkGdTp
	ldj3PI+6sZJZ8P+i9TRMl+Ha5pSTZs+el2D2hdtSojB0kejM6volqKFBpb6je5r01qwO+UfXTm5
	jB6ipFjsdza2e+G19eRinBwhnGRWzGObzXI1zCDrsVUiWn0y7PwUv51fwfv2WOgOmsmENU5xOg1
	hy+86mlFPbQ4QgBlg/QiOkPj0SVNbToDO+Zc9kInyC1p4nbyGSzk8LsCGpU5n1O3NRY4f5NSg2l
	kaEfI9lgJT4QHAPkJs/22t7XOnXkDOxw1vILpKJsj3OBCqLSzGxE5EUJTQOr3B2m9Wtt5NYUrWj
	yNfF++C56y403UOVHhVk20Bq+T4d/JMYhz+kAHvabTBFi19jQWSR/l5TWYaXWppfwWftIeLE8oW
	th7R1ImAx7eChaM/issWN4
X-Received: by 2002:a05:600c:1910:b0:493:e52f:6ee1 with SMTP id 5b1f17b1804b1-493e8a618bamr64043825e9.0.1783625364288;
        Thu, 09 Jul 2026 12:29:24 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:8fb6:1d85:3dc1:42ab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6ccdbbsm84366045e9.3.2026.07.09.12.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 12:29:23 -0700 (PDT)
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
Subject: [PATCH v19 07/12] mmc: renesas_sdhi: Add optional axis/axim reset controls
Date: Thu,  9 Jul 2026 20:29:04 +0100
Message-ID: <20260709192916.630794-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709192916.630794-1-biju.das.jz@bp.renesas.com>
References: <20260709192916.630794-1-biju.das.jz@bp.renesas.com>
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
index 438b2a7afe76..d46598190004 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -100,6 +100,8 @@ struct renesas_sdhi {
 	unsigned int tap_set;
 
 	struct reset_control *rstc;
+	struct reset_control *rstc_axis;
+	struct reset_control *rstc_axim;
 	struct tmio_mmc_host *host;
 	struct regulator_dev *rdev;
 };
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index b6bba03316fe..6ec8dc96b581 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -623,6 +623,8 @@ static void renesas_sdhi_reset(struct tmio_mmc_host *host, bool preserve)
 				sd_status = sd_ctrl_read32(host, CTL_SD_STATUS);
 
 			reset_control_reset(priv->rstc);
+			reset_control_reset(priv->rstc_axim);
+			reset_control_reset(priv->rstc_axis);
 			/* Unknown why but without polling reset status, it will hang */
 			read_poll_timeout(reset_control_status, ret, ret == 0, 1, 100,
 					  false, priv->rstc);
@@ -1137,6 +1139,14 @@ int renesas_sdhi_probe(struct platform_device *pdev,
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
@@ -1363,13 +1373,18 @@ int renesas_sdhi_suspend(struct device *dev)
 {
 	struct tmio_mmc_host *host = dev_get_drvdata(dev);
 	struct renesas_sdhi *priv = host_to_priv(host);
+	struct reset_control_bulk_data resets[] = {
+		{ .rstc = priv->rstc },
+		{ .rstc = priv->rstc_axim },
+		{ .rstc = priv->rstc_axis },
+	};
 	int ret;
 
 	ret = pm_runtime_force_suspend(dev);
 	if (ret)
 		return ret;
 
-	ret = reset_control_assert(priv->rstc);
+	ret = reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
 	if (ret)
 		pm_runtime_force_resume(dev);
 
@@ -1381,15 +1396,20 @@ int renesas_sdhi_resume(struct device *dev)
 {
 	struct tmio_mmc_host *host = dev_get_drvdata(dev);
 	struct renesas_sdhi *priv = host_to_priv(host);
+	struct reset_control_bulk_data resets[] = {
+		{ .rstc = priv->rstc },
+		{ .rstc = priv->rstc_axim },
+		{ .rstc = priv->rstc_axis },
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

