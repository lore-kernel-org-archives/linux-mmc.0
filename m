Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5905D3C553B
	for <linux-mmc@vger.kernel.org>; Thu,  9 Jul 2026 19:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783625367; cv=none; b=W0XesKOdPiuezLiStlx/6Lw7nSIr9kFDN1B27RI9CQvX525k5btot8DNabA11i+ixjerd5Gfc1Z8ObZDYLa4Ex7azdX1P4XcEQoPo35knptTtgglZV40IJP+M4ewexVIDI4asCxJmXgH4I7Fz7wFs1I3V8Ta0jgKSRp7/VGhaso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783625367; c=relaxed/simple;
	bh=1cxAkR9yAtlC5mHwqUD2EvA18orjnTNpVK97GJp9P1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m/NSk2QRFImLnM39IVQBaRrbWog/EFtssutY1jcZ6w1i/i4qhqUomsNPzwEo2HnlRUi6/Iw42kuLPVC9ikNi0frkddDPnV1NpcIv8LMSEMtgu8eudDusJfYcA4am0OFFfi2U61f3n/P4ZqEvspTeK2HagaNl6yd0RmoB5fPUir8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZyCRx8l; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZyCRx8l"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4938d5f86f3so1258905e9.1
        for <linux-mmc@vger.kernel.org>; Thu, 09 Jul 2026 12:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783625364; x=1784230164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G47nT6mkH5AUFnhHVR2jv6VlllcNtsKYGuK3Pr8gb6Q=;
        b=dZyCRx8lHu5fsFjE7s33U1t/Yo+B9fLYvL6fObIism4IEUf3RA9F9Rso2ToyNyVb3G
         e7wylYj8DbMQxil8ljvg0niRLg/RZFcyhJ7YjGwJ5+XtiGhBpFDEDFZqle1mSKWmNUJ8
         RzSb1rNuTE5kbXgjseENID3btR3oUxsv3a0dB0EZnVXYy8LW0fBKAP1kv7xEP7A7/wU3
         ADBPWx4XBYU9BjHHRIPSQaYtfzGddBuVytm7BpMKO46xPDLIgelwVsgQkcB8lI70ju2G
         oIT8JJXZUoyq3OszJ0OAu98f1Et4uhiepRrTWEdS2Bw/z86wV4MV/sodagoLeGabQSOP
         A6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783625364; x=1784230164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G47nT6mkH5AUFnhHVR2jv6VlllcNtsKYGuK3Pr8gb6Q=;
        b=e/+qhobJZGqiMtnc48Ah718jhHoOxjXNsPiTIU8UF1C9zQ9JBfaAWmbjE4D2KsfcSU
         hfmDmeRlJBy+f15SHcQOe0vYClKWuwP0tG0Ek1figVsSvFpY0rEr6Jk3BRHMChsgF542
         sDwqC1ROR45RKk41O3dh1K7d5NB6MutNe1WGYbefjbXsI+wYktsd+P8ypLWRAV7RGCT/
         5XyNdB/Vh2cg1IHrf7viWiE6M/eSSqA5Pnj7x1xcIqD1GDagxrJxcSqIQ+dBUaITlaoG
         fduQg/qSAHyt3+PCDfThv0zlG1Pdnjv3+I3lF5PQJ3Ec5Jjztt9ANB97/pgtD9VXAYY6
         kx3A==
X-Forwarded-Encrypted: i=1; AHgh+Ro49nFe6GFmr10jnYUcNeBb0vGE4Rxnt1GhTKrQWfjTy/UWW0zDyMlCpXNGoyO7T51MzwCN3MftZ/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGUWoIqSy/X58ZMzWv8WODxakSbgL6+EZBvE+glXF2dxI/WIFn
	tbenTfvWzia0IT+S7lrSUeGewAP84NaRZRH9k/KjTO37N855UBsfxJy1TJBR4SIN
