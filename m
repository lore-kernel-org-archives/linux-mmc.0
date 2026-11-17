Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794933291;
	b=YtGnYD94X3DjoKHDzBkZ/XYLBKVy9/QNLqyswl3VwsjN1kz7a87ToF+XzCUWVUIz3YrV
	 99A6gdB0yQMheBNru/ukVcfJFHpqNW8brq2FP7vz19ifqf3Ug2JRQcGe0k0QGN6ABtBqS
	 Lz7RfaSfciTaxV2SNRjpVikQ/P+/IVITFpeF47FjM7RprwPULhwqvyfUWT2KKiXw73md0
	 HA2Lh+HJP/AWS58NIARbO3jRQTSuwtE4yzXxDrKkdQADsFoKy+AyE2ChRcv/9YBx649Cw
	 RaT9jC0XTLPrDmmFLRNVT8xSykYN/BEk7hyj8EAt4FlhEl+FYezFjUIe/ibPykB158A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933291;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=G4VqzAzyHFDWVHFLx84TvM4z7hRkGfZ+L7UI3ozJ8uk=;
	b=wtynI/wWY+36apDyGcKPpldwkDvJJadHtBVpiNMWdXu01hGi7UW9JgIXgjUC8h1EY+ct
	 Pg+ndkd45yvahON08HOf8Q4JEHotgJ18BC/NdhNGPf7J7hbNrzg30yQHKXIZXNfDQ/9g6
	 luQudiaUEgnnBrb4Eo00jyxgk3E+U5xNd9d19VosYNAWut4OLlSGkPz14XUStUI0Nh7C8
	 F7w9Ogc8ea8cDwFd1w1t4KtkOj0De4IkzEi+jlbyIVRz5igcutVw0A680in+9keXx2LtG
	 4jLRJZhgbq1Kps6gR12yx8K1S5ffHreO7BMgw/raQc8phCZEUcqghFarW/Xenp45opg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rwiyFm5J;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D29606A33E
	for <linux-mmc@vger.kernel.org>; Tue, 17 Nov 2026 16:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94D29606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rwiyFm5J
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so4364669f8f.1
        for <linux-mmc@vger.kernel.org>; Tue, 17 Nov 2026 08:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794933290; x=1795538090; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G4VqzAzyHFDWVHFLx84TvM4z7hRkGfZ+L7UI3ozJ8uk=;
        b=rwiyFm5J5KcFTQQE+S1XsoqkqIrP4yBvmZ+PbLMSBCw6Q7uFf8dpnzdG/VD/2FkR7W
         iefd41L+YA8QWbSbBBc3PP13B3+9D7+UE8XFpfcHCAUInRS7H3BD/oLsjSTjPEpt04ty
         Vz6+WNsHsrhdDqOOd+D+iA0K4ZhgjHhGmWR4qLRC1oyADzjXFx6IEfT2intMfxEseJ+V
         XwPYY5+SlqS4It+XLva8w6zS/ymQdCF6Q6+wQjPZaLUDwTmwl2NzUbFkHpwArz7GeJO9
         3nKwmndaRUKxaSQqR7AZxDqn5+8S7Xoq1PIK/6jaEPbEXq3vM3MdQSY+45Nutp5Cbe5w
         sn1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794933290; x=1795538090;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G4VqzAzyHFDWVHFLx84TvM4z7hRkGfZ+L7UI3ozJ8uk=;
        b=cQZMbwIBeo0+ZYb1RIj+/lKWrdT9kCeocvbfiv9hF7k6adSzqlXaug1Uai0UAty8Tl
         PfyTJzDV7LIbDy5+D/BJ9Ldw5ZCMR3zJa6FovH/+B17Beta3zzaQA5WBBhDR5ue358mB
         AiWXMaU0txPXz9tj2poZgG79czQUJk7EBtB/SXtVGwsCaEXFuVD2U471GMJ9EfJyehUc
         VNPBjA2jHuorF72YH9GexVzbdn79VRLHHicIUYHdewZsa2IMp6ZNnLI7Yq57r85ZoZsi
         nPS/qj8/5MCgHmrIyGq6WBHGwN6uDXFEkwyUx1Adlr+3MQlcD+WcEfi8xnIR1e7sNYvb
         u57g==
X-Gm-Message-State: APuU4Z8Zb4SFnrysuHGccO17z1EWCj/mukTJMxQyZ38ky+jAaNqlZY12
	qSCnwz+uW+A8lEhr8+A4iwmEvTvVHp+7wWAWzNtDfEoaKxANaT76Q6Yy5nCelA==
X-Gm-Gg: AZFdTZey7GyRWNZbHt+MgTycVSUIlRTLiM5pymQmFZsmjiI3wXF9dJ/0mAKaP4gt4My
	dkXInQESKTrGe/9d80q10Jv/C3W8xqDv6lzabpTp7vGjTpr5qfZKIcX8tyXq3GPCNVa18g/rwAh
	nel9p6FBRv2V5VUjYZMvAy1hqfNCG9h686M18Wad/KrIl+/AlvBvsrGk42oOHV86ieGYJI2ATZ8
	k7oNQ6TttOR9GuzKHRdZQrTCutT1mg822Nu/Qskj0jflE+PafJx42st6BMP/gwCEA7gViGWxm4z
	LEclUUtQaSMFuAhWIgxn1qdkTFAJ0/N86qXBXgK7Y5j1fKg/o5EHBhK4wXr6ZTkChJ3WUlcvEdY
	rYf/ldckrDXLISbqQ/UdaREzNRHOkR1UgL7QdTL2q1yB6RXk9FR3Vuq9SP14FdYiVXb0GtHP6df
	4+MaScWYkmWTDUvJ8X5Qxdt+UjmFA5QoNcwYma+YlqHC6wmTgKVEvb6iBjBPC/KG1K58bQ0UiL/
	OTTCpAZ2sZwlx1fUlhGqaLzQVjLNOLDqLAVZmDrhr+dGkc/fEKqcg4mm5NvBXGPeu6LGSU5YH/B
	EJtfRy+/BOOYilpsQxm9P3MajbSq/YYbNrhX2yDBoIJauTs+mtRIKkOqNSDgVQA2Urw0/3ITH/6
	/eLXFv1qrKRo=
