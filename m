Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DB23914E1
	for <linux-mmc@vger.kernel.org>; Sat, 18 Jul 2026 13:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784381933; cv=none; b=kN4cfNhejeGdi2Vzqt/+CDgNYmkL0q14qhWOlOEOc7pRH7/i/TfI5/Ugb229RoVQytbQq405mYUhodEpqshQNMxGmlhqklstAs0Srqe4PZcBCzYnZngHO4cCxcq+rdDq/WZL/ELQew6yqTGbg47eXDlDcUlH/AALhA5/qvb/NJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784381933; c=relaxed/simple;
	bh=rXfYovdzg21NGSMp8KtrTDJa2I8psWek+CBsRKmdLJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iae9doSlXnnTVarPj5cl0/EjMI+d+Y0lCy637WUnDyEO1xmqbt6nucanHTRC+cWRHyxAFieW7dnLfVP7JslxgL2R0L34wo++b9VclXq/J1vd3zTjTkuWo02AZ8r03NNTjgki+xjxrcOP0hJH1ADXLk4RJ/GN2IVPvfMhLszzAgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCEeK9FY; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCEeK9FY"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4728c12ba97so4240553f8f.0
        for <linux-mmc@vger.kernel.org>; Sat, 18 Jul 2026 06:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784381929; x=1784986729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9cBwHO4qAougX6DtoREZzxzE017dKl/Ks+heWhVmI14=;
        b=cCEeK9FYIkA4Q/pcng71UpChl9+0G0lFT/eqKL+pRil9w/JGboRzv+8l3mdHZGTeRB
         z4WYjdvlAuru+xz8EYGHR1bDMW5ikqB9wRu0zpynh9dqFPBMcT6NUoCG9wdwJqNejLIy
         ibqyWVhKIUm4BKN+zmM9Llc8o9Qzubvp6KlCFizLZCzH8GEhQQ9kjdkmUj0/E5vI7szp
         CoTI70jbVe3jDWin6GcdfqPBm61307eCciIwXoA9A82uVfPcXpb2XXs1X3/Uj46D9yus
         5t1ZQn7/Wsxy9ErO52rz5P8n7UTgFqNVs+s0OulQtUJn0h6bFhYdy4fTXggJFI2uGxyH
         mqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784381929; x=1784986729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9cBwHO4qAougX6DtoREZzxzE017dKl/Ks+heWhVmI14=;
        b=k2ZnAYvgJw0+sGJh1fCTKv683RRch6SJLsigVTjUEWES6Al3wlJ5sRCq/MJCSP5SmS
         +6b9EL/7D2F1IT4Hjsk1gGqmnrzxNyWI6wYv05bFVQUW97SWOrL7lk3uYvCmZwunGZ9I
         j749iNyQY2p7sFtFQ8IQLhDXPV/1/fozQtx57kFQgWMBlAwMITksapTn0jC6VO01/UXJ
         i1cSAJlsAt13iIhmHeePy25nwGiJ84jItusX4qJYIc00EoPpJIN7m9ykecYfDn5tmzxn
         HRfrDySSpsjoaix0lkr/fiDpc/FdXiSTz9DrVL4bpv592I6zrbxrj3XO6mJkD8tL0Le0
         Ss9g==
X-Forwarded-Encrypted: i=1; AHgh+RreRQYbrEkw2m3WS7GgYy1tsoYJ1yOl496pID3meSEmQKaVCXdHNQ9NizBpFaMlSHmn6IQj6fcuTn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUiP15dooFR0Aac0BbwykEcM7UNqxq0JFWH2K5VTNXASDVNR9U
	xtrzrUNiANrZGYTWS9/Jd7YGXlWI8SdhzeM9aQZrkcVSfBqOMsGrnR24
X-Gm-Gg: AfdE7cnQb08uWJRFCDZvXa0lhglafDyfc43rzilCNSOAS6cc/CAU+WnnXkpriLbMgYr
	y1VpG3iWnjX3u6Ijp0EBMRND5hyZmZC6PUamuRLFB/2HF0yGb2vLwjV6mk+jILID/MLaPEl708Z
	trA/fWNBC/shw6jSdBtK9iJmJiT8A6n5Ed4vWyd2/fHyi/ec51kmGrX7SxGb+KeDl/Ufxfuop9Y
	1ey0n+zjp4GWIsKYqVULXFm1EoO4V88u88TH4iV1Q174yr9SXAUvcRWsRW/sB/u0WnMZOFNnJaf
	CZhsWdnh07E42OODgKKaVQE4Sp+zikNnb0bOozOW6AsRtuk86mVE/3UVsTbfc+JrY8tDIEzTMPn
	Ns0gVpJeaKaKzwH3XNnFMweYU7j/RHFmIu16f1F5eDw2ogu9sTg3xAsb9b5zXrnyow+JtJ7wLIp
	NzMeeh9cFO6mF6NvZE8dfJU4OWmiE=
X-Received: by 2002:a05:600c:4ec9:b0:495:4589:707 with SMTP id 5b1f17b1804b1-4954a3ec5ecmr84020695e9.5.1784381929335;
        Sat, 18 Jul 2026 06:38:49 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:c53f:e1cf:6009:4c03])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49549c96ff7sm121717845e9.10.2026.07.18.06.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 06:38:49 -0700 (PDT)
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
Subject: [PATCH v21 08/12] mmc: renesas_sdhi: Add optional axis/axim reset controls
Date: Sat, 18 Jul 2026 14:38:28 +0100
Message-ID: <20260718133838.152905-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260718133838.152905-1-biju.das.jz@bp.renesas.com>
References: <20260718133838.152905-1-biju.das.jz@bp.renesas.com>
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
index 456d52f5fbe9..4c977198070e 100644
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
@@ -1366,13 +1376,18 @@ int renesas_sdhi_suspend(struct device *dev)
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
 
@@ -1384,15 +1399,20 @@ int renesas_sdhi_resume(struct device *dev)
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

