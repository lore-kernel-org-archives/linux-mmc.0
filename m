Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9644A3148DD
	for <linux-mmc@vger.kernel.org>; Mon, 22 Jun 2026 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782143780; cv=none; b=da9A7JYeqYz5Hd4J2SNPeLRmpqyMQnbJju6cQmPkW13txGgLHmL1Ex/7EgdEagD7lkybjG6vKYbRNMTIzzeLFiz9dRSDD0c1L0BkbR5qnXE7eUNJt+SLvZ6DKhVbKn6HY7NXdOAxX0WFQpLIWZHjYkxJMuch8QO7MeZoLN9p/7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782143780; c=relaxed/simple;
	bh=EkYC+u14GA00HAaiP7CjwOkISPXvzMkhhVS9iWJbHDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=skWkTx24WsWEUjv9UeZ2tL4ZdcdyyqPOcqSMWgtWCQY9orGHzqAxtTNj3BHGAB6YZWA/LTmogx+5r2fzZSFoop8OlP2tcca9V0Y02A1+jM2N7EKzPRfPC/5WRyBqRM/CEzxnrCB4ZqQccrNpwHY3Y/gBZF+YBZnmGbjlZHuu8iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgV/y1Cz; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgV/y1Cz"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490b1bbcf3aso30070005e9.1
        for <linux-mmc@vger.kernel.org>; Mon, 22 Jun 2026 08:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782143777; x=1782748577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdxW1AuEnueb828iRQ599rSsY8k5+AArSQFa+n9iykA=;
        b=AgV/y1Czv7YJVjQZKJ8g19O5o93cr4tN13tbKSPDmMZQ+CvyBHFRsHJ/R4FeoJWIUU
         u/ka4PIA1uGsxpolc25xxAPXjJQ3PxUgaowenu6Hy3Ppkx0I4Y0kU+nHLHtkGe5m6ocB
         JV+gtTIbGZQWAFcR4lL6W82IFKAXFBF554tQBo2MZYzd2qF70IOsznNXK7OV/gTmlaHB
         EoC4aR1C78RAwuBQfEwZv09UDRytSN1VGd/lfd5vXxpE0UF7CzHdKGN+L9fTR/wLFkpw
         kvjCIvqM3e9/dCXNXR7OqF2d7B1ajM3JNIeGoRNL4rlxS7HFJUXD2uaaOTk6tWWoCtWY
         VTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782143777; x=1782748577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TdxW1AuEnueb828iRQ599rSsY8k5+AArSQFa+n9iykA=;
        b=mXCWoBRJYN6VxFhV71xInkM3JhsTRrTUEZxWwpdeVD41Vn0YhbzAPuUX6KziGu8aOB
         8mlTgZ4iZTCtKLd84Af1q2OilUwGx9gZjWztUdutwqJDzaYyTEMu+xQycfoZXT4ABB79
         V8RU+wAmcafnEqDB8d7zXRf/+bNHFDPlas2lSkmx157EI5rMapzvYNi1zNuec+iqs/5K
         1HsqM64imuni/cCdKiGFapLW1ISpOAfX5YWBX74Mou2M98WFkYudJ3qbaaIlLgUdJ/h5
         DewXhZABq6SSOzewdIvBvNhzw7fViYPbdQRiKv0FDvjPgrp1kh4WGVhS2u8YuDb02h/t
         nB1Q==
X-Forwarded-Encrypted: i=1; AFNElJ+wQ0BXI/tqXUMvAaGTAtrQ/c8jDvM0SH6nBoTIVMruDx+vyj679ThgfOmgIDAVvdVbRs/M+lXEUBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJQmevGsAU7iIeGpuwfxtHMtX29g9D/ZCGMKL0yLuiW3fFNBFk
	2TpYRrimf3CJoTJQR0+DsSLGSYi/PwTBhF8HCwY2zNphdQWaJ4nfI80fKRepng==