X-Received: by 2002:a05:6000:2dc9:b0:48d:f460:2c62 with SMTP id ffacd0b85a97d-49c71785323mr33874048f8f.33.1794933289986;
        Tue, 17 Nov 2026 08:34:49 -0800 (PST)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:9260:9c28:f0f5:e091])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c6d079a2asm26672248f8f.16.2026.11.17.08.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 08:34:49 -0800 (PST)
From: Biju Das <biju.das.au@gmail.com>
Date: Tue, 17 Nov 2026 16:34:47 +0000
Subject: [PATCH v3 2/3] mmc: renesas_sdhi: Make HS400 OSEL bit configurable
 per SoC
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-sdhi_hs400-v3-2-b4659189db69@bp.renesas.com>
References: <20261117-sdhi_hs400-v3-0-b4659189db69@bp.renesas.com>
In-Reply-To: <20261117-sdhi_hs400-v3-0-b4659189db69@bp.renesas.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794933288; l=4117;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=SYAfKvjWLRvmc21t371OTT6TgUwITNpCe9K/LsMWWmY=;
 b=pMXLHb46a/LS8oP3axfxPDPS+u+Wt6ygFOeiojPu8970sOZsOMNQM4qKK0lPrTkojh2FbGEwf
 QYo2hvyotaIC6kRABLxNCMDuudh/7gTsPksstD+VzD8D83djD7228eH
X-Developer-Key: i=biju.das.jz@bp.renesas.com; a=ed25519;
 pk=yzD2T1OLS3lEYflbk64xhLlxhk75lZ+NoOtkTOqrlVw=

From: Biju Das <biju.das.jz@bp.renesas.com>

RZ/G3L and R-Car both use SH_MOBILE_SDHI_SCC_TMPPORT2 but interpret
its bitfields differently. R-Car uses BIT(4) (HS400OSEL) to control
HS400 data output timing, while RZ/G3L uses the lower 16 bits for tuning
delay and does not require the OSEL bit.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
- No change.
v1->v2:
- No change.
---
 drivers/mmc/host/renesas_sdhi.h               | 1 +
 drivers/mmc/host/renesas_sdhi_core.c          | 6 +++---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 2 ++
 include/linux/platform_data/tmio.h            | 1 +
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index a93e613e9821..8ae2ec04bd1f 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -42,6 +42,7 @@ struct renesas_sdhi_of_data {
 	unsigned long sdhi_flags;
 	u64 clk_mask;
 	unsigned int max_divider;
+	u32 osel_tmpout;
 	u16 clk_div_mask;
 };
 
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 56286431fd2c..7dfcf7f970aa 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -333,7 +333,6 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 #define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_REQUP	BIT(24)
 #define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_ERR	(BIT(8) | BIT(24))
 
-#define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL	BIT(4)
 #define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN	BIT(31)
 
 #define RZG3L_SDHI_SCC_HWADJ2_1_8V	0xff
@@ -484,7 +483,7 @@ static void renesas_sdhi_hs400_complete(struct mmc_host *mmc)
 
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2,
 		       (SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN |
-			SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL) |
+			host->pdata->osel_tmpout) |
 			sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
 
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DTCNTL,
@@ -621,7 +620,7 @@ static void renesas_sdhi_reset_hs400_mode(struct tmio_mmc_host *host,
 
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2,
 		       ~(SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN |
-			 SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL) &
+			 host->pdata->osel_tmpout) &
 			sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
 
 	if (sdhi_has_quirk(priv, hs400_calib_table) || sdhi_has_quirk(priv, hs400_bad_taps))
@@ -1233,6 +1232,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		mmc_data->clk_mask = of_data->clk_mask;
 		mmc_data->max_divider = of_data->max_divider;
 		mmc_data->clk_div_mask = of_data->clk_div_mask;
+		mmc_data->osel_tmpout = of_data->osel_tmpout;
 		dma_priv->dma_buswidth = of_data->dma_buswidth;
 		host->bus_shift = of_data->bus_shift;
 		/* Fallback for old DTs */
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index eaf21f93f5d3..37eeaa52f011 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -124,6 +124,7 @@ static const struct renesas_sdhi_of_data of_data_rcar_gen3 = {
 	.max_blk_count	= UINT_MAX / TMIO_MAX_BLK_SIZE,
 	.max_segs	= 1,
 	.sdhi_flags	= SDHI_FLAG_NEED_CLKH_FALLBACK,
+	.osel_tmpout	= BIT(4),
 };
 
 static const struct renesas_sdhi_of_data of_data_rcar_gen3_no_sdh_fallback = {
@@ -140,6 +141,7 @@ static const struct renesas_sdhi_of_data of_data_rcar_gen3_no_sdh_fallback = {
 	/* DMAC can handle 32bit blk count but only 1 segment */
 	.max_blk_count	= UINT_MAX / TMIO_MAX_BLK_SIZE,
 	.max_segs	= 1,
+	.osel_tmpout	= BIT(4),
 };
 
 static const struct renesas_sdhi_of_data of_data_rz_g2l = {
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

