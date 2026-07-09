Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1F83CF042
	for <linux-mmc@vger.kernel.org>; Thu,  9 Jul 2026 19:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783625371; cv=none; b=DaRGe58MvU+GA7rkbwfTquFkFizvx+0TLbIjAk6+jKSUu6HEHe9zyVrBBYOMO/p7AQx/a+m3IKxjpYuSc6k6adN/9ZaiPpCx26PC3ARL/vKPHlcdnfReWEppl/5zCPxtLcepTPoq0yuy8+CrKFJOqRPz8EzsByRoS7uWeJV3j90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783625371; c=relaxed/simple;
	bh=b0mC0z3mXoF94nmNC6wzgnhnW2lTB0n54RAi6RaYfpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JiXwaEXLCuMZ4I5v+7X2s6OmfPfM0lJdVY7h1y0J4B9O130oC84cWXp/i/NhIABzW3gqv9kUb95UTlQpH5i+45glOcS9H2A8aL9GWQL5P1PrHc1f+v1d1fkg/TMbAeSGUQzNhCzGpFOw4xF00p4FS5jcJdRLsGwVvBUBeqjb95E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pnfQj0Ml; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pnfQj0Ml"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493b27c7451so16466875e9.0
        for <linux-mmc@vger.kernel.org>; Thu, 09 Jul 2026 12:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783625367; x=1784230167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+7TbHB1/SqYTGYc33mM2vte9Y9gjPl8yqtjDGJQOuKE=;
        b=pnfQj0MlWkLTgkWsyimgpuOS3VpjU3rkntq88w0u2Gdzidwoso3afpmTIate7I85nK
         d6yFDG0VHLt7xzcDs/LJUycRx1hPIDqVRTLeQ+ir2z55lR8HLRKz9mx/+HYljnmLvrGW
         3AnSoPKJZryvwbWHg80JZKOBSlA1VhaOVR2PUH+pH35jBiwwnufIZwzqzU09UiVoreTT
         AcWsjDUHnSb1tmaduttzEeOPeFY0dVr6FkX95o1Xyp1QNx5xNapvf4nzarfzBYcGB3Wq
         BN0N5XckxwehEJxz2XJQrAsPEUKfM950x9Fsu+HS7SlgB3Dp8EHbFUACyzOr1ozpQZ5W
         4Alg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783625367; x=1784230167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+7TbHB1/SqYTGYc33mM2vte9Y9gjPl8yqtjDGJQOuKE=;
        b=fBbi6bSkcxAWJN+956h8iTW/1efjLrdfrC614u8frcfyka2cYID914dI8QTBU2YHKH
         naRi3M0SQ8n9CBudV/izzHe83XwRH5nwVYNX75icXiGJpSMywIDbNW/CJd2R221N2sST
         xBGtfBlK83bimdIGwirKh/eD3NcUs5X9OMXgDe6AZEFHgpBdMlW0vjMLJdJg4dy1d1jF
         sHFOoejzesMIpTgwASqwjLrqAHLxAjZ3bTYQBjHgj/sQ9D8muPgkBjTMmGeqPOA3ApzA
         p8RHArVTex93xH0QE1BBuONeMC+IpUmrVmPR2INXXoynOR/1UvZkDj3TimMYwgk2chPa
         8c2w==
X-Forwarded-Encrypted: i=1; AHgh+Rra+bsXlrxuFWuKGETR3hAjKh/bRQ9b5LzZwdXwD8/EWOnt6jxnaqO84Fdx5/W4MprJyzyX56ZaE+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkMjw/4Zb2Tsdj/XzrnQpn+7U8RWEbT0hFDxXQOK0xBft/t6u8
	kTDHMSRqV3Krekrmr1X2tSLaXYlvZFN6pu8+uTyOLkzEUKNytQdUSdE5
X-Gm-Gg: AfdE7cl2qVdqCsXF8CoO7RNWHPTFvebCXkmXR/lNCxKM3x1NB+unzHMWuynba/XExxR
	URPpe8jiKFquGosLpr4AI2r2b0ah1CtBTxffn1KF8siWaa9tjBAhZx3tcVGm5NE+GwZ+waCqIp6
	RjuKRu4rfN5VrErY59BISI/JQqxqag6w8lz8EBaKlEi9DWUW25+SUBA40idvRgvE1mwpKDBb3zh
	WPy8/yXc+HyJMViZGrhdcN9rxJMoZTyJXH+rh9UWOm0gzD1Y3WJQUqVAh0vIJ3MRC34G7rtad/s
	QyCoOwOcq0zqeQUqNBeb2c82fjADxQxUDoIvynOM1vnaIgUdKVtXeb4w70ajqGeOrtfcaNkQ5Ze
	N7uXhzrItOu5qhQvuYwYdUa/gf32xeEDmBOwdZRKhUJtZ/e/JetlYBB3SXxuRE3KG6W5fXvvFDX
	YOOkva6Sjx9TQG3HuKlRU0
X-Received: by 2002:a05:600c:46cd:b0:492:6f5c:fd8c with SMTP id 5b1f17b1804b1-493f2b3fedcmr4274115e9.15.1783625367246;
        Thu, 09 Jul 2026 12:29:27 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:8fb6:1d85:3dc1:42ab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6ccdbbsm84366045e9.3.2026.07.09.12.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 12:29:26 -0700 (PDT)
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
Subject: [PATCH v19 11/12] mmc: renesas_sdhi: Add RZ/G3L HS400 support
Date: Thu,  9 Jul 2026 20:29:08 +0100
Message-ID: <20260709192916.630794-12-biju.das.jz@bp.renesas.com>
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

