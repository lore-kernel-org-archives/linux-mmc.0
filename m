Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD9C488742
	for <linux-mmc@vger.kernel.org>; Thu, 20 Aug 2026 17:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787246242; cv=none; b=nwqliEFG2ubCaKiuBwlAqAy8Kigq2xvoK+AlLabIHHwr8dmLUAUn458tbgOP5Ks4CwZVVmmaxhkme3IZFM1JwrbeqIXC6N9Cqsx6sJYq+ddoN1moWS8kfXrOJrSKgZiy/frwZXTHFfGLb2cUJG5TfbzDyszl8TX7iESm6z5eU2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787246242; c=relaxed/simple;
	bh=U54RaZKAqZC8aHk39WCNLShm7fi09cuGQeTreWgZzWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iR7fGzRjcUvxydqjn22Cw1NRxV8YWGGYnYR2lT9cRxm5PBIRnKlvfcGxUusII+d4oVT9js1TWhVWhv1D3p1FQnJb0/odB8byQQMScnSQpBhLAF5XBoNN2HPxyV/+mpd7BXX2obqgeWRXCFLbVBjRpDOJAYUBCDx5Kf0Kh/DB3/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i353f/V/; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i353f/V/"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4954df200ddso649435e9.0
        for <linux-mmc@vger.kernel.org>; Thu, 20 Aug 2026 10:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787246234; x=1787851034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0T1NM5S7Ehgk9tTC+v8Mhk7l+caWHzRm98uhzY5VU74=;
        b=i353f/V/PdqCyGaw0VKaNckThx5pfVvumWyiE59Ogtjv9jOjszz6V5X03rHISkhKHB
         WmyqEkw3rmdDQNyQFm5kXyt7kLgfVzAiskHWBd7DcaRlOlkpWaklFjOnCXxOn3bGNbKM
         8nT5jG7OQleWR0bUtSZAnM5v2nj2Y8NOCNBcj4b8PnkvVSH/UVp0NJkYOCN5rHWBfnhT
         GtInx3KA2vVlrH8BSjyLoBmcAGlTDIk2JBR0l+Rvum7T65HZJARDuto4i7tDhbaayYYL
         cPo2NJMWX3t7P4l60MCjiIdXrs0zY3bIDMYauqxz4EmKRJdL+BZuXdBxbuVWwNtwsFB6
         +k4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787246234; x=1787851034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0T1NM5S7Ehgk9tTC+v8Mhk7l+caWHzRm98uhzY5VU74=;
        b=ayQR0eLurHLkxpHh2/WJr8rWlfHBuFExmO8JZzu/WvIUFL2IOpb7xatlbwdF1ZwCPt
         WJVgl8j2+e7ZQUWuUVAK3W7I42N9yOFIktqf1kZN0b2n1ilkyWq5HeX8IjJ07ILlX3zZ
         Wy7xYvG2MOFA8lm0KoAJM347unhsVfsREd/qZSzhx73bLDLx28ob4Xw3u4oBmTz+/p5/
         nsBewgDBAXnB6Uy73x7W8MvqzH2mmUPY9E2quoLUCDzutrdlV4koHf+3uxFkFBbLZt+f
         bjveNOGcOEHAsIRV8Tm53KyXOBWw+0rQBDi/txmB9hvqWTw+K/30RxSISrf9t3daDrr2
         s/KA==
X-Forwarded-Encrypted: i=1; AHgh+Rq3Ns5f6mZ09ju6yIvk17Xq7jBddTdrhgshON/XnRr6tPgDtinl38qqiuWPU+9HqVnprd/oK0EgV2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyo1f2zINSXByQYwpe8N01J7V7+oAwQs7ILOJa2avuPe9+fhr7
	LRHWmDGUek+sBg/ovF9DT6sXHPnqFsc4y723LBqwZgx4ukwltjs6fL4R
