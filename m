Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432183CF1F0
	for <linux-mmc@vger.kernel.org>; Mon, 22 Jun 2026 15:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782143789; cv=none; b=m/A5syYwaJ9x45HtWpZRqVxnvZGdurCAB4N7YpbymW8ospT0n6JhAa89Bx5ukdvT2HzUCT+/ZAPmaHKvcpzPXd1PJEMDq9T5Y6ilvwOydYp1LhPMU55T/UMDzop7Hb6euTdSeJCrKA7b+s8FDccruNDZHBmhNqy0ZtObMb4vCfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782143789; c=relaxed/simple;
	bh=nHSCQ0T3X03ITihxI/PypcltAh9LnWZ25hMqPFTlsRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KA+CP4lfzDxWHy7ylSjfvPqCGIevVng2R2vYLqjfPFAMdtaxycEc0b8sXBG01LPgIntYii6hJBb+uiccoifAK48+L3rwdgdaD/wu3M379hzYTl2hEnHdVAVWHFlr0ZCXIC07HcEYrsC/+0ymOJ+eHG+OIyoQ/lNind4nLVwuMzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZiSXEyW; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZiSXEyW"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4921e4dd62dso295215e9.0
        for <linux-mmc@vger.kernel.org>; Mon, 22 Jun 2026 08:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782143785; x=1782748585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53AJnkyGN6jNd0Q05SIz+j34qM5d67kFmVYxK/89G+k=;
        b=VZiSXEyWc/Ko01ArpmRFl5Cx6STDMWwBs/4yKtq5zmFMLS5XyyO04am5DRZEzmcF6E
         QV/AuExRW/tkJe5BQSvw+52PsKuKq4GifG5oWH9NaLsToO53xARqszSlkhdlpEbHuasr
         uI9PGV93UXDtG5c9sEbpBGbrww/EbLDVL6cWqT/5e51uJCZaxDoVPRMFHehE5gCSusWU
         xA5OrPS70T+tj5c7r10s62R+L3mbJokWLkJfettvvyzW++MW58CifcXUNnMfZbDWmEm6
         C6mBNGHuTaKBTVL3e6T21mvxyIjURy2VZ40ewWKWHTE8ftcodxCjJilIzyNj6v0z5gGU
         a6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782143785; x=1782748585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=53AJnkyGN6jNd0Q05SIz+j34qM5d67kFmVYxK/89G+k=;
        b=fptlNS74rvTDtutuIxBv0J9mqWGiyGwZcIRIiRgyl56Cc3bHnm5KbyR0CNT/NQToBg
         9nGA9rhk6urHfxufsepIZ+lpRHqHjylGEmhZoKMb7tVjWhmzUurr1JdjAXDbG1fcUhyq
         FvZCDq7RZYWR2S/2RulBG6gBjTKUxMrAcy8XJtHOSHAAeX8aRtHbj7MpEEdrOmE1C9Sm
         FwrH0Z8H2EWHcQn1N2DloTrY/6Vk3fTpBLlOZzBnyo25gcMls7D77wSmQezaN0tfeCyI
         U5E3xxL99d2hiUVIgv86f8Sf7zQfzEk37iNMBUw7FZQi5gXLM0bHDgNRmQCac3s/9cYb
         FlCw==
X-Forwarded-Encrypted: i=1; AFNElJ8jVYVQawil2cupUIARuQDN/Gn2bHPviQspCYkErdUkB5JAbXTreOetqQXwNllyWmo4/RgxrUs72fQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx64KX6EwjjILdfu9VQZ10Mfmlu6DCwo56Giael4l9WFm2MmOoo
	lOp1uUQinJ3hSV84ClWeSOT+0whuTu1b/8/7gjz4rT8BTh6SMcbBo6Vd
X-Gm-Gg: AfdE7cnBannsaYkm1AEBhPL/DmOxK9B42A2VnlQsOxNtjDanmWF+4ejMkQKhUPhdly9
	N+FJjV1S3g8HTzRVO+R4rhC+7K6APl44xCH8nt6GR7CLml/RKLS51WD0Mi3tv8r8AKEnq81ByXx
	5lwpA0csqSv7LB/f5VTucdH369eqY/PQlRQgTBHMn6B4zzv+kmghux5CnEFjmebjIGtTA6s4+FJ
	y5DyiTzM8PddJkNBJCUGCz4z8DWexNGKHI6+aJMXNZGOsCgQPwQpEpn4MOCLfJHt6ENhb60r4ct
	WL5kVuwj6sP7+2xzs2bdvSPu0kk6xDX7weus8e3lfsMANYbgjYVeai4TlxnzLtkcnGMk6xPusFC
	BsGfrxD0iyTt4xGuA1AMjjfeX8OKmjVugqigE+XZa9IDlal1GpbTtOumRDGY01tpoOuAwOs/3G/
	9G4Oh/WYWv83DA7zcpXiFXdWDHSQlIw11RNrLQcnf1UdDcqffb
