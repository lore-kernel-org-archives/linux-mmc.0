Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795537884;
	b=P0jgW9+YqWU3dl8LG6hiQy54+xjz3an6f+RUOktd8pMeUNbZuiDh+9Gf537pIoueztUf
	 JYVmh9YAc2T9bDI+R7B6RwTe7Ia4dE+UtipiKpagqGgOBQxjsvJPnSUqcYnzmESe1M5Ix
	 ozxla27pZWX5Qv9EI1g2JvVhY+UTQpiD8Geh9qb0kx2y4YoHIEsMc2+GtReGhYbsD0eFl
	 gmbk/Cqljh94jHBeyp8izt8wqQ3OS9l5VOmXrHqDmP8NGNfjgWNpJw8riWiNbbbGij6GW
	 ugPJcDCPTsqK61kKBifK/+of4u8nZsFO9vSke7WgHJC02VMkGCLNwlEXrHMyBbFur6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795537884;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=5PVlPBRThxX67H9TTtVJx0hv+Td+7iCuwsI+GnVhog4=;
	b=seDF+oqpWIuxkWpbpv2GcyYzGKF+haW0aL6m237rkzKnRdVQdr5E6jrfYj7PCv4+6Y8d
	 mlx98qLRzQC+OlDOIIphf2lFz3UtWOK/Zq5Ydup37Z4OK+Yjat6neVaAXntOweE42nznZ
	 wDE0+BqHFWSBgyHIS1IIswsrKZar3jRM2W9mM9effqIFQuQuD0WCIb7zvTk08dACdMoHh
	 s/beyVUeo8qhGfpM/NdnGJ8Ml/j0AUonUW8k4oFPffOdNtqwQtMiGzgKrXFgylm+s5YYX
	 kj1+D4M+aHqZ+kpaoXXYfZ4uwze1DXm/XNwrrb+kA4x9YWbIxw7muR07l6gmR1gh6fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EoBjn5+z;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F53B606A334
	for <linux-mmc@vger.kernel.org>; Tue, 24 Nov 2026 16:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F53B606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EoBjn5+z
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso46870245e9.1
        for <linux-mmc@vger.kernel.org>; Tue, 24 Nov 2026 08:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795537883; x=1796142683; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5PVlPBRThxX67H9TTtVJx0hv+Td+7iCuwsI+GnVhog4=;
        b=EoBjn5+z9vfyRMolB7sHPK6JX7M1nDRZOPpaW2AZ+ohoq4W/bOyGLvEY93MCkdAL5H
         AwZfgQPMcUzD+/Q4j6H5uk9/GTm1IMWyHGfxeKC/BHTyorm3A7tTGBqYyjmtDuIbgVSI
         sm0SuIXR2iRUJnbAvd5fzsCB+Gsdh/6wis6wLIWv0KUN6fU8O3AEe2414h+q2Kvf/FKu
         2Kf3RhX5D91DgxHzfiEyLPHsUBORGKWQSWXfxkLQRQ5V/dPezE9r+ocGK2RXdWD4afFp
         ljz48Ladd1NLkRFja3P809REOQc8IJ88UlwdkCTk31NhwnwJdDTo7iL//jXjWiHaSzco
         J+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795537883; x=1796142683;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5PVlPBRThxX67H9TTtVJx0hv+Td+7iCuwsI+GnVhog4=;
        b=UKK44P/1Lc9ikDzr6ms64AR1iNIpXM/TounbcbGTcHcGlzz4eyK5jM7LvUWkNBRpOy
         1rZuAxzicIOkgakyHY/XEqpDnwDYILVtqeNq2jYM2UL/q1H1h6kAnG1ccpvsl2nXUsuZ
         wBUtZ5vwSQFN+1pHDaTfSXbKwLt5H4iFXVgOMQzAM899Fw2124kIaNpF7Ngs+7lRJAAY
         e+yXL/wJF7L46253aXGHv9GoCx0qrWdkQytOXPfZWInSsaVhBYwLC6OXgATnoTwjoWsl
         9rjqOf1LIWLaAF9M+07/3rjxJ5ZyJAmFRhlMJOCgjSnAZl/m7jcwhVvszDxw4yWyiJ2l
         X2AQ==
