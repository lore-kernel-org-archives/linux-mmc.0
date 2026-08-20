Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC1F489863
	for <linux-mmc@vger.kernel.org>; Thu, 20 Aug 2026 17:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787246242; cv=none; b=kAs7tQs0ssJLmctNaRU+gwz/e9o6YhdyiKVcr8u+PPcU9BLHO/jCGsI7/G1Lj1oHpxEsCBdoJnAY4CpUdN9DBooz89U6h3ECyfjfa+d4BalFiA0Ao65EC/TlJZ1PSQepi2gFcNfV44n+Wsg0+zzsVN5cqVa7Eo2vD/ChhC3ScIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787246242; c=relaxed/simple;
	bh=/D3sAoqU+MeT14mSSA6gTS+Z3nkAtgml2Luib8E7qmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gW31TkCukiXMPXGi4M6joz5jGE6NPG/f5YR6egUEwkd2iSXxr8JMRJmCWWj+i4obPoHB6Xc/5e8Fdra51wiVO6TcnR184INmIGe3CN5pCfy5RKvlrXrnPngk0cK3Wz3EkqwgWwTa/4hwizh0a2JnneXy8y70hXmVdiVexQyAvUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTVVAIOD; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTVVAIOD"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-499b0eefa61so394415e9.2
        for <linux-mmc@vger.kernel.org>; Thu, 20 Aug 2026 10:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787246235; x=1787851035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VXrYMLQOAJ1MDGDIN0etPVycCMAfznFnFAv9LaQaKX4=;
        b=iTVVAIODoeyz5+FlDz/SUJ9MVH2cgevOtcyYtZZb2+UZP38Xw7mrNrUxv27vFk4W0q
         tZ6kOp5UW8Vy9Y6dx6sDRZ9wMx0T+d7Ib8ArRbTv/DNFOx7UGX0okFpx7llEIoVFX62r
         43gVRI5fGMZlcR4zcIJF+2HzdCLk1aUexExChqmSwR3h1d2wwuQLxP+C+Fnrd/T5gUaA
         x5okTEStZZaiXI5dskrVsWQ++WQEQ23lIb9+tmYHtHhiO3FnxbWIjdb5l5fDFRobW5fm
         SI8JO0ImAvUHxWcxKGmGzeowtHbajDiHTtFo5X9E1Zi7V9xvPlctMv8zr4Cumawh1c6Z
         h1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787246235; x=1787851035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VXrYMLQOAJ1MDGDIN0etPVycCMAfznFnFAv9LaQaKX4=;
        b=HIoOnR/XIGaIkSiouSN8tIj8aJFRKskHY5SxdgMHdD945iuNYYlxD7grSeaXxupeFj
         s1xEHqjLsy2KhRHyHp2l8lFSUqHOD1+9EtNrIXBsi6I+C1wEEeC60SFVQmQrDp7qix1m
         NsNTbdebCvLJvsLpznC2hUYGJurismK81p9j7Ub6xDVB+mKSg0VmuCuaY8fLX8270M3c
         8GaO1KpM4MQZWGAxfKEHByjccgrEjOyFnGS6A8AD8qa0sXTJrR3JpTQl6/IFfnr10Q9t
         s7GzZa8SWXqsIhLCWWPR9bvK6egncQbCVgBb7EY6ZkXrrMQvoi4F3mMDDe2tQLk0JdcC
         1o4A==
X-Forwarded-Encrypted: i=1; AHgh+RoJQ7JIoTr7xuT8SUPKy/0C/odoo/IfooeqdrC2bzQE/to1fcvfN4Y8DPDh3krdBPTyHDpiBTZZ8LA=@vger.kernel.org
X-Gm-Message-State: AOJu0YymXzku263L6DtntvM+4eGDpQ3nhdLhGOyRfKydsxgvanKd+Ydm
	eG5EfWKrZtIi8KgxdEOZ1Q8XjSjf3bXZaDkXFhJ1+SLTCzg5+iVWzSJqmL8qbw==
