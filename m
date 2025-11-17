Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCC5223DED
	for <linux-mmc@vger.kernel.org>; Mon, 17 Nov 2025 10:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763374375; cv=none; b=g8Btdz8DVV8Rc2CwoIHhZ9dBe5K/kHy85BpxjONOacilT/v4RDTv6PsyWvtevbdKmIMExKakYz+T8xFo+mCo4LLPTvyUJtP6fTCbx3W21nX9b0OoqBC2AHoONSjY+6UljSBjRDEYdSgVaj029/CR2nOexz83h2rZUC8sPtsITxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763374375; c=relaxed/simple;
	bh=PZ2VgrJLCT6NE6Pefv6XTKPPIj1W5MZjYi6YpoC0I3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9Y9ywR/dOHRZv17rEHaIhcG+y+PnDPD9DMjGy91tUtCdi4u8K+hZMJ/MZu9Z70ZDMDwW1I/dC4sxkN9fgjHm9Yw41VcURXZqLPTqULmtr7C6wz9ucwVmzxGn5WWNlqfe6Mvvy3G8ekamk2IW9TH6VoJw10WFyCxn06sO11nVTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=BxL+6V2v; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="BxL+6V2v"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b31c610fcso3589478f8f.0
        for <linux-mmc@vger.kernel.org>; Mon, 17 Nov 2025 02:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1763374372; x=1763979172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4PkvTKq6TDEv7PXnSRVk/VXlyWDyWyNgT0QaQUkpPE=;
        b=BxL+6V2vTTv0cv59rlaM7/PWoFxAAWN/BqoTvWJpzm0ny6SX0TLuYWotBVuk9AFs1o
         ak1EUYaYt0QMKx40WKLdLdlfyC1+x4LaVHPa2qy6spNwf5uQMqNvUFCzkQ11xhlHFleH
         RGnSLFe9X+T3tOvIFc5rBbhYklobA/Ux/WadialhT0ll9YUye4dlacVJHWYK6A0ts9J8
         gC8075xT7AJvMdOntueimG9PCKn44JlRuD3QxwOYm3G6KQOwCsOGz8k5x/7McI0jOA9Q
         VI8+ZbxrRT7gEFh1yhpNQV1HgH/9pVQpe1ps+KRn/tfcYn9b08yb+J9boxBKQ9G1x0GV
         dmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763374372; x=1763979172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e4PkvTKq6TDEv7PXnSRVk/VXlyWDyWyNgT0QaQUkpPE=;
        b=jDtQAJsjOujOYp+kzZEoltMsfYGF2Qheuw87TA1Piy1IbohR+JKv+YEB/f2Z/08hcq
         Cmowgpu4vyyB1J1LhY/JP4s7t9ecDlHcWklXUk3nGIXYqMoCUBNDlL5/VfucOjzbff+z
         c9jsisk5dAsn5jJCLDKkyArTjPrTPQ1Bj5fZZlmDSS7LG6h/3rUJofls0gwrzrjQXUsL
         5GBG8VBRGzHNh+v/uNmula1M8VdDs40wG9xYgJKbk+VBWTogi0EfKKb4/dxrA1iC8BYD
         X4CxJ0f0Rm8SH+YSn3S+xHj+7p73iGgUVG/oalzWJGGZwcSaFdNBS5bvGFa8z2+uy0jA
         61iA==
X-Forwarded-Encrypted: i=1; AJvYcCVZ8MYI+31r55pxNm6DrQvK19GkYhUysj89PWWy5aAEGZVnNxG/YWTXcU10Kf1Q7fAbYB0OnGrF4j8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4vhh/vQBTL3VSXhI8rSFutBanXgYSlNAz0j4sYQzs9+QXCksp
	3IWSa4lS5EA/VPpCxCzlEmb+P/35USfda1Tj+Kc8/BEczGlm/lzP+NIEGD1Vmn7VAg0=
