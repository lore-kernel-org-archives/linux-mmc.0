Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C1F3CDBB7
	for <linux-mmc@vger.kernel.org>; Mon, 22 Jun 2026 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782143785; cv=none; b=Pshao9oYH2eBWq4ZtSKTn1gWhk3KRMXwZjAsQgf0s7FsyQKiGAm1LLaknv3RYQwjonpcMfhnLkqFTeaI1VczVyHstXfC9EVnCUjcTfbFsnw98Sg22fiQrB9FZy6UAOPeCcCEQYyBQ2OEw5btP2vaZmgTSCnKtbrrdSg/ZBbJZeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782143785; c=relaxed/simple;
	bh=3pSYeI3Ov5IRhZN7PCvd79JnHMNr4PlXkUDxKRt8tI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AY+BW4XidNV31BqyhAywbTz1dyQPU6kcjgE3HOXbGmqEG5FIj2bg8kT64wMXgAFQYWNYNE9rEODSHzgEBA64KMHK3rlM5kUvJP0HVQ5u48dpCpmgT5UpQPfF8xZRc9RyXdQmQycGJF/4AMMdAPolpKznw8C4cM56Ws/g/54qQeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjnnqKHx; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjnnqKHx"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490cf3000f0so48471075e9.1
        for <linux-mmc@vger.kernel.org>; Mon, 22 Jun 2026 08:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782143782; x=1782748582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ChpsRMDYahXFwT9HY/F/ClsapQx8Ght63tpNspUZit4=;
        b=EjnnqKHxFMn3+GARy6981Una4OSVlrsIqseFfgapE3J+8LPFgEnM12L6IJjxcQRfD6
         CTfhw2hvEq6mUmzOZUak8IXwd4pQiAfuxRnUX8XmS/SIa1ASlh65NeFnmaG7k2GE9BqB
         RlGJv9IVwr351z4twYh5+PGaEzdEfAKisvkEFWI7UZxHQ25jYpGfTSWmGlH+TzcCq8tr
         sgR6MdjQ5waleuwpDaqRkePHoIo6C3A5vtwOPJDxAlEdzm72CYFNzWP5SvpnpZl/17iI
         O3PEuiY/z4+Q9/thXGfcVc6TjahjCxpTtZ3B2hZNLsqoxhfy3KZkhNpLOd/0E66Pjy7y
         m7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782143782; x=1782748582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ChpsRMDYahXFwT9HY/F/ClsapQx8Ght63tpNspUZit4=;
        b=SQH3j4mdKX2IZusSf1iW7LHyTHG39E2s6MjZU5QFGOm8BuWMsXMm3jIETJ7y3PA0u6
         H83ocEYcSuxXXnR3L0XpSTO8B2PM/+njKVHq2aNxVfxMNYQHEj+8sVtFxMrmHsUUtPEz
         ifanpp+2D79rK0bbcs22wzJhTPJCcIfsK1PovnaMd+RVkjF7Rm86O271X1FVnWd11VPU
         ZuYK9ZqZd2bA1vPKfHKpEChdCRNPvMbDPc0kU0XCD5sx6Fy4gaiX8vF2kqgIS9xqwdAo
         OYgp2Poj2o/QzPukoaG0ZA44uIFWGlwDT23QmvtYoPAnUTFsAdDQd1H/DSRFvIu7Zbv4
         hxsA==
X-Forwarded-Encrypted: i=1; AFNElJ/04Bjee0c5LCEHblzYKAKJSBEvOwkXZL7C5/uXljO3a2a2LYT8cjBFfhTyIc5IdqlGUF4BUDIWPIA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+f36DquegFUkh+V83gA6YWX3B1Wz2pyQgxykqy0jizeLA1Spl
	yeTTudL9AmdfgG0n4DhrjWlsbqPtkQNFi1bI/+f+j0vHu7fJR4yhCxbE