X-Gm-Message-State: APuU4Z8A5LA3JIjyCzh+gu70XAn2vR12x8/VG7t8Frd2VPLUOvT9pN1M
	/OrGP/JHzWcz8ygE1RL3ehNwRhJmQox10eGapTA0ULCVmoZ6PtI2q8mMySIZ/w==
X-Gm-Gg: AZFdTZdnI3AFrpcbAlUozemRUlFDvuylTNntpEWopFmU1XoKsGE55jFsnWzZaf64Hnv
	QkYwB7TzYmX9aotLwr0UCA3tZ83Hv5/0As81UViH8tMWPxSZOtsclaCYGZ+FtnzfD/ZkxQlTVwA
	j9lTDtCP+IASpz3jctOkh9fqTWlloJdeAqC1CqUxo/3nw81hjO2PZ7YhOO6ZzeV2wIsBNn9Zjqv
	7K09C5td34lLE4NQqQ3+110gcwcHUpcakxvm/B4WnSA/pFeCxJdWMiDJpMk2NNP1oy81QqcJPzG
	NpP+j5Zrl2BkNtZK+FI/27G7CQV7IiwySJ7rvBNnaQ8j6kdeyq6chChZHGznh/T4Mexr0VKOQ2q
	5wL4IeseEiGZt80oQw8LtTTwQLlQEWGdL8a6VCm9uwfE0Zx4Y3DKLLUAXgdmY+tMNyLF6gUFXPA
	Ito6Ymm/lVUJftkF2Mq1tas0JkOoYYHaT/ukeAynBybFTNoULN4HVdr6HkzP8fQf6py/av9zjXC
	LRLZJp84rmi/tr7vNFDshHsqfRTMPVKOZ+gMRmxba951eAdFzY9sSfqd+//RZOYqg7p73HLTDY3
	jrZ86G67ewzARU4t0Xqcgu12INcmT6N/UfPhrFmoegPGsvnb4AgttpTFCipJW6v+8A==
X-Received: by 2002:a05:600c:a11:b0:4a2:e0c:2b0a with SMTP id 5b1f17b1804b1-4bb888120famr315786195e9.16.1795537882758;
        Tue, 24 Nov 2026 08:31:22 -0800 (PST)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:d107:658c:9ded:696c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe75sm33058741f8f.24.2026.11.24.08.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 08:31:22 -0800 (PST)
From: Biju Das <biju.das.au@gmail.com>
Date: Tue, 24 Nov 2026 16:31:20 +0000
Subject: [PATCH v4 2/3] mmc: renesas_sdhi: Make HS400 OSEL bit configurable
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
Message-Id: <20261124-sdhi_hs400-v4-2-df452ccd9bca@bp.renesas.com>
References: <20261124-sdhi_hs400-v4-0-df452ccd9bca@bp.renesas.com>
In-Reply-To: <20261124-sdhi_hs400-v4-0-df452ccd9bca@bp.renesas.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795537880; l=4140;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=uzoW0FnBY7lsUObZbuxqWOsDbiHEnxLpgnRmU8ynFUU=;
 b=KvBXPiVvk3F0FXZUfyq2iW2tY7tkdQdK5VfG/TFS2+4FK1iZXZDItLjCEpby60uoTlQo9gv7/
 VghwMVRPnhvCyGtBGUqVJ97uKeoeL/h4zPBHQOH8byVAE/IWR+9pL2L
X-Developer-Key: i=biju.das.jz@bp.renesas.com; a=ed25519;
 pk=yzD2T1OLS3lEYflbk64xhLlxhk75lZ+NoOtkTOqrlVw=

From: Biju Das <biju.das.jz@bp.renesas.com>

RZ/G3L and R-Car both use SH_MOBILE_SDHI_SCC_TMPPORT2 but interpret
its bitfields differently. R-Car uses BIT(4) (HS400OSEL) to control
HS400 data output timing, while RZ/G3L uses the lower 16 bits for tuning
delay and does not require the OSEL bit.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3->v4:
- No change.
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

