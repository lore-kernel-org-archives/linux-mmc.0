Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794830541;
	b=EiBgBlmuOUUcYXt/7tbMijzV1LvqJ264bcJoG3S1ea6O34nO+MY3x4JUbXf8DpMKjxoP
	 vGv6eBr2OALUl3kUhDc0ZiMDPpMZdMy8UiMAxz24+Sj1mAiaS0KqCGhq9zggYmIT+B2ow
	 mG4lzeau0W09oqaJT7RnxV2LzFlU2bVu7MNMzmUGbgwuOwnj9XgJGPB5+QTeGa+tUVgci
	 ol9LvjABa52TYn7+FqYL3X/TiJ8D2gFa7VNhyKVB3ThURjOGAk5JINeUpmukWun2+uzev
	 dIk2k7A2PlGY3qNLcw2HpI9OmrZFgfIXoqRl1c4uFevETwrmDk1sKrZTvRK4FcHiGaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794830541;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=wycBFwUVd8CFbin6WeDowNgzU6IjX96JHqmfLjS7zaE=;
	b=KElsA8XZ5X5MrLHnebfO1kZC3MteyZLa3DfSG0ShTTBpcWQ3LFztirF6DhEWXH8yX9XU
	 54+CYj3WIF8yWtve415ghHcSYjsJKZdaejwgu3x+6ISg+oT8sKOE4L5VTA7MTHps6p6mO
	 jNy1+Ac7uKs82onQgbe/Au35D5RM4Fb9plp9jF7Z3RAMkhH/e5sBiXOjxao7DnFaJiJwf
	 iZhqZz27UKb06HGdOxp74CBw/zmmaUsH7CgOs0sF1ZzgG8VdDH3FZU4bEQVS1QJmW+Jdv
	 QZYWLIrQuiFI9K1Odt+85TAqYHb7kowEnWqSB3+JEUris/N7TMUoQ9VYow/cFte9sWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fb7TEeEO;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68A2606A33A
	for <linux-mmc@vger.kernel.org>; Mon, 16 Nov 2026 12:02:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D68A2606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fb7TEeEO
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bb69f5b161so7232905e9.0
        for <linux-mmc@vger.kernel.org>; Mon, 16 Nov 2026 04:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794830539; x=1795435339; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wycBFwUVd8CFbin6WeDowNgzU6IjX96JHqmfLjS7zaE=;
        b=fb7TEeEOOQoidHokTK/7ClvicnQNNePjJBdsq3S9dEIYNFvsv/piL08koa13tfXJZ/
         YGv0T9+lDfjm7TwjI3OhtmeUMdLD7Zz+cMKHyXeS6vxxBCczzXTDGS9HAM73QIUL0G2o
         2YbpbgXvGsXKDhk1OcBiqzE1v/JphRGioAnMJtYmK22XMUm1WUF1Sn1vS/UbuPbNbAXO
         I8vTODfvRMsFroPgyRNh9qcBXRQEImiV72FQ1eW+/pWCiuWzXA8AXdyIzWzc/kb8YIzD
         NTHoDSvEVgdMWTxb4hLA5pIfbkpKtRvFeeuWtY3ySLXAq82J2HPMDgR5t4MnzpykYYOe
         d14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794830539; x=1795435339;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wycBFwUVd8CFbin6WeDowNgzU6IjX96JHqmfLjS7zaE=;
        b=g4nSKdNWcCCG7VMSANZz9GFWRLBASRO3YcPZWe4eGxbwuhJHY9wVSHZvDlyB2HWE5M
         aA8hT4WhgXnv82hxUDSF11oCjEOwQQSJKBwj+Do5b1RRqrXA6Lt1dbA6p8s/yQk8ErFt
         tLloU8W1ldFxWwPJSx5l4fdHVHPZi+Qjmm5qnWwCJ4nThrdiUNvWK25j/oX1jRcg0gVy
         bwnRVu9r0zYVvT4klQALL/PjcWfTGZavXgbdWvJK0JzgZ5jXnNpyf+GEzVAtvNCHXbGt
         mVFQE+ot6C/KF+tRf8WFAR1BaBc0nLJyHcUewowUTEaJ7SQJAVyvOm/ZKiYCLvgE/mVi
         J0EA==
