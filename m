Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB3C340298
	for <linux-mmc@vger.kernel.org>; Sat, 30 May 2026 16:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780157321; cv=none; b=G1c3O3oYCj+CRwg4S1x4iQtoelHoTmvOmXS/e/TCVDXuOer37v1FnrWlC6BYUREXo77/IpE0B4qz/VTPMxVjap/o6MwnNUNCu9mFXsxZpOXHcTEjiT5o04syzihkYhWE8ElTMUHURYb2oe9hwLV0ODn7NqsPiZkexMPAUyEZQAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780157321; c=relaxed/simple;
	bh=wvan6W6jwklPW6AfsnqXuduvznpRT1b5qohEMynpRgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqMunzIXznbjikom+DzuQ4Zzm68iEreV0jA4+78cK1dWnAO/p1qUi9WsSDbq8o8wMexG6LjAv3svn+/OP4tiiU8KQkoXNJdfLrjfpd4IJb/XlPNI+SZ7XEDTqYsy7RvfUXV5DIrY3f07VrvC98opQcEKf+k1iOeeBxIQAvoQ3Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pwmPwStJ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pwmPwStJ"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4904c1ce4c1so93527215e9.3
        for <linux-mmc@vger.kernel.org>; Sat, 30 May 2026 09:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780157314; x=1780762114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rru3FhAkaruVuAVpt4QFVtG35h6W/HLXeGb3IVFEYFM=;
        b=pwmPwStJXBDkOpZDQ4rKxi+xwR6CjCI7QaKkB7AncyiqIWr9c3acJcFP1y1+Xr1bBR
         7t4Um1ZjowQWtTVvVGp+8EW2S+pV3SNXFVL80qK+AsRXuRPDV51IQ6Jgsg8M9gy+CVN5
         TzYKObzXUckTeGe3lszilAZGf4TesLBc2tS4KCrYm2PzaunJQnQm0T/QHSin4WgVOuzz
         +r3yUf7k2fE97eJMlX1vZJI2wjpSsmewh5xgrXzINiIGxamZfvrEz4sE7c9/KHX370zC
         DbSc+dzjFF02bdeEdeyulpbBUHJoFkjgCEEIWGFglE2ATiUu6wezDqyGDOTheeKtwy8c
         cQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780157314; x=1780762114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rru3FhAkaruVuAVpt4QFVtG35h6W/HLXeGb3IVFEYFM=;
        b=MtVzT6TRZVkNacwlqwI/rHdY/R8uGLT+LbcWMsitr570D4XFwEajdX5/LDACcD4Ett
         y4tjisBZOh+91sEeARHIjsZfIlsjN8NcNyivi01UuczgQE6znRdKNxNGD8URwzGImjcx
         fiHZ/gV+38FFrImokQ3bseOvZd3r8+dMrGuzHD+zldCfWKPlguyKGZYM6sCh0wtANIZV
         P+obzVp+uUYJmw/ETKXAVoN2nup6ZolnuV16poDkHuxuR4kv4NKY+v/luixR+PMfEsZB
         lzFHKD78/H3VXjcQKwWPIJ/CLRLtR+2irDGowJiCQzpDpjkipReBQGtxkvVIukULl4ti
         RrcQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ycOmTbs6EC+OAZWTl60JhUjNRftF7E1TQKSTglz71Y5nOSyizWWEkDTgcjNxajbQ5r91plJlzmdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyGzcBL2QsEnM8WyDUbOV/7WIuVXysRbW92pNiTWGhFvzGFWmn
	8txxftDrPQH8gCrDsk23RTvG5xphL7V7bEIumuAEBJmqMtTCnd6yxw15
