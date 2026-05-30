Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2847F340A6B
	for <linux-mmc@vger.kernel.org>; Sat, 30 May 2026 16:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780157324; cv=none; b=h+9xizctRCh7+YUDsA4As8WFYqMcRVYouKa1jiNxW4KkfMtdQiCQhggWc7CBaeBUrKbY76K7CU4YqcJP05c1AHiOiVoNS5VKiuCvmnLYainL1lzGc4Jx58biUUe3KB111tFiCZseySncQU+poYOEU2G4hKqqUvMCjSwkjSE7lNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780157324; c=relaxed/simple;
	bh=+Gj+E54kIeR6azwXCnzOrh/r+OqYHYE3BfZBH52pezM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6yhI7zyR8QuUEg53L7OL6ZSbgnM31E1TVOpdXO1kprj/Edtl7JS7jir5OVLD3nI8wlM/ivsZoXmNrl34eJBoy2UXD26UOXezI1m/pOHrWdTWwAdAkneH0/waN3xPmD0cSQD5TbgSA5nXH+Gj8c1Y/XIsCOiyUz+iYeA9OCVtAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCLSwizZ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCLSwizZ"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4905e190c71so77590075e9.3
        for <linux-mmc@vger.kernel.org>; Sat, 30 May 2026 09:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780157320; x=1780762120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iODUbMAhX2RQGeC4auc1CdHGKLWe9qHj630NG6jprBo=;
        b=GCLSwizZFbuotUvxmKTCDnCgeaygpNovIc8BISX9CSLdOcHhbAGcXuIvRxwaOZ84t2
         CLTW6IS21Y83arB2DYGkAWRmuipCqEqcGq069XDxpLOiYyHDwS0Qqdm2AUIceElyMnmA
         U7/MVgpLNHo29aVFtqpc2aYYRETmP8fX7sbQsp4ZgPyea89gLW7O3C9s/HN0yhceGX77
         6ycKLAPSIbDln8cvswdjEsxTMfoSdJ1fVViFKkhH0ehtoMt8SggCiFNUh49ZaGwEw1MP
         kctOMvWgOP+7YdW5bsuReu2QxBUOi1czCKjGKR/4JqQWgig0uFYixhx/wkN4hW0I/D8T
         RdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780157320; x=1780762120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iODUbMAhX2RQGeC4auc1CdHGKLWe9qHj630NG6jprBo=;
        b=nfbt91xoDpoR3K7Fk4d1jfaSk8dQtQ2tWPn4NLajffYrkx29h6C2cNyvzluYSxcpWp
         y3Ewe7y7HfG0gGoo3dbwo05c0U728Yr6gOrzYBbjod+D2LcscB723uKqONe1M5156B83
         BmXGij+XWjWdCOYkwhv52lsQNhoS/oH2/0brv+wndLHbNTg84Nm/qaP+Y/Lfjx+nzb4X
         ELk0UWRxdczZ+sQWFWMYjJw8/wLwDj/3RPgIH7sqRFsrM3CgbJs5mgN12qS/U5KsRwj7
         VSfd9/577ekI8K79doS21UpfARhgcqE8mSRV97wmqf/0iuzpVNP++Gg9O0yseFL/mhY/
         dZNw==
X-Forwarded-Encrypted: i=1; AFNElJ8X5Dh25ODmhgxorP362+qsAShdeW6HQQcfC8sgLmgZMrnGkwF2l1+DqsnSCORDtWGk0KBMa6E26zc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy73DSzxSOBZWV9U/f2NVHaCoxZviiPHZ6OfLgLFZ9VLdyhi+tQ
	dgMTSjfLpBvi/I4vTM9zwwSiZdFzCbKqEVTIvwPxGF/sxMT42rMiVpHHLKY/6w==
X-Gm-Gg: Acq92OHWTXtMaylngJzNcLH8KWjiVsz1Gip0QasULVwltQH7zV1fCxgX/lhllsWUJdz
	hF5TDJ852Uk33jDA8skNjo5udeBZQUAbmq2vxHiP9Cp04dUa+OsPz/qstlYpRTt6xqfrq56VHnK
	U+xzbguSlWekKRwKmV28S+Afr2ynmSegu8ZhftnQXUIHWSveReRlzEVSktBh/QK4e4YHQFIDeQU
	m2msRgMs2/QpvFAKcc6hPM5VTIJ6jxHKdcizbKmNvaAzSNwk+62MkankZTWUjnUaeI1FjTEkP5i
	ecE2NQ/cFtRDV4YzsINzyhOsXVlTQPNvNIiI6Ml9640QeJcIzVPgEUb+B2HXc5p+6NLAdnbt/Ys
	JHUVhAWMIHkGqEaQQ+e4+uiPc92MQApDa27KF2yGjBgiSlrmC5Y5HmM//74iHb2YCepnXatyz9q
	ug3ZLDbLrzPHZAx9yeRXR9HskFZjxhaH+QtZKjcx7ZvX94BratMvwdONtcgPU=
