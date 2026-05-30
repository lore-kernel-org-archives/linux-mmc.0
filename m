Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9E4342C80
	for <linux-mmc@vger.kernel.org>; Sat, 30 May 2026 16:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780157324; cv=none; b=vEH8Y+KAjzc4g29ouqpABR0FJOal5JZIaHeP0kdY9aC1D4GdCwFkV/WsAn+dmJ42FmVqi3cH2OoweeUPnCIG/YoZ5RImfRs22yd84gWfrOXT2AAuO8FYtl5myVoewWVukeseYranJ4E0Dz1FS073KxIAkfjLsJkEVqY53SQGsz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780157324; c=relaxed/simple;
	bh=WL00R54JtnIGCqbVD23oMHeV2SNxcWSfX0/F2cNxCRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WbaeYvO3f1iIXLvz+nVNjv6J78w9HH9iveTAzjWPc/mga5ZoQOqz+NczqC6SUV9x7ACK60eiucvAqWQGUrK2wxxU3stIbRVTYjZPEOoW381w4srd67u9wtfHb5MLsIOeUDWSLI96l+2BoyrKlXWd44nFBxSJlp4QQJ0jPh8nInc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEz0XFOt; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEz0XFOt"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso128122705e9.2
        for <linux-mmc@vger.kernel.org>; Sat, 30 May 2026 09:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780157318; x=1780762118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXkjQLqG1wqQ9sN8pwB+4cPvEKXxoY4geiEx2luqEGA=;
        b=UEz0XFOtmaZRi89bj/Y/uo3k935smUFwdrEyVKWqSW1QBpZGI9Qftouw3XZ88QqFZ0
         KSBwfkPkrc1BHWtCtKrsU4z76fYbhrG67SNmLVP0RKnWAOYZ5QnZLzqW/iwFBG1BgwIG
         uKS9ub0NZoL1VkEcmGA0D+pupwehK8Ut0XYU804rz36lX0aCooYqg1/G/Fo2VHM6Pjg6
         h7hXSAWa/2cGTKxFu19q6QkNN5LSkhzCSrcyGeZ5LOIvU1kIr5ycnsBpmjwuA1qnboh0
         jNc9cWzlk9ca48/iFzVqVxZwOxuPU2/VgWZT746BVFOrKoVEx2sgXRGY08QS4/pSX1Fk
         P8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780157318; x=1780762118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hXkjQLqG1wqQ9sN8pwB+4cPvEKXxoY4geiEx2luqEGA=;
        b=DzRqStA4hph9q4EziL5SHCxUrNpikLLThn6bLfmjHb743JgdUxcdCEF2CHburu7JcL
         59RCn9S/2Gd/XGXAEDGBlNSvzHxITxhf9CK4N31CGZZyOqVEYwBAzI07j6kD8Oqo9bWM
         DG7x0CnVb5v6V+S32d6oaUq834Q6jpeuXYU+KBWIqLYnoanpxzmwEZTJQN7oOGLH+V55
         NwI69fAa+9/X6IwCQup92sVkAxn4zpeBlK62CEJVVNjeLS2AfNfr2KBLHsSAr9Nmb4/p
         gaOS1YmvEl+1I8Qm7voChlE6zifGzylUTA4tHqhW0pz+1L/mkUErAffaF3NIFsjF5Ljz
         BsPA==
X-Forwarded-Encrypted: i=1; AFNElJ+iDP1FqtAYddLSsO3g0jdJeT5OC+e5Cu1td/uAyA3yqVPSsyCaBv1IUGO1ntYryP1Tlc9KYGcfIAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIDDblhxQeayDG9Sv7JV9m8DbeBhUb2cMOCYF92FFH4ZcCYIkg
	fktYhd7GOLANDpF4FyhQcjgxstrL5pCqd3OmuGE8NGMtdO4h2KXhjLOK
X-Gm-Gg: Acq92OGZjjbRwjwjg8/Js6XZrpSv96X1iP1NsS3w2sANFBgzZhabuL4Abpb1knG/aKF
	ClLzocxvreDzojrA5ynjbgSH9uYLj285No4nUcSOi47dLV1ac9X3i1S8qC+0nWyt6XacsgAuZfz
	Bkcvcm158Pnf/DAxwETJDtKa5CIJa4NnN8YsqH/qqviDmZIh73kTpkCI62srgfhKYXkp2gUanr8
	ZocY6I5ESVZYeWu4wF+Wsr1CoIaxqpJVdXCbYJXxANyRKrgMlAhmJoduxVE1KUqZVatbJukU6Cn
	PpGhe1c79P49xXAPx/FF83IbT/iZL+vyEeOSMfazAOtqJCwAihHtY/Do1Yj7stGJ8iY/FPlWVSc
	Fhr0c8lt6I0eETseFGQTO3w9xcg/sNSyxIUBiSoLtccggX1zTXniyYL/lK9Q08bRSawMVTE+iFF
	7cLFDbx9jkraOfhxXKXtGM1lILV9q/iFa29aiQN08sqmxcKE8xD78mI8oGaaY=
X-Received: by 2002:a05:600c:34cf:b0:48a:563c:c8c0 with SMTP id 5b1f17b1804b1-490a2901abcmr77279835e9.7.1780157317975;
        Sat, 30 May 2026 09:08:37 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a700:7301:5db6:a512:6ab4:aa07])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef35874b7sm12170799f8f.35.2026.05.30.09.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 09:08:37 -0700 (PDT)
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
Subject: [PATCH 10/17] mmc: renesas_sdhi: Add optional axis/axim reset controls
Date: Sat, 30 May 2026 17:08:04 +0100
Message-ID: <20260530160823.130907-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530160823.130907-1-biju.das.jz@bp.renesas.com>
References: <20260530160823.130907-1-biju.das.jz@bp.renesas.com>
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

