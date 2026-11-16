Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855166;
	b=erDYw6iVEgnXw80IubshtQXyWdJvoV2i+txkZY5iJQETRncrJO7i3+rrcHcoaguX81uW
	 LXCfx0WzUHaCXOoyCZhnpr8VhBSYItwUfQAukd+OXiu6ekvtvlE+UYQ7P86EAKdmdZ9bE
	 df4+2fiXag2ExJbCnWFGmWCxvLcedo29dERi79Y4odfKWu4MNFVcc2H8XQpcdQF2bNCMZ
	 dyFws5gjcTchakRKNCFWMUmFgA4/gC+37TEienWzFG/UeSL9cAu6Sd7xdPSZm5KTDsDS6
	 MeJsYxGIoyn6UuVKOTcFNA+PADf7ATAUm9WcuLXYcR5r99t7hXbPcViTm5SwaoVW5Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855166;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=TJT4CBUbgD3xpezjgv+AsgOQys6XK1VUjumYM2wegeg=;
	b=RnYjvhk2NKgfkCBK5jvFU80dVzMbbfTM8QNn9Cgxpn1DCdgTjMIH2dm328HZ4/NfHdjE
	 QOgwyOTNEzsYTNt3gIVB8zNPJjfUBQ79+0QC9x3KxMSoxHX/CnQlCv8+vt/ocLNTRAUfC
	 qjT246Qr3toZxbmha+Th61+H756mLAC0Vu5VVUTXSYR+N50kadwaHrcPDL6WlfY3gnqZG
	 /PW33vpvYAa3C6K7LroKi1eYQOpWkixTHxEhRzDVSo17u4Bv4PfB27AIWCO/N4e3i78ax
	 mDMcqmsc/r6YVoaCi3oV7jak5f9ktSH+XZ36dDPUc7B2I8h6piwthW1zyVU2XjWVaPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wyLQ5Mgj;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B752C606A338
	for <linux-mmc@vger.kernel.org>; Mon, 16 Nov 2026 18:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B752C606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wyLQ5Mgj
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so23827655e9.3
        for <linux-mmc@vger.kernel.org>; Mon, 16 Nov 2026 10:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794855162; x=1795459962; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TJT4CBUbgD3xpezjgv+AsgOQys6XK1VUjumYM2wegeg=;
        b=wyLQ5MgjxjsoQtM0gPvPL1Skkd0515VBuf3ATX7cSVOFqv7lRiIcZc7BgwfE0sTMaO
         /t9N07vlpHHy+HJmr02ctplUm7MZXxDS2snEKADzh2UmP6NBAAPVGGm/f8C5fYwaPNnN
         c2/ra2Ae/RiXgOWDUfc4ZN9jT8lfV9QfcCalHEQAADMZ9to500NgLfILGRrLQE2I5+RN
         g4BZ/9sz4SVqB8Sb7xFgNDpxsTZuwdxsHegUN81spoQjGmmRG712Ajmwuku89CAIdq0J
         6ymsuil6hEUD2qKazE/KPFYcB7iVeLz3wGu1E2HEJ37ml1QAxhm6dFxv7za9F5mTUtq4
         Pq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794855162; x=1795459962;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TJT4CBUbgD3xpezjgv+AsgOQys6XK1VUjumYM2wegeg=;
        b=oI32yJb1/FYvQ5d80lYpqKJu2adAhQo3+vESSPrPnB83HVge+fWxqMcbJW30pIvowK
         NJYdl7g5jgi9I/vgKr68Ymf5PQwWAEaHGlrC8FVOtEgL/ntnIkkdCgYrt9jzqijOeKR1
         sxiZ6q7ZJWFcM86wNb8MtakJ8/u0ocxxSv/wgu69+Qjn9iwne6GMfxzBX+s2pvSbZIt4
         CVuchhE1twmH/djQdjf7U4CP3vurcTcGrxv8AAUW0GRWPSokSd1LnoI1l9jOCwz7XVuM
         r9XRUfiCNx1zeCZLLG2ijO19FaQknsMdPvoNzWhOS0SqvbMCJECW71zROk8rmgnULIPE
         od+A==
