Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3B63FE663
	for <linux-mmc@vger.kernel.org>; Wed,  3 Jun 2026 06:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469876; cv=none; b=LMoW2iEr5/p/j93bB3mVwp1PJH7lGuK6UaK7Imt7JYUlhHtm6e+nKJiPVX6Ch28dkyql4kwBzItxiJOSJ/Nj0XMDSAtuGtUhn1oFi39lnjR1vZ5e3bvoQFpgeQCCl74cBI75k4nu/Y9BGPaGvvdOlXNMDXSRb2abLyMQMNEMqEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469876; c=relaxed/simple;
	bh=6qJpZhXyYCBf57vMMkgWvPXgE1xKgVP7wRIY8jD34Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mpeO2KMfSNZIuh6oymYNjLLLopFN1xVZVeNCtaXvL1IVccCfx2R9JQqPbjs1yNB1z7qwfrid+dixpifLTbLTMuJh8FHIDyqNfWRiyqwH/d5+hYwHbIBZZrcjiuc/SUSbhpTKEHFPa5UgdjKidgMm1Tj2Ya3cwNJWpWy9IDpqzGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JqmY/N3K; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqmY/N3K"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45eee266c6cso4628637f8f.1
        for <linux-mmc@vger.kernel.org>; Tue, 02 Jun 2026 23:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780469869; x=1781074669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WeWYYBg948WaEc/rhznTVtqdM3wH6i2nY9UUNG9eJ2w=;
        b=JqmY/N3KQXI4IP7XO0LiGqfEzOUl4Q7i09f/gduT36Xsxd+dxqxcGfmiPtkmFfB7Yh
         RJejeBBfWgICUhaOf45QtI4iw3A/qerbBT007IwUb8yNMdhW+ZxjgLKzwCm0ZhFjU4G9
         9gD+8LJZWl4Cs8Yibp+zM6oJ7+iyBZqPXkOefUSRsnNEy9VS23DsQtund5/mGnNlNkDB
         Qhvp961hBIG1zcoMGRTZXb5Tva223xc/wZ8dWXACdz+DtddfpmSK2vc9h0ixev0zOW9B
         17Oqt4TuFILrAMVHctIu/clSgOnoG9WhMEwB5HUxX9dF09nf+lwdnHlM29ItDr1w9Mbz
         iK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780469869; x=1781074669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WeWYYBg948WaEc/rhznTVtqdM3wH6i2nY9UUNG9eJ2w=;
        b=bzw9RkGQ9PEFdDOWmpWgKEp8ZB+QojNB4+TfWJJt7WRDmgnlG6bFuMOfCdZQksQXot
         k/6xg/sx/ZXF0B8uQUmEhurlfPRZdC41n72gMj7VeDqtr9AXt4/viR91bVp+CBstgo2D
         lGeEd+GIHmk41KVusDWuZwfL1j6lvhxWeDspKVPGLo4g+a3tRJCSviqywoVsV9oXFgsZ
         zh2JtuJTUX+E1BZP06hL5EhtN2XfPkToVkOcCVjswcTiz24Ubb20GnjM2kfsR4qh0t+Z
         +38YLyf0NKLAD7R5UqaDWRLxSLCdD8WLRzvEmeEPgJ+0J3UE2o/BQslrVOzXcXf6g7ID
         8g5w==
X-Forwarded-Encrypted: i=1; AFNElJ8YFC8vcW8G/8iPldr/k+dzCGDZ4+It+BPDmdKBsmX492J3jqWaaeAFQPj8eX/3qKMVjfEuTGGGA04=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzg+7VwvAhgB+ThtcDsx/8c99/tCSObYrg/jnyVg5KoQe7+9t8
	mTgyzfq7rJ2qId5Xsm7DOVqmlF7kxi/5vaaNO0r02+OFz1J/5Eixdb7Q
