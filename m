Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6965A3CAE70
	for <linux-mmc@vger.kernel.org>; Mon, 22 Jun 2026 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782143790; cv=none; b=ELJxYTwqntx9zxITgO9SiMVgrv47Vv1cUNs4i/ZFZpMoRUCSpkFJg13zuD+xRCdWLZgpatlGedEUUybHI3Bs6bxuKIV9CEDsj5IU+inx6kucsnUwmXphfh2s4Z1ysF8ljZhzYDie3X8dDnu3UDP+ggqK9kh1PBuoNO5UUCOkhxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782143790; c=relaxed/simple;
	bh=NjGzZ8pEMWwTTJV+EMPOwX+fWltDubxdn/JlKN3jbOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+s00VXZSwm2QCnS7OQ4Zev8ak7zecLXEq/w0m3V7+HZl40Is4easH6vgrR7DOVRpb5ygby/crlqS+rLzhzORsawB8P5xBID2NYSImo0IrGRIswqfsKZHSVMFpQ5Y2Ft5iWpQkTvYL3oaqa4abhrNuhB/0peVDKIWzESCqg/5ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nCmteVXw; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCmteVXw"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490cf3000f0so48471995e9.1
        for <linux-mmc@vger.kernel.org>; Mon, 22 Jun 2026 08:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782143786; x=1782748586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8bfzq+cgm8ruH5qsF5XCt9vRYuliueX4fzvLe6neUBI=;
        b=nCmteVXwLSxOWj50amg6TPWymqYeUrr7QZfnmtJwjN7C67UrtC+TmoJymVmhaR92rt
         3ffLT8Li0f6HAdE0eIIKwp2DwcaRAhGBcDhJNwEJBC7xtHwIBazluTJxvxYCvLcsqjjQ
         Iq6HiT61VnUpKjDst5NA+QaVDvyYomIKovkLc6Pher8SbVce6piLypZsVPK4zeQZ2lga
         7CGqNDV5aYG33q5ytAUDFMbWGvkMc9BSibxz+jrhvJwT03tujXJUDWqfCFXRKoug8Vhz
         DUAuk9vFBR72m0sbE4x5A4x9D5gOgLOIcQFwDAIPxl88/pUvyyzKainaDfWNnsMcB0bq
         SagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782143786; x=1782748586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8bfzq+cgm8ruH5qsF5XCt9vRYuliueX4fzvLe6neUBI=;
        b=doxmqG0EGpuaohsgo1P5/6jRZBEgkoDjzx4kIrDeuEVMA+l3R82jk2CpXHpKv1umlN
         QvMyruOj9JQVsyiBc4aSNMqou0IMo0McdXo53WJwxcWwNWmeDC3WmDmhYf3eHiGOWmgT
         8VVHzcc5FasrR10+4dVBxAnYWLeyInEwmHQmVZ+qD9tzNp6lXRASeC/pAPDMp1ZeJ1bQ
         GSi9eo8o91R+RktzuAKVqgFErn82vR/ekc0nhbf7kk+tHdqF6V4BbqGDfR6ogCep2SDY
         qyFY7qVGAut1zNqCbi3A2gutDOx4zOCHasYvJCNbZ6w//0+wOhy0sywf7PDNU4IXczv1
         +LZw==
X-Forwarded-Encrypted: i=1; AFNElJ8oTzyiiRutu35ikO/bKdrs3C9yDTFf6Uy6+62Aq8KSuT1m9P9ILC5xA+ewse7VrFbbMcDdUZrPbzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNgCLZoV9hgR4n8eFnwVyxzY7plSoAqFlOH2JBt5oKaKWAOlt1
	FQ9Ui8FhD7VHs+z7hv/cGjTiW47dWPuxdggp5N2PbcPcErMQ4tirz3QB
