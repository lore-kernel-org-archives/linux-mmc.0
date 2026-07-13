Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0737A345CC0
	for <linux-mmc@vger.kernel.org>; Mon, 13 Jul 2026 17:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783965127; cv=none; b=qGZhZTMMyv8v4nQlynNXAqqZC/D82Y+xs9EQK+sWBiZ+foPTT0NMsoW/NIfesqM8KhqIQP/+FPfaYgqNKUNdNhmOkHSoJWYyhrNL8GEXvtfckrCbYUKp+rGvH6xdCijwvFCFtCiWe33MfLhZDy5bmBUKkpxpAKsXzT6Bdk171iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783965127; c=relaxed/simple;
	bh=/FGwBoak+K1dZ3DgCaKeto6pzKCz+zzDgtJUpzrYq3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qCMEI4J0GkRuRK8Syc5EdZ5KLnCVrFyk2XIWMeKgXA/pqTEM6VCIHS8ziZqUUDfHXK413A2v63cxf1MDuENuBJ/IIE56kGV2Yl8QjldFpYWCj2v2WnGI/WzgF8IthgnRFDPoFkbpsh8EKtxe3WJLEEXiKGL8WKrKQUiVK/DbLH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKHSLgPF; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKHSLgPF"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4720d22c94aso93868f8f.1
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jul 2026 10:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783965124; x=1784569924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iyfVj+1fDts4apxcCqosk3edydtohs7g/ZwBDxQKGmY=;
        b=fKHSLgPF+C4FAkP7zFEJNT4LfRo/pSZE5V0RsdpEFUNl8oVF6FVs//SrTweBAn4CvW
         ltbotEN6JO3gFSmuL9eKmfjDs5aNLsnKH+m418GpJqVB4l7mEseSdnd8BT0S9vJC1RCG
         aZZWDqkBo06nkVrPsZ4qTJNWWhI4512KFjGxGaJZ4uoW+5OTF6dUzOPUzOAjpC7/K1xm
         dSy4dhhjvOVnd2ErwJGGOhB+atHES5WkICkLv9ighOskAujutbaK9l57vbs0kvDqaSFl
         jYBPtOM9koPnYRbZXH/SYWR/eYxW5WDqfVk80+3KTqf9TW0aY86wK7xNNpVMGbJF12Ta
         5WQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783965124; x=1784569924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iyfVj+1fDts4apxcCqosk3edydtohs7g/ZwBDxQKGmY=;
        b=cCtO2jaHXHnJ0kMLKA74LSzD9f87mg0Ly76cp1winIBpedoPSSlwHre5r5It0rg5ZW
         ghAfRo7BOPdR0xb18pXdSFPfS7gm0vsLPKRFF0nGO267jSUZydcKRCQiItcoOsHA/7D/
         X5+95yw9OzL9MSgnpAq9IG9L8uT6W99x+5sOEddUlVtzsqn1NosUYViLay2T8cGazqya
         8IiTwdATyeMgGQdqqi5dYp6vQRtKmCXTDZHm/Gk1sDKowYu+BEOFoTYDTKjBbydj11g1
         yvjgAErRZQHpZKNAaJ4uFzzhZPO29ybSl5rBxaN0xBz4gONrZjDvVsUs5mINOgECfRBR
         sL5g==
X-Forwarded-Encrypted: i=1; AHgh+RqkpXSR/5G0djnTbTFASNKPS/c4vHdqFUg2b1Va3T+7hQT9OtodmCOOmzqVTbqHJ3D/xBdSdj/86T8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCBjvHft09CW9CtDuaQ3ByySD5FVLUvR4RrF/eTtEl/WnkMjlg
	hVskRW2hmkLgx5e65C+vRFqXYB6CIk/vBccYeAXj9IUR/3jKa7jMfmwo
X-Gm-Gg: AfdE7cmZLICyuzpp8HKcnqUhTfUZgQZ7QVrcp2/3Inv4wDAojrAz79QZSB+nLCVWiIt
	O4MnMb7qfqHgOemkSJJnJ/JSn7k6HPP1LYn83OkRo6O9en6Zbd9b1HFswyjZYj2I5Fvw0DZ4Eu/
	3cNXZvq3F/4QGRhcfWAh/eyUgw5NGlB6B4umB7PyFOAcomNfHaKXyo8f/MYD20+6THrl3BpdqCw
	Q1mep7sZnOup5jvUpVgYdre2yUZSEWrLJAwfnCICruZr3/ThKlILukMoRq4/TNCopXMTwQczAzv
	ReDzMzxlmigBBvK54NSxXC4nX4cRAxjuNdKrOf9XYwfEMi5yOtvMKr/BajD6njlLRdprEg36W/e
	14Flo7L0gu6TbF7EH23BiEtis3AAto4yAgXUbN2wH5ZissUAwIBfLkK58OvqAFYQOvAPUeNRfQy
	PajHyFQDUPU3zWlElH1pbxm+NIr13JzEGHXlu5dg==
X-Received: by 2002:a05:6000:1a88:b0:47e:81aa:def0 with SMTP id ffacd0b85a97d-47f2dd215c1mr11680288f8f.61.1783965124369;
        Mon, 13 Jul 2026 10:52:04 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:c899:4fec:2bdb:b719])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464d6fa7sm1011037f8f.37.2026.07.13.10.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 10:52:04 -0700 (PDT)
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
Subject: [PATCH v20 02/12] mmc: renesas_sdhi: Clean up whitespace and add OF table sentinels
Date: Mon, 13 Jul 2026 18:51:43 +0100
Message-ID: <20260713175159.138334-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713175159.138334-1-biju.das.jz@bp.renesas.com>
References: <20260713175159.138334-1-biju.das.jz@bp.renesas.com>
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