X-Gm-Gg: AR+sD11zdMdPbEz5u9B9hsKFXEXOxPvMXZ/xOzPAEM0+63uvUApILyCevRhqyO6zDa6
	hchdCTALim9b3S/+xMyd6KzqRDGYrSSsPfaYUr2V0WHXBGf5brwJ5d3ul0ED+N+R8Px3wJJ2N+X
	xjhM6vvEG5tUcAefd9Qp+QuBHhkEqwTE89AIFhGSUOYm1ASn3ZKML6N9SaIRg11zdHYcB0HcQP1
	AD6G0hMp3JjwK1xKkg/AKT6x5ljgMN1PCf5VrmRnI6mLI7gZ28ut7h55x4YKzkoljEehZcOeWQ2
	tPZUZmMjDLM/MKLzdd/KnPDe+B53GyH6clr+ecYkIV5p2liw0BT1NOFr8LsGaRHapQ7/0B9z3uA
	0wVwsU/i61fhjK6dmc+ohjgMWmCb5Zf2toxqaRln2ucwHAsEO4yDDvh8T/WIMpkTnftNyh+UwV2
	NcK3Won5eNIcxeGhb+XmCxNWnVIPYgsjnWK7bY4S5Zi7HEtlkP+F9oIDsDRectfbymJrR7
X-Received: by 2002:a05:600c:a088:b0:499:7a19:408b with SMTP id 5b1f17b1804b1-499b83572bbmr8819065e9.11.1787246235358;
        Thu, 20 Aug 2026 10:17:15 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:eda0:8ef1:e1ab:c2b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa0fd728sm219313495e9.3.2026.08.20.10.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 10:17:14 -0700 (PDT)
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
Subject: [PATCH v24 15/15] mmc: renesas_sdhi: Add HS400 enhanced strobe support for RZ/G3L
Date: Thu, 20 Aug 2026 18:16:45 +0100
Message-ID: <20260820171657.62815-16-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

RZ/G3L's HS400 enhanced strobe mode needs extra SCC register
programming beyond the standard HS400 path. Add a TMIO_MMC_HS400ES
flag (bit 17) for controllers that support it.

Add renesas_sdhi_hs400_enhanced_strobe(), registered as
host->ops.hs400_enhanced_strobe when the flag is set. On enable, it
clears DTSEL and TAPEN, programs TMPPORT3 and HWADJ2, sets the HS400
interface bit in SDIF_MODE, sets HS400EN2 in HS400MODE2, and sets
HS400EN plus the new HS400MODE1_ENHANCED_STROBE bit in TMPPORT2. On
disable, only the enhanced-strobe-related bits are cleared.

Also mask off HS400MODE1_ENHANCED_STROBE in
renesas_sdhi_reset_hs400_mode() when TMIO_MMC_HS400ES is set, for a
clean reset on mode exit.

Since a controller reset clears these SCC registers,
renesas_sdhi_reset() now re-invokes
renesas_sdhi_hs400_enhanced_strobe() after reset whenever
TMIO_MMC_HS400ES is set and the controller is currently in HS400
with enhanced strobe active, restoring the enhanced-strobe state
instead of losing it across a reset.

Enable TMIO_MMC_HS400ES in of_data_rzg3l to finalize RZ/G3L HS400
support.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v23->v24:
 * No change.
v22->v23:
 * No change.
v21->v22:
 * Updated commit description.
 * Restored the patch after fixing inode corruption.
 * renesas_sdhi_reset() now restores data strobe register values
   after reset.
v20->v21:
 * Dropped the patch due to inode corruption during boot.
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
 drivers/mmc/host/renesas_sdhi_core.c          | 68 +++++++++++++++++--
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  2 +-
 include/linux/platform_data/tmio.h            |  3 +
 3 files changed, 68 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 5d9d3c7dedf9..fc58f2188852 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -340,7 +340,8 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 #define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_REQUP	BIT(24)
 #define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_ERR	(BIT(8) | BIT(24))
 