X-Gm-Gg: AfdE7cloSQTQ9Jchn668WB5fklRVHzuFKhTvabKoaa4OWaIyHLOm6rWHyon8uLn/dmF
	C9zDnUBge0+n/+WQyu9Uf+WctIYwKJ3Z0CmWPOF/uX2qGHNamoXLZaQ+I//4DaYpNyXLxCE4GT8
	BE+ec77mNZN43WBVUbYVZsWn+sEUGW/JpwVgREbA+IPIr7uWVw/oty+fZeQAWLrGleW9LUiFUvm
	NMk6Jv73UJC6+8TahZ67/P3uH+vFVWxXN2Zujj/m4gnswt40aaswGfahX7eR+XohO4/U7ixXtW9
	OtrCDAl+R7ufDfUmdwmvKqUR1KEl+7mt51FSYmLK+lpLvm02CV21gF8ZfnLLQf+c/fdGzV7tbKA
	NTUpzjuzAMG6HV2F7IpXg+814y0Xfz6/n296ChFk8ul8P+/dbLMZiV2PrrdXH300Gvml9h2EHWF
	HnUl0NsIksAtK7f45rdiH0XUm/tf0K+8I=
X-Received: by 2002:a05:600c:6211:b0:493:b698:9247 with SMTP id 5b1f17b1804b1-493f2b3fee9mr4076435e9.14.1783625363592;
        Thu, 09 Jul 2026 12:29:23 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:8fb6:1d85:3dc1:42ab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6ccdbbsm84366045e9.3.2026.07.09.12.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 12:29:23 -0700 (PDT)
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
Subject: [PATCH v19 06/12] mmc: renesas_sdhi: Add TMIO_MMC_INTERNAL_DIVIDER flag
Date: Thu,  9 Jul 2026 20:29:03 +0100
Message-ID: <20260709192916.630794-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709192916.630794-1-biju.das.jz@bp.renesas.com>
References: <20260709192916.630794-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The RZ/G3L SoC integrates a fixed internal /2 clock divider that is
active across all bus timing modes except for HS400.

Introduce a new feature flag, TMIO_MMC_INTERNAL_DIVIDER (bit 14),
inside the TMIO platform headers to mark hardware profiles carrying
this integrated divider scheme.

Modify renesas_sdhi_clk_update() to inspect this flag when setting
and reporting clock rates. When the flag is set, the function
bypasses the standard base division logic via a modified clkh_shift
adjustment, then factors the physical /2 division step directly into
the final calculated frequency value, provided the current bus
timing is not MMC_TIMING_MMC_HS400.

As no existing platforms configure this newly introduced bitmask
flag, this patch delivers the underlying operational infrastructure
with zero functional impact on existing supported chip variants.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v18->v19:
 * Updated commit description.
 * Dropped divider variable from struct renesas_sdhi.
 * Updated renesas_sdhi_clk_update() to return rate for HS400mode
   and nonHS400mode(uses 1/2 internal divider).
v18:
 * New patch using flag.
---
 drivers/mmc/host/renesas_sdhi_core.c | 13 +++++++++++--
 include/linux/platform_data/tmio.h   |  3 +++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 832a7a7be725..b6bba03316fe 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -184,10 +184,19 @@ static unsigned int renesas_sdhi_clk_update(struct tmio_mmc_host *host,
 
 	clk_set_rate(ref_clk, best_freq);
 
-	if (priv->clkh)
+	if (priv->clkh) {
+		if (host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER)
+			clkh_shift = 1;
+
 		clk_set_rate(priv->clk, best_freq >> clkh_shift);
+	}
+
+	freq = clk_get_rate(priv->clk);
+	if ((host->pdata->flags & TMIO_MMC_INTERNAL_DIVIDER) &&
+	    host->mmc->ios.timing != MMC_TIMING_MMC_HS400)
+		freq /= 2;
 
-	return clk_get_rate(priv->clk);
+	return freq;
 }
 
 static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
diff --git a/include/linux/platform_data/tmio.h b/include/linux/platform_data/tmio.h
index 868a21842fa5..6c512e96e192 100644
--- a/include/linux/platform_data/tmio.h
+++ b/include/linux/platform_data/tmio.h
@@ -53,6 +53,9 @@
 /* Some controllers have tuning delay */
 #define TMIO_MMC_TUNING_DELAY		BIT(13)
 
+/* Some controllers have internal divider */
+#define TMIO_MMC_INTERNAL_DIVIDER	BIT(14)
+
 struct tmio_mmc_data {
 	void				*chan_priv_tx;
 	void				*chan_priv_rx;
-- 
2.43.0

