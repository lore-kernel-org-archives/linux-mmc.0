Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3346351C3B
	for <linux-mmc@vger.kernel.org>; Mon, 13 Jul 2026 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783965137; cv=none; b=PTOO+D5sXner6+ABFA4EHtlkvcnZDHG1SLrC/npoB3SWwPaN8LzulbabFbrtsT1RKC9kntBBI0v5Nu23DJl8VRHQBHNtqIYpyiiGeK78yBsIR4HerUxDipFo+Kbs6SOMJDX1cKr2slXNsoyfCLPuomIY8csCrUmry2aNxyLkc8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783965137; c=relaxed/simple;
	bh=WfePVuMcyWwUoa/S8B4Za1awov3gH3tCx2h6SypzY/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbbKUNPmWIkFxAi85NeHB4K2oeyJMHZ84yw+HCzwd+R4mvV5jOISax0IQw2PHoL9Po2cv4Y1mw/zVF1/f/af+xGjB/yaq8UBTO0tScWEIBBeqhR6cJWPH2wvse2mF5JIVrFwBCF01l+QC6uH1bo52s9hcBYUCVSdBK/w1FthCBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iV7jbOus; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iV7jbOus"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-476a130c138so136168f8f.0
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jul 2026 10:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783965133; x=1784569933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JCNvx4H5sDk7dEgNHijSOPephvBQqGBDLMkUessOnek=;
        b=iV7jbOuszBCyfzKhVDEapM12C9BDSv2tDuD4qHPn+AUeSNRCPZ3C06ygXScBSeJqe4
         6/pDyW74/z+6PN6Tm6TdfiG/OJ4zyYS/IPw+89bdVUnXyDq4Itpzv9WhMqKn3H1oasLR
         Nv/R6irdRJOUFGduewP8g4EJ+JRxBewk7K00mzjPJVH3rBRbnjwvQQLuXrujXQyOilkD
         VR8xuFiwpfZdTF0vyjX07sIkew19tvpZtxrK695G7eN66H8fPoU8WHeG3i8J+uSoz5jl
         4w63Q2YePSTmWKyyhNvBoRc9JQ+5M5aWtqcBClCuPn2QrcsUt/03Fv+jIphok1T44sFT
         y8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783965133; x=1784569933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JCNvx4H5sDk7dEgNHijSOPephvBQqGBDLMkUessOnek=;
        b=WKwSMzPEXBb6g9RkAg1pbTv3RMF1+AAwE6IYobTUihLiycKN/AQcy938XpKm7jCmI5
         ZzFz0VDyEoWo0tr0kXuwE6D5T07JLKBo+m48TQ9/9VZ23XuzQXqhRYFlLWHNYRFQadya
         JpjqgMqf2/sxL31ALsXuChjKH2msdYjSYOd8NfAmmQKkCIvlXbZs8TqWAIkhNIq6uIAH
         5u68ARnoR6R3dzy1a/PxQ680+GsTkcpQk1m52XpBBh1OfjCT8DzopKNmaBlz5cEqIMKc
         7J02pPlM5g4zkl8IyjQ8TgQuC2FACMHl0ZOefbSVYvKkCXfKCf77OXUlZDexK/ynT/BE
         6TsQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr8mpVTRdlq8OD5qgVqXRUsIVPNVaax96LfASIdtM9MixGup2R1Dcynmw2wTr73KyE0wQDyQ8Gjo5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuppTyGHhhkSh05yC16T79sKM40641Dv64i9GhaFivnMsIScn+
	ths8OEJYaEQym0W1RlXYoEWxa5UL/Z48pFJTP3eOsFINszQ7ZvacK2KI
