Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5951331A43
	for <linux-mmc@vger.kernel.org>; Sat, 30 May 2026 16:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780157320; cv=none; b=qLK1aa5TiX7Gb9GgTQrYHeNuQLspnlKxTxGLV0ZqTSzI8KmgVdyscyQENvHVNF1/PuRyzkeEvTDyZrr/QM6cTHf1zKCZPRXv5JYuGxXJo174z30+0Wn471s2K6DaxPRdGa8+XaEVO0GuAhWgwhKwpyrgq4KNgHzx2jtcaeEV/JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780157320; c=relaxed/simple;
	bh=wJdWUv2MNInaY/Ix9JpLMlbTDopw1lODDQtF795isII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EJjfPeNtZAClvmVqVj6NoJqPjN6SE2KiaqGf2ENdBrQ8Bx2qBo7E/6JfvLV66pO/UCwhgw0WevTHaTqhFI5haVKiaQRvwjD7LZCWTvPgSpEiyW/2jgknzJh+fy8TLx5qpFFFbZG5s1kFjg1s6LoRNkDir6Xxp8pdeygAk9Ep6l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5ENE/Qg; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5ENE/Qg"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45ebafde87cso5538954f8f.3
        for <linux-mmc@vger.kernel.org>; Sat, 30 May 2026 09:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780157315; x=1780762115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3EFmxX3xfuUFsSfWDI4lD89MI6Ae0v7p/AERGxrwy3k=;
        b=K5ENE/Qgyd2/7i1BC/qmRY9CAgyzEpVCFLINcHSoFBGWkFEnQsrpXBmVsAS2cJnPZ8
         2cS+fzBe1CfD59dGXGzehNn0bhXGpsm9FhYSRvyZChUDP5djh9vKuZWo7gfQiCC2cKTr
         9NkHG3zS3mTWV4oAXLR3XGzGS6Em4hTHxAehvWUcKzBm/r5+vA87UK3ks8D37bzQQ06c
         s0qsNN2eJDi2CU858NvGL5CeFWlunzf3tGWhKrCnYtujEw3knBvD6v3KLsA7gmoE52jc
         D2RCrqsripLFAksT/JLbOX5NvlibZg5thIv8moJEm0h66XVFj4NVqGQYmgoEJOw+Y3XZ
         fELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780157315; x=1780762115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3EFmxX3xfuUFsSfWDI4lD89MI6Ae0v7p/AERGxrwy3k=;
        b=Z26wPsEOP5EOzrshny+t8sEb/YjMZE9GvYhpi6aXgRhvxfv35h7bA8x8JT+UmsOfGl
         BSzFTH3g6/QQxf6rfSNp7IXvixt5lo8exIMCIlzviYt+cyXt4d2lZy4sXQ3GhFjuRc7Z
         S3a6OUZSP1XeA1BhKCwLmKSwI8Q4fa+hPwcuWl+71CByCIQIpE7obtphjCR03HrFLe93
         wp1PfDCJeThJfpIu72B2Ahdq5KhZMMOE6p1IMpO2BoqU6vqVPNq53Xv33D5g9tik4cZv
         3CG2VZjTTM+5DSW6SqGSGDDAXNRoijA8tdC7Jr9SnhZ6h9FLQNT/JvtMe2Xt+vEdxFb6
         m/xw==
X-Forwarded-Encrypted: i=1; AFNElJ8k1gZl6p0jU4ZXUY+bL95AmGSiN1lOQrpqN0L+AKmIqLqLHspIGAxJxieH59iPFhab6vX7m7AP300=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE2Lm6zs/erm6f84dHdJDuiAcm2QXDZz8K4Vrq/ECPn8Bq6ewN
	HIKiNOdphBjpseS3cbww7FevckjNLUzBAFB7xX7Ht+T3qoGtRNiWUvQi