X-Gm-Gg: Acq92OHcJaRQrOC5G4N3XLejjkTSp6PL81gq2mC6YPuVkP4VTw8SxbVAWDft0ZM+dnQ
	kt16uZNpygmsL0lgtvcWx8ZbllMLNffKBEFEGAp6cNP+UiR2/8sT7Oe6ho8LHZkgb2aOvMuGm7U
	t1xBWiVVK7hNp4J/8gaC8jKVELwC4DMGbXWpsFnLHSqa1DVqtvC1z4ua7KkS3YkexJo8HF36nh7
	uk/m44yPjKdgH7l3YkP/5axPOEAcPt+KbdmJzMZTpuyOmjntmAwQ62BaP7cceBAS9FNK5neNtid
	tATQRVfsb8ef6N2fr7A5X7Og2aHmVYLqEgwcPmywuAi4Lt1I1cRYj+kPpczeYheXpB8XCnsZ5/2
	LeT9OpeXK9zT9xTeiAv5JPsKvncqpVtALGDD8YLXqO/c7VBoxSIklCVk93deQHQgV0ordxpXyIa
	yZzGsCE4v4xumVChLCM66qUdlpxaBCsJxFYMcvazEuqEafGDDqQkKwUakvYUemmDyfrGDftQ==
X-Received: by 2002:a05:600c:4712:b0:490:ab8b:1bb3 with SMTP id 5b1f17b1804b1-490b5ec4258mr30130165e9.18.1780469869397;
        Tue, 02 Jun 2026 23:57:49 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a700:7301:179c:89ab:19f6:9ba4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b79d90bdsm9001855e9.0.2026.06.02.23.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 23:57:49 -0700 (PDT)
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
Subject: [PATCH v17 14/17] mmc: renesas_sdhi: Add HS400 enhanced strobe support for RZ/G3L
Date: Wed,  3 Jun 2026 07:57:14 +0100
Message-ID: <20260603065731.93243-15-biju.das.jz@bp.renesas.com>
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

Add an hs400_es bitfield to renesas_sdhi_hw_info and implement
renesas_sdhi_hs400_enhanced_strobe(), registered as
host->ops.hs400_enhanced_strobe for all SCC-capable controllers.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No change.
---
 drivers/mmc/host/renesas_sdhi.h               |  1 +
 drivers/mmc/host/renesas_sdhi_core.c          | 53 ++++++++++++++++---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  1 +
 3 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index 92b66116f044..1a837d0c9479 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -48,6 +48,7 @@ struct renesas_sdhi_hw_info {
 	unsigned tuning_delay:1;	/* Has tuning delay */
 	unsigned internal_divider:1;	/* Has internal divider */
 	unsigned scc_hs400_mode2:1;	/* Has scc hs400 mode2 */
+	unsigned hs400_es:1;		/* Has hs400 enhanced strobe */
 };
 
 struct renesas_sdhi_of_data_with_info {
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 282107d06114..2a70a2e64b9c 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -274,7 +274,7 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 #define SH_MOBILE_SDHI_SCC_SMPCMP       0x00C
 #define SH_MOBILE_SDHI_SCC_TMPPORT2	0x00E /* G3L: SDm_SCC_HS400MODE1 */
 #define RZG3L_SDHI_SCC_HWADJ2		0x010
-#define SH_MOBILE_SDHI_SCC_TMPPORT3	0x014
+#define SH_MOBILE_SDHI_SCC_TMPPORT3	0x014 /* G3L: SDm_SCC_HWADJ3 */
 #define SH_MOBILE_SDHI_SCC_TMPPORT4	0x016 /* R-Car */
 #define SH_MOBILE_SDHI_SCC_TMPPORT5	0x018 /* R-Car */
 #define SH_MOBILE_SDHI_SCC_TMPPORT6	0x01A /* R-Car */
@@ -298,8 +298,9 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 #define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_REQUP	BIT(24)
 #define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_ERR	(BIT(8) | BIT(24))
 
-#define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL	BIT(4)
-#define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN	BIT(31)
+#define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL		BIT(4)
+#define SH_MOBILE_SDHI_SCC_HS400MODE1_ENHANCED_STROBE	BIT(30)
+#define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN		BIT(31)
 
 /* Definitions for values the SH_MOBILE_SDHI_SCC_TMPPORT4 register */
 #define SH_MOBILE_SDHI_SCC_TMPPORT4_DLL_ACC_START	BIT(0)
@@ -574,6 +575,8 @@ static void renesas_sdhi_adjust_hs400_mode_disable(struct tmio_mmc_host *host)
 static void renesas_sdhi_reset_hs400_mode(struct tmio_mmc_host *host,
 					  struct renesas_sdhi *priv)
 {
+	unsigned long val;
+
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
 			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
 
@@ -583,10 +586,12 @@ static void renesas_sdhi_reset_hs400_mode(struct tmio_mmc_host *host,
 
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DT2FF, priv->scc_tappos);
 
+	val = ~(SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN | SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL);
+	if (priv->info->hs400_es)
+		val &= ~SH_MOBILE_SDHI_SCC_HS400MODE1_ENHANCED_STROBE;
+
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2,
-		       ~(SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN |
-			 SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL) &
-			sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
+		       val & sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
 
 	if (priv->info->scc_hs400_mode2)
 		sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HS400MODE2, 0x0);
@@ -783,6 +788,41 @@ static int renesas_sdhi_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	return ret;
 }
 
