Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793191888;
	b=1zHR2aKfswe4n9eqDwx++BawkPmv+OdRrfs9JqSqs3UW504c+ozSED6Jkjzq2dHDsztN
	 rqtfNaKQdS3YX07uDq1bBPov2y7qz1P8EJYTBsv0jvmwbX44v49qwdyioE26Mv9nFIW67
	 jT19YmZxnXO8CqxLCkUdCMjzOLflLeQ7ZX2QuTch4m+QPkddDJRz90/7T69U7+JDPnqrZ
	 PKxZ+mR5ghonL5DBvVxyhDqYmU18GSBGcRP1z/D63zbTrKA82dpx1pby1ZD+H4vAVsKb5
	 4mACg7fKXbRuHbJ+LKve4S1ZkaW435JJHMm9DqC7zehkpwoRtc7ltJFC//m3aX0q0Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793191888;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=ddP2tvF99I/T141/A+gWhvbN3hboCdFeGuQB06Tv2b0=;
	b=5tR2XqLeMuMK0K9j9wuWt1I7DE40GIkRSnQ5LYFrkSkU9iljzG6fIFzJvoe7sjQlnfWg
	 5aGIfq0RVik9C3FyCsl2YSQ60CO9sEqrdlbbLH0oWQBZP21kGhi6W1+Xs2jgMHMR7fL1a
	 fqCjubl2zKoIvH2oiEiF1gY9nXwCIeDukCkV7eqewLsGnJHR5on2c4L0S5gveu5vVt56D
	 w7XOKYjtbH9W6h24txLjaUmsnw4sWJjTs2kr3A1zO35UdgdDK+aRSqeZ/VxdKjr4//37h
	 ZEKL8HSryBn73y6lW72ioBzgQCmEfzDWdZY4+T5wnh60FjrBaC/ztLh5hQwGMIUYXlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IL5UIErK;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C26560A3815
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 12:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C26560A3815
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IL5UIErK
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48e10a70540so582674f8f.1
        for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 05:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793191887; x=1793796687; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ddP2tvF99I/T141/A+gWhvbN3hboCdFeGuQB06Tv2b0=;
        b=IL5UIErKM/lQd2sgYQ2SdH52+xW3kobCm/N5cfmX8+XFWTpGyNGeyInMxwRTROHizD
         +LmDPGH+yYW3cbybhD5OXjHLQ5654K7wq4UnlxiGGguPcQzwLfzJ9XZmEy/SgXFqGzB6
         V/Tn+YyMszstLGt+CgxuFIYkARQ8jTOp7AoiaA/VJ0d8aRkv/CewP1QWQaiocjc0uPXw
         9/FuR2rwQZrJeP5VLVWbL1K1ss6AhGFIdk4MwnMclfFt6z7X5+uu51UbrTdOYxP3VMWl
         6Ck1wPeLEoE9tAOIFZXsFNfEL3CCZP2dzPvMLTZ+4KFSG648YonOB1S7lM07aaZtsb9M
         MQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793191887; x=1793796687;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ddP2tvF99I/T141/A+gWhvbN3hboCdFeGuQB06Tv2b0=;
        b=XYgG862kSswDFwH3Qjf7sHiNNHJC7bABHhfnraOel8/XZRCEpS2B7G1CKbaFlf5F33
         mx2rK6zttuTDkp3UHTo+KNO0Djbnu0be12+7LsE65b0VHxvv2ZNCSLuegDQcmLiPwsjH
         NtHApHRS1DYAA0bXX+kXFmZmzWEbdWZiBQcrrQJOw+xEJlE+FT35pia5Tpt8YwUcn+Yz
         EHh/hMt037tpplXkCRKhSF2M5dTV8E1F7WyMa1kJNwL7A1jPTsE1FYvOFoJHePGFb5sK
         bifaC9mJ8a1OQ4N8U4mCngacwxGV26NthT58mAw8vCZC4TKysF8p01Dzn5Ih5Z6yu/vy
         26Sg==
X-Gm-Message-State: AFq9FYKpgklI6Jm7lTac2g50eYcYWI2kd0S6DJXlhBOXlRlRLfLJxbUl
	+JvTyP+/d6EBI1l+EtvRZ0bZbu2UkRhiHDKlKp8gTUxC3dktg67M3Owc
X-Gm-Gg: AYBFou3pKDNgDJV+Tw/eYs/bl0ISvNHpq7Pcc5BfNqhpgLv9ueFZbF/hrObXfJrjU5/
	E4fDsjCT8FO/Jcvu6MdVTpGXkHLDb7J0fcZ/lOewInQVemvvofBCYUDipPTXSjSw9RjP2m0Ay5p
	+c8NV9x0KdldFMJgfuJ4pvbCABn10+1IQ+XFJQDmR1CVTvYU/TI+Jj+xszzwqJkQBrJn/RtdLjJ
	gnhX8/OfNszx7pCaZU6/KHW9yMTxDk525Kjg1b6s/Gus325crBmqRSK9Vngr2jglwcbRRM2faEb
	cPQBAHC1n9gQKqqsRQ5oVi73b28gxJ065Dg01Ku6ybc9d5ueEZHq9D0GREbQepOPMhnzkn73BF5
	VB5B/syCmfGTx0grBiJUBqQGVSuaZlOn8No5bipxgdGVI99T77Ui/W3v6PjnWcxTutBlXjTMMFb
	dO4M4TV2Z2GgPNozVZPuwdYIPcSKMzKiUC3KqHzZcL+DvILmIFqdPH5bv8ZoyvYW/dkahP6zH4o
	IIO/1af6ws3sUB/B536pZ+7MNCJQD5ElAZ30ALcK2L+PcHQ3UWLyrQXHdRdntJc/qompmE4viJf
	vwbmkiM1uUVoFx3aiUugv1tGa1RG4fZ9jF57r0FStPjDlqv0dDp1UZPNN3MDZ1HCjHM=
