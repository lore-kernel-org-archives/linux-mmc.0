Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3058391E50
	for <linux-mmc@vger.kernel.org>; Sat, 18 Jul 2026 13:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784381935; cv=none; b=HL+n34Buc3ADoKDFtWNHBU4CK4RpyAnqe9I5K7lZg2WD1Rncu2cQXG+qezBzgNhLXt/GFaa3nWbCKiVXurBY6omcbwq6aEobshS438ZEDnAjvEj8mfyToCHSzczKRta8UOpUcv7Yr+/zSpHhzjHe2dlVdggxY4MFdj08cIB33Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784381935; c=relaxed/simple;
	bh=y/WSoV7nvfcrB1W0zj2/Mvh6cJfEPxCK9CUupbrr45k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NX0IaUaTcXyYllwIu32ukAs2V++WVC+bg2KuPZMeYJs27Wu/8dqT9lw+e60SeYQMQRdyyQPa4/plIHVza6X8ZyLj7pp079YPreKB04BYe9ZNpFYvWr7DXV/2L4md2SqFwLXEKRRItjtePw05guP212eBKWSyCyVs+2Q28KxTigs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTmmqvr8; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTmmqvr8"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47f703a9e5dso19707f8f.0
        for <linux-mmc@vger.kernel.org>; Sat, 18 Jul 2026 06:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784381932; x=1784986732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uvx0jbtDdMHoGdK+DqsZ7JHopU84dkAONUnfD/8T1D8=;
        b=GTmmqvr8OPHpPYnUns/5IWnjwKO65zZrac0l9cdydpe53ybN2YrJbFrXWhGrQwd7nF
         4PMFW8wGxTVE8hNowbnuYBDx7wMZLz4W2FaxP4voKxcD/m4a+zxLzjKXtPKim/R4oFZ0
         pWW2RK63/2JBQMh+tdEKJtHRenCn8+rBAvP3Vp9Wu9f5DTFRgkd0A+ccUREyBpYI98JN
         oFmUhzJ4Z8LPTVQ5MdNFVMv5K5jU0h9BaX+D2dGRy9OCVZdbdA8RGBMR7fiJgd/TswK1
         Lyw1ICkbmAL9D07HMLSuFuhvzUkrLDeIokgHeWtijSN440RWPLTEGzhh0bUWlYtsErp4
         aFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784381932; x=1784986732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uvx0jbtDdMHoGdK+DqsZ7JHopU84dkAONUnfD/8T1D8=;
        b=f/kLENSYzKgKPqKDBLv1zE16aFCxNW5dzUWTZXsPPTJOGR730pyCi0rfyfsdOlX5AR
         LKJQ9fcV/d+TEhEgUm/tfXeZlIYzR8Zofdde55ju3pZihycUJMyoeEwguUHYPV/2IJAg
         tuGEo2ajfA4d8tg6+GYPzFjozX1b7BuDfdfdIktJpllyW+2GVS7oB0Yq/ENJHaF1ErJ3
         3q0bd2Z78+N9WkQQ2+qDoJgWoWxZQAY8Z+lmxYGY1JaJUlo1YQCsx5aQWQEbor3SaO0P
         KP/v9nwtwgiM8bmoDf/nKDPANjPKwsHzoGoqzJVSiEj9ICrivYL99wossVvdRy5ezBsV
         ROpQ==
X-Forwarded-Encrypted: i=1; AHgh+RrvY4j4zN8CpSAQRISx9W4i2FQgiXUNjuWglxzU6+/9yVQK+JOksvU5bJA65N7A2VcJ/wNZr0ob/78=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLLn82MD3sk9ye8q0gO+24jGReRQ1oTTox1XxjopRRQFMmXNdJ
	vcI5fcdoGntZEOwOeOWZaS07kb1vVC9T70suuysXNLYGfKEo8mHuYkl7
X-Gm-Gg: AfdE7cmP7i/8mAV9j1kDr4VCXE24x+D064xtf/LNo0mkKSP+Hq4yVeamNTUzSVTxkCe
	X5mgazNCpd2gIArdtlJU4qqOmvlNrbOWvWxTgWwaLflk33AqV1ixaQkXS0g2vtlNHleTa1R8df4
	zbAtUPetSIN4FgFim3yd9QLTxM1XDfsPnzqf1VJxSHZMu+uASWfo62a7aRQHLO/Hajm3PCByk++
	3O2ehn8GaGRmwpfJiycgo9PfOVxRNhM8yFmY6dtC8KQRrtOxq2KDvtjq4Qwr1t9JOdVcipmP+/u
	oxZsywNA3nHGLveClEbv/tsQQy2Q/t2/mgrhErwiF/PjbRabBs4C2OS6Ft+59odb5X5rznfB2MR
	Oxeu/mAp1ptezeq2dtSX97/Wskl46EVaTwSu/qAdFJ+fcOJLaLXSFORyfV42TkFm8+Vqv0pp+HD
	JS6bsWscjqw4iG9Ss45HofUq5PBFk=