X-Gm-Gg: AfdE7ckf/IaZeVKWMQj6fN0SUjf0JpPUeRKsj3uuhEWi0SbQ9E0AwYdHeJA4IcEh7A9
	dAdh9reggtX+CY39W8jaCbpe8jcBaZgUrUZ4Cdbz+k6zG+beUuuZxM6nbYQNwNrHsYq6Rzm5xR8
	v5eVA+ZAjoZ2E9cysQ4cmo1e6rtTVCgTkljkFxkx26ogKf6/wdpk4oGpLePelZxCbgQdBywCZ2M
	FLgKeoa57XGN5LvW6Weeof79bZcSepuULA950gXGVBDN3TNaP9lquXa1s0nz2RxwCymMIXWdZPu
	oj4CILvcuydg/+IHhxfR1Xe6/loycCDkfiGh6ub24us+th2JnwL3VbqMgRRKUhyuntcNgqOm1Hw
	dcFGbqH5aTC3gud/hHNUdgY1bxYar4UHJJD5vrBeWw6YVxnjqapkp4uU3BfRQaVtRpndvN/uNLb
	voHYV8wpP5NEniojoA8yfOd+U3yWPZpRpb7i1nlA==
X-Received: by 2002:a05:6000:240a:b0:46e:483c:2262 with SMTP id ffacd0b85a97d-47f2dcdecc8mr12444575f8f.14.1783965132596;
        Mon, 13 Jul 2026 10:52:12 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:c899:4fec:2bdb:b719])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464d6fa7sm1011037f8f.37.2026.07.13.10.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 10:52:12 -0700 (PDT)
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
Subject: [PATCH v20 12/12] mmc: renesas_sdhi: Add HS400 enhanced strobe support for RZ/G3L
Date: Mon, 13 Jul 2026 18:51:53 +0100
Message-ID: <20260713175159.138334-13-biju.das.jz@bp.renesas.com>
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

The RZ/G3L SoC supports HS400 enhanced strobe mode, which requires
additional SCC register programming beyond the standard HS400 path.

Introduce a TMIO_MMC_HS400ES flag (bit 17) to identify controllers
that support enhanced strobe. Add renesas_sdhi_hs400_enhanced_strobe(),
which, when ios->enhanced_strobe is set, disables DTSEL in
SCC_CKSEL, clears TAPEN in SCC_DTCNTL, programs SCC_TMPPORT3,
sets HWADJ2 to 0xFF, enables the HS400 interface mode bit in
CTL_SDIF_MODE, sets HS400EN2 in HS400MODE2, and sets both
HS400EN and the new HS400MODE1_ENHANCED_STROBE bit (BIT(30)) in
TMPPORT2. On exit from enhanced strobe, only the enhanced strobe bit
is cleared. Register this callback as host->ops.hs400_enhanced_strobe
for controllers carrying the TMIO_MMC_HS400ES flag.

Update renesas_sdhi_reset_hs400_mode() to also mask off
HS400MODE1_ENHANCED_STROBE from TMPPORT2 when TMIO_MMC_HS400ES is
set, ensuring a clean reset on mode exit.

Enable the TMIO_MMC_HS400ES flag in of_data_rzg3l to finalize support.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v19->v20:
 * SD_CLK_CTRL clk enable turned off before updating SCC_CKSEL_DTSEL
   register.
v18->v19:
 * Updated commit description.
 * HS400ES support is enabled based on of_data.
 * Fixed the space in HS400ES comment block.
v18:
 * New patch.
---
 drivers/mmc/host/renesas_sdhi_core.c          | 55 +++++++++++++++++--
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  2 +-
 include/linux/platform_data/tmio.h            |  3 +
 3 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 4cab7a85d517..5d9a3dc814c7 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -311,7 +311,8 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 #define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_REQUP	BIT(24)
 #define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_ERR	(BIT(8) | BIT(24))
 
-#define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN	BIT(31)
+#define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN		BIT(31)
+#define SH_MOBILE_SDHI_SCC_HS400MODE1_ENHANCED_STROBE	BIT(30)
 
 /* Definitions for values the SH_MOBILE_SDHI_SCC_TMPPORT4 register */
 #define SH_MOBILE_SDHI_SCC_TMPPORT4_DLL_ACC_START	BIT(0)
