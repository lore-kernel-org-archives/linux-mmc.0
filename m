Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92013FC5DC
	for <linux-mmc@vger.kernel.org>; Wed,  3 Jun 2026 06:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469872; cv=none; b=YluNqmBN7s8i3kJ3T6azxOEC0jWEHMqerYBzJDbhbel+39R1pBtFWAQ7HxccXQD/BEHEPg8FZHRkUebW7vWut1Nmau33JaBdzaH7KqEOwUVgX/3cvCZM6+h0RKTOAwVftKnNxOGB0GxnaAqWweZ+iWZuZb6NoUYEvt9gkGbFYd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469872; c=relaxed/simple;
	bh=DOE7EJT3PfheNZHlIo1/Ata11iEDQupyGoxl7JVJu8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HztVbSvQvFCJuUon86iAaimbBMxIEgjSaXG7uv95c8X7Z2dyrYUsIYJHDzYDmVKti3PKGWKB1yiek3znNy5KRryIEpmsEhwtkQ/x3y8/Myqdia5rPrYMi+b5WelkWkscBZngm1kpOV8Ux+BOKsCKWYwli06ZYALm18w+m2l2qBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mX62Xevt; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mX62Xevt"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4903997fcb5so124051995e9.2
        for <linux-mmc@vger.kernel.org>; Tue, 02 Jun 2026 23:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780469866; x=1781074666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHOOsGIBznMP5bc1sOgQ6EqGFGggMqQedHi1JZubx9Q=;
        b=mX62XevtsxJHXR+osCoeRkrZ3AL2C5El19aHbhLampFVNSi6vuFhFQ0BNqIzQDQNSE
         r5M9lkYAZldaCRz6yyqb5+ZgzVHSF5O524qp/8Y6z4tbbXxSLfPHTXygdGHY+4wS09Vq
         Wby1rqU8dZBljrTOCkadLMDPCYy94IqjNSkOEoVpVgacYiz1IF2I+g0hLYxPHtAk+AvC
         vmiv61QSx/Fvc706zNoPL8p55rvT7PJEbMilHoPo3HMl3GcNM3XGD6EU77zHsoJziVP2
         4ynPwDdt2IxUA4FiJRbbnyQ7uDsIDZNchQHrELbGfF0jh6wcGAqiXhU/KG95iMiL9Ik6
         mIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780469866; x=1781074666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SHOOsGIBznMP5bc1sOgQ6EqGFGggMqQedHi1JZubx9Q=;
        b=JHlDcZkydn/pRsnU+3IltH6+mXR+RvwkytAgHzI92fseH0gyitTJKEJtopFhFxUx/2
         YJw+HjfCMoobOG1HcRgmZkQPjUqeLGL4VQtuKJ/Y85im8NJ5MuHy/cMzupbtpTc6Y30I
         OIK4gpKCQ+ctSa+Li++rMlLFiNafZ5NG2u1WVDa8Y8/vHbYnr7dFFp8qR3oT22hCOl7Y
         SaIxSF0hi2y7a9j2wXjfrnbQhZLXqR9i1YOJS7FU9JPMU802YWNRy7+cDZvHkvtgoPsd
         d0C1Abs/VVtViDjQrotN2vC4e0WBjwaau3lYqnnr/nDkXQ2+ohxcZfAGtzyUW6WRGdsU
         SR3w==
X-Forwarded-Encrypted: i=1; AFNElJ9i6gPe2FL+VaId18xtQeC2fcdaogPfyXJS1uiQPoaHXB3nebGe5kMFSIJcrG3o1D0W6Dqa9FpeZs0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt1mq51bC3GXGpyc+yyYHy6952k9OLzq1liXO9iSwWblYdDher
	PMfCGojBAvLIGmxRgKiLvYuuzQpYjaMZKgr8BBLQAg1NYbCZz15/TRqJ
X-Gm-Gg: Acq92OEBN7EV2IEyOqkKnq/LdgTz/bb0WYBkPrmCvdqRrqS/fVW2u4hb+jiIs+2SILU
	iWF00KSBLGXAaLgrW4qy7UJHoq5ii/Rohcvqva7Dct5WIt26fdGRkx0Y2egi/CCkWDObRr4LFkn
	ytPXQQCUPNtulJzrVUmITCvDndUE+1c7WX8A96Pjb4zLUyMYhn0FIXgEq7XqGe7IWKe5fYlWN1h
	vq9gGP5unxtzQhsSskoNwtlHon1Euc4N2c3ry4Rs3QB3xn/wA+i5nRGyLKbGAnlnFrsVpJ2B1Mg
	0vgmCv7OMr9ET7R4ra7RORx/Eo55lB08GN4UeU4Dt6ntiiHdXE9otUZr65DGTgNa2Ju4aCQe11N
	ZvcsEzlzsydoMEbxNtWWC7IXWRuiMmdRg/oRbWLdTjsnpZx/smMl2ZjQ4l+x4rm0BXkc4/7beRi
	Mr8/xpSBfSYdiHri/i7mAdpwB7HjM026DHn3lK/+1O/CXoPTGTSbJkY6MOYXIJPNT7nd/GwQ==
X-Received: by 2002:a05:600c:3e0a:b0:490:52c0:73f1 with SMTP id 5b1f17b1804b1-490b5d2fa47mr37487355e9.9.1780469865639;
        Tue, 02 Jun 2026 23:57:45 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a700:7301:179c:89ab:19f6:9ba4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b79d90bdsm9001855e9.0.2026.06.02.23.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 23:57:45 -0700 (PDT)
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
Subject: [PATCH v17 10/17] mmc: renesas_sdhi: Add optional axis/axim reset controls
Date: Wed,  3 Jun 2026 07:57:10 +0100
Message-ID: <20260603065731.93243-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603065731.93243-1-biju.das.jz@bp.renesas.com>
References: <20260603065731.93243-1-biju.das.jz@bp.renesas.com>
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
v1->v2:
 * No change.
---
 drivers/mmc/host/renesas_sdhi.h      |  2 ++
 drivers/mmc/host/renesas_sdhi_core.c | 26 +++++++++++++++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index 0ca8ec27c320..6c024e7f69e1 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -111,6 +111,8 @@ struct renesas_sdhi {
 	unsigned int tap_set;
 
 	struct reset_control *rstc;
+	struct reset_control *rstc_axis;
+	struct reset_control *rstc_axim;
 	struct tmio_mmc_host *host;
 	struct regulator_dev *rdev;
 
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 8e2fb19b994b..699872766f88 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -615,6 +615,8 @@ static void renesas_sdhi_reset(struct tmio_mmc_host *host, bool preserve)
 				sd_status = sd_ctrl_read32(host, CTL_SD_STATUS);
 
 			reset_control_reset(priv->rstc);
+			reset_control_reset(priv->rstc_axis);
+			reset_control_reset(priv->rstc_axim);
 			/* Unknown why but without polling reset status, it will hang */
 			read_poll_timeout(reset_control_status, ret, ret == 0, 1, 100,
 					  false, priv->rstc);
@@ -1128,6 +1130,14 @@ int renesas_sdhi_probe(struct platform_device *pdev,
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
@@ -1351,13 +1361,18 @@ int renesas_sdhi_suspend(struct device *dev)
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
 
@@ -1369,15 +1384,20 @@ int renesas_sdhi_resume(struct device *dev)
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

