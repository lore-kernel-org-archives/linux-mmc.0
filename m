Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3DD3FB7EE
	for <linux-mmc@vger.kernel.org>; Wed,  3 Jun 2026 06:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469874; cv=none; b=ADJmqigXLA4m7HU77eui97cxaGQVOT3/A3vKNHVfCqd+Kzolp9HObWOeDA/T/yy2hcqnC1hfDO1yGEnh9rrr8/c2eO4dV5jytNgPLh4LR6u3QjqnHvN7pwgwrh7ssWBiKiXegdsFpMLA9BIhQ+Z2VEesAFav9bn7Ac2dpS7hAPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469874; c=relaxed/simple;
	bh=hfcvW48RTVOZQJUjKHOYeF67Im7HnwNrRO6plbK2CAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qmia+IwQmyFjIsI/un+mSMcY7CwNdID8lq5R+GKM0/+ZmjTi7FqBQybtx+Cva1NjmymFqRe0liPf5TQOipDe+xreL56LfSVdlLn4Rti6uCi6uMt9dVTgWpZAUZPsDlBJKjTFCfKtPf6C+3TEj3iY3AKNa7BXETnD6ZcC5p5EeMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgjoQVEA; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgjoQVEA"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490b3637b90so12716545e9.3
        for <linux-mmc@vger.kernel.org>; Tue, 02 Jun 2026 23:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780469868; x=1781074668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zv9IdkurX2GjnKPTD/4GcmG2i55GdzrhY07mRQklhMc=;
        b=KgjoQVEAXgMGlFneE7PWPuwGhUiRWbwQELuS/p5iyx9zhZMXOk7/QeZNQM1gTKRvdN
         qxek/SrkwlVCUtWVTM6yhWEBmf+ULQfFK6U6HO1nEMR7TyTF82W8+7yVa+qmhCJ1i8by
         1VzD+knt04Yl4MS0umVvPcme1BH8qZLlCUWooKgJWGPofZET+NILsmX4hGjRi8k4sPIf
         oqw5r4BuumrX4Ep1akdAtZ2CdL7TzrfJ9ZBCrJv6NJIxkNMUB9bm/nROICZPJzRflECb
         Twcqz0ILYAtBOXPpeozs4iM/DL4YtVPrOaWHBpxsrQNxSONl3qAhxuEzIFG5deumV8oH
         6gMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780469868; x=1781074668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zv9IdkurX2GjnKPTD/4GcmG2i55GdzrhY07mRQklhMc=;
        b=KgjKALFs2cxFBi7IPulYbdIUcbek5G0Zo6fSJqjge0TBA0+nMD+7oqgjyknt+qXN/1
         3J6Yhsk6tsYmw0h/bZtJ9YJHjwku7XNryVRYZTYUUkuTMlugFw5+mu3YNww3jtlF1+z9
         qCS9rbyClCgsVZKxhFZSusAIqNSoY9t/GY2DK7OWaXd2prq6niUjlIyiwbfYlbu2QgnM
         vPoQq+pE2T6RtsN0O2OhiJ5PD2tilvmk54vStfkET2J7yEbMWvpRMnG1NV8R7gyhB53e
         +iNC+moezZXpTxROdgG312YoYcnJG5g5AurjXG2gaJ6TVt/ltV2WUgGhGMQyyg+KCB7x
         2nww==
X-Forwarded-Encrypted: i=1; AFNElJ9XFiMkRjJAwTH4ErMDIFPNaP0Ca9JwgQRpBetWP97KsbGXILfrfYnf3spPSjeY8omb8WhMPKB7D4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX2W0o48MkI6KNVr23QVZ7qeDs9Z6hBXh453nIcuf2h3NX9mH3
	wHu15Blx1eY1wNPJi2LnfTLdSHrkrKUqTQc3pb5CtqSTsUrUbKvKzLIt
X-Gm-Gg: Acq92OGWMZrjcdKSYj0ylCNCmE/gxHc/pA+z4FJzApswMhV98dwPqLjN8UlGBxJ14o+
	CFGcX9TuUWVoqTgKwiRJNmdwUxQvsBL+GRDURZomieh1sVqKhDuAa0IDSFh9txxBKzUAeuW+6YR
	4vdkFlaePNQlGrRG8MsuvZmPB+URlsvOGt/3Rnh4NSHY3UIGDmU/5Corvy7Znu3P28EMCvJ4+kr
	X6vdCU1Pg1lp3wQnivO4rDqF9/f5/tVBbpx35uq4sIqzw6Hsci1qpr0+F+HzXd9WC7YosIkXzhs
	rPQBXBP1bAmuikGUfK/8KAnUJg2z3ARVqm9hHhrXlz21pyhK7hgpu9riUKuKM+nwtuZUd0cpZ6o
	HTmQcV0su72DgEo91pdW/WQzXaR6SgLKQgyIuxPWZk8B0RpvkDarqAQQtU8KQCItrk6XCZMvoJz
	pUD7BQ2a4SySMN+X2w/3w3IHxIj1hb6I4OJTq8IUwcBTIH2Kjvcukugk5hMnw=
X-Received: by 2002:a05:600c:1387:b0:490:601f:d766 with SMTP id 5b1f17b1804b1-490b5e8359cmr30877065e9.1.1780469868442;
        Tue, 02 Jun 2026 23:57:48 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a700:7301:179c:89ab:19f6:9ba4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b79d90bdsm9001855e9.0.2026.06.02.23.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 23:57:48 -0700 (PDT)
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
Subject: [PATCH v17 13/17] mmc: renesas_sdhi: Add RZ/G3L HS400 support
Date: Wed,  3 Jun 2026 07:57:13 +0100
Message-ID: <20260603065731.93243-14-biju.das.jz@bp.renesas.com>
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

Add HS400 support for RZ/G3L SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No change.
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