X-Gm-Gg: AfdE7cl0+LiwtlVAmvgo4FRemjyHnLxErXZ77NoO2wYBOTvdTUYoqW1jBB/WJLFe0r4
	ad4/jrPEPrrRSlJWhoJsw2y5/zIIYJHK97Yx4uUyG9HSIf+VuuHtK3y0Yx4nIiiZI3zpTlKObdw
	cs0nX/i5CYfqqVTWX7rWBw5a1WJvSNCy8/XM3qgAdmEI6OarPCTdS0vbrWeJYOYZgeW25biuvdc
	XcluyHObpozzwwwnViagFo1JXsImaix7gBwmYAzoOAnljtLHfPA66eU32VJqcaSjDKr/XmdZl+j
	JwoBeYZaimyThwzvEqoZrqOw4/ZsR7BBwazrIs1/2HQFSHt36wuoQ6dHnV7m4soNe30pLWTrZiu
	OH1hUxLJg0m/fmEjqJaSb19RCyCtVXCw4i5LqjKqb7zeywwzjQux6I79V044FTDKpKvazln7JR2
	ZAFlMEO0i38Sd8iW2wxFoFo/U8+UWXB//jJuzjcg==
X-Received: by 2002:a05:600d:6451:10b0:492:463d:b2af with SMTP id 5b1f17b1804b1-492463db33amr140858185e9.31.1782143785248;
        Mon, 22 Jun 2026 08:56:25 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:fdf9:c68d:5fce:b1ef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923ff8a9e3sm331778025e9.14.2026.06.22.08.56.24
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
Subject: [PATCH v18 11/12] mmc: renesas_sdhi: Add RZ/G3L HS400 support
Date: Mon, 22 Jun 2026 16:56:02 +0100
Message-ID: <20260622155610.184271-12-biju.das.jz@bp.renesas.com>
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

Add HS400 support for RZ/G3L SoC.

RZ/G3L requires a dedicated HS400 enable register (SDm_SCC_HS400MODE2
at offset 0x020) in addition to the existing TMPPORT2 path used by
R-Car. Introduce a TMIO_MMC_HS400MODE2 flag (bit 16) to identify
controllers that need this second register.
When the flag is set, renesas_sdhi_hs400_complete() additionally sets
HS400EN2 in HS400MODE2, and renesas_sdhi_reset_hs400_mode() clears
it on exit. During tuning, when both TMIO_MMC_TUNING_DELAY and
TMIO_MMC_HS400MODE2 are set, the lower 16 bits of TMPPORT2 (TMPOUT)
are masked off while preserving the upper bits, replacing the previous
unconditional write of zero.

In renesas_sdhi_clk_update(), force clkh_shift to 1 when
TMIO_MMC_INTERNAL_DIVIDER is active and the timing mode is HS400,
allowing the SoC's internal divider to be bypassed for that mode. Adjust
renesas_sdhi_set_clock() to halve actual_clock when
TMIO_MMC_INTERNAL_DIVIDER is set, and guard the clock divider
calculation against a zero clock value.

Enable TMIO_MMC_HS400MODE2 in of_data_rzg3l, completing HS400
support for RZ/G3L.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v18:
 * New patch.
---
 drivers/mmc/host/renesas_sdhi_core.c          | 33 ++++++++++++++++---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  3 +-
 include/linux/platform_data/tmio.h            |  3 ++
 3 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 42645480b62f..efc8bd1d2422 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -186,8 +186,13 @@ static unsigned int renesas_sdhi_clk_update(struct tmio_mmc_host *host,
 
 	clk_set_rate(ref_clk, best_freq);
 
-	if (priv->clkh)
+	if (priv->clkh) {
+		if ((host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER) &&
+		    host->mmc->ios.timing == MMC_TIMING_MMC_HS400)
+			clkh_shift = 1;
+
 		clk_set_rate(priv->clk, (best_freq >> clkh_shift) * priv->divider);
+	}
 
 	return clk_get_rate(priv->clk);
 }
@@ -206,7 +211,8 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
 		goto out;
 	}
 