X-Gm-Gg: Acq92OHBa541c7na7K7uPTJ182ZeMGZ0517YwvF2VO6PH9xQIp+mcaBifr8KqWaRfQR
	k/B4NjfGVxVwy9c1yC1n/xgieTObvxiKyNO07iLlRf5MsqMUy9HumeQyn3WON3w8g9rt8rgz2UY
	ekPC/hi2jvg12G5UVwO9yMWdhYpmC3Ck8h5SBOHVSKNuKjpqlhRJvX8vJYFJxqF3EIGeG6RKdsR
	yCXKncKMC1a38KEvzKLv1RxnN8iZxS6L1rPy+oF9rN+2d8Z/4kB5s7Mr8lRtr7/draMIAIAW9Rf
	Sst68Vhl7OcAb+ifTqKgx1nZ+BoT0oOO2kO4TymDzDBqbl3z8tKpARYzApwkpp4BE6nPbt5/KOj
	v3Xs1dB7y1muloNbcc1+6dzSDZ8B7k4othLTixYSn/excwkwX3HpYB5vMVMi2x/rzWwGdA+dJyp
	zMwNEYgLPT8Ndic2NLMXHRw2bl1sSh3GVQQ4QJUSAKyLV9Wv1eBSh28l1/09Q=
X-Received: by 2002:a05:600d:6443:20b0:490:a1be:6b01 with SMTP id 5b1f17b1804b1-490a2923a7cmr57681505e9.4.1780157314269;
        Sat, 30 May 2026 09:08:34 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a700:7301:5db6:a512:6ab4:aa07])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef35874b7sm12170799f8f.35.2026.05.30.09.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 09:08:33 -0700 (PDT)
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
Subject: [PATCH 06/17] mmc: renesas_sdhi: Introduce renesas_sdhi_hw_info to abstract clock mask
Date: Sat, 30 May 2026 17:08:00 +0100
Message-ID: <20260530160823.130907-7-biju.das.jz@bp.renesas.com>
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

The RZ/G3L SoC has 11 divider bits and requires a different clock mask in
renesas_sdhi_set_clock().

Add a new renesas_sdhi_hw_info struct to hold hardware-specific
parameters, starting with clk_mask. This replaces the hardcoded constant
in renesas_sdhi_set_clock() with a value sourced from the per-device
hw_info, and widens the clk variable from u32 to u64 accordingly, as
clk_mask for RZ/G3L exceeds 32 bits.

Wire hw_info through renesas_sdhi_of_data_with_quirks (internalDMAC path)
and a new renesas_sdhi_of_data_with_info wrapper (sysDMAC path), and plumb
it into renesas_sdhi_probe() so it is stored in the per-instance
renesas_sdhi struct.

