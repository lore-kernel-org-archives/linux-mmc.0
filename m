Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930603BED70
	for <linux-mmc@vger.kernel.org>; Thu,  9 Jul 2026 19:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783625372; cv=none; b=ZiwdqDwr6XvzsqmvVLX1zdSKP5A7fckBmp2DhjI2X5vCNIrM+Tt5f4LawfTwgzmqFrtaFysHWxaTc+RappkqVNSZrl6j/lU6MRUTGxsFPgPwGgYOodDgPGJ3bPeEDT7RcCRph3Met1/WYfWN5qwdLQKysEjzHnLbLIacRvneVlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783625372; c=relaxed/simple;
	bh=vYuDPsDodFqWN1y9gaEu5L83M/Vnv68iVElGR33nm3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTZfcLjE60ri0iQpBD3jcwJsMYSC/Gxo6vDMqGrOA5jQVA6Qi/GiV1uejWr0NFavN8yrLfjMu459m0BBt5xNQWsBgPdqzeRuOpmhZGWKZ7cCEmxUklCjRyz3qerHj4BddexoiwSPSI983brJ6cZ7hkbMiO1+GSMW/8scHW1FBQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2dLKMdp; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2dLKMdp"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493c7902f47so1447655e9.1
        for <linux-mmc@vger.kernel.org>; Thu, 09 Jul 2026 12:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783625368; x=1784230168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fcok/IGZfr1lX6+PnoLSMpJveMLsElCbdRbkEOekdbA=;
        b=g2dLKMdpg53kodltYgVamEXSkmi1kLFRdA58ehGjlUscFOZU/54OLLS539MCOZZpBi
         Aqujk5Tw7AFHE6IQS/Q0NspfNMiSArFFc/g2UZVt4Ep4kt/xAiMTpFRTywqPPdxZwC9w
         vu2MTrkq7m55kui1znnemWybgjzaBit/cqKsVO1L0BEpoAFredkHNXeoz8XiGpS4MTsz
         bf3/bo+AS0RphfezPd7W4OQGf2IbNIaFUCaFsdP6UFGtO+079OddZDZJKBLUTpECXotL
         QYQlajeMocxHBnvHo6ItVBHYrQ3dUJR6j0x9+f7anf2O4ksLw2mwaY47JKUEpx9xepG4
         BD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783625368; x=1784230168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fcok/IGZfr1lX6+PnoLSMpJveMLsElCbdRbkEOekdbA=;
        b=LXpkGvMOwUt9C7I944Wo9HAskWTE5Bzlsh+W+kOuHondFbxg0l1LD9Gew4LQyntn0c
         tGMt6LYCLIfZK1O6mVK68YUnNEq2obctCzwERmUa72xmXykK4DArHACy0PkdteHFcHO6
         CyJ3W/k+OqwCWXvUEjMB8dPbzrMpFds1kcPtDBQaqSyXHGBYo8qJk/kJWYmwvOmir6ea
         8u1lIuhitDdGMw/2g2+eO9vR3e08I+JiYktL4EVb/bCgXJuz+Lj+yGsYSLkbTpBYNJcm
         o/nQnSllN85JFG3i55pg5p3DD8pjC63CdIt2WPEmLKPnZU35KSu1SsBzOXNQxwSsBki1
         962Q==
X-Forwarded-Encrypted: i=1; AHgh+RomfUIxz3Q+7JoGUmYZuWac8iyfi3gibtEArME9fzgL5d+NUYLSVZyUN2j52LQWFE2wE3iZKS61OJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOoXSyPhp0GcJS8r/r5p9DYlp5z1ow6gg7ZaTVO6tDpBTIfPo+
	uJv2Lf2VZ3nT6OCO/gsMWH2529DnpTcOkxLs1d+QROXcP1j13kmNH1rV
X-Gm-Gg: AfdE7cn5h9GNbTbp3Y+luLJE81ogWM/wKFelP8Ru6nWcy5c1MSZLXmscDC8A8/S1rWj
	TlTAV+Sb4ENgFsAl94LnxsqnsCPmpjImOF38dQ2nmrY6pTJzq14e9Ek/tvaSgffKDDcKhdDak+t
	sG0YbI6uhqW1dTEqNDEVld5elBz2HWA+RwJ51rn6a3DP5Vh1XtovM7V/cuOvBzdbnA2UasKEgCS
	ssAlZJgO7EYNVGgOo9tRgg4sxb2thYaD8LLE3aZiUgiTZlHtksRqj0x/To59K7+izU7OS+Rqu95
	pjw5ycB2+nZIXMzAESjNNxXLa1TWukBpKTjtQHvmgf0YXAQMJmxyT1FvAyKqGV526/iIk2I8ibx
	JJtqu9w0RDXhp/qUISTT6/KeJPZkFQDLKhiYV6mPMb/JpyFZPplZgLLC9x64hMSsoWGwqMtjv14
	nWncwaGr/ltehWWjChoOq/
X-Received: by 2002:a05:600c:8b53:b0:492:67df:3dfa with SMTP id 5b1f17b1804b1-493e6875dc0mr83805925e9.34.1783625367801;
        Thu, 09 Jul 2026 12:29:27 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:8fb6:1d85:3dc1:42ab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6ccdbbsm84366045e9.3.2026.07.09.12.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 12:29:27 -0700 (PDT)
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
Subject: [PATCH v19 12/12] mmc: renesas_sdhi: Add HS400 enhanced strobe support for RZ/G3L
Date: Thu,  9 Jul 2026 20:29:09 +0100
Message-ID: <20260709192916.630794-13-biju.das.jz@bp.renesas.com>
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
v18->v19:
 * Updated commit description.
 * HS400ES support is enabled based on of_data.
 * Fixed the space in HS400ES comment block.
v18:
 * New patch.
---
 drivers/mmc/host/renesas_sdhi_core.c          | 49 +++++++++++++++++--
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  2 +-
 include/linux/platform_data/tmio.h            |  3 ++
 3 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index ae6b7d8c5b98..894da06b0d2b 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -308,7 +308,8 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 #define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_REQUP	BIT(24)
 #define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_ERR	(BIT(8) | BIT(24))
 
-#define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN	BIT(31)
+#define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN		BIT(31)
+#define SH_MOBILE_SDHI_SCC_HS400MODE1_ENHANCED_STROBE	BIT(30)
 
 /* Definitions for values the SH_MOBILE_SDHI_SCC_TMPPORT4 register */
 #define SH_MOBILE_SDHI_SCC_TMPPORT4_DLL_ACC_START	BIT(0)
@@ -589,6 +590,8 @@ static void renesas_sdhi_adjust_hs400_mode_disable(struct tmio_mmc_host *host)
 static void renesas_sdhi_reset_hs400_mode(struct tmio_mmc_host *host,
 					  struct renesas_sdhi *priv)
 {
+	u32 val = ~(SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN | host->pdata->osel_tmpout);
+
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
 			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
 
@@ -598,10 +601,11 @@ static void renesas_sdhi_reset_hs400_mode(struct tmio_mmc_host *host,
 
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
@@ -806,6 +810,41 @@ static int renesas_sdhi_execute_tuning(struct mmc_host *mmc, u32 opcode)
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
@@ -1358,6 +1397,8 @@ int renesas_sdhi_probe(struct platform_device *pdev,
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