X-Received: by 2002:a05:600c:8012:b0:490:e180:2e0 with SMTP id 5b1f17b1804b1-4925a09d73cmr1621685e9.3.1782143784537;
        Mon, 22 Jun 2026 08:56:24 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:fdf9:c68d:5fce:b1ef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923ff8a9e3sm331778025e9.14.2026.06.22.08.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 08:56:24 -0700 (PDT)
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
Subject: [PATCH v18 10/12] mmc: renesas_sdhi: Make HS400 OSEL bit configurable per SoC
Date: Mon, 22 Jun 2026 16:56:01 +0100
Message-ID: <20260622155610.184271-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622155610.184271-1-biju.das.jz@bp.renesas.com>
References: <20260622155610.184271-1-biju.das.jz@bp.renesas.com>
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
v18:
 * New patch.
---
 drivers/mmc/host/renesas_sdhi.h               | 1 +
 drivers/mmc/host/renesas_sdhi_core.c          | 6 +++---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 2 ++
 include/linux/platform_data/tmio.h            | 1 +
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index 9d5e591ef2f5..3099330c7304 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -41,6 +41,7 @@ struct renesas_sdhi_of_data {
 	unsigned long sdhi_flags;
 	u64 clk_mask;
 	unsigned int max_divider;
+	u32 osel_tmpout;
 };
 
 #define SDHI_CALIB_TABLE_MAX 32
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index f77985d305c0..42645480b62f 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -292,7 +292,6 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 #define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_REQUP	BIT(24)
 #define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_ERR	(BIT(8) | BIT(24))
 
-#define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL	BIT(4)
 #define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN	BIT(31)
 
 /* Definitions for values the SH_MOBILE_SDHI_SCC_TMPPORT4 register */
@@ -439,7 +438,7 @@ static void renesas_sdhi_hs400_complete(struct mmc_host *mmc)
 
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2,
 		       (SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN |
-			SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL) |
+			host->pdata->osel_tmpout) |
 			sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
 
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DTCNTL,
@@ -580,7 +579,7 @@ static void renesas_sdhi_reset_hs400_mode(struct tmio_mmc_host *host,
 
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2,
 		       ~(SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN |
-			 SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL) &
+			 host->pdata->osel_tmpout) &
 			sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
 
 	if (sdhi_has_quirk(priv, hs400_calib_table) || sdhi_has_quirk(priv, hs400_bad_taps))
@@ -1180,6 +1179,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		mmc_data->max_segs = of_data->max_segs;
 		mmc_data->clk_mask = of_data->clk_mask;
 		mmc_data->max_divider = of_data->max_divider;
+		mmc_data->osel_tmpout = of_data->osel_tmpout;
 		dma_priv->dma_buswidth = of_data->dma_buswidth;
 		host->bus_shift = of_data->bus_shift;
 		/* Fallback for old DTs */
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 9cb69003ac96..709351693efa 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -130,6 +130,7 @@ static const struct renesas_sdhi_of_data of_data_rcar_gen3 = {
 	.sdhi_flags	= SDHI_FLAG_NEED_CLKH_FALLBACK,
 	.clk_mask	= SDHI_CLK_MASK_DEFAULT,
 	.max_divider	= SDHI_MAX_DIVIDER_DEFAULT,
+	.osel_tmpout	= BIT(4),
 };
 
 static const struct renesas_sdhi_of_data of_data_rcar_gen3_no_sdh_fallback = {
@@ -148,6 +149,7 @@ static const struct renesas_sdhi_of_data of_data_rcar_gen3_no_sdh_fallback = {
 	.max_segs	= 1,
 	.clk_mask	= SDHI_CLK_MASK_DEFAULT,
 	.max_divider	= SDHI_MAX_DIVIDER_DEFAULT,
+	.osel_tmpout	= BIT(4),
 };
 
 static const struct renesas_sdhi_of_data of_data_rz_g2l = {
diff --git a/include/linux/platform_data/tmio.h b/include/linux/platform_data/tmio.h
index 96eff17179cc..8b4032b24d36 100644
--- a/include/linux/platform_data/tmio.h
+++ b/include/linux/platform_data/tmio.h
@@ -72,5 +72,6 @@ struct tmio_mmc_data {
 	unsigned short			max_segs;
 	u64				clk_mask;
 	unsigned int			max_divider;
+	u32				osel_tmpout;
 };
 #endif
-- 
2.43.0