X-Gm-Gg: AfdE7cmZVybPpmshOB/ujEPAqxdGwXCDDxtEVXB7UT6bBS0Lhy+K7a6Q6xfcBo5I73i
	v0KLGexn8Fbyqr9SYEikE4OpwzIUOH1RA1w13KsLUddvoasE3fBGFF7FhRIlc4CbGv++hNM9qsJ
	Lgtf6nIZyAOPr3kCPG254lA46xvfUGxSIfm50Vou3aMvjibx1asyeBoqELAMI0wnSHhaWejyRR3
	fEwdalE7vMNcS7EU8/SuePsTgKScYTgr9pFrfcchtCmOnysu489teQlNpNapN1YCpHKtmWRmkv7
	Jt6kpuAk/aVyXJKzS3SfTJU5i96oac9tZOHrshQdkxViYuYANTpB7yVxe7DKWct0E18a6Kiv73t
	sEtegrreq3QWkSyWaqU7cjfsjpUn6FN9hDWQOfrLk4KjZmq8QmXf4skNJNnpqNzqFg+JQWyaOUV
	Ig3J6fQcVr2kYvZKOdZ9twvHXmraxio4CurO7eWw==
X-Received: by 2002:a05:600d:8654:20b0:492:4fda:7720 with SMTP id 5b1f17b1804b1-4924fda7824mr88441745e9.14.1782143781438;
        Mon, 22 Jun 2026 08:56:21 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:fdf9:c68d:5fce:b1ef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923ff8a9e3sm331778025e9.14.2026.06.22.08.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 08:56:20 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v18 06/12] mmc: renesas_sdhi: Add TMIO_MMC_INTERNAL_DIVIDER flag
Date: Mon, 22 Jun 2026 16:55:57 +0100
Message-ID: <20260622155610.184271-7-biju.das.jz@bp.renesas.com>
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

The RZ/G3L SoC has an internal clock divider active for all modes
except HS400. To compensate, the rate requested from clk_set_rate()
for clk relative to clkh must be doubled in those cases so that the
SoC's internal /2 divider brings the actual card clock back to the
intended rate.

Introduce a TMIO_MMC_INTERNAL_DIVIDER flag (bit 14) in tmio.h and a
divider field in struct renesas_sdhi. During probe, when the flag is
set and the device tree does not include the mmc-hs400-1_8v property,
priv->divider is set to 2; otherwise it defaults to 1. The divider is
applied in renesas_sdhi_clk_update() when computing the rate for
priv->clk, replacing the previously implicit multiply-by-1.

No existing platform sets TMIO_MMC_INTERNAL_DIVIDER; this patch
introduces the infrastructure only, with no functional change for
current platforms.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v18:
 * New patch using flag.
---
 drivers/mmc/host/renesas_sdhi.h      | 2 ++
 drivers/mmc/host/renesas_sdhi_core.c | 8 +++++++-
 include/linux/platform_data/tmio.h   | 3 +++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index 438b2a7afe76..6f6b41fbe91e 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -102,6 +102,8 @@ struct renesas_sdhi {
 	struct reset_control *rstc;
 	struct tmio_mmc_host *host;
 	struct regulator_dev *rdev;
+
+	unsigned int divider;
 };
 
 #define host_to_priv(host) \
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index e9767aa83b00..8890859d0777 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -185,7 +185,7 @@ static unsigned int renesas_sdhi_clk_update(struct tmio_mmc_host *host,
 	clk_set_rate(ref_clk, best_freq);
 
 	if (priv->clkh)
-		clk_set_rate(priv->clk, best_freq >> clkh_shift);
+		clk_set_rate(priv->clk, (best_freq >> clkh_shift) * priv->divider);
 
 	return clk_get_rate(priv->clk);
 }
@@ -1231,6 +1231,12 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 
 	dev_pm_domain_start(&pdev->dev);
 
+	if ((host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER) &&
+	    !device_property_read_bool(dev, "mmc-hs400-1_8v"))
+		priv->divider = 2;
+	else
+		priv->divider = 1;
+
 	ret = renesas_sdhi_clk_enable(host);
 	if (ret)
 		return ret;
diff --git a/include/linux/platform_data/tmio.h b/include/linux/platform_data/tmio.h
index 868a21842fa5..6c512e96e192 100644
--- a/include/linux/platform_data/tmio.h
+++ b/include/linux/platform_data/tmio.h
@@ -53,6 +53,9 @@
 /* Some controllers have tuning delay */
 #define TMIO_MMC_TUNING_DELAY		BIT(13)
 
+/* Some controllers have internal divider */
+#define TMIO_MMC_INTERNAL_DIVIDER	BIT(14)
+
 struct tmio_mmc_data {
 	void				*chan_priv_tx;
 	void				*chan_priv_rx;
-- 
2.43.0

