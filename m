Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91A03CC338
	for <linux-mmc@vger.kernel.org>; Mon, 22 Jun 2026 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782143791; cv=none; b=fQbzJNAlUuBJMFw1twgIgWSsED8E3uTCujAth8tESGCKDdNP8XlaHlYguxBeWtTN7ib0Mr/tNGeHAU0Qzw1K9ds1NlWmCnC2Xdr3kq6fepvnyrDVd+iq/wH5kvDOYYl3eRV80NT7lNETpYaRajURHYV6L0/4wdM3VlRO1TBRFY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782143791; c=relaxed/simple;
	bh=emcPNcFdIze9bE29hR1bHTjwqVNPSqHIZoEO8Hz86Tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=btWEzo/srD4eMlZWqfrvH7+kA0cNePuC7yDdnj/op7xHUVl63n+CQvq3zXwA34gfOx1J1KjADgjHgIQMPFsnjR7l/dQeKS7tuEkecBJm9CKb7OURWNHXykoVpA0t6nIInJ6CVbXAA+5jlolihHpD8VGhnz6vGoRdc/GmS4u1Ups=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=do/dxuv1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="do/dxuv1"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490cdae130cso22247105e9.0
        for <linux-mmc@vger.kernel.org>; Mon, 22 Jun 2026 08:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782143786; x=1782748586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1oAQSq9f8aRycZVjVE2TObaVOiHYiBPk/NWVZakwuc=;
        b=do/dxuv1F8YjD7jlu+WBEJuabc5g8Es7Y92aiWCywNFIKZpPxkE36aRUF6HPs4gtQ1
         l03vrSa61rVm4YWRM3B3xLORNq68mhsF+fFBU6jdJkTpdCWQUZYtvKoZdXK7lB1hzLIL
         MHJ2QZVwuK1can5f4NKQfOtjW+Wq0WusyqkZMK2Py+jP0kCUMPwjbgUVINuo4HYtq2Du
         d4oHXWSwC13T/cnXolfRMdUxTQY8wxPbTLH1mRxwrAM78ajs0S5cMJCrtm2v8geMhAuq
         AuNS/qac4cOKoFjzM+29BjTsthc+4aI38X7cY0OkN5w5OZEZG+6jqoU4+AERyhfioxS0
         raPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782143786; x=1782748586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+1oAQSq9f8aRycZVjVE2TObaVOiHYiBPk/NWVZakwuc=;
        b=Uk/bJw7iMZOtnN0IKTyeO/MPRtMhKhlnzper6Lz0V3Dr9at6GuKjCT9TGFvoQ3KUVq
         G67ztUUEXmeBmFzD6ACb+WSPlnQOmvLHcD0igpHTqBBKK7Ng4887HgHG7qpSJrslCTl4
         TIsCZ5eRU7a3ZjaVEeNhTqT+64JqiSmjL8/gvYXMTOmA9GkDE8tNUsv6dnRTEWi9PEN6
         T40g24qVKNnY2MHWGY7iYasQVxAs2ESNkWMr8I90Qd88TXX5RBE6RgPLzFWiMw6urxUU
         zg0/vsBSq0SkbYLFAgYjRoN/plTkbGVGr5CVEeZeGtlcfC7mDlkWER5eKVW/yS5MLCog
         1BAg==
X-Forwarded-Encrypted: i=1; AFNElJ9TdjFVgdvGtBHUqI/3YLKX2UomzqK4LoaAw0OiAOE1lykPDLlYoDduk1WIpIskkjJBDB3zNLTi/sQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCYlD+u2gNaR02TgCW12rMs1qpn1N5ht+tqytZ+18QNHxSwscf
	9MlmYdh5Oj2kZsnnWAJYs26cPOx22OTdcv3ONISSt+sMgv8GFRUNldAi
X-Gm-Gg: AfdE7clLF/CfcVX1Z5xEYzstBNHjSSB+s8ace7Lh6OpnU9RvkOantv/4QdZiQ9eT8CA
	e/erZXACvZj2Xk6BlAXyGbqZZIAYe4WfRfsUYTDvBTMBxcwl9Ok/hlHeBEff4a4MZ5OW+YS2czZ
	NklTQkkMoQfsVMM05mLZrRSvozwYPKJ3/yWgBE0EqwdYrstMyV9JJDgVHVDIXjbka3qZG7Q7qin
	myofp8Y78izyZJ1oAGZmSXQo0jUqw4BPgyqVxe6p2MgoHojdBBlaTAjFQKpHlOpa6c2wT7Pmwmk
	pKoblx3UMQHIGBlBGI03wEp2ANfoPBZaA96i8cr8Ib7maOHODKJSFQiLZPJfsgLxUXR1bZVqx9f
	nE2DuABO3RKGdHjwRotN3ofInXpKmxcxNaHxvH43NufGjXnW2ZMjBSpphb8yCuvZYKqtHJLyRj6
	zz9WEzFrcevMFUBYRfgki7TqSz2rmZC+lR2mWDgA==
