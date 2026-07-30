Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD25A417369
	for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785411130; cv=none; b=eZEDEoqJe+Q1wP3Sxx0TPtnxg6gIa0OQoDmO21enGbFW+HRGZ3zu/z2lebPWMEXE+YkW0jCXsRV3mMuHaeSf/D3Vmz4mmwhPIGbHaleu0IAjhb++v8GTN94yF1JqMR5CL5170RKjReyFmOa/7qhlWmc10jLmUQQ3Zu/nz6hwNC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785411130; c=relaxed/simple;
	bh=whcyjtG0+hhh5KeRVkFYr3pGCx9D/bFoL0ggUWSo/vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RT+9sQ+ipDZ0EjeUQTEgO/lbw/4qneG5XWhAJdZFzFMygBIPRtJ//qVZKKvZrgCkzYVvKCUhCXNVyOErV67364n6VzvIBoVvy271kD1IfZxkiq1f6H75DQ57DKDBx9eBlgdaph7UqtaOZ/iXLcgQRQBFhbWbBFzG9pwrHbgsx9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rK40+098; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rK40+098"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47f703a9e5dso941646f8f.0
        for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 04:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785411126; x=1786015926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=505oIgk72o91zMELTQZjenr02tky02BeZpzR3q2ANy0=;
        b=rK40+098PlxSnfdzumebx2h6ppGjX5Fu2t5gHT7M0I301oIyYTow9UBzYbdydyWVfB
         ApsXItFKmtoUgVUP9gAhnksIYOyKF5f6iM1/gWR3ydvOoC+BcZz2GkuP9FyHjAd9dAeh
         6351+OSSvmzUtXZDt7yKu/otlz/Dtv27gb9XLqlnwEIsfr34ZLNSUBuViDs8Mwlp0mTp
         FKfndQgJEVpSOckqek71Xl8EDz3K6eO+K4r4CZCGTd2gg7lMT7JqD6PvYoOrQcMFn2Jn
         21kfvPNeBbD+7sUNsOMiKM63ev8AJ+7TfZcbji/mS/7boQAqRyoBElNN6l76GIfvjpjN
         2qxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785411126; x=1786015926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=505oIgk72o91zMELTQZjenr02tky02BeZpzR3q2ANy0=;
        b=e8FUkN3ftCcOuEhlFRWnh+NTVdyhKle/0kYmXsv83Ii+EuF01XZZM/MV4tL+xEZqbk
         AK2/sjnIzzVbhSmT7JGRaEwqAjkpAeFxl40jnKtKrJc8DZAyHE5GEIJOpfvVshi1rAM3
         y20XFAB7mmlZHTDOvWh07NIPov2+AgZ+UDhuYaWxsqF5+jVwnqrBBp48L8/XQowf7ttB
         CxSnPSoShPeGrBOxDXJK++yFDvQKdiP/b+wjEYDpQ+cFlf25PDixjMSN6srlPmPvNKku
         +RsZa2y+/uphzzIiZq06Evp+GfwcGF4Gp0fTTEBUCiczLU/US4OOfOhSvyzQiG+KNsF7
         w1Mw==
X-Forwarded-Encrypted: i=1; AHgh+RpGNN6WDqWIzmGHIs83pAiFk1HJitbT3jzhBjfxwcfm1aB+grskw6vu+vOpKk24C5JIhQyRh/V/CzI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy91iyd7g8ES8BA/vZAjsePcCXH3cPFAs3AqI+CmaiiEusP6ACO
	s5XAo4h8r0qTc0oDMDDPTFlacO6Pyz2uYq7ToVQmbuzxWNXw5JHEIGuN
X-Gm-Gg: AR+sD10WHFRvBWo8BHRhx0RnkHmlB1YPtPC+Qk44+Hsc0vCKM47GyxmRiQd6LTcl48M
	chVVJUC2MZoIOOzRoaDjNDx9Fn+MioRNqIMrJeucLjLhdsJSy8ID9smEC9IP/UwT8bEoa6hf+1a
	wpUYcTMCU7QfyzinpGqCytBIW4SvlmZdnbCFWVOdbHnE0XkFScnl5oDaEsXaHM1tcoSBihy5pX3
	WJ+ZjE45Is8n5ihg7FNPTXsDfFJiJEjwcfVxASYAUqCV7w7oCdPPhbL5EPB65gJHVym4X6XlkwC
	UQanru73FhDwHcB1Gr5AZ2lsu+xDOxSafIED3gSnu2LKRLCpp3VPuQE/HygKA3SbEAILCC5R7Rl
	HUhVAHNHbh1WpQz/H8hhI5vHQ6hUr6tZ/6hpC6Pn4SNkb6DW2Sl4RZcfgOXVGH8U5SVPgSXa0dY
	YBK2PWNj517uXni0vNmz8dWi6l6hEcD58oemRfepsFi7lF1DzLlsB8Cwtq6uI0H+qY19oc0LqHN
	FO3FfC8CZvd3UccmBWs9I+i
