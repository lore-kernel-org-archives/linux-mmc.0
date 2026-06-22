Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C0D3CE0A7
	for <linux-mmc@vger.kernel.org>; Mon, 22 Jun 2026 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782143786; cv=none; b=AethNOetnHIMYAbcdYTr11oryANoiLntU2S5x4NFhCbLO6XgZTp22VpJdkFkTauvvtlI08r6GwTDnlD/8AW3U825g65zAbGxl1kMPpZgskv3Ut+MGhggjkB2xbfshv23slkli38FLp5Ohr1Qh78k6OGbOO8FJwYkxIj+9VlO2Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782143786; c=relaxed/simple;
	bh=Ltb9VlbT1WZlakF565+04Nm4z1r6jpFx89YmjQPEVcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dpUY6RTN1cb7Jh67sNO4KMZ7ApUEW6QBBt+kpo6WN8lFYOyuD9tUQFup/5btj9Bi4hfWqFidWAxdAhMh1ggr5hiSJh/DdnXfpOF1a2t+SpcKEY5nZRxqYEzEKohlEv8nRnqeIfnOGaOH8/wOrh3WfrlRi7XL+OmorG5IAWKHnKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p+mUw95J; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+mUw95J"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45ef29c5561so2562048f8f.0
        for <linux-mmc@vger.kernel.org>; Mon, 22 Jun 2026 08:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782143782; x=1782748582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmVHBO44uP/RO9dJvydXdxFgZjsqSR6kPniiCK1ezVg=;
        b=p+mUw95Ju2UwO366lzHVqBytvVHlrMFgMCxeTN4k8gwOJYVV3burvUmhJB7etrh6ju
         UTvZ9ZchJXLQcnllBdJ4QavF0/yHeDOn6TKFMKcMDMTI8Vfv894NJl1F7N1CbrxNUXOy
         gel6QuSu5RKZZ6owwN0OTqDAAwXlSCbCj6kLLmMkEiKw/XT+ag/yep0uTcusP3yVtrot
         xwa/4QvHVVJuqcxokfRKilbMTw+HrEvZ0VE3ovZ31fvpXSFfLvobHKLKEAkp974ws8qo
         d6bfUDbx0KnUgH7xvHTKHOeZCb6B1lnMg3vJkgxrlLJ4S06oJacSdL5L5p1a84H0X8F9
         QI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782143782; x=1782748582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qmVHBO44uP/RO9dJvydXdxFgZjsqSR6kPniiCK1ezVg=;
        b=JEDZQHd6wBgHZyNKYHruGw+ZrurzXIlFpXw/galli1TPcmzTU3zeCgW/UCQCcXjKK/
         ekg9nCSCa/jixvkkSmcPhuNHzieLWUbTNHuLo97VJra5ZlVDWnrfXugod94fBa1ETlK5
         gnyOSSDUDlS6WfhlH8SPDnC3Xjyzp0sw6Icqy3879GyAG+quvFsHlD2IF3JKcAOjpb3B
         nZaLa8ODSYBw8LEfMEHRtwTdGAPiGp5nS6Vgkdj7YGwUKQGu/YOFm5woBP528/UtOg6L
         ZDSAsZ7m3OLpj4ppdj3tSvvfYRZs1v1ILypn4IhfwxljUVbWiWbSP986EJp/Z+NpUnny
         xLPQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ZxGJT/gS1zIPxQjrX9ACsMbJHEdeHkDoUDobApcECM+bhQsLIuRxPLlrlXeWZnbuXCF2k6tazke0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8IEP/tVZL0Jz4ZkEmI5NAjyipHvRsroTRyiB1F1Gvexv7TWLI
	ElsdskTK9UrH4i5mLybqkgaJw6K8u84nlqZtw7gkmHpzuqmnf5VAnsTg
X-Gm-Gg: AfdE7cnS2HpmmZiiY7IxMyH3qcb/2U1RHTAUsg1LFjOzOAAhC+ZrsJ8CnQVfvmNRjJR
	OSqjF2jNt8zzTYXPDYch3H9qYPmouoJxQ+zJjwKHsY+UzSfjwOGmD8V68iA72PXXCZlstoSQhwy
	nsFyXXddimiMynqWXtX5KkAVy9W+kW7RwnYtMQsdwA/LBXCf8uYB3uE2rVFOd4yFkpc+ja7HCPi
	wKVA7nk/9P813JRkB8nIBhsjzjdDce2hh5Ti3VS7aNKIV7QFts3PGTmzbaiwHLufpxa3vTwtFO2
	sbTJdpSpmGpFAeoXYqM1DpFU++xYTQj91KnO6Z1H4ZgXzWrX7+nexhEr9ugvUwGuIOXROvecTx2
	H6EB7LXU4+/TyKrpjLOollymBpoIkUIxV1O3zwOXWICvYZENLJLv0se5oRXTL5MvWU6KhH7ez6e
	MGzFMYMYY9qujl/yAiByo7ydB4QUufNwDMvILh0A==
X-Received: by 2002:a05:600c:1389:b0:492:1eed:3e67 with SMTP id 5b1f17b1804b1-4923f5829aamr242605845e9.26.1782143782209;
        Mon, 22 Jun 2026 08:56:22 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:fdf9:c68d:5fce:b1ef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923ff8a9e3sm331778025e9.14.2026.06.22.08.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 08:56:21 -0700 (PDT)
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
Subject: [PATCH v18 07/12] mmc: renesas_sdhi: Add optional axis/axim reset controls
Date: Mon, 22 Jun 2026 16:55:58 +0100
Message-ID: <20260622155610.184271-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622155610.184271-1-biju.das.jz@bp.renesas.com>
References: <20260622155610.184271-1-biju.das.jz@bp.renesas.com>
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
v17->v18:
 * Fixed ordering of reset in renesas_sdhi_reset().
v1->v17:
 * No change.
---
 drivers/mmc/host/renesas_sdhi.h      |  2 ++
 drivers/mmc/host/renesas_sdhi_core.c | 26 +++++++++++++++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index 6f6b41fbe91e..9ac5cb25ee98 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -100,6 +100,8 @@ struct renesas_sdhi {
 	unsigned int tap_set;
 
 	struct reset_control *rstc;
+	struct reset_control *rstc_axis;
+	struct reset_control *rstc_axim;
 	struct tmio_mmc_host *host;
 	struct regulator_dev *rdev;
 
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 8890859d0777..f3ce29cb3053 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -614,6 +614,8 @@ static void renesas_sdhi_reset(struct tmio_mmc_host *host, bool preserve)
 				sd_status = sd_ctrl_read32(host, CTL_SD_STATUS);
 
 			reset_control_reset(priv->rstc);
+			reset_control_reset(priv->rstc_axim);
+			reset_control_reset(priv->rstc_axis);
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
@@ -1360,13 +1370,18 @@ int renesas_sdhi_suspend(struct device *dev)
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
 
@@ -1378,15 +1393,20 @@ int renesas_sdhi_resume(struct device *dev)
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

