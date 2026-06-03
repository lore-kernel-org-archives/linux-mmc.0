Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61CD3FC5A1
	for <linux-mmc@vger.kernel.org>; Wed,  3 Jun 2026 06:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469868; cv=none; b=b8MsSYh/wBT2Edk4SpeY0BQTqG1zBfoqFvoRxdO4Rtd2lSAH6od+KO0dAZDrLN4btBxD0cke/oFpWdeilYBPRhY2XY0EkpmxvR4WTmuxzpuuwGJ2HDXmsE0EXn/OIGHkcG25zrqIICKs1yUYcJE63OCiaV9Kk6eUlT38fBEFVSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469868; c=relaxed/simple;
	bh=0xf+hP5rWVHXOKLQ6AuUcMvnJdEpIeucNgsnnDWzESc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VH6Jcfcu11K6RebdiqypPjNtCYPiX9fslm9LmuthQ6U38iAzwUE90Pm+dyjpc9DC1zRpGNwVcNYJTmTEWuiah62LN62aGe1PjbIqBgyQ9sx4PLTqbZlcnPjaU+mX8cr9B4yyzajqja4afSt8tv3wt0pfxvT7Stsd2YOUbEruTFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNFp4Gqs; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNFp4Gqs"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490b3e03939so2578055e9.1
        for <linux-mmc@vger.kernel.org>; Tue, 02 Jun 2026 23:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780469863; x=1781074663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HwqViYMj+duoG+HGmmKtoADFYA5MQk3J3/I4ySPOkzY=;
        b=aNFp4GqsnSGTkDO1c+xra1FqvIQkLJGYPz60TD9pebQFRr3KzGR3j+QoWJ5UKoiSkH
         gOMlvEdG91mImeBFPszRZ1SKkX8CS1tjiGT1BCDVs2uJytNKxqQBHu8HG9tkgWjxsOLx
         /4+YMe3H79OedA6Q2s4Ynzv1PsVE0+8zvmZYSEHy6P/mct4qVq49EXuDFu/xNHPo09YI
         oAJ6RMfGkgv06OwqeZjDaZWXf0KvgtJB5CbyOY56PZbRGJRdfxaKwSQhO0S/DuoYPOpK
         i8Iv5qRzzWEpm2YwxIb3Ap9iMn80T7LE8Y7qL3+qOFrJLCS8SLJY+K6gelN23+ZofP+7
         Qiew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780469863; x=1781074663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HwqViYMj+duoG+HGmmKtoADFYA5MQk3J3/I4ySPOkzY=;
        b=GzAWBoXrlgVCzLiehsWjuBm7bCmkdw73MrJ3LX6UPputEzODmsLDQaiJH3wOVbeqtE
         hM9x28ES1dBeJYFX+fj8c7l2kzf/2INrEiRP0ovNPGcyRXDlmcWmooVvAial+yz6TMl3
         zP0cNkskYLVl0mF6gAP9iTkmCJbO0BrCYk5f8WdIwnEyYwnlvWakDqt5eWVMjI6Scorb
         EdlllORvcHkDSHFju6Z8oPHMod0WgSvOho/ykReKa9XtLIjZTwIGLW22NlMrQsSYYu8A
         fhvnAfDdU0yKeulndeB/lEvtCyUrbNetiI3MAfpYmGP04SSwQC4dBso/hT/WJ/MmAJK8
         IMDA==
X-Forwarded-Encrypted: i=1; AFNElJ8stHEr1xETw0iDHVgfU7HT9LeYVXQ7FvpfkK858IDWaUMpJD9W9ZE7zFMDa8464j5b19sDuySWAjc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9g4pEHI/NM93yxkQKIWc39HJIS6yLjSzpsX+bORGHk2sIg+RV
	ZvX+tyPJM1VVBClinqOmDHYLaxBrqpzsccVzU6cRC+HI6729xbCHgiEK
X-Gm-Gg: Acq92OHer4s7LJ4Ke18uLUV6Hay3UCqAmfCpIiUytDwa5pV6mamjDPOzHI1nAlbBgBk
	JuAZXfy7owzaUMAWpDmGKzA5BsBfXxSasaEjZohIfKh1LhBOPCNvUvhFuVqyBHJ8edbeD+saoO3
	m+LUCQvMjkMT5ZMKwfhFmmSO7mfbmuWHLYB0YyGxklQsbOaRHBN3pJbUh+grbeWioffs22itfd4
	KseRNncmymtyo4CpF8xsxhdtTFtPQSCrf4k9n6aOGLRqu9QiLB/MC7Z2Iz7tOU0o/qtC38byvfg
	fWMHsqlmvpHUvoX60TXWm9bQl376Y8Kw31YV2MMuOwlyyKVvKvrMOZqvMVggH2EKRPtZcotZfrG
	qeG80tZ0yPdDm+rs0NvOlhvBsCth1UVpceJLyQnqiGr20NJtOl+r8JhYND/aCWPP/OwYCFM2yTA
	lXHVmZe55ARigamxN7k2Ydx9Wo/0PR8TCMkVjFiCdy5rkR8fB0YDv7ZJF9ZP8=
X-Received: by 2002:a05:600c:3586:b0:490:b080:4835 with SMTP id 5b1f17b1804b1-490b5ed385fmr26303835e9.0.1780469863125;
        Tue, 02 Jun 2026 23:57:43 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a700:7301:179c:89ab:19f6:9ba4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b79d90bdsm9001855e9.0.2026.06.02.23.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 23:57:42 -0700 (PDT)
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
Subject: [PATCH v17 07/17] mmc: renesas_sdhi: Add max_divider to renesas_sdhi_hw_info
Date: Wed,  3 Jun 2026 07:57:07 +0100
Message-ID: <20260603065731.93243-8-biju.das.jz@bp.renesas.com>
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
v1->v2:
 * No change
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

