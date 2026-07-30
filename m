Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C7841CB5A
	for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 11:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785411139; cv=none; b=evHUr1C2EgzE9nGf1jvPP4Q9owU18bWw+t4ncPlldQGK7Cl77g8PuNyzG++w1gzOKH5ZoRz8YArT4JlItVDljbDRwBdBYMvyXBvy5Gx14+oqLbx4cOvu+cZV9Mip6nfOCQsfxirHeKrzDdnJQXlXpeQjfsTfN5bk9UOhMlsTHr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785411139; c=relaxed/simple;
	bh=x3Q2vO95L8RcsVO/YvCCUSbgJEbdiDzNVsL4RhcDVuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NZn33XlnGHA7snH+i5Knqt44xCuO6FS2VOrYF44AWjcdSWBvy9hOHqFOH+bHVblG+wa0Qk5lNtYP3XGyZ/gO22oMng3eKjWTzN7ppxA8sxcKY3Hf6t6l+B8U/S6Vb49/30ZABWYLFnFH8sRDgSQsd2s83yVSnkJXK8CYhgV+ILY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o1hj53Cn; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o1hj53Cn"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47f93b2fe4cso1379155f8f.0
        for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 04:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785411135; x=1786015935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=re2hKecVBUX60tpOeigCJ6YFbdIRoIcRDfBc82tx5Ag=;
        b=o1hj53CnyJTeKwWTcsr9h9hNpv/CtNc5atecQ0GVrZoI4AIl3G/vVOtlTYM2Cib7AV
         ePTmt8QFPTuhqAuqdJOx32/3v4CLpP9KdK1XOek2wXaDKH3UiPbp8r1TbbHVH98KKK93
         LAUGgBfZMUmj6XNddVRxwXKXeihlWT6mHZP5GPXSQaHPj/B3CLQQ05YjvxjV8TE2VY5o
         kj7h2pxXZoskUINr4ydpwGXDf+vpUEq+G2jqNfpB4aDGONoPTxxL6RDLR6L0LSp8CMnY
         L0AtojgluZ2EMewjiBkZJSdreYteRvLWreatlbDfWtp9O8bqeZsbcf63i/K7WWoPHxea
         7L1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785411135; x=1786015935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=re2hKecVBUX60tpOeigCJ6YFbdIRoIcRDfBc82tx5Ag=;
        b=Y9yvOqcK2DHSSvbMW7yhfsb6rG9JrEnUTeb/zw8smsVUzynsmCKgL6jtlz6acAd1ob
         wwI7E1PrdgcmOXxgjpwGwzPsuFjw9QvNPm6gikqV5J8YjY2viGYm1WTrd4GB2/E2S+o1
         d/znqvy36Euh867dcqBGxmmAvC22rYRDkNfRBbrNJS2hsGt2ok9dKRsfL4M+1pI4+aig
         xz1NSz7iJzIbh9ViblT6H8ENRcX/T6t3sl44RjjR6eC6O1DE+UCoIE4s+Ocnc+sHIjuP
         qn7qjfaQbD8mFTIjKBTgw/pr5MHRjM9T8RTg9wowQQ2egoERsTB/TKKR3DVmHYeVI3MS
         VHZw==
X-Forwarded-Encrypted: i=1; AHgh+Rra/SHOOABWVSFexjENgOdX7okIu/VgA9k6sa5lTvUZNDAFfyfv7RrQH3CmOCGpqag6B7fQjCO52f4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO3ycC//PKn8hkpmLdA1tjFj4HU3/oweaoehltictSQBkXhupP
	Hwe8nDSk2onssDb64NDAQ7TeSbjWE0rEO+0WsWLZQhCuCn0WkFFpp02J
