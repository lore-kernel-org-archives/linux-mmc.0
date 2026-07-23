Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6F34570F6
	for <linux-mmc@vger.kernel.org>; Thu, 23 Jul 2026 15:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784819446; cv=none; b=DDleEvTX8fDevV5Z8Ivml0bA4aB1WV1mZXeNw7LHS82AacD8duHwxnKV2n5ki/mNbbgFEhFaOTXImmpF64KTaHNvDKIhFSXkjc1S9YpLPX3bUx5d9MPg8pIwBaR06C50CcG5iyjkmrr1L59jEoppXc2s/lE0sfP4YNJxfezehz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784819446; c=relaxed/simple;
	bh=8oqAWOlbZCz9/fU4ImdRXrI2DoLq/IL8BIzA7ejnzr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iKC3U5mChp+9Rn6BIYwD/EXZyTj5XdOxHYeWmo7WOFMjQ8csCmm2A7WOHcllN765FFZbxh37v2jMrbxia9I3n5hSs9j4OqqGCjMhIDJCqA9qLFlIm0KEDTTS58wkITrikl9ska+PnyWxPmraWAQZ57Qn9/W1v+GxLV72WGifh6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ibt/OlQq; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ibt/OlQq"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47f633e6058so690004f8f.0
        for <linux-mmc@vger.kernel.org>; Thu, 23 Jul 2026 08:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784819438; x=1785424238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CUXCYiEDLzdrAA0ZrYezKtW7bblT4ETUt38pzCsWyjY=;
        b=Ibt/OlQq8QIyYGvRIRzrD4d2q0mG1qbgN1z++CxEXOreYnwtCaiub38F+oZ89S4jRG
         8PymMDohMJbU5ByDsuVhfY3bvEszLUdy3ZYmQNntBWDnNJNkuMqYafSiCeIdzBhiT0kW
         6bqACoDA3fEs4T2EhDXdE063yiw4l7vKU8j6+5vGm+MDiML3l0pzPS2LZTmi8VfmtHwa
         3RE0fgg2IUu+rByOJg+FIqbem8Ofgk87dbQpM2XyYTyCBrfoVq6BLQr0pQQjQar5CSbf
         PoA0QJ1WpAUjw7/xwQdFC9+fZx6xvMMKnKiyj/Qvn4GDN2vMyoX77XNQGBwWZOQmyVuz
         Fguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784819438; x=1785424238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CUXCYiEDLzdrAA0ZrYezKtW7bblT4ETUt38pzCsWyjY=;
        b=WZ+ObwZ/1m+bWEhj/yr1lZ3Soqp9gH0rL9py3bqmGB9h4dls3RwCSPgTAaQaMoGytb
         FE6nzCGzc+AVzMsd9EXzAn24p1Mr7oEL2tDMX9xAWzhh2cyDArhCvfKLPyUKz6xyXd6V
         eboeudaDDPp8zYp1LGWb5KXGw1jrjqVWG2s61ZqvtCeuSOmCznFEKRlFnRotYlDJZA6h
         GVaX0a1TOKpNUby2wWy054uQ3/dHNN7HDGDXT1Qku4rRJ6b1x5EnDg7hBdCUl2uzktJF
         Zgr8DLfvFhBpX8IHfsLJBy9jCAfwab7zNTROSK1CSodenx+Vk67i4Qs3CmEu35ndwJPT
         Cs9A==
X-Forwarded-Encrypted: i=1; AHgh+Rp4kFnxuxas+cXE4v2jrVamvUU5xS2hvJ6P9mGbYMXR+rnuCKXjhkdBn9fqMZjnQCSs741tAytUH5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx97o5YIcut3ASLQjGK3XYtUBnh2M8f8cml/GdixOP1NWDS5BzE
	VIU759kenEQUgMq73VBqRCN5YQemQ9cXyiO++pvjUWFgJ8Kt7bDpjRQn
X-Gm-Gg: AR+sD12KNU/TqPGt2Vy3b/I35egC3EjyRv97eQ15VibNEjgbawK0rHMvISNyD4MdLpJ
	x3A2Vn9byx5YDo7mep2peBIP/s0z7xzWjpz1L8b2n7s1r/kplB6J2vkCFT5YYai7R2ec04SAdnn
	DeVPMLoG987FI5e6CYgjGRswphK0uUC8DvJY/7dxvclEAnhzdECNUceToXMuPFdYnn4B1Vk1jYV
	vhOFTOfhETCAXxIBm7oZO3J52qydn1jzkEHwyyc379Cgd8jyjz6dkgpxY2zS1t03TFu0p6mKL/3
	07hon8kjZ03kQiKYDJ1HQkdFKAYc9UhBKkgicTZ0n6RqtPRG+hZIL06amuR3M4QhcDWeg0gRZ8k
	kEqWDvwXWOSmx9rowfUACwYFju8YAv7PWCzS+9vs7DTbhVSy6b/XWxA+xIKqAaB/aXIVacWhqgE
	ImHWXrYY25BkC52+3VooKk5K9SfZg=
X-Received: by 2002:a05:6000:4a1c:b0:47f:70f1:a577 with SMTP id ffacd0b85a97d-47f8d71f8a8mr4783740f8f.17.1784819437621;
        Thu, 23 Jul 2026 08:10:37 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:f073:32ed:a057:cd3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb81dcsm15886823f8f.12.2026.07.23.08.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 08:10:37 -0700 (PDT)
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
Subject: [PATCH v22 11/13] mmc: renesas_sdhi: Make HS400 OSEL bit configurable per SoC
Date: Thu, 23 Jul 2026 16:10:15 +0100
Message-ID: <20260723151024.318918-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723151024.318918-1-biju.das.jz@bp.renesas.com>
References: <20260723151024.318918-1-biju.das.jz@bp.renesas.com>
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
index 70ebe5902f6c..0d38fbc53512 100644
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
@@ -1216,6 +1215,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
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