X-Received: by 2002:a05:600c:1553:b0:497:ff4c:246 with SMTP id 5b1f17b1804b1-49800e8666dmr29514525e9.16.1785411125880;
        Thu, 30 Jul 2026 04:32:05 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:eabf:a623:1e7d:c359])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc89351e3sm5737947f8f.29.2026.07.30.04.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 04:32:05 -0700 (PDT)
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
Subject: [PATCH v23 02/14] mmc: renesas_sdhi: Clean up whitespace and add OF table sentinels
Date: Thu, 30 Jul 2026 12:31:40 +0100
Message-ID: <20260730113200.36456-3-biju.das.jz@bp.renesas.com>
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

Clean up coding style inconsistencies across the Renesas SDHI host driver
files. Remove redundant internal spacing in the struct definitions and
static initializers to enforce a single space separator or uniform tabs,
aligning the code with standard kernel formatting guidelines.

While at it, add a "Sentinel." comment block to the empty terminating
entries of the Open Firmware (OF) device matching tables to improve
code readability and explicitly mark the table boundaries.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v22->v23:
 * No change.
v21->v22:
 * No change.
v20->v21:
 * No change.
v19->v20:
 * No change.
v18->v19:
 * Updated commit description.
v17->v18:
 * Merged patch#4 and #5
 * Updated commit description
 * Annotate the empty sentinel entries in the OF match tables with a
   "Sentinel." comment for clarity.
 * Retained the tag as it is trivial cleanups.
v1->v17:
 * No change.
---
 drivers/mmc/host/renesas_sdhi.h               | 2 +-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 6 +++---
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index afc36a407c2c..09bf9b24a8c3 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -25,7 +25,7 @@ struct renesas_sdhi_scc {
 
 struct renesas_sdhi_of_data {
 	unsigned long tmio_flags;
-	u32	      tmio_ocr_mask;
+	u32 tmio_ocr_mask;
 	unsigned long capabilities;
 	unsigned long capabilities2;
 	enum dma_slave_buswidth dma_buswidth;
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 0c3967f758c2..b3f4a5f8dec0 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -271,8 +271,8 @@ static const struct renesas_sdhi_of_data_with_quirks of_rcar_gen3_nohs400_compat
 };
 
 static const struct renesas_sdhi_of_data_with_quirks of_rza2_compatible = {
-	.of_data	= &of_data_rza2,
-	.quirks		= &sdhi_quirks_fixed_addr,
+	.of_data = &of_data_rza2,
+	.quirks = &sdhi_quirks_fixed_addr,
 };
 
 static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
@@ -293,7 +293,7 @@ static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
 	{ .compatible = "renesas,rzg2l-sdhi", .data = &of_rzg2l_compatible, },
 	{ .compatible = "renesas,rcar-gen3-sdhi", .data = &of_rcar_gen3_compatible, },
 	{ .compatible = "renesas,rcar-gen4-sdhi", .data = &of_rcar_gen3_compatible, },
-	{},
+	{ /* Sentinel. */ }
 };
 MODULE_DEVICE_TABLE(of, renesas_sdhi_internal_dmac_of_match);
 
diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index 426308b73b49..7ae488e5c1e0 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -27,7 +27,7 @@
 #define TMIO_MMC_MIN_DMA_LEN 8
 
 static const struct renesas_sdhi_of_data of_default_cfg = {
-	.tmio_flags = TMIO_MMC_HAS_IDLE_WAIT,
+	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT,
 };
 
 static const struct renesas_sdhi_of_data of_rz_compatible = {
@@ -89,7 +89,7 @@ static const struct of_device_id renesas_sdhi_sys_dmac_of_match[] = {
 	{ .compatible = "renesas,rcar-gen1-sdhi", .data = &of_rcar_gen1_compatible, },
 	{ .compatible = "renesas,rcar-gen2-sdhi", .data = &of_rcar_gen2_compatible, },
 	{ .compatible = "renesas,sdhi-shmobile" },
-	{},
+	{ /* Sentinel. */ }
 };
 MODULE_DEVICE_TABLE(of, renesas_sdhi_sys_dmac_of_match);
 
-- 
2.43.0