X-Gm-Message-State: APuU4Z84lOvFWUiU2DqNAxHqPCcTaGeiN6sJE25Yuvefn7Pp4IOBjjKT
	5CKws7a4+XRLevblIt2OYjM75zn7hla7Ivbnn9qoJQZt9hSO0hSn+SfB
X-Gm-Gg: AYBFou3s03t4lGZTs74wAuIQjPz4R/MCpXx9PNCG2z/2YUxSAxIMf6tBQlnYi+tLo1G
	QmdDNcH88jAiOHkBXn+lvA7Wt4EItFkoNrtRCYHqGRYkmZVLUc2Uh8vPtR7laAoratFVw/ZFhaU
	gte9RgzEn7Gi2MHHE+1LxYtJo13NoaukKbAd+MNw1oPG3xBqRLD+cXIIhXXVvJTG/+3rwwokyXw
	p7hMkDUg/J/0Ev3+8RVXjXl4sTuuM7By50/2/qQ1DUv+BwzA+s3D4wp7fmfvnC0EZg8YDBxcltR
	m+pAAu3X+Ol6ugSrU7X5fdBiyJtQB2B6ybHAzKKECSj3ctIrOuyFiQmqyll7+kVH1pZeEhBVLuY
	hxPXut2NYLUigsU4X0tjZJcSJPnKc5+EvCSFZwXEEEe/Zt9f/VoeADOWC3YsqkAMuxoh/ucLNAX
	/jeqagADl4jrJx0TN6xxIPtOq+T4ifb+l7jB5jBUCI7zsPzdPMVMjkW8pXGp6SdOcd3G4NBt/zG
	VfrYf3TXPnT7UuWoDPXFYDY/xO1WW1e+CxEJCyWVE+0n0psG4R5DtTZTJxVpd1apJXM//0D2Dtx
	wUNK1CAjMku2HGcmakG0K828q9qb2w7WBlsoGF99ghgpmo44UpxDZ6ySPUwGZN0y6VPjz2dBTy9
	FPFHJqMrUraA=
X-Received: by 2002:a05:600c:4e43:b0:4a1:e00b:a10b with SMTP id 5b1f17b1804b1-4bb55a6a937mr215757375e9.7.1794830539328;
        Mon, 16 Nov 2026 04:02:19 -0800 (PST)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:6889:eb24:5e57:83b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2adf53sm395562805e9.15.2026.11.16.04.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 04:02:19 -0800 (PST)
From: Biju Das <biju.das.au@gmail.com>
Date: Mon, 16 Nov 2026 12:02:16 +0000
Subject: [PATCH 2/3] mmc: renesas_sdhi: Make HS400 OSEL bit configurable
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
Message-Id: <20261116-sdhi_hs400-v1-2-c5bedd312408@bp.renesas.com>
References: <20261116-sdhi_hs400-v1-0-c5bedd312408@bp.renesas.com>
In-Reply-To: <20261116-sdhi_hs400-v1-0-c5bedd312408@bp.renesas.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794830537; l=4066;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=ggghEPeGQYbLQtc8+CGJ64+RPB8GdQRBKmahvFKobRQ=;
 b=JsRU2l9EyfhgF2O3OSO4uvWFprbcqX7UxV8vPYEez4BWTNYMJnmySyhR9QXLhrYqc6tSzm/x7
 slDbEDc5m5mDIlHDB8IPKPNdfcUwstJJP8KgOfi+Bb+ZqvxDrZ0kcS4
X-Developer-Key: i=biju.das.jz@bp.renesas.com; a=ed25519;
 pk=yzD2T1OLS3lEYflbk64xhLlxhk75lZ+NoOtkTOqrlVw=

From: Biju Das <biju.das.jz@bp.renesas.com>

RZ/G3L and R-Car both use SH_MOBILE_SDHI_SCC_TMPPORT2 but interpret
its bitfields differently. R-Car uses BIT(4) (HS400OSEL) to control
HS400 data output timing, while RZ/G3L uses the lower 16 bits for tuning
delay and does not require the OSEL bit.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
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