X-Received: by 2002:a05:600c:c088:b0:492:2f3c:d0ed with SMTP id 5b1f17b1804b1-4923f594511mr234197905e9.30.1782143785921;
        Mon, 22 Jun 2026 08:56:25 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:fdf9:c68d:5fce:b1ef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923ff8a9e3sm331778025e9.14.2026.06.22.08.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 08:56:25 -0700 (PDT)
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
Subject: [PATCH v18 12/12] mmc: renesas_sdhi: Add HS400 enhanced strobe support for RZ/G3L
Date: Mon, 22 Jun 2026 16:56:03 +0100
Message-ID: <20260622155610.184271-13-biju.das.jz@bp.renesas.com>
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

RZ/G3L supports HS400 enhanced strobe mode, which requires additional
SCC register programming beyond the standard HS400 path.

Introduce a TMIO_MMC_HS400ES flag (bit 17) to identify controllers
that support enhanced strobe. Add renesas_sdhi_hs400_enhanced_strobe()
which, when ios->enhanced_strobe is set, disables DTSEL in
SCC_CKSEL, clears TAPEN in SCC_DTCNTL, programs SCC_TMPPORT3,
sets HWADJ2 to 0xFF, enables the HS400 interface mode bit in
CTL_SDIF_MODE, sets HS400EN2 in HS400MODE2, and raises both
HS400EN and the new HS400MODE1_ENHANCED_STROBE bit (BIT(30)) in
TMPPORT2. On exit from enhanced strobe, only the enhanced strobe bit
is cleared. The callback is registered as
host->ops.hs400_enhanced_strobe for all SCC-capable controllers.

Update renesas_sdhi_reset_hs400_mode() to also mask off
HS400MODE1_ENHANCED_STROBE from TMPPORT2 when TMIO_MMC_HS400ES is
set, ensuring a clean reset on mode exit.

Enable TMIO_MMC_HS400ES in of_data_rzg3l.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v18:
 * New patch.
---
 drivers/mmc/host/renesas_sdhi_core.c          | 48 +++++++++++++++++--
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  2 +-
 include/linux/platform_data/tmio.h            |  3 ++
 3 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index efc8bd1d2422..f1acdf07e8f0 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -299,7 +299,8 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 #define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_REQUP	BIT(24)
 #define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_ERR	(BIT(8) | BIT(24))
 
-#define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN	BIT(31)
+#define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN		BIT(31)
+#define SH_MOBILE_SDHI_SCC_HS400MODE1_ENHANCED_STROBE	BIT(30)
 
 /* Definitions for values the SH_MOBILE_SDHI_SCC_TMPPORT4 register */
 #define SH_MOBILE_SDHI_SCC_TMPPORT4_DLL_ACC_START	BIT(0)
@@ -580,6 +581,8 @@ static void renesas_sdhi_adjust_hs400_mode_disable(struct tmio_mmc_host *host)
 static void renesas_sdhi_reset_hs400_mode(struct tmio_mmc_host *host,
 					  struct renesas_sdhi *priv)
 {
+	u32 val = ~(SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN | host->pdata->osel_tmpout);
+
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
 			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
 
@@ -589,10 +592,11 @@ static void renesas_sdhi_reset_hs400_mode(struct tmio_mmc_host *host,
 
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
@@ -797,6 +801,41 @@ static int renesas_sdhi_execute_tuning(struct mmc_host *mmc, u32 opcode)
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
@@ -1355,6 +1394,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		host->ops.prepare_hs400_tuning = renesas_sdhi_prepare_hs400_tuning;
 		host->ops.hs400_downgrade = renesas_sdhi_disable_scc;
 		host->ops.hs400_complete = renesas_sdhi_hs400_complete;
+		host->ops.hs400_enhanced_strobe = renesas_sdhi_hs400_enhanced_strobe;
 	}
 
 	sd_ctrl_write32_as_16_and_16(host, CTL_IRQ_MASK, host->sdcard_irq_mask_all);
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index bce8f4bb6cf2..b342d963032a 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -176,7 +176,7 @@ static const struct renesas_sdhi_of_data of_data_rzg3l = {
 			  TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2 |
 			  TMIO_MMC_64BIT_DATA_PORT | TMIO_MMC_TUNING_DELAY |
 			  TMIO_MMC_INTERNAL_DIVIDER | TMIO_MMC_HWADJ2 |
-			  TMIO_MMC_HS400MODE2,
+			  TMIO_MMC_HS400MODE2 | TMIO_MMC_HS400ES,
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
 			  MMC_CAP_CMD23 | MMC_CAP_WAIT_WHILE_BUSY,
 	.capabilities2	= MMC_CAP2_NO_WRITE_PROTECT | MMC_CAP2_MERGE_CAPABLE,
diff --git a/include/linux/platform_data/tmio.h b/include/linux/platform_data/tmio.h
index fe8cdc057e5a..c74b9865e65d 100644
--- a/include/linux/platform_data/tmio.h
+++ b/include/linux/platform_data/tmio.h
@@ -62,6 +62,9 @@
 /* Some controllers have HS400mode2  */
 #define TMIO_MMC_HS400MODE2		BIT(16)
 
+/* Some controllers have HS400ES  */
+#define TMIO_MMC_HS400ES		BIT(17)
+
 struct tmio_mmc_data {
 	void				*chan_priv_tx;
 	void				*chan_priv_rx;
-- 
2.43.0

