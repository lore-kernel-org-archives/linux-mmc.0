Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E91E34F498
	for <linux-mmc@vger.kernel.org>; Mon, 13 Jul 2026 17:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783965133; cv=none; b=DFlomfwlee+PvjJpZyyGBQPY5pMO2awAVfODgU0GLTAFtRKfs4sibdsE5GzcER93t5b4GYL5nmfHSzjeGlvKbCKuVR00HEAYR+3xWr6tOFgSjj9Ti/jY4Xymyh0Ml3MoRgvK8Cr4gfS+6cjyVc4NUZwuYh7TpoUh18R944gvhhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783965133; c=relaxed/simple;
	bh=W77L0VNCoY7Tvzw4PzFSS4Ekd35/93E+qrb/dKg4lzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jEA1rXM9OaPp2YlJClSRBVTf5mP4fttIVhT1VbRRReqsQrqIijTc+dTJROFH9ujf8or7m/IsET2pMywd5iryBqfdfHybmuwqJ3JW1vcjaB9cAHJjz3H6Tlo0OuON7n2WSCYM7YcITt+J233ABuh20cWIgZ9qiViyijKKtkSjROQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQQsV0S4; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQQsV0S4"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-475881b9a4bso89230f8f.3
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jul 2026 10:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783965129; x=1784569929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nz4lXMnM+3qHjXu6Jdn8WbXR2CI+PL9asho50kScHBI=;
        b=nQQsV0S4yUBJb8pllmY63rXs6m3/WwviqZehzg1alQFt7CWvhosYHY5iuPVBSVjFBz
         qVk702jyjG0Mhx/wyrrypKCqRukaPS5JS0W82zRRUVPS2woq4mP96MBeay1LlCWk4FQq
         FWqg/gbdS0HI9tW4nQkVP9+a2f5Fxi63sLdTO/OKHr9Gh5h/BROIfBqACJ2KDkj9gmU5
         pH9SK4X1+sMs4uc/OlGO+E23lsIOXxbDZpTAlOACsyDSomyRlSpl1zd/EHCN/OdAsaVw
         Ba8CZ8g1sd1Aqm4dAT+KEfz5acIhn/1MyJSHKmeoP6QmeHtZkxP9NK0l6IzKICfAVdz7
         AzCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783965129; x=1784569929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nz4lXMnM+3qHjXu6Jdn8WbXR2CI+PL9asho50kScHBI=;
        b=XluQLdpt3+YizGHpbHr66Op7sjEMlyT+Jb81czsIwi9qsC2VwWA+nvhP8Q/YFv5zPD
         qZzDqtK09A4Jz7/2kQVkF7f9cFYQazMd0bpcLBY9lWXpNPnNuVjtBjWEe5jBCxf3A1bp
         v8DeK8hewAVihDchAIO00ufmgNIBIh1qBQo06fRqp0JdnuKnzUT2mvzJ+cc2+N4D1Lzb
         Wf7f8BKUI/vH23MzCPbTeu0DO0C+q4yefB1+yiem5E8WFU7G1JRewAf8AsUjsoktAN0M
         iaw0NEOlGjEm3fPnG9xNgPj85KhDcwAAOb7mj01TY9KkAMSsbrmh0SfF4zqRTZJHCYDE
         y/+w==
X-Forwarded-Encrypted: i=1; AHgh+RrmzWhjvkDBalW1xAdvMA8QbEmW+HwwR3Ih05LgTLuNm6UxrWYX2R1PvWvCqyKVz3URKzx1ns0CQwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL6gIVg/n4qaTEe8z+hkDfS8Gzku7Sj2Ou9kKmiV0RsHnE71pH
	DJ5atMRFlHvCBN6kzF2XdM60Szo03Whj9jyHmx95jGINs99RzaqyGRepV5HcLbiH
X-Gm-Gg: AfdE7cmumjLT5EIMw1mm7L+O4dRFHiyE/a2Rh2oIK9aMmmE2MUHnSiGdDyvbN4I4rm6
	OV0s3wBnQQo3szz3CaWuti/y9zMt6lICe++CsRqCVltYwf2XDTZAU5vLDRaJVmJwAiEyP8KQ9x6
	jSMiWa5o66fHYLwAYWu1u3qSGquKOFPsi8LUV05F0c2P6LQ8VZPdHwaYSSbbw28Q9x1oeM5CqYM
	JrmhC4gr5o5Kx3nuSD9dEL6UGZoJs1D2xDvGtdtntaP7pWAsAW28P9skBu5TDbg7pRhuA6/8piK
	gHFPU6F9vlkRsOxX33ktESJFIkad9kK/Oo/eF1LHr49kDgGfIeki1gWyhwyu3JMSG6wycRzifaL
	Mg6PkCV7KqedZtt1cfdkCkd9neb2L6WrL2Y0IdmJ5bMUEjLefSchrZOC/eD+iqFeqwTw25YIpe4
	teN4mk0GuEwng4rFLqI3R8zVKJG6Cg4biomeS+6sHp0vHq/ILK
X-Received: by 2002:a05:6000:612:b0:478:65a8:262d with SMTP id ffacd0b85a97d-47f2dcd1a6cmr11891993f8f.9.1783965128698;
        Mon, 13 Jul 2026 10:52:08 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:c899:4fec:2bdb:b719])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464d6fa7sm1011037f8f.37.2026.07.13.10.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 10:52:08 -0700 (PDT)
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
Subject: [PATCH v20 07/12] mmc: renesas_sdhi: Add optional axis/axim reset controls
Date: Mon, 13 Jul 2026 18:51:48 +0100
Message-ID: <20260713175159.138334-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713175159.138334-1-biju.das.jz@bp.renesas.com>
References: <20260713175159.138334-1-biju.das.jz@bp.renesas.com>
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
index d3f6d459fdc7..a4e822f141e8 100644
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
 
@@ -1381,15 +1396,20 @@ int renesas_sdhi_resume(struct device *dev)
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