X-Gm-Gg: AR+sD12csLYJUyoItxWiVS7n+XkOLmc//0am5EepOwwq2iTd60LMHLhxQzZ7MgLbdrl
	Ow5OODadoJhcu0v+g6Ss2ljBZ3obBhB+edMwCtJx//PEmllaDHS0Lbu3VODACVG6ajkem6Xq0SG
	v2btSoK6Wkw3GJ4LLyi7ZTDpMMarp1TKEPEiZOgTFzegoDcPzpJ1hmn/QgAltQjPI2PvfvC5TeO
	b041rlRpZDtOwuZGZis55RGYDUxJkDHk+2DdPwP1+dudhOHYBhr+tJJAcktlGemGcRMRvZtMdwo
	oICpA6TQVOkvehXDvDJDhLj1MdwnzAO8a93Z4I9bjhU1uJWUAwQJZpC8Lvfp7d5KaN2yEVgBkxS
	YXqgQXINhqxIgSTHL8sTeFt8aqc0wzXvTxuywV2B6CXUNKuIcIWDqGjxZqddHCmHQrfr1KXSbdK
	Rl8JiFIFoidINBsUMIH48FjJVEJWFqErk8EQpS89FHTZnckvVbxnm3TCn6KccRD6O2l42cNU0q/
	RWejuGhXnhH0g==
X-Received: by 2002:a05:6000:220b:b0:472:7dce:d8c7 with SMTP id ffacd0b85a97d-47fc81f36eamr2914972f8f.36.1785411134969;
        Thu, 30 Jul 2026 04:32:14 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:eabf:a623:1e7d:c359])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc89351e3sm5737947f8f.29.2026.07.30.04.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 04:32:14 -0700 (PDT)
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
Subject: [PATCH v23 12/14] mmc: renesas_sdhi: Make HS400 OSEL bit configurable per SoC
Date: Thu, 30 Jul 2026 12:31:50 +0100
Message-ID: <20260730113200.36456-13-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260730113200.36456-1-biju.das.jz@bp.renesas.com>
References: <20260730113200.36456-1-biju.das.jz@bp.renesas.com>
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
v22->v23:
 * No change.
v21->v22:
 * No change.
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
index 3e08b099ee87..44bd9b2bca2a 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -41,6 +41,7 @@ struct renesas_sdhi_of_data {
 	unsigned long sdhi_flags;
 	u64 clk_mask;
 	int max_divider;
+	u32 osel_tmpout;
 	u16 clk_div_mask;
 };
 
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 3459df084a02..58362c5ef793 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -327,7 +327,6 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 #define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_REQUP	BIT(24)
 #define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_ERR	(BIT(8) | BIT(24))
 
-#define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL	BIT(4)
 #define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN	BIT(31)
 
 /* Definitions for values the SH_MOBILE_SDHI_SCC_TMPPORT4 register */
@@ -475,7 +474,7 @@ static void renesas_sdhi_hs400_complete(struct mmc_host *mmc)
 
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2,
 		       (SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN |
-			SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL) |
+			host->pdata->osel_tmpout) |
 			sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
 
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DTCNTL,
@@ -616,7 +615,7 @@ static void renesas_sdhi_reset_hs400_mode(struct tmio_mmc_host *host,
 
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2,
 		       ~(SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN |
-			 SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL) &
+			 host->pdata->osel_tmpout) &
 			sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
 
 	if (sdhi_has_quirk(priv, hs400_calib_table) || sdhi_has_quirk(priv, hs400_bad_taps))
@@ -1225,6 +1224,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		mmc_data->clk_mask = of_data->clk_mask;
 		mmc_data->max_divider = of_data->max_divider;
 		mmc_data->clk_div_mask = of_data->clk_div_mask;
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
index e2273a262a23..fecc61e082de 100644
--- a/include/linux/platform_data/tmio.h
+++ b/include/linux/platform_data/tmio.h
@@ -72,6 +72,7 @@ struct tmio_mmc_data {
 	unsigned short			max_segs;
 	u64				clk_mask;
 	int				max_divider;
+	u32				osel_tmpout;
 	u16				clk_div_mask;
 };
 #endif
-- 
2.43.0

