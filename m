Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED9D3B9D81
	for <linux-mmc@vger.kernel.org>; Thu,  9 Jul 2026 19:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783625363; cv=none; b=Kbi0SMbp8vEAWCg3v2RydU0eGNpNb//SdYSINOG62EOLg5KZou7Woe0Etf1VKT8w15RF+qF5Z6bSdSWDZP3JyP3asqhjOIr2xxdqb56nb97SCpePA/zR1gnFGbji6hEydSOPBBZr32MFeL6M0e3J0OReb9BjR2SZ7SnrRZl6GBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783625363; c=relaxed/simple;
	bh=RA1pPksesQLMuuJZlegy8ekyMVbUZXDvoORdtGUSq+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MUcsgf12e95c7Q3mg7vlROC8tGQRFhDrlmNLku0qx69n12lrLpXdjjnaHI7z7zZt22GzAPkFhS+IIx3HejJeEaYheYmfzI3rKBNrrjhwn0cVXU55FFVUaQTVIrBibJCKMfmfC/Pf3dG7EsN5Gv8/Bc8D6oRC03J4Pyjl3WcpZhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFc/O8s5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFc/O8s5"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493d92b7db3so1212555e9.2
        for <linux-mmc@vger.kernel.org>; Thu, 09 Jul 2026 12:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783625360; x=1784230160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VTaURIADtTAC4E+hJcTTNsDUDjlzy0b4j+cqWy9wvlA=;
        b=jFc/O8s5PmWNw8IbqEEj5KVhB4yoU9gHUix0aWyP/uZryaffhzyCzbMK4nOL3UlETZ
         VtXab/V2glnCPHQwsTkoeZRRMrVwH9/GJasHPiW+nWfmaow68YqEGut4Ss/lLr8Xds7e
         6+OPznnMuNguTgcKvwlCI9sGuG32WJbPZkAwswz0Dh/2KSZgz+6H6N2XWXGjZ++lRKng
         0Wno+35Kj/0t5Mgeucvg24F1Ogn/L6SaUvS/kxVeJSTF6l6Xs2WtNI8oyIjYYZYPMVn1
         uFRkoyC0Mj46WX6U2efv/L2JGtJS9D2EcHhb8w9hNJNOD2MwSsyF4Z48IhRKZVWmzJy4
         r6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783625360; x=1784230160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VTaURIADtTAC4E+hJcTTNsDUDjlzy0b4j+cqWy9wvlA=;
        b=bqTbrBUFb2psgYsafNVBAWXaZHJUXzHlh62kLHyYOKM5nbP5njN8qiuscW6jYUDrWd
         fd3Zyidby/cZqGWjMbzec5eLRT+/u0W/4lbzJmfdbWL1POre/2HGaLBmVqByva9Sp4wh
         AgTZcJj12USnKTkmvRA58nRzV6ZFK0CMjnWOrwAGKznvSrdLEDRP8hfagV5QBx+i5Yjc
         UDSY8nfXI8Sjdk63FkwYYrsd9ZDEUFm32mp5dWodYKwFXwNik2IMR0ps+se+TySbJa0i
         86Gd7AsTFvsDtmA9mUj7Is64+8ogPx7Prhjf1VgdTIhOsswIGvQ+eHu0lC1+T6+JqKMr
         TGew==
X-Forwarded-Encrypted: i=1; AHgh+RrHPLDWj97G3pERM75vY3qa5KswAoCwDMySF4a7QlYHWyaB/WHlOSlwMmbo1TluXUsC+Ifv8mp1piM=@vger.kernel.org
X-Gm-Message-State: AOJu0YySwlr9IGfK0M5vNzIH7ii0YepWXiTUUYMhnQAKhfMqYPmDrDyD
	VhLIx5qqoqMToIZUYIAOg6ZJ+V4jAPgHwBy2Cp3cgtZbJS2wnYm0P89S
X-Gm-Gg: AfdE7cmH7BZGKMLe5LXaBX0Y+Z2VXqfwBPh7gpioVF1VKWXtYdANs4PH2bJ2Tahi2PL
	PQHi05568of29uZw/IAZ2j2SUv5u6VJfM2uJrPUAeerFCm9E68YVXbAhmEa/ZKWatkJA1GiKh64
	qmgn8CVFSHJuP1tJKq3pYAoCfa65kTySCK9y4l6Vbk/KCPytMxWoRvXJdneJNVoy+0SZ7EZEkj2
	ZAThyfi6z2o7Ofsm6VNuz3gGw8Cgg0Ig3mUn/08zIz03LByAAZWQjZNRralCVI5wffTquer/uC+
	i1jgEErGQNRnEKzWvlBiLW8Xerdrhj4CbRTfLwC7gqwnSAULC0cKSgCr6WnGzwXFiV/G4n5RuDs
	CVpUNNJ4gui26BmSJP9rKKZRmEl539fVrM8lO6fZPBlmTLMj2nY05savQleNdyI7tHtnenYbF7o
	7P+8XRqbWYdCGN1MQ5aq/m
X-Received: by 2002:a05:600c:c168:b0:493:c14a:a1ca with SMTP id 5b1f17b1804b1-493f2d06c1bmr2135285e9.3.1783625359795;
        Thu, 09 Jul 2026 12:29:19 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:8fb6:1d85:3dc1:42ab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6ccdbbsm84366045e9.3.2026.07.09.12.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 12:29:19 -0700 (PDT)
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
Subject: [PATCH v19 02/12] mmc: renesas_sdhi: Clean up whitespace and add OF table sentinels
Date: Thu,  9 Jul 2026 20:28:59 +0100
Message-ID: <20260709192916.630794-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709192916.630794-1-biju.das.jz@bp.renesas.com>
References: <20260709192916.630794-1-biju.das.jz@bp.renesas.com>
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