-#define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN	BIT(31)
+#define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN		BIT(31)
+#define SH_MOBILE_SDHI_SCC_HS400MODE1_ENHANCED_STROBE	BIT(30)
 
 /* Definitions for values the SH_MOBILE_SDHI_SCC_TMPPORT4 register */
 #define SH_MOBILE_SDHI_SCC_TMPPORT4_DLL_ACC_START	BIT(0)
@@ -636,6 +637,8 @@ static void renesas_sdhi_adjust_hs400_mode_disable(struct tmio_mmc_host *host)
 static void renesas_sdhi_reset_hs400_mode(struct tmio_mmc_host *host,
 					  struct renesas_sdhi *priv)
 {
+	u32 val = ~(SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN | host->pdata->osel_tmpout);
+
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
 			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
 
@@ -645,10 +648,11 @@ static void renesas_sdhi_reset_hs400_mode(struct tmio_mmc_host *host,
 
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
@@ -679,6 +683,53 @@ static void renesas_sdhi_scc_reset(struct tmio_mmc_host *host, struct renesas_sd
 		       sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL));
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
+		val &= ~(SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN |
+			 SH_MOBILE_SDHI_SCC_HS400MODE1_ENHANCED_STROBE);
+
+		sd_ctrl_write16(host, CTL_SDIF_MODE, ~SDIF_MODE_HS400 &
+				sd_ctrl_read16(host, CTL_SDIF_MODE));
+
+		sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HS400MODE2, 0);
+	}
+
+	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, val);
+}
+
 /* only populated for TMIO_MMC_MIN_RCAR2 */
 static void renesas_sdhi_reset(struct tmio_mmc_host *host, bool preserve)
 {
@@ -703,6 +754,13 @@ static void renesas_sdhi_reset(struct tmio_mmc_host *host, bool preserve)
 			/* Unknown why but without polling reset status, it will hang */
 			read_poll_timeout(reset_control_status, ret, ret == 0, 1, 100,
 					  false, priv->rstc);
+
+			/* Restore data strobe registers */
+			if ((host->pdata->flags & TMIO_MMC_HS400ES) &&
+			    host->mmc->ios.timing == MMC_TIMING_MMC_HS400 &&
+			    host->mmc->ios.enhanced_strobe)
+				renesas_sdhi_hs400_enhanced_strobe(host->mmc, &host->mmc->ios);
+
 			/* At least SDHI_VER_GEN2_SDR50 needs manual release of reset */
 			sd_ctrl_write16(host, CTL_RESET_SD, 0x0001);
 			if (priv->rdev)
@@ -1410,6 +1468,8 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		host->ops.prepare_hs400_tuning = renesas_sdhi_prepare_hs400_tuning;
 		host->ops.hs400_downgrade = renesas_sdhi_disable_scc;
 		host->ops.hs400_complete = renesas_sdhi_hs400_complete;
+		if (host->pdata->flags & TMIO_MMC_HS400ES)
+			host->ops.hs400_enhanced_strobe = renesas_sdhi_hs400_enhanced_strobe;
 	}
 
 	sd_ctrl_write32_as_16_and_16(host, CTL_IRQ_MASK, host->sdcard_irq_mask_all);
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index afe259c1566d..c64993ee3ec5 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -179,7 +179,7 @@ static const struct renesas_sdhi_of_data of_data_rzg3l = {
 			  TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2 |
 			  TMIO_MMC_64BIT_DATA_PORT | TMIO_MMC_TUNING_DELAY |
 			  TMIO_MMC_INTERNAL_DIVIDER | TMIO_MMC_HWADJ |
-			  TMIO_MMC_HS400MODE2,
+			  TMIO_MMC_HS400MODE2 | TMIO_MMC_HS400ES,
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
 			  MMC_CAP_CMD23 | MMC_CAP_WAIT_WHILE_BUSY,
 	.capabilities2	= MMC_CAP2_NO_WRITE_PROTECT | MMC_CAP2_MERGE_CAPABLE,
diff --git a/include/linux/platform_data/tmio.h b/include/linux/platform_data/tmio.h
index 88a3744f965a..ca1435441628 100644
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