Add HS400 support for the RZ/G3L SoC.

The RZ/G3L requires a dedicated HS400 enable register (SDm_SCC_HS400MODE2
at offset 0x020) in addition to the existing TMPPORT2 path used by R-Car.
Introduce a TMIO_MMC_HS400MODE2 flag (bit 16) to identify controllers
that require this second register.

When this flag is set, renesas_sdhi_hs400_complete() additionally sets
HS400EN2 in HS400MODE2, and renesas_sdhi_reset_hs400_mode() clears it on
exit. During tuning, when both TMIO_MMC_TUNING_DELAY and
TMIO_MMC_HS400MODE2 are set, the lower 16 bits of TMPPORT2 (TMPOUT) are
masked off while preserving the upper bits, replacing the previous
unconditional write of zero.

Enable the TMIO_MMC_HS400MODE2 flag in of_data_rzg3l to complete HS400
support for the RZ/G3L SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v18->v19:
 * Updated commit description.
 * Fixed extra space in HS400MODE2 comment block.
 * Updated the comment HS400mode2->HS400MODE2.
 * Dropped the updation of clk handling as it is taken care in
   previous patches.
v18:
 * New patch.
---
 drivers/mmc/host/renesas_sdhi_core.c          | 21 +++++++++++++++++--
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  3 ++-
 include/linux/platform_data/tmio.h            |  3 +++
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index caeabce7e192..ae6b7d8c5b98 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -289,6 +289,7 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 #define SH_MOBILE_SDHI_SCC_TMPPORT5	0x018
 #define SH_MOBILE_SDHI_SCC_TMPPORT6	0x01A
 #define SH_MOBILE_SDHI_SCC_TMPPORT7	0x01C
+#define RZG3L_SDHI_SCC_HS400MODE2	0x020
 #define RZG3L_SDHI_SCC_HWADJ4		0x022
 
 #define SH_MOBILE_SDHI_SCC_DTCNTL_TAPEN		BIT(0)
@@ -321,6 +322,7 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 #define SH_MOBILE_SDHI_SCC_TMPPORT_DISABLE_WP_CODE	0xa5000000
 #define SH_MOBILE_SDHI_SCC_TMPPORT_CALIB_CODE_MASK	0x1f
 #define SH_MOBILE_SDHI_SCC_TMPPORT_MANUAL_MODE		BIT(7)
+#define RZG3L_SDHI_SCC_HS400MODE2_HS400EN2		BIT(0)
 
 static inline u32 sd_scc_read32(struct tmio_mmc_host *host,
 				struct renesas_sdhi *priv, int addr)
@@ -456,6 +458,10 @@ static void renesas_sdhi_hs400_complete(struct mmc_host *mmc)
 			host->pdata->osel_tmpout) |
 			sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
 
+	if (host->pdata->flags & TMIO_MMC_HS400MODE2)
+		sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HS400MODE2,
+			       RZG3L_SDHI_SCC_HS400MODE2_HS400EN2);
+
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DTCNTL,
 		       SH_MOBILE_SDHI_SCC_DTCNTL_TAPEN |
 		       sd_scc_read32(host, priv,
@@ -597,6 +603,9 @@ static void renesas_sdhi_reset_hs400_mode(struct tmio_mmc_host *host,
 			 host->pdata->osel_tmpout) &
 			sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
 
+	if (host->pdata->flags & TMIO_MMC_HS400MODE2)
+		sd_scc_write32(host, priv, RZG3L_SDHI_SCC_HS400MODE2, 0x0);
+
 	if (sdhi_has_quirk(priv, hs400_calib_table) || sdhi_has_quirk(priv, hs400_bad_taps))
 		renesas_sdhi_adjust_hs400_mode_disable(host);
 
@@ -754,8 +763,16 @@ static int renesas_sdhi_execute_tuning(struct mmc_host *mmc, u32 opcode)
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
index 6a1b59d2e837..4000673ed7f8 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -174,7 +174,8 @@ static const struct renesas_sdhi_of_data of_data_rzg3l = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_CLK_ACTUAL |
 			  TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2 |
 			  TMIO_MMC_64BIT_DATA_PORT | TMIO_MMC_TUNING_DELAY |
-			  TMIO_MMC_INTERNAL_DIVIDER | TMIO_MMC_HWADJ,
+			  TMIO_MMC_INTERNAL_DIVIDER | TMIO_MMC_HWADJ |
+			  TMIO_MMC_HS400MODE2,
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
 			  MMC_CAP_CMD23 | MMC_CAP_WAIT_WHILE_BUSY,
 	.capabilities2	= MMC_CAP2_NO_WRITE_PROTECT | MMC_CAP2_MERGE_CAPABLE,
diff --git a/include/linux/platform_data/tmio.h b/include/linux/platform_data/tmio.h
index 6443ba01c723..8a5dc18d43da 100644
--- a/include/linux/platform_data/tmio.h
+++ b/include/linux/platform_data/tmio.h
@@ -59,6 +59,9 @@
 /* Some controllers have hw adjustment delay */
 #define TMIO_MMC_HWADJ			BIT(15)
 
+/* Some controllers have HS400MODE2 */
+#define TMIO_MMC_HS400MODE2		BIT(16)
+
 struct tmio_mmc_data {
 	void				*chan_priv_tx;
 	void				*chan_priv_rx;
-- 
2.43.0