X-Gm-Message-State: APuU4Z9h7/Lru2ehGgtM+NjWZoL8UUDlsR0OZNRvsrbkZ8NMCN6M6aj/
	ePOVjlE2kfaI/aMZt9Oy5MHhp4UzT3elEg1uE2ch4octvP/O/PMg4A6b
X-Gm-Gg: AYBFou3x+xmscUm5Yu1XAltKSj5E/WxQTov1RXAHLRRKwdBDNA1pdcmG7vrnGvWYN73
	6rvwS8yfdojMMfOIkRDIle/Z55BVNmUZsXZGwZsdSLHYgkWKZGFDE5yAcYuHCdkKC33MyJfiFL/
	hwbMBjMRw52rUhFcLBvs3zdV6x5qClArJ1vK4YPrm+i3Nhd16lc/6AdVQYdt9Oo+dsYrvAMIhZk
	maeXDl4FIqbfl+TAIuZWVn5NetdF6+ifGrf1HkeEg56s6VvEQvuCPBTZPHEtwh1sem3ka/4WvyM
	j4ym7YytwI5M4pXaqwOoiwdY2UZHFUOp4ARZANsB+8042s6sVNICw13vyKixHXTS9jtv1715kAK
	rEWhgNSKUqGZx5qxMboEt9ytDgb7q3+aEv9KvnNtfUGhufZOH3awYgqP3scNjEcZucatqvSERpm
	Z9hp9jATLIMAnnr6TlrAGUCWYWPIalPk/78GCz1HAdzR8Sj59Ywh23PBDhjhLreBZMM/jNvydms
	XviTouyu9dM9T25WbkgHJZkj8Ra+fVlFvEvvNfd6tl6vywA4xfJWaKoyvzTU+XyWgTwLmLqPb3C
	EnqxvKihnuc/dJV9UGK5CP0EhzT19eSdm8oWBbHi+qWal2Tm8gHoHSMDEw5FzoQI2ws=
X-Received: by 2002:a05:600c:506:b0:4a1:f377:5c6c with SMTP id 5b1f17b1804b1-4bb55a5d6bbmr162373025e9.10.1794855162142;
        Mon, 16 Nov 2026 10:52:42 -0800 (PST)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:6889:eb24:5e57:83b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb5720f6basm157961345e9.4.2026.11.16.10.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 10:52:41 -0800 (PST)
From: Biju Das <biju.das.au@gmail.com>
Date: Mon, 16 Nov 2026 18:52:40 +0000
Subject: [PATCH v2 2/3] mmc: renesas_sdhi: Make HS400 OSEL bit configurable
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
Message-Id: <20261116-sdhi_hs400-v2-2-de41f7a7f330@bp.renesas.com>
References: <20261116-sdhi_hs400-v2-0-de41f7a7f330@bp.renesas.com>
In-Reply-To: <20261116-sdhi_hs400-v2-0-de41f7a7f330@bp.renesas.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794855160; l=4095;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=AnhaKOiPuDqc6xcLEGP7+1MeHlroB4vbW7YE9vOw010=;
 b=c5atoYCQWPfqNKolpifzoMYk00fDB2d23uepR6WSvcjIje1VR13Q73QWr5S3+oLm6nLE6oHxN
 gtTbd6VDSIMDnM6/wzMbjK2ycIwEimomYaSwy7GjWcGZMIwc10whUE1
X-Developer-Key: i=biju.das.jz@bp.renesas.com; a=ed25519;
 pk=yzD2T1OLS3lEYflbk64xhLlxhk75lZ+NoOtkTOqrlVw=

From: Biju Das <biju.das.jz@bp.renesas.com>

RZ/G3L and R-Car both use SH_MOBILE_SDHI_SCC_TMPPORT2 but interpret
its bitfields differently. R-Car uses BIT(4) (HS400OSEL) to control
HS400 data output timing, while RZ/G3L uses the lower 16 bits for tuning
delay and does not require the OSEL bit.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No change.
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

