Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B13353A7B
	for <linux-mmc@vger.kernel.org>; Thu, 23 Jul 2026 15:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784819446; cv=none; b=HWCDD7HvZMYh+RZfc18j9bRGWC8V2EIIQ0hGTB2mD5PFiw5X5oSVUniJv94TPQAcnh6Inh392wtx1mHqiyoVOllFlxMynSMovlGp9Wi9TqQEXfkZ/IzpKzRDwz1HYdL/TAIsb31NdBt3qOwebkFkbUHcx7LsfsNxJxAROIoWbAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784819446; c=relaxed/simple;
	bh=I9B5hCEPj/2qC6RxP9RIC4e5doT9hlNPY/U50x8w86I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hxudt0THte3fAsWfqsZKiEOWImBH6xmBW3WcqZuCqd9tLQj7se9PeqZURF+vG/P6oj87ZtCEtg/QxNCxn16J/3UzNLLOePtMsVOSslID3tvsAGFAm9a0V5Fi3hR6MJmDw1IpkGuI2sYUwNvrdDhUcDz5fvo277CQmt/4dJ57viI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IX4P664y; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IX4P664y"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47f904e80eeso685161f8f.1
        for <linux-mmc@vger.kernel.org>; Thu, 23 Jul 2026 08:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784819429; x=1785424229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lguDETuZ5pwR2oZLXb/cSJFC5IBVUlZkaMF+X+TNpZQ=;
        b=IX4P664y9ixudqWPRowA+ujrLCp6t1/ZrcafvKgLguXTLKviXV2xmh1UFrO0EO7vzZ
         eXmH49IHr1ZwhtrN3lHHNKxF4/DX/vjLjpTjBH/OYUm+ZQ5y7zkXiNeWh3jdg70scdWR
         LtyvClxkSXMkXJGu55YSE7ZKxVFfGqGK4cjUFfTDkAwzWigOPMARot+jYcJ8VTOFd40X
         MoChCouIfyIc6eIuFahSf/X/8CK08FXm8f9NDAMor+oiPy1AxQeXM6GmC2XKfBvAJ1JP
         M4MCBYiltvUufQxTpsLhu5eet7po3qSWsjpTuXMcOA6mz8+NOjyUSXxuk2/NTBTkZA7t
         prTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784819429; x=1785424229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lguDETuZ5pwR2oZLXb/cSJFC5IBVUlZkaMF+X+TNpZQ=;
        b=VSlPT7wa/qGP4g4kTBzRPquigeuTYf9KdF9ovPhuyMlVhTyWYK4FSsuwBmeVbDH0yQ
         263mIeF8UFdSpMbjiXRM8GqyhvnwwjvxbfqiL/fJVi/ImQtD1uk2wglhpuyU+Zt/xrMU
         UdliCv7mmP66qgz5bAzGfc9LG69Mu/QiYtYQCZbR9pENNkLp0+S80zAHZz9X4dIQNdR1
         HNdzmY4aMDIpuEtX/K17TsiGsURfU6yyYR0HSqNzWqHsKTaDnY04S2QrbKayDFabVp1h
         Pvz19f7MNNP2wDI8ucH4Rsj0J2KEatqlyoBEDeceUVf3Tts/STHbAHtt9Cyj5qavP7up
         VEfQ==
X-Forwarded-Encrypted: i=1; AHgh+RoZOwJSn2atRkuz0ntYUYSOutFuH6nXx16Y76C9Rai0WS2XRDyKdo8wXM7clqFotvhUQACxWvLM0GQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8gWl2Jzdh6bSF6xpVua9Gc0W+rPizQxwpPronUCoM2ejtAKuN
	bCoPyTiyx/7Gltu8x+9JB1G85INg5xfEVW4oQD2VA7Tk2mtwICAZLHb/
X-Gm-Gg: AR+sD10j7l2MCRSbekqYQvQ046xye4Fr1R8aKc3V/ejHtnwC1VTflIMp9eJ+frq3j1d
	TSRoJDQizwixDfMlTK0AqBdJGAfq8WH43335tV6rrwOfdiB+Er8WSdbMJvhGsTtPN7T6003lm5A
	bnQnsvouBLF6bA1CHiF5D+//59hNUMh0QnpQPy02Q20MQD0gJoxF6FIRh/BY3PmjmCGKTX3ys6w
	/mkYh9XeXN5iM4D1KhYLQnUYhR5XRb3iHly1JEYirULBjraH/z6/3aBz3/SS+NOk8pc7tMs+7Ur
	u/BpKEzpFerBJ7v/Dqa6p+hHKqk5ugXvoyLkDauP7fwkXLj6StUe6kShuqP6pJH1yWyegPmvh/E
	K3jtzUtvwJp4JPLRNNytOdJny71UowmYNhLPewukbER/ZHxLCbky7TyeRuJl9lTpxwzr3gazioE
	dR97o+BAGgi6KTL/YzJ5zCarYoj/g=
X-Received: by 2002:a05:6000:2507:b0:47f:9266:7cbf with SMTP id ffacd0b85a97d-47f92667d0emr2648885f8f.20.1784819429276;
        Thu, 23 Jul 2026 08:10:29 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:f073:32ed:a057:cd3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb81dcsm15886823f8f.12.2026.07.23.08.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 08:10:29 -0700 (PDT)
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
Subject: [PATCH v22 02/13] mmc: renesas_sdhi: Clean up whitespace and add OF table sentinels
Date: Thu, 23 Jul 2026 16:10:06 +0100
Message-ID: <20260723151024.318918-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723151024.318918-1-biju.das.jz@bp.renesas.com>
References: <20260723151024.318918-1-biju.das.jz@bp.renesas.com>
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