X-Gm-Gg: Acq92OHg8pKrB1ngpzkqlkQISbzQZjBsTaYLVNy2wp/ELzNWC3KtZbNVHWGTwQQ0jmO
	LTx0ZgSBjMz1VLydpccfWQHkcef8BeAOR6BsLpRUu8ZIwr260nG1Upns4G1oZHvyEC5fMPf5trY
	QXYH4Bw0G4aUHJfjqjB8elEEqLKkEWIH08pLw1KqJUrdO+RkDgmIjfK2L3K5GAUxKReLVslTMwK
	ISgJFKvwYyXSTBEHFc/gguI84qEKAg6t7Jk8iP188wTyhuMcqdofHyvNtXOmw9gvX0k2tsPacOa
	P5M9nz41mvxOeam7uCJKeOe+Q0BeAc1BS443mp6LLKVZRaS8sNrUD8LOhEa2qooZeZiMJ/H10Ij
	6BFlCuS6GHh6j9YVVPD6xVMcu9uK2n5Rni2/NyqKqcLMGmFxmDxjZkcZqiQtqdbliB3XiFYW9S7
	wzMr3gVebs0GNUVhP7mVUNNitJcVibZqWTgfIaxbTdzQnI9pvkSmo+vw/S+3A=
X-Received: by 2002:adf:e744:0:b0:45e:ea71:c6e1 with SMTP id ffacd0b85a97d-45ef6b6b8ddmr5116898f8f.21.1780157315055;
        Sat, 30 May 2026 09:08:35 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a700:7301:5db6:a512:6ab4:aa07])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef35874b7sm12170799f8f.35.2026.05.30.09.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 09:08:34 -0700 (PDT)
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
Subject: [PATCH 07/17] mmc: renesas_sdhi: Add max_divider to renesas_sdhi_hw_info
Date: Sat, 30 May 2026 17:08:01 +0100
Message-ID: <20260530160823.130907-8-biju.das.jz@bp.renesas.com>
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

The RZ/G3L SoC has a maximum divider value of 2048 compared to 512 on the
rest of the SoCs.

Add a max_divider field to renesas_sdhi_hw_info and replace the hardcoded
value in renesas_sdhi_clk_enable() and renesas_sdhi_set_clock() with
max_divider.

All existing users are assigned max_divider = 512 via sdhi_hw_info_generic
in both the internal and sys DMAC paths, preserving current behaviour.
No functional change.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi.h               | 1 +
 drivers/mmc/host/renesas_sdhi_core.c          | 4 ++--
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 1 +
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      | 1 +
 4 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index a7fc525b7218..a42934e6d49d 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -43,6 +43,7 @@ struct renesas_sdhi_of_data {
 
 struct renesas_sdhi_hw_info {
 	u64 clk_mask;
+	unsigned int max_divider;
 };
 
 struct renesas_sdhi_of_data_with_info {
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 2ff40950f209..16ed6fd8470d 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -117,7 +117,7 @@ static int renesas_sdhi_clk_enable(struct tmio_mmc_host *host)
 	 * Minimum frequency is the minimum input clock frequency
 	 * divided by our maximum divider.
 	 */
-	mmc->f_min = max(clk_round_rate(priv->clk, 1) / 512, 1L);
+	mmc->f_min = max(clk_round_rate(priv->clk, 1) / priv->info->max_divider, 1L);
 
 	/* enable 16bit data access on SDBUF as default */
 	renesas_sdhi_sdbuf_width(host, 16);
@@ -206,7 +206,7 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
 	}
 
 	host->mmc->actual_clock = renesas_sdhi_clk_update(host, new_clock);
-	clock = host->mmc->actual_clock / 512;
+	clock = host->mmc->actual_clock / priv->info->max_divider;
 
 	/*
 	 * Add a margin of 1/1024 rate higher to the clock rate in order
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 512ed70b3779..84b1b38ca465 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -234,6 +234,7 @@ static const struct soc_device_attribute sdhi_quirks_match[]  = {
 
 static const struct renesas_sdhi_hw_info sdhi_hw_info_generic = {
 	.clk_mask = 0x80000080,
+	.max_divider = 512,
 };
 
 static const struct renesas_sdhi_of_data_with_quirks of_r8a7795_compatible = {
diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index 1291970c2810..9d34551c6836 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -75,6 +75,7 @@ static const struct renesas_sdhi_of_data of_rcar_gen2_compatible = {
 
 static const struct renesas_sdhi_hw_info sdhi_hw_info_generic = {
 	.clk_mask = 0x80000080,
+	.max_divider = 512,
 };
 
 static const struct renesas_sdhi_of_data_with_info of_default_cfg_info = {
-- 
2.43.0