X-Gm-Gg: ASbGncunG+pON0BMsZXxTMuBx7ylFPCFrFoUBniTJ4UWKVTOYeVP8qIvpq7oHNATNw3
	F2TsfTo+1aTiuq5yEbKtkPEjKjseZEd19N7YD2+swBIowEBq23bdNjq+csTFhKsNAKXz2H/ZZx6
	QtMWXA25/nOCiQfzPaY0ifjyicvX6rZoAAtquocqABtM6XQx9VT9lkhuFVO3kNyT0ViIXaGhP1b
	COcSaX4uWvz+PYTqWaHSlyrnQHLEXnXxU0CIPqbJ8uQJRkuie2xBJcC1Id9W3kfjIdEbt1alZg3
	oD3FegfQzPi91cLET9a40cfB9x1cWjzQE6s4PVX280Q75Al+WoVctiGCSPn6HKVj/cZ7AUuKPvU
	W+vh5JVySlgUYJ+uB9GSfI5llMAleLwZqzZ+SDk+Ca5STS10Omp9EfvqMhUOsbmEgzwmnZc5OYD
	SLTAbG9GMLiqO9SUvk+bov0p6Lo9SO4VpkDP07RNM0zO2AktjDBeg=
X-Google-Smtp-Source: AGHT+IEykh+Wlet8VlkgThLmhCvrSTt1q//BTlZcTgfJl+kE1lU1w4o7mJz5iLJHHZN/1nGc/YYH2w==
X-Received: by 2002:a05:6000:2888:b0:42b:3ab7:b8b9 with SMTP id ffacd0b85a97d-42b5934db2cmr10562830f8f.20.1763374371844;
        Mon, 17 Nov 2025 02:12:51 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f203afsm25806958f8f.39.2025.11.17.02.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 02:12:51 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: wsa+renesas@sang-engineering.com,
	ulf.hansson@linaro.org,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	geert@linux-m68k.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 2/3] mmc: renesas_sdhi: Switch to SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() and pm_ptr()
Date: Mon, 17 Nov 2025 12:12:41 +0200
Message-ID: <20251117101242.4018208-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251117101242.4018208-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251117101242.4018208-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

SET_SYSTEM_SLEEP_PM_OPS() and SET_RUNTIME_PM_OPS() require __maybe_unused
or #ifdefs protection against unused function warnings. The usage of
pm_ptr() and SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() allows the compiler to
see the functions, thus suppressing the warning. Drop the #ifdefs.

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- adjusted the patch description
- collected tags
- dropped changes from tmio_mmc_core.c

 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 11 +++++------
 drivers/mmc/host/tmio_mmc.h                   |  2 --
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 73c84fd8a2d8..ef06c3a60ae8 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -600,18 +600,17 @@ static int renesas_sdhi_internal_dmac_probe(struct platform_device *pdev)
 }
 
 static const struct dev_pm_ops renesas_sdhi_internal_dmac_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(tmio_mmc_host_runtime_suspend,
-			   tmio_mmc_host_runtime_resume,
-			   NULL)
+	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	RUNTIME_PM_OPS(tmio_mmc_host_runtime_suspend,
+		       tmio_mmc_host_runtime_resume,
+		       NULL)
 };
 
 static struct platform_driver renesas_internal_dmac_sdhi_driver = {
 	.driver		= {
 		.name	= "renesas_sdhi_internal_dmac",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-		.pm	= &renesas_sdhi_internal_dmac_dev_pm_ops,
+		.pm	= pm_ptr(&renesas_sdhi_internal_dmac_dev_pm_ops),
 		.of_match_table = renesas_sdhi_internal_dmac_of_match,
 	},
 	.probe		= renesas_sdhi_internal_dmac_probe,
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index c8cdb1c0722e..b9de03325c58 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -209,10 +209,8 @@ void tmio_mmc_enable_mmc_irqs(struct tmio_mmc_host *host, u32 i);
 void tmio_mmc_disable_mmc_irqs(struct tmio_mmc_host *host, u32 i);
 irqreturn_t tmio_mmc_irq(int irq, void *devid);
 
-#ifdef CONFIG_PM
 int tmio_mmc_host_runtime_suspend(struct device *dev);
 int tmio_mmc_host_runtime_resume(struct device *dev);
-#endif
 
 static inline u16 sd_ctrl_read16(struct tmio_mmc_host *host, int addr)
 {
-- 
2.43.0