@@ -592,6 +593,8 @@ static void renesas_sdhi_adjust_hs400_mode_disable(struct tmio_mmc_host *host)
 static void renesas_sdhi_reset_hs400_mode(struct tmio_mmc_host *host,
 					  struct renesas_sdhi *priv)
 {
+	u32 val = ~(SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN | host->pdata->osel_tmpout);
+
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
 			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
 
@@ -601,10 +604,11 @@ static void renesas_sdhi_reset_hs400_mode(struct tmio_mmc_host *host,
 
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DT2FF, priv->scc_tappos);
 
+	if (host->pdata->flags & TMIO_MMC_HS400ES)
+		val &= ~SH_MOBILE_SDHI_SCC_HS400MODE1_ENHANCED_STROBE;
+
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2,
-		       ~(SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN |
-			 host->pdata->osel_tmpout) &
-			sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
+		       val & sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
 
 	if (host->pdata->flags & TMIO_MMC_HS400MODE2)
 		sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HS400MODE2, 0x0);
@@ -809,6 +813,47 @@ static int renesas_sdhi_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	return ret;
 }
 
+static void renesas_sdhi_hs400_enhanced_strobe(struct mmc_host *mmc,
+					       struct mmc_ios *ios)
+{
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+	struct renesas_sdhi *priv = host_to_priv(host);
+	u32 val = sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2);
+
+	if (!(host->pdata->flags & TMIO_MMC_HS400ES))
+		return;
+
+	if (ios->enhanced_strobe) {
+		sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
+			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+
+		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_CKSEL,
+			       ~SH_MOBILE_SDHI_SCC_CKSEL_DTSEL &
+			       sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_CKSEL));
+
+		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DTCNTL,
+			       ~SH_MOBILE_SDHI_SCC_DTCNTL_TAPEN &
+			       sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_DTCNTL));
+
+		sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
+				sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
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
@@ -1361,6 +1406,8 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		host->ops.prepare_hs400_tuning = renesas_sdhi_prepare_hs400_tuning;
 		host->ops.hs400_downgrade = renesas_sdhi_disable_scc;
 		host->ops.hs400_complete = renesas_sdhi_hs400_complete;
+		if (host->pdata->flags & TMIO_MMC_HS400ES)
+			host->ops.hs400_enhanced_strobe = renesas_sdhi_hs400_enhanced_strobe;
 	}
 
 	sd_ctrl_write32_as_16_and_16(host, CTL_IRQ_MASK, host->sdcard_irq_mask_all);
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 4000673ed7f8..ea993197aff2 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -175,7 +175,7 @@ static const struct renesas_sdhi_of_data of_data_rzg3l = {
 			  TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2 |
 			  TMIO_MMC_64BIT_DATA_PORT | TMIO_MMC_TUNING_DELAY |
 			  TMIO_MMC_INTERNAL_DIVIDER | TMIO_MMC_HWADJ |
-			  TMIO_MMC_HS400MODE2,
+			  TMIO_MMC_HS400MODE2 | TMIO_MMC_HS400ES,
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
 			  MMC_CAP_CMD23 | MMC_CAP_WAIT_WHILE_BUSY,
 	.capabilities2	= MMC_CAP2_NO_WRITE_PROTECT | MMC_CAP2_MERGE_CAPABLE,
diff --git a/include/linux/platform_data/tmio.h b/include/linux/platform_data/tmio.h
index 8a5dc18d43da..75d32c8ee57a 100644
--- a/include/linux/platform_data/tmio.h
+++ b/include/linux/platform_data/tmio.h
@@ -62,6 +62,9 @@
 /* Some controllers have HS400MODE2 */
 #define TMIO_MMC_HS400MODE2		BIT(16)
 
+/* Some controllers have HS400ES */
+#define TMIO_MMC_HS400ES		BIT(17)
+
 struct tmio_mmc_data {
 	void				*chan_priv_tx;
 	void				*chan_priv_rx;
-- 
2.43.0