X-Gm-Gg: AfdE7clYGCFlq3N9Jxh1k7AJ2Rsus+ZC61WhTtkTcsVzMBPIQAC73xy+sncku86QN45
	zWsNIqIpwKLqJh2Blj/NER0z4VkHFS6JcuPQofXpsTwIyIz/NJ+InQ1SZ5al9kR4ozl/ACGg5gs
	G6/XF7hLpLPjxNc/2rL51Ot/6SsTMXgmnR/gg6KIqc5mfRmDnvK5VXznpYeJXCkhBr/2qa03h1h
	FtOy0pvnfTnp1yuvhKIScusgSESLs9oD/YLSpexa0DMa1ijmmDj5v9hW8EcyQWn9pkzCc/uhTfN
	rkVpmxM2gthdsKSZVOKQxgmrcsh6JdLql9grvnQ0F5iV3mZ4mAv/LREl5BufQASgE6hLltLzbYZ
	EDDYkNGeYqaJoDWUe7cJmyouZ/aBhm8aTVQCkX1hHq0qU5PdM9OjLjRTMT/bH3YXIiIDN8uUG//
	IKZ8VIYKH9OYNIBTPY0vJsXquqzfJXgE+t5q1B+w==
X-Received: by 2002:a05:600c:609a:b0:492:3fbc:556f with SMTP id 5b1f17b1804b1-49249083b99mr166963805e9.2.1782143777032;
        Mon, 22 Jun 2026 08:56:17 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:fdf9:c68d:5fce:b1ef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923ff8a9e3sm331778025e9.14.2026.06.22.08.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 08:56:16 -0700 (PDT)
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
Subject: [PATCH v18 02/12] mmc: renesas_sdhi: Fix whitespace alignment in struct renesas_sdhi_of_data
Date: Mon, 22 Jun 2026 16:55:53 +0100
Message-ID: <20260622155610.184271-3-biju.das.jz@bp.renesas.com>
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

Remove extra spaces in the renesas_sdhi_of_data struct definition,
replacing the tab/space mix used to align tmio_ocr_mask with a single
space, consistent with kernel coding style. Apply the same alignment
fix to other struct field assignments and initializers in this and
related files where the surrounding style was similarly inconsistent.

While at it, annotate the empty sentinel entries in the OF match
tables with a "Sentinel." comment for clarity.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
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
index 024edc4e5fe6..990e3d18d560 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -272,8 +272,8 @@ static const struct renesas_sdhi_of_data_with_quirks of_rcar_gen3_nohs400_compat
 };
 
 static const struct renesas_sdhi_of_data_with_quirks of_rza2_compatible = {
-	.of_data	= &of_data_rza2,
-	.quirks		= &sdhi_quirks_fixed_addr,
+	.of_data = &of_data_rza2,
+	.quirks = &sdhi_quirks_fixed_addr,
 };
 
 static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
@@ -294,7 +294,7 @@ static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
 	{ .compatible = "renesas,rzg2l-sdhi", .data = &of_rzg2l_compatible, },
 	{ .compatible = "renesas,rcar-gen3-sdhi", .data = &of_rcar_gen3_compatible, },
 	{ .compatible = "renesas,rcar-gen4-sdhi", .data = &of_rcar_gen3_compatible, },
-	{},
+	{ /* Sentinel. */ }
 };
 MODULE_DEVICE_TABLE(of, renesas_sdhi_internal_dmac_of_match);
 
diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index 9215600f03a2..13f9a25f4722 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -28,7 +28,7 @@
 #define TMIO_MMC_MIN_DMA_LEN 8
 
 static const struct renesas_sdhi_of_data of_default_cfg = {
-	.tmio_flags = TMIO_MMC_HAS_IDLE_WAIT,
+	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT,
 };
 
 static const struct renesas_sdhi_of_data of_rz_compatible = {
@@ -90,7 +90,7 @@ static const struct of_device_id renesas_sdhi_sys_dmac_of_match[] = {
 	{ .compatible = "renesas,rcar-gen1-sdhi", .data = &of_rcar_gen1_compatible, },
 	{ .compatible = "renesas,rcar-gen2-sdhi", .data = &of_rcar_gen2_compatible, },
 	{ .compatible = "renesas,sdhi-shmobile" },
-	{},
+	{ /* Sentinel. */ }
 };
 MODULE_DEVICE_TABLE(of, renesas_sdhi_sys_dmac_of_match);
 
-- 
2.43.0