X-Received: by 2002:a05:600c:4ec6:b0:495:4d5c:903e with SMTP id 5b1f17b1804b1-4954d5c913dmr59504785e9.7.1784381931810;
        Sat, 18 Jul 2026 06:38:51 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:c53f:e1cf:6009:4c03])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49549c96ff7sm121717845e9.10.2026.07.18.06.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 06:38:51 -0700 (PDT)
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
Subject: [PATCH v21 11/12] mmc: renesas_sdhi: Make HS400 OSEL bit configurable per SoC
Date: Sat, 18 Jul 2026 14:38:31 +0100
Message-ID: <20260718133838.152905-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260718133838.152905-1-biju.das.jz@bp.renesas.com>
References: <20260718133838.152905-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

RZ/G3L and R-Car both use SH_MOBILE_SDHI_SCC_TMPPORT2 but interpret
its bitfields differently. R-Car uses BIT(4) (HS400OSEL) to control
HS400 data output timing, while RZ/G3L uses the lower 16 bits for tuning
delay and does not require the OSEL bit.

Remove the hardcoded SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL constant
and replace it with a per-platform osel_tmpout field in both
renesas_sdhi_of_data and tmio_mmc_data. The field is propagated
during probe and consumed in renesas_sdhi_hs400_complete() and
renesas_sdhi_reset_hs400_mode() when setting or clearing the HS400EN
bit in TMPPORT2.

Set osel_tmpout = BIT(4) explicitly on of_data_rcar_gen3 and
of_data_rcar_gen3_no_sdh_fallback; platforms that omit it (such as
RZ/G2L and RZ/G3L) default to zero, leaving the OSEL bit untouched
during HS400 mode transitions.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v20->v21:
 * No change.
v19->v20:
 * No change.
v18->v19:
 * No change.
v18:
 * New patch.
---
 drivers/mmc/host/renesas_sdhi.h               | 1 +
 drivers/mmc/host/renesas_sdhi_core.c          | 6 +++---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 2 ++
 include/linux/platform_data/tmio.h            | 1 +
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index e2c26917b884..7ed92229e937 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -41,6 +41,7 @@ struct renesas_sdhi_of_data {
 	unsigned long sdhi_flags;
 	u64 clk_mask;
 	unsigned int max_divider;
+	u32 osel_tmpout;
 	u16 clk_div_mask;
 };
 
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index d5d8afde9bfc..e44751647982 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -310,7 +310,6 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 #define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_REQUP	BIT(24)
 #define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_ERR	(BIT(8) | BIT(24))
 
-#define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL	BIT(4)
 #define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN	BIT(31)
 
 /* Definitions for values the SH_MOBILE_SDHI_SCC_TMPPORT4 register */
@@ -457,7 +456,7 @@ static void renesas_sdhi_hs400_complete(struct mmc_host *mmc)
 
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2,
 		       (SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN |
-			SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL) |
+			host->pdata->osel_tmpout) |
 			sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
 
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DTCNTL,
@@ -598,7 +597,7 @@ static void renesas_sdhi_reset_hs400_mode(struct tmio_mmc_host *host,
 
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2,
 		       ~(SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN |
-			 SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL) &
+			 host->pdata->osel_tmpout) &
 			sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
 
 	if (sdhi_has_quirk(priv, hs400_calib_table) || sdhi_has_quirk(priv, hs400_bad_taps))
@@ -1198,6 +1197,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		mmc_data->max_segs = of_data->max_segs;
 		mmc_data->clk_mask = of_data->clk_mask;
 		mmc_data->max_divider = of_data->max_divider;
+		mmc_data->osel_tmpout = of_data->osel_tmpout;
 		dma_priv->dma_buswidth = of_data->dma_buswidth;
 		host->bus_shift = of_data->bus_shift;
 		/* Fallback for old DTs */
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 893d9395e9d6..b1146dca94ca 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -130,6 +130,7 @@ static const struct renesas_sdhi_of_data of_data_rcar_gen3 = {
 	.sdhi_flags	= SDHI_FLAG_NEED_CLKH_FALLBACK,
 	.clk_mask	= SDHI_CLK_MASK_DEFAULT,
 	.max_divider	= SDHI_MAX_DIVIDER_DEFAULT,
+	.osel_tmpout	= BIT(4),
 	.clk_div_mask	= GENMASK(7, 0),
 };
 
@@ -149,6 +150,7 @@ static const struct renesas_sdhi_of_data of_data_rcar_gen3_no_sdh_fallback = {
 	.max_segs	= 1,
 	.clk_mask	= SDHI_CLK_MASK_DEFAULT,
 	.max_divider	= SDHI_MAX_DIVIDER_DEFAULT,
+	.osel_tmpout	= BIT(4),
 	.clk_div_mask	= GENMASK(7, 0),
 };
 
diff --git a/include/linux/platform_data/tmio.h b/include/linux/platform_data/tmio.h
index 99b05c8c840a..501ca4355c34 100644
--- a/include/linux/platform_data/tmio.h
+++ b/include/linux/platform_data/tmio.h
@@ -72,6 +72,7 @@ struct tmio_mmc_data {
 	unsigned short			max_segs;
 	u64				clk_mask;
 	unsigned int			max_divider;
+	u32				osel_tmpout;
 	u16				clk_div_mask;
 };
 #endif
-- 
2.43.0