+static void renesas_sdhi_hs400_enhanced_strobe(struct mmc_host *mmc,
+					       struct mmc_ios *ios)
+{
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+	struct renesas_sdhi *priv = host_to_priv(host);
+	u32 val = sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2);
+
+	if (!priv->info->hs400_es)
+		return;
+
+	if (ios->enhanced_strobe) {
+		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_CKSEL,
+			       ~SH_MOBILE_SDHI_SCC_CKSEL_DTSEL &
+			       sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_CKSEL));
+
+		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DTCNTL,
+			       ~SH_MOBILE_SDHI_SCC_DTCNTL_TAPEN &
+			       sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_DTCNTL));
+
+		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT3, BIT(8) | BIT(9));
+		sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HWADJ2, 0xFF);
+		sd_ctrl_write16(host, CTL_SDIF_MODE, SDIF_MODE_HS400 |
+				sd_ctrl_read16(host, CTL_SDIF_MODE));
+		sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HS400MODE2,
+			       RZG3L_SDHI_SCC_HS400MODE2_HS400EN2);
+
+		val |= SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN |
+		       SH_MOBILE_SDHI_SCC_HS400MODE1_ENHANCED_STROBE;
+	} else {
+		val &= ~SH_MOBILE_SDHI_SCC_HS400MODE1_ENHANCED_STROBE;
+	}
+
+	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, val);
+}
+
 static bool renesas_sdhi_manual_correction(struct tmio_mmc_host *host, bool use_4tap)
 {
 	struct renesas_sdhi *priv = host_to_priv(host);
@@ -1333,6 +1373,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		host->ops.prepare_hs400_tuning = renesas_sdhi_prepare_hs400_tuning;
 		host->ops.hs400_downgrade = renesas_sdhi_disable_scc;
 		host->ops.hs400_complete = renesas_sdhi_hs400_complete;
+		host->ops.hs400_enhanced_strobe = renesas_sdhi_hs400_enhanced_strobe;
 	}
 
 	sd_ctrl_write32_as_16_and_16(host, CTL_IRQ_MASK, host->sdcard_irq_mask_all);
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 83d348fb5eeb..a021ebb46070 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -277,6 +277,7 @@ static const struct renesas_sdhi_hw_info sdhi_hw_info_rzg3l = {
 	.tuning_delay = 1,
 	.internal_divider = 1,
 	.scc_hs400_mode2 = 1,
+	.hs400_es = 1,
 };
 
 static const struct renesas_sdhi_of_data_with_quirks of_r8a7795_compatible = {
-- 
2.43.0

