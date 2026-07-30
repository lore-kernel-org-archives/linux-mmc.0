Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C040041B8ED
	for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 11:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785411136; cv=none; b=PfhfIvI1nFkDDtPNtsOizwZH11OmJ6yR3cNJfrPEBS82ssvtnuapEQ2eDbHakMmJNvTUVsQL+ll6wnso4Higex4mP1oQheNA9dyTIM5cfoOd7e8SNydjCNOhf6IVQWsuNua6D1ccEFV52V5UvLmxNffzZ0bdkcqLR5h55/P9UHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785411136; c=relaxed/simple;
	bh=/xNA7EXIhSCo9lgOB39JI/P9JaSZ0VgwLpK+Ez57y10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ln0vhVzri3F6154Lims+dkegnSwdDXkewccQFfiLxOs8vnQNbb2/6x5qPQC3jYixLgAhthD1dH13RWBmhycbpSogWW3VkxJT9M29bJjbQsjXUic+/ZrGAsrQtRLoxAR9Lk9bz6Jie7gJUBM332DImkR24d8SuLzkUQ3/TOTuyZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcuqIyuA; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcuqIyuA"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47de0093c42so1532571f8f.3
        for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 04:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785411132; x=1786015932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NRvcrtcqnhGgSFkrIS2JSbPQJdicpHVDNdLVJkGZfMY=;
        b=XcuqIyuAMmNsb12gz7jPU637SXlZhOx8OQVNkPJzzCCeF51HR0Y4QecSh+zFT1o8SD
         umAec9zg8CjeczB5Dk+0uo8wP6PyzUNMnCS61wh03fooWA756zSkwxV7s61PugaW+ocB
         pvHEuRo6fUcQ9jrwVE7SZVlm/XmVonIGWWZjFpPU4uhZ5gUL3pYF9M26qyCr4pSw0kt1
         /sSS7OXBm8mCGYfc5HYFNtkBG7uuoOCY6vAqrIKFvx9WGFmVi7SdlDbrofGRu0/ykgFY
         zW33vmPvSyiTnJCW+YHHCkdhbCy+H8SdAtpcy8/4HYi4SC+drrf2afoRaJbVMPelOGWH
         W6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785411132; x=1786015932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NRvcrtcqnhGgSFkrIS2JSbPQJdicpHVDNdLVJkGZfMY=;
        b=HUzmBJ9VLjp2b9YhB+bhlxndbctzDAHPLzpYDiWr5Tk/51MdTjCgZ0/cmUIRHFBTak
         rFqy+QXhCHYNugYzNzqwkf4MiyxOb0fh/TIZ56OHePtrC0VVgCMs+0ifzf0N/H6sP3FC
         gt5ulNQqilVwf4JPwZ7sP8jJzRMX8/gWcIbY1TAuh15JAIcGss0Z83ZnGsmBSZjJzmDz
         6L8XURIVByP4oHF48KTj7PLZNDd2lEhfRvDpmgZCAv8mt0+vJoJlk9ZcwgPQEi4WeP0k
         HKua5JUrYQraNr8RUMf/tObVXIec7ohx4ym6BcMi8+ujR6fB9hnSGvMeCpj+LUGw4ipj
         l9tg==
X-Forwarded-Encrypted: i=1; AHgh+RqM8ir15Ism74v0ZtN7i2qNC7pGEskltdnVPUo0DNaLqk9+fIjz2Io+M7hcK57sv9sHJ+SW6bawVRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBcOSVFwPehKYkZx6GZPMSZWQlZaEk9ZO3f5ewLAu1a0IPynbA
	idGg4ZW30ECOZ/GhheyjysOC7ri5Dobd0fa68tygf6NFfD7H3CuBvFtr
X-Gm-Gg: AR+sD13lwUTy1GsW2RItWHzRs3C6674cf9b2elhDfISw8OdqzzA9htYUco3NV8Ivmnc
	ZocyK0xkSj8GTQTfeisMc68nPwjq6JgyKYMrJnG2NeF4ozZ6xJ7Nn5b9WQJ6AHb0KL/FKeznVrI
	U/eyfjR7eyZCZsWRRe+KqcpsIGEkTHh2mSIs/ihErKz3mFevf2Obgj+bJtCDUABF8cfrtoMYaEr
	JbnhXHPS9gxeOcwDjXol2JNXiBq6+qsNTcJUcVzGkt/HFThl1fTl5HuiiQXjQ29nS3WJWyHiQ/e
	TAa4BwixccbOO0CnIfI3Nnna7MgnMZHOHR03BZgjQGZKlFdaf569kmfnHzaZL5sKrorwSfD+wf3
	6RTZe684HKPpc0UYGO3WKaQdKnCT5u4BVxQCZATt/QM9aVw+AO+Xp5tJU3efYJY4NqRl6bFRwE4
	HXREtNkoPbi4A5/b2yMmfFFroP1JsnZy7vxyyntnvK2tSVyVGqpBVVELmiGrHMKOnU6rbg50pUc
	OZsQVM9VviJvQ==
X-Received: by 2002:a05:6000:2308:b0:47f:c648:e265 with SMTP id ffacd0b85a97d-47fc81f53afmr2967908f8f.17.1785411131644;
        Thu, 30 Jul 2026 04:32:11 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:eabf:a623:1e7d:c359])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc89351e3sm5737947f8f.29.2026.07.30.04.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 04:32:11 -0700 (PDT)
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
Subject: [PATCH v23 08/14] mmc: renesas_sdhi: Add optional axis/axim reset controls
Date: Thu, 30 Jul 2026 12:31:46 +0100
Message-ID: <20260730113200.36456-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260730113200.36456-1-biju.das.jz@bp.renesas.com>
References: <20260730113200.36456-1-biju.das.jz@bp.renesas.com>
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
v22->v23:
 * No change.
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
index 9c72eb78e31e..3b140cd4ee0c 100644
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
index 655f0920c015..ebbce7f010be 100644
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
@@ -1385,13 +1395,18 @@ int renesas_sdhi_suspend(struct device *dev)
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
 
@@ -1403,15 +1418,20 @@ int renesas_sdhi_resume(struct device *dev)
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