X-Received: by 2002:a5d:6108:0:b0:48c:54c0:4cf3 with SMTP id ffacd0b85a97d-48e5d5c8a50mr4188115f8f.28.1793191886781;
        Wed, 28 Oct 2026 05:51:26 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:6bf5:6c0a:cf99:c9f2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc39b3sm29275016f8f.10.2026.10.28.05.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 05:51:26 -0700 (PDT)
From: Biju Das <biju.das.au@gmail.com>
Date: Wed, 28 Oct 2026 12:51:23 +0000
Subject: [PATCH v25 06/11] mmc: renesas_sdhi: Make clock divider mask
 configurable
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
Message-Id: <20261028-rzg3l_sdhi-v25-6-57f16691c2ed@bp.renesas.com>
References: <20261028-rzg3l_sdhi-v25-0-57f16691c2ed@bp.renesas.com>
In-Reply-To: <20261028-rzg3l_sdhi-v25-0-57f16691c2ed@bp.renesas.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 Biju Das <biju.das.jz@bp.renesas.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793191879; l=3021;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=NV58WXFwlSqcA9STMr65g+9y2UmbhN8wHlp/bQXqlI8=;
 b=FR2J1qyfFrzrgjVYnS/CxYTKleL8E1J0oQGmZDc04CvBxDWktJydaSolk8scnDIcqQxcb3Yal
 KO7o8AgRAAuBRXyD4RqEUz6n9Y/9DR4oqlfJLHXheOLgl3uIBuLrDVS
X-Developer-Key: i=biju.das.jz@bp.renesas.com; a=ed25519;
 pk=yzD2T1OLS3lEYflbk64xhLlxhk75lZ+NoOtkTOqrlVw=

From: Biju Das <biju.das.jz@bp.renesas.com>

Add a clk_div_mask field to renesas_sdhi_of_data and tmio_mmc_data
so each SoC can specify its own divider mask instead of the
hardcoded CLK_CTL_DIV_MASK used in renesas_sdhi_set_clock().

Default to CLK_CTL_DIV_MASK at probe time when unset.
This lets RZ/G3L, which has a wider divider field, reuse the same
clock-setting code.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v24->v25:
 * Updated commit description
 * Dropped initializing clk_div_mask as it use default value.
v23->v24:
 * Updated commit description.
 * Replaced  GENMASK(7, 0) with CLK_CTL_DIV_MASK.
v22->v23:
 * Assigned of_data->clk_div_mask in renesas_sdhi_probe().
v21->v22:
 * Updated commit description.
 * Added clk_div_mask to of_default_cfg and of_rcar_gen2_compatible.
v21:
 * New patch.
---
 drivers/mmc/host/renesas_sdhi.h      | 1 +
 drivers/mmc/host/renesas_sdhi_core.c | 6 +++++-
 include/linux/platform_data/tmio.h   | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index b759376103d7..3c991f6b988b 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -42,6 +42,7 @@ struct renesas_sdhi_of_data {
 	unsigned long sdhi_flags;
 	u64 clk_mask;
 	unsigned int max_divider;
+	u16 clk_div_mask;
 };
 
 #define SDHI_CALIB_TABLE_MAX 32
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 500ecc357095..86778d83eb7d 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -232,7 +232,7 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
 			clk &= ~SDHI_SD_CLK_CTL_DIV1;
 	}
 
-	clock = clk & CLK_CTL_DIV_MASK;
+	clock = clk & host->pdata->clk_div_mask;
 	if (clock != SDHI_SD_CLK_CTL_DIV1)
 		host->mmc->actual_clock /= (1 << (ffs(clock) + 1));
 
@@ -1146,6 +1146,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		mmc_data->max_segs = of_data->max_segs;
 		mmc_data->clk_mask = of_data->clk_mask;
 		mmc_data->max_divider = of_data->max_divider;
+		mmc_data->clk_div_mask = of_data->clk_div_mask;
 		dma_priv->dma_buswidth = of_data->dma_buswidth;
 		host->bus_shift = of_data->bus_shift;
 		/* Fallback for old DTs */
@@ -1194,6 +1195,9 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	if (!mmc_data->max_divider)
 		mmc_data->max_divider = SDHI_MAX_DIVIDER_DEFAULT;
 
+	if (!mmc_data->clk_div_mask)
+		mmc_data->clk_div_mask = CLK_CTL_DIV_MASK;
+
 	dma_priv->filter = shdma_chan_filter;
 	dma_priv->enable = renesas_sdhi_enable_dma;
 
diff --git a/include/linux/platform_data/tmio.h b/include/linux/platform_data/tmio.h
index 27ea21c00419..f684f4087a8f 100644
--- a/include/linux/platform_data/tmio.h
+++ b/include/linux/platform_data/tmio.h
@@ -63,5 +63,6 @@ struct tmio_mmc_data {
 	unsigned short			max_segs;
 	u64				clk_mask;
 	unsigned int			max_divider;
+	u16				clk_div_mask;
 };
 #endif

-- 
2.43.0