-	host->mmc->actual_clock = renesas_sdhi_clk_update(host, new_clock);
+	host->mmc->actual_clock = renesas_sdhi_clk_update(host, new_clock) /
+		(host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER ? 2 : 1);
 	clock = host->mmc->actual_clock / host->pdata->max_divider;
 
 	/*
@@ -227,7 +233,7 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
 	}
 
 	clock = clk & CLK_CTL_DIV_MASK;
-	if (clock != CLK_CTL_DIV_MASK)
+	if (clock != CLK_CTL_DIV_MASK && clock != 0)
 		host->mmc->actual_clock /= (1 << (ffs(clock) + 1));
 
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clock);
@@ -274,6 +280,7 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 #define SH_MOBILE_SDHI_SCC_TMPPORT5	0x018
 #define SH_MOBILE_SDHI_SCC_TMPPORT6	0x01A
 #define SH_MOBILE_SDHI_SCC_TMPPORT7	0x01C
+#define RZG3L_SDHI_SCC_HS400MODE2	0x020
 #define RZG3L_SDHI_SCC_HWADJ4		0x022
 
 #define SH_MOBILE_SDHI_SCC_DTCNTL_TAPEN		BIT(0)
@@ -306,6 +313,7 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 #define SH_MOBILE_SDHI_SCC_TMPPORT_DISABLE_WP_CODE	0xa5000000
 #define SH_MOBILE_SDHI_SCC_TMPPORT_CALIB_CODE_MASK	0x1f
 #define SH_MOBILE_SDHI_SCC_TMPPORT_MANUAL_MODE		BIT(7)
+#define RZG3L_SDHI_SCC_HS400MODE2_HS400EN2		BIT(0)
 
 static inline u32 sd_scc_read32(struct tmio_mmc_host *host,
 				struct renesas_sdhi *priv, int addr)
@@ -441,6 +449,10 @@ static void renesas_sdhi_hs400_complete(struct mmc_host *mmc)
 			host->pdata->osel_tmpout) |
 			sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
 
+	if (host->pdata->flags & TMIO_MMC_HS400MODE2)
+		sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HS400MODE2,
+			       RZG3L_SDHI_SCC_HS400MODE2_HS400EN2);
+
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DTCNTL,
 		       SH_MOBILE_SDHI_SCC_DTCNTL_TAPEN |
 		       sd_scc_read32(host, priv,
@@ -582,6 +594,9 @@ static void renesas_sdhi_reset_hs400_mode(struct tmio_mmc_host *host,
 			 host->pdata->osel_tmpout) &
 			sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
 
+	if (host->pdata->flags & TMIO_MMC_HS400MODE2)
+		sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HS400MODE2, 0x0);
+
 	if (sdhi_has_quirk(priv, hs400_calib_table) || sdhi_has_quirk(priv, hs400_bad_taps))
 		renesas_sdhi_adjust_hs400_mode_disable(host);
 
@@ -739,8 +754,16 @@ static int renesas_sdhi_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	if (!priv->tap_num)
 		return 0; /* Tuning is not supported */
 
-	if ((host->pdata->flags & TMIO_MMC_TUNING_DELAY) && priv->tap_num == 8)
-		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, 0);
+	if ((host->pdata->flags & TMIO_MMC_TUNING_DELAY) && priv->tap_num == 8) {
+		u32 val = 0;
+
+		if (host->pdata->flags & TMIO_MMC_HS400MODE2) {
+			val = sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2);
+			val &= ~GENMASK(15, 0); /* TMPOUT MASK */
+		}
+
+		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2, val);
+	}
 
 	if (priv->tap_num * 2 >= sizeof(priv->taps) * BITS_PER_BYTE) {
 		dev_err(&host->pdev->dev,
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 709351693efa..bce8f4bb6cf2 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -175,7 +175,8 @@ static const struct renesas_sdhi_of_data of_data_rzg3l = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_CLK_ACTUAL |
 			  TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2 |
 			  TMIO_MMC_64BIT_DATA_PORT | TMIO_MMC_TUNING_DELAY |
-			  TMIO_MMC_INTERNAL_DIVIDER | TMIO_MMC_HWADJ2,
+			  TMIO_MMC_INTERNAL_DIVIDER | TMIO_MMC_HWADJ2 |
+			  TMIO_MMC_HS400MODE2,
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
 			  MMC_CAP_CMD23 | MMC_CAP_WAIT_WHILE_BUSY,
 	.capabilities2	= MMC_CAP2_NO_WRITE_PROTECT | MMC_CAP2_MERGE_CAPABLE,
diff --git a/include/linux/platform_data/tmio.h b/include/linux/platform_data/tmio.h
index 8b4032b24d36..fe8cdc057e5a 100644
--- a/include/linux/platform_data/tmio.h
+++ b/include/linux/platform_data/tmio.h
@@ -59,6 +59,9 @@
 /* Some controllers have hw adjustment delay */
 #define TMIO_MMC_HWADJ2			BIT(15)
 
+/* Some controllers have HS400mode2  */
+#define TMIO_MMC_HS400MODE2		BIT(16)
+
 struct tmio_mmc_data {
 	void				*chan_priv_tx;
 	void				*chan_priv_rx;
-- 
2.43.0