X-Gm-Gg: AR+sD12uMC78a7sKZwmRSi5c0mPvpMwClX1DSTOFXSD7fNCEe+RmyGvSdLlZeNlqY8d
	3ZjGa5MpAs0MzDLnP2o0CwOsEFwpwoyvYHCWsh238QCZ83YX2MYHzGhfP0XfsLJURp4Zgr8MeTr
	6s8ZiVExv3Rjnzx7u5J8dQpO8TAr0dKJduXIFmsgxTKd9qdIzsXPerxrUyJUsrKaEuIr4IcXpea
	gYM+jU+b1YAvt1swVZeEmClDTWfadwGCNxyEZp0clqAHj+UIyuX4MuzYl4/8V5MU6TsuDc3/dfH
	yhBb0eaqCAi+2MtCXAAoSZbm3oYjl/S6I05sqEHshCKEoLfIPfa29Rf/BGxkQ0CFy3YMO7d3GSG
	Z0nhZ6Asr0yIXh/AAJ3aprqfZc1LZNHAIrj4oX9kx1BrM3oSngx9eFIyz4eqFuVyMlpdMMGr9iW
	DqgFqag1Qg/LK5PG6wNCVCupLXnZsSRHY22nDsGncXrEVftLfCas5mg7fT0pj87nd/rF2F
X-Received: by 2002:a05:600c:3486:b0:499:781e:25fc with SMTP id 5b1f17b1804b1-499b828e031mr11322555e9.3.1787246233653;
        Thu, 20 Aug 2026 10:17:13 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:eda0:8ef1:e1ab:c2b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa0fd728sm219313495e9.3.2026.08.20.10.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 10:17:13 -0700 (PDT)
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
Subject: [PATCH v24 13/15] mmc: renesas_sdhi: Make HS400 OSEL bit configurable per SoC
Date: Thu, 20 Aug 2026 18:16:43 +0100
Message-ID: <20260820171657.62815-14-biju.das.jz@bp.renesas.com>
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
v23->v24:
 * No change.
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
index dd650dd24b27..7c562074d119 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -42,6 +42,7 @@ struct renesas_sdhi_of_data {
 	unsigned long sdhi_flags;
 	u64 clk_mask;
 	int max_divider;
+	u32 osel_tmpout;
 	u16 clk_div_mask;
 };
 
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 2f5e02537a94..23332539ac65 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -330,7 +330,6 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 #define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_REQUP	BIT(24)
 #define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_ERR	(BIT(8) | BIT(24))
 
-#define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL	BIT(4)
 #define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN	BIT(31)
 
 /* Definitions for values the SH_MOBILE_SDHI_SCC_TMPPORT4 register */
@@ -478,7 +477,7 @@ static void renesas_sdhi_hs400_complete(struct mmc_host *mmc)
 
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2,
 		       (SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN |
-			SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL) |
+			host->pdata->osel_tmpout) |
 			sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
 
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DTCNTL,
@@ -619,7 +618,7 @@ static void renesas_sdhi_reset_hs400_mode(struct tmio_mmc_host *host,
 
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2,
 		       ~(SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN |
-			 SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL) &
+			 host->pdata->osel_tmpout) &
 			sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
 
 	if (sdhi_has_quirk(priv, hs400_calib_table) || sdhi_has_quirk(priv, hs400_bad_taps))
@@ -1228,6 +1227,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		mmc_data->clk_mask = of_data->clk_mask;
 		mmc_data->max_divider = of_data->max_divider;
 		mmc_data->clk_div_mask = of_data->clk_div_mask;
+		mmc_data->osel_tmpout = of_data->osel_tmpout;
 		dma_priv->dma_buswidth = of_data->dma_buswidth;
 		host->bus_shift = of_data->bus_shift;
 		/* Fallback for old DTs */
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 3eccad143526..de570f7fc9c4 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -130,6 +130,7 @@ static const struct renesas_sdhi_of_data of_data_rcar_gen3 = {
 	.sdhi_flags	= SDHI_FLAG_NEED_CLKH_FALLBACK,
 	.clk_mask	= SDHI_CLK_MASK_DEFAULT,
 	.max_divider	= SDHI_MAX_DIVIDER_DEFAULT,
+	.osel_tmpout	= BIT(4),
 	.clk_div_mask	= CLK_CTL_DIV_MASK,
 };
 
@@ -149,6 +150,7 @@ static const struct renesas_sdhi_of_data of_data_rcar_gen3_no_sdh_fallback = {
 	.max_segs	= 1,
 	.clk_mask	= SDHI_CLK_MASK_DEFAULT,
 	.max_divider	= SDHI_MAX_DIVIDER_DEFAULT,
+	.osel_tmpout	= BIT(4),
 	.clk_div_mask	= CLK_CTL_DIV_MASK,
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