X-Received: by 2002:a05:600c:c108:b0:489:201c:dc46 with SMTP id 5b1f17b1804b1-490a290ec82mr52352825e9.12.1780157320472;
        Sat, 30 May 2026 09:08:40 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a700:7301:5db6:a512:6ab4:aa07])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef35874b7sm12170799f8f.35.2026.05.30.09.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 09:08:40 -0700 (PDT)
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
Subject: [PATCH 13/17] mmc: renesas_sdhi: Add RZ/G3L HS400 support
Date: Sat, 30 May 2026 17:08:07 +0100
Message-ID: <20260530160823.130907-14-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530160823.130907-1-biju.das.jz@bp.renesas.com>
References: <20260530160823.130907-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Add HS400 support for RZ/G3L SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi.h               |  1 +
 drivers/mmc/host/renesas_sdhi_core.c          | 17 +++++++++++++++--
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  1 +
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index 10f634349da9..92b66116f044 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -47,6 +47,7 @@ struct renesas_sdhi_hw_info {
 	/* hardware features */
 	unsigned tuning_delay:1;	/* Has tuning delay */
 	unsigned internal_divider:1;	/* Has internal divider */
+	unsigned scc_hs400_mode2:1;	/* Has scc hs400 mode2 */
 };
 
 struct renesas_sdhi_of_data_with_info {
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 974acdf110d3..282107d06114 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -186,8 +186,12 @@ static unsigned int renesas_sdhi_clk_update(struct tmio_mmc_host *host,
 
 	clk_set_rate(ref_clk, best_freq);
 
-	if (priv->clkh)
+	if (priv->clkh) {
+		if (priv->info->internal_divider && host->mmc->ios.timing == MMC_TIMING_MMC_HS400)
+			clkh_shift = 1;
+
 		clk_set_rate(priv->clk, (best_freq >> clkh_shift) * priv->divider);
+	}
 
 	return clk_get_rate(priv->clk);
 }
@@ -229,7 +233,7 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
 	}
 
 	clock = clk & CLK_CTL_DIV_MASK;
-	if (clock != CLK_CTL_DIV_MASK)
+	if (clock != CLK_CTL_DIV_MASK && clock != 0)
 		host->mmc->actual_clock /= (1 << (ffs(clock) + 1));
 
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clock);
@@ -275,6 +279,7 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 #define SH_MOBILE_SDHI_SCC_TMPPORT5	0x018 /* R-Car */
 #define SH_MOBILE_SDHI_SCC_TMPPORT6	0x01A /* R-Car */
 #define SH_MOBILE_SDHI_SCC_TMPPORT7	0x01C /* R-Car */
+#define RZG3L_SDHI_SCC_HS400MODE2	0x020
 #define RZG3L_SDHI_SCC_HWADJ4		0x022
 
 #define SH_MOBILE_SDHI_SCC_DTCNTL_TAPEN		BIT(0)
@@ -308,6 +313,7 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 #define SH_MOBILE_SDHI_SCC_TMPPORT_DISABLE_WP_CODE	0xa5000000
 #define SH_MOBILE_SDHI_SCC_TMPPORT_CALIB_CODE_MASK	0x1f
 #define SH_MOBILE_SDHI_SCC_TMPPORT_MANUAL_MODE		BIT(7)
+#define RZG3L_SDHI_SCC_HS400MODE2_HS400EN2		BIT(0)
 
 static inline u32 sd_scc_read32(struct tmio_mmc_host *host,
 				struct renesas_sdhi *priv, int addr)
@@ -437,6 +443,10 @@ static void renesas_sdhi_hs400_complete(struct mmc_host *mmc)
 			SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL) |
 			sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
 
+	if (priv->info->scc_hs400_mode2)
+		sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HS400MODE2,
+			       RZG3L_SDHI_SCC_HS400MODE2_HS400EN2);
+
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DTCNTL,
 		       SH_MOBILE_SDHI_SCC_DTCNTL_TAPEN |
 		       sd_scc_read32(host, priv,
@@ -578,6 +588,9 @@ static void renesas_sdhi_reset_hs400_mode(struct tmio_mmc_host *host,
 			 SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL) &
 			sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
 
+	if (priv->info->scc_hs400_mode2)
+		sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HS400MODE2, 0x0);
+
 	if (sdhi_has_quirk(priv, hs400_calib_table) || sdhi_has_quirk(priv, hs400_bad_taps))
 		renesas_sdhi_adjust_hs400_mode_disable(host);
 
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index fb8a70d28eed..83d348fb5eeb 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -276,6 +276,7 @@ static const struct renesas_sdhi_hw_info sdhi_hw_info_rzg3l = {
 	.max_divider = 2048,
 	.tuning_delay = 1,
 	.internal_divider = 1,
+	.scc_hs400_mode2 = 1,
 };
 
 static const struct renesas_sdhi_of_data_with_quirks of_r8a7795_compatible = {
-- 
2.43.0