All existing users are assigned sdhi_hw_info_generic, preserving current
behaviour. No functional change.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi.h               | 12 ++++
 drivers/mmc/host/renesas_sdhi_core.c          |  7 +-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 16 ++++-
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      | 66 ++++++++++++++-----
 4 files changed, 81 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index 09bf9b24a8c3..a7fc525b7218 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -41,6 +41,15 @@ struct renesas_sdhi_of_data {
 
 #define SDHI_CALIB_TABLE_MAX 32
 
+struct renesas_sdhi_hw_info {
+	u64 clk_mask;
+};
+
+struct renesas_sdhi_of_data_with_info {
+	const struct renesas_sdhi_of_data *of_data;
+	const struct renesas_sdhi_hw_info *info;
+};
+
 #define sdhi_has_quirk(p, q) ((p)->quirks && (p)->quirks->q)
 
 struct renesas_sdhi_quirks {
@@ -57,6 +66,7 @@ struct renesas_sdhi_quirks {
 struct renesas_sdhi_of_data_with_quirks {
 	const struct renesas_sdhi_of_data *of_data;
 	const struct renesas_sdhi_quirks *quirks;
+	const struct renesas_sdhi_hw_info *info;
 };
 
 /* We want both end_flags to be set before we mark DMA as finished */
@@ -79,6 +89,7 @@ struct renesas_sdhi {
 	struct tmio_mmc_data mmc_data;
 	struct renesas_sdhi_dma dma_priv;
 	const struct renesas_sdhi_quirks *quirks;
+	const struct renesas_sdhi_hw_info *info;
 	struct pinctrl *pinctrl;
 	struct pinctrl_state *pins_default, *pins_uhs;
 	void __iomem *scc_ctl;
@@ -106,6 +117,7 @@ struct renesas_sdhi {
 int renesas_sdhi_probe(struct platform_device *pdev,
 		       const struct tmio_mmc_dma_ops *dma_ops,
 		       const struct renesas_sdhi_of_data *of_data,
+		       const struct renesas_sdhi_hw_info *info,
 		       const struct renesas_sdhi_quirks *quirks);
 void renesas_sdhi_remove(struct platform_device *pdev);
 int renesas_sdhi_suspend(struct device *dev);
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index f9ec78d699f4..2ff40950f209 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -193,8 +193,9 @@ static unsigned int renesas_sdhi_clk_update(struct tmio_mmc_host *host,
 static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
 				   unsigned int new_clock)
 {
+	struct renesas_sdhi *priv = host_to_priv(host);
 	unsigned int clk_margin;
-	u32 clk = 0, clock;
+	u64 clk = 0, clock;
 
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
 		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
@@ -213,7 +214,7 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
 	 * provided for actual_clock in renesas_sdhi_clk_update().
 	 */
 	clk_margin = new_clock >> 10;
-	for (clk = 0x80000080; new_clock + clk_margin >= (clock << 1); clk >>= 1)
+	for (clk = priv->info->clk_mask; new_clock + clk_margin >= (clock << 1); clk >>= 1)
 		clock <<= 1;
 
 	/* 1/1 clock is option */
@@ -1055,6 +1056,7 @@ static const struct regulator_desc renesas_sdhi_vqmmc_regulator = {
 int renesas_sdhi_probe(struct platform_device *pdev,
 		       const struct tmio_mmc_dma_ops *dma_ops,
 		       const struct renesas_sdhi_of_data *of_data,
+		       const struct renesas_sdhi_hw_info *info,
 		       const struct renesas_sdhi_quirks *quirks)
 {
 	struct tmio_mmc_data *mmd = pdev->dev.platform_data;
@@ -1079,6 +1081,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	if (!priv)
 		return -ENOMEM;
 
+	priv->info = info;
 	priv->quirks = quirks;
 	mmc_data = &priv->mmc_data;
 	dma_priv = &priv->dma_priv;
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 08cf1604ef1d..512ed70b3779 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -232,48 +232,61 @@ static const struct soc_device_attribute sdhi_quirks_match[]  = {
 	{ /* Sentinel. */ }
 };
 
+static const struct renesas_sdhi_hw_info sdhi_hw_info_generic = {
+	.clk_mask = 0x80000080,
+};
+
 static const struct renesas_sdhi_of_data_with_quirks of_r8a7795_compatible = {
 	.of_data = &of_data_rcar_gen3,
 	.quirks = &sdhi_quirks_bad_taps2367,
+	.info = &sdhi_hw_info_generic,
 };
 
 static const struct renesas_sdhi_of_data_with_quirks of_r8a77961_compatible = {
 	.of_data = &of_data_rcar_gen3,
 	.quirks = &sdhi_quirks_bad_taps1357,
+	.info = &sdhi_hw_info_generic,
 };
 
 static const struct renesas_sdhi_of_data_with_quirks of_r8a77965_compatible = {
 	.of_data = &of_data_rcar_gen3,
 	.quirks = &sdhi_quirks_r8a77965,
+	.info = &sdhi_hw_info_generic,
 };
 
 static const struct renesas_sdhi_of_data_with_quirks of_r8a77970_compatible = {
 	.of_data = &of_data_rcar_gen3_no_sdh_fallback,
 	.quirks = &sdhi_quirks_nohs400,
+	.info = &sdhi_hw_info_generic,
 };
 
 static const struct renesas_sdhi_of_data_with_quirks of_r8a77990_compatible = {
 	.of_data = &of_data_rcar_gen3,
 	.quirks = &sdhi_quirks_r8a77990,
+	.info = &sdhi_hw_info_generic,
 };
 
 static const struct renesas_sdhi_of_data_with_quirks of_rzg2l_compatible = {
 	.of_data = &of_data_rcar_gen3,
 	.quirks = &sdhi_quirks_rzg2l,
+	.info = &sdhi_hw_info_generic,
 };
 
 static const struct renesas_sdhi_of_data_with_quirks of_rcar_gen3_compatible = {
 	.of_data = &of_data_rcar_gen3,
+	.info = &sdhi_hw_info_generic,
 };
 
 static const struct renesas_sdhi_of_data_with_quirks of_rcar_gen3_nohs400_compatible = {
 	.of_data = &of_data_rcar_gen3,
 	.quirks = &sdhi_quirks_nohs400,
+	.info = &sdhi_hw_info_generic,
 };
 
 static const struct renesas_sdhi_of_data_with_quirks of_rza2_compatible = {
 	.of_data = &of_data_rza2,
 	.quirks = &sdhi_quirks_fixed_addr,
+	.info = &sdhi_hw_info_generic,
 };
 
 static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
@@ -599,7 +612,8 @@ static int renesas_sdhi_internal_dmac_probe(struct platform_device *pdev)
 	dma_set_max_seg_size(dev, 0xffffffff);
 
 	return renesas_sdhi_probe(pdev, &renesas_sdhi_internal_dmac_dma_ops,
-				  of_data_quirks->of_data, quirks);
+				  of_data_quirks->of_data, of_data_quirks->info,
+				  quirks);
 }
 
 static const struct dev_pm_ops renesas_sdhi_internal_dmac_dev_pm_ops = {
diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index 9215600f03a2..1291970c2810 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -73,23 +73,51 @@ static const struct renesas_sdhi_of_data of_rcar_gen2_compatible = {
 	.max_blk_count	= UINT_MAX / TMIO_MAX_BLK_SIZE,
 };
 
+static const struct renesas_sdhi_hw_info sdhi_hw_info_generic = {
+	.clk_mask = 0x80000080,
+};
+
+static const struct renesas_sdhi_of_data_with_info of_default_cfg_info = {
+	.of_data = &of_default_cfg,
+	.info = &sdhi_hw_info_generic,
+};
+
+static const struct renesas_sdhi_of_data_with_info of_rz_compatible_info = {
+	.of_data = &of_rz_compatible,
+	.info = &sdhi_hw_info_generic,
+};
+
+static const struct renesas_sdhi_of_data_with_info of_rcar_gen1_compatible_info = {
+	.of_data = &of_rcar_gen1_compatible,
+	.info = &sdhi_hw_info_generic,
+};
+
+static const struct renesas_sdhi_of_data_with_info of_rcar_gen2_compatible_info = {
+	.of_data = &of_rcar_gen2_compatible,
+	.info = &sdhi_hw_info_generic,
+};
+
+static const struct renesas_sdhi_of_data_with_info of_shmobile_info = {
+	.info = &sdhi_hw_info_generic,
+};
+
 static const struct of_device_id renesas_sdhi_sys_dmac_of_match[] = {
-	{ .compatible = "renesas,sdhi-sh73a0", .data = &of_default_cfg, },
-	{ .compatible = "renesas,sdhi-r8a73a4", .data = &of_default_cfg, },
-	{ .compatible = "renesas,sdhi-r8a7740", .data = &of_default_cfg, },
-	{ .compatible = "renesas,sdhi-r7s72100", .data = &of_rz_compatible, },
-	{ .compatible = "renesas,sdhi-r8a7778", .data = &of_rcar_gen1_compatible, },
-	{ .compatible = "renesas,sdhi-r8a7779", .data = &of_rcar_gen1_compatible, },
-	{ .compatible = "renesas,sdhi-r8a7743", .data = &of_rcar_gen2_compatible, },
-	{ .compatible = "renesas,sdhi-r8a7745", .data = &of_rcar_gen2_compatible, },
-	{ .compatible = "renesas,sdhi-r8a7790", .data = &of_rcar_gen2_compatible, },
-	{ .compatible = "renesas,sdhi-r8a7791", .data = &of_rcar_gen2_compatible, },
-	{ .compatible = "renesas,sdhi-r8a7792", .data = &of_rcar_gen2_compatible, },
-	{ .compatible = "renesas,sdhi-r8a7793", .data = &of_rcar_gen2_compatible, },
-	{ .compatible = "renesas,sdhi-r8a7794", .data = &of_rcar_gen2_compatible, },
-	{ .compatible = "renesas,rcar-gen1-sdhi", .data = &of_rcar_gen1_compatible, },
-	{ .compatible = "renesas,rcar-gen2-sdhi", .data = &of_rcar_gen2_compatible, },
-	{ .compatible = "renesas,sdhi-shmobile" },
+	{ .compatible = "renesas,sdhi-sh73a0", .data = &of_default_cfg_info, },
+	{ .compatible = "renesas,sdhi-r8a73a4", .data = &of_default_cfg_info, },
+	{ .compatible = "renesas,sdhi-r8a7740", .data = &of_default_cfg_info, },
+	{ .compatible = "renesas,sdhi-r7s72100", .data = &of_rz_compatible_info, },
+	{ .compatible = "renesas,sdhi-r8a7778", .data = &of_rcar_gen1_compatible_info, },
+	{ .compatible = "renesas,sdhi-r8a7779", .data = &of_rcar_gen1_compatible_info, },
+	{ .compatible = "renesas,sdhi-r8a7743", .data = &of_rcar_gen2_compatible_info, },
+	{ .compatible = "renesas,sdhi-r8a7745", .data = &of_rcar_gen2_compatible_info, },
+	{ .compatible = "renesas,sdhi-r8a7790", .data = &of_rcar_gen2_compatible_info, },
+	{ .compatible = "renesas,sdhi-r8a7791", .data = &of_rcar_gen2_compatible_info, },
+	{ .compatible = "renesas,sdhi-r8a7792", .data = &of_rcar_gen2_compatible_info, },
+	{ .compatible = "renesas,sdhi-r8a7793", .data = &of_rcar_gen2_compatible_info, },
+	{ .compatible = "renesas,sdhi-r8a7794", .data = &of_rcar_gen2_compatible_info, },
+	{ .compatible = "renesas,rcar-gen1-sdhi", .data = &of_rcar_gen1_compatible_info, },
+	{ .compatible = "renesas,rcar-gen2-sdhi", .data = &of_rcar_gen2_compatible_info, },
+	{ .compatible = "renesas,sdhi-shmobile", .data = &of_shmobile_info,  },
 	{},
 };
 MODULE_DEVICE_TABLE(of, renesas_sdhi_sys_dmac_of_match);
@@ -452,8 +480,12 @@ static const struct tmio_mmc_dma_ops renesas_sdhi_sys_dmac_dma_ops = {
 
 static int renesas_sdhi_sys_dmac_probe(struct platform_device *pdev)
 {
+	const struct renesas_sdhi_of_data_with_info *of_data_info;
+
+	of_data_info = of_device_get_match_data(&pdev->dev);
+
 	return renesas_sdhi_probe(pdev, &renesas_sdhi_sys_dmac_dma_ops,
-				  of_device_get_match_data(&pdev->dev), NULL);
+				  of_data_info->of_data, of_data_info->info, NULL);
 }
 
 static DEFINE_RUNTIME_DEV_PM_OPS(renesas_sdhi_sys_dmac_dev_pm_ops,
-- 
2.43.0

