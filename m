Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98346FBF;
	Fri, 19 Jul 2024 08:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721378805; cv=none; b=Pmn8LGziJrAhntQiUfUk6N0bQIpogYUCzmBVQey6Smxgj/AokmPkp7/uWqDz2W9sC4X+ziD9PKURfUcHXGD+g2xBwZ/NWgcB58HrIrEOmWLgL4RJJzP3wbSDXaeeXNiZoqDrpq+fbpKRJ2ZEgop3M3yOTMnq0+L22FTuKlAAFHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721378805; c=relaxed/simple;
	bh=mVfEx4JP9AFjrvMyaLOq8aBTc3imfnbDnF6rEKi/ieE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rhYRs7qrLZEMVPtYRHdiNfGb1UDZUy3ER6QswMUGrjySu8GIuFrJiJToW7faBIIpoc+6L7tUwLqaI/zSUJ1nZe5ZfcrXbsamlglRioECPsZ1cQ3BvRpp1GdKJ6UcyhhLeMm5tmPCzKKjyrMeqz9cFlZAUFM/RDsTiWpWnR1COIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYo7i7UV; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYo7i7UV"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3d93f9c793fso942291b6e.0;
        Fri, 19 Jul 2024 01:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721378803; x=1721983603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOIP4q3AyZUicquYYeZDzgyZKG/BRB5AHyNydm99StI=;
        b=GYo7i7UVfJwkNAyyUH8rjBNbb1GnfIm9yr6EZWNoOiTH1xVrKI/ytOTWKApF3GmRe8
         nxioipu6Yd+8TcR0OfE2W28Q/K1ApxMwO+kOLz31Xo2cmpCa7Ll7TAVFFJE+rp5JOS4p
         2hXyV+dz0WzZLlPII7ObSJIXGabG9NW6spdqm0VXtDf9DWy9HN0AVhxYHz4x71aeT4SK
         aEb1ZZkDi98/mI7rTHHiB7Y3pDIytSuofk16QgsIDhUJ0wQ8qSJb+tFiAme9i7iz2oeq
         gJn+D9BZLBsJKb4nPK/J2BDSNK+rRzRtrz+nOpc5U1Adc0SO41vZw+q4I0ixd/D/Vn5p
         mouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721378803; x=1721983603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOIP4q3AyZUicquYYeZDzgyZKG/BRB5AHyNydm99StI=;
        b=JtMBcGdb4lrFNO1fEqUxrPoV3RHIPIsX0nlyLnYYrgeqLkPpDxkG2uCEWLVI5qEw/M
         roRDIpEoMyl19gX7L319TY9uiTDvBcGoqikC9s8diHzdf0UiFynnZt61KRDFutDWKqPc
         pLbTYWvBtd0ZLrt7axCvXrSZ4eX3oI6xMijH/GVOUtVxcoSsk4bpAxqEM25APLfxR6Bo
         7IG/5muceTkAvhLi4LAZcwQ4E2Pyk3ErhAcMncbk5X4/Y1BXXGJtkqmpfabBscoKKBQH
         gV6wGMMtOTEeqFhOddtyIM4taXy6kXH1aPRQpoXtLrJZarzWprqj6ZSxsSJL8PtZTv7g
         r8vw==
X-Forwarded-Encrypted: i=1; AJvYcCWCCe9X09xlLtDqQcZIeeCkHgHU9pF1+ieGCQo3WwgG0l+CRXAYGDLsI3207F80zH4YEzsCmAIZIV87AI1BxYt99s6ZCtCtg9irB4KICrt//x0S64hX7KB1tJGIuJ07zCx0+2VCbe4VTA/r2ZgbPT2but2kxNlI91y1IUo1GvBaE1a7LA==
X-Gm-Message-State: AOJu0Yz992RBZvdh2YrA4M0KuKgXEhenIzQr9/rz8lUam6ffX+dr33hl
	fMugokHzwONId6dTvWWKjNve2vj+NFAII9D6Q4vZlZp7InzEp5dg
X-Google-Smtp-Source: AGHT+IEZdVebCRmDzN7T5YViaIUMpQsDsevKAw7S7+jm57mupstNstZ/ad5JpT9pxRIYtp3j59AuZQ==
X-Received: by 2002:a05:6871:20c:b0:260:ed20:dc8c with SMTP id 586e51a60fabf-260ed3177f1mr4045642fac.52.1721378802656;
        Fri, 19 Jul 2024 01:46:42 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2610c7d3cbdsm233860fac.33.2024.07.19.01.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 01:46:42 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: adrian.hunter@intel.com,
	aou@eecs.berkeley.edu,
	conor+dt@kernel.org,
	guoren@kernel.org,
	inochiama@outlook.com,
	jszhang@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	ulf.hansson@linaro.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	tingzhu.wang@sophgo.com
Cc: Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH v5 5/8] mmc: sdhci-of-dwcmshc: add dwcmshc_pltfm_data
Date: Fri, 19 Jul 2024 16:46:35 +0800
Message-Id: <63b66e64c22b5ef73df2d0aa2f5a992d562898d8.1721377374.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721377374.git.unicorn_wang@outlook.com>
References: <cover.1721377374.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Abstract dwcmshc_pltfm_data to hold the sdhci_pltfm_data
plus some comoon operations of soc such as init/postinit.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 83 +++++++++++++++++------------
 1 file changed, 50 insertions(+), 33 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 30e4cea8a058..972d03ec60e3 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -205,6 +205,8 @@ struct rk35xx_priv {
 
 #define DWCMSHC_MAX_OTHER_CLKS 3
 
+struct dwcmshc_pltfm_data;
+
 struct dwcmshc_priv {
 	struct clk	*bus_clk;
 	int vendor_specific_area1; /* P_VENDOR_SPECIFIC_AREA1 reg */
@@ -218,6 +220,12 @@ struct dwcmshc_priv {
 	u16 flags;
 };
 
+struct dwcmshc_pltfm_data {
+	const struct sdhci_pltfm_data pdata;
+	int (*init)(struct device *dev, struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
+	void (*postinit)(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
+};
+
 static int dwcmshc_get_enable_other_clks(struct device *dev,
 					 struct dwcmshc_priv *priv,
 					 int num_clks,
@@ -1048,39 +1056,52 @@ static const struct sdhci_ops sdhci_dwcmshc_cv18xx_ops = {
 	.platform_execute_tuning = cv18xx_sdhci_execute_tuning,
 };
 
-static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
-	.ops = &sdhci_dwcmshc_ops,
-	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+static const struct dwcmshc_pltfm_data sdhci_dwcmshc_pdata = {
+	.pdata = {
+		.ops = &sdhci_dwcmshc_ops,
+		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
+		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	},
 };
 
 #ifdef CONFIG_ACPI
-static const struct sdhci_pltfm_data sdhci_dwcmshc_bf3_pdata = {
-	.ops = &sdhci_dwcmshc_ops,
-	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
-		   SDHCI_QUIRK2_ACMD23_BROKEN,
+static const struct dwcmshc_pltfm_data sdhci_dwcmshc_bf3_pdata = {
+	.pdata = {
+		.ops = &sdhci_dwcmshc_ops,
+		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
+		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+			   SDHCI_QUIRK2_ACMD23_BROKEN,
+	},
 };
 #endif
 
-static const struct sdhci_pltfm_data sdhci_dwcmshc_rk35xx_pdata = {
-	.ops = &sdhci_dwcmshc_rk35xx_ops,
-	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
-		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
-		   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
+static const struct dwcmshc_pltfm_data sdhci_dwcmshc_rk35xx_pdata = {
+	.pdata = {
+		.ops = &sdhci_dwcmshc_rk35xx_ops,
+		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
+			  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
+		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+			   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
+	},
+	.init = dwcmshc_rk35xx_init,
+	.postinit = dwcmshc_rk35xx_postinit,
 };
 
-static const struct sdhci_pltfm_data sdhci_dwcmshc_th1520_pdata = {
-	.ops = &sdhci_dwcmshc_th1520_ops,
-	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+static const struct dwcmshc_pltfm_data sdhci_dwcmshc_th1520_pdata = {
+	.pdata = {
+		.ops = &sdhci_dwcmshc_th1520_ops,
+		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
+		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	},
+	.init = th1520_init,
 };
 
-static const struct sdhci_pltfm_data sdhci_dwcmshc_cv18xx_pdata = {
-	.ops = &sdhci_dwcmshc_cv18xx_ops,
-	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+static const struct dwcmshc_pltfm_data sdhci_dwcmshc_cv18xx_pdata = {
+	.pdata = {
+		.ops = &sdhci_dwcmshc_cv18xx_ops,
+		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
+		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	},
 };
 
 static const struct cqhci_host_ops dwcmshc_cqhci_ops = {
@@ -1196,7 +1217,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_host *host;
 	struct dwcmshc_priv *priv;
-	const struct sdhci_pltfm_data *pltfm_data;
+	const struct dwcmshc_pltfm_data *pltfm_data;
 	int err;
 	u32 extra, caps;
 
@@ -1206,7 +1227,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	host = sdhci_pltfm_init(pdev, pltfm_data,
+	host = sdhci_pltfm_init(pdev, &pltfm_data->pdata,
 				sizeof(struct dwcmshc_priv));
 	if (IS_ERR(host))
 		return PTR_ERR(host);
@@ -1251,16 +1272,12 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	host->mmc_host_ops.hs400_enhanced_strobe = dwcmshc_hs400_enhanced_strobe;
 	host->mmc_host_ops.execute_tuning = dwcmshc_execute_tuning;
 
-	if (pltfm_data == &sdhci_dwcmshc_rk35xx_pdata) {
-		err = dwcmshc_rk35xx_init(dev, host, priv);
+	if (pltfm_data->init) {
+		err = pltfm_data->init(&pdev->dev, host, priv);
 		if (err)
 			goto err_clk;
 	}
 
-	if (pltfm_data == &sdhci_dwcmshc_th1520_pdata) {
-		th1520_init(dev, host, priv);
-	}
-
 #ifdef CONFIG_ACPI
 	if (pltfm_data == &sdhci_dwcmshc_bf3_pdata)
 		sdhci_enable_v4_mode(host);
@@ -1288,8 +1305,8 @@ static int dwcmshc_probe(struct platform_device *pdev)
 		dwcmshc_cqhci_init(host, pdev);
 	}
 
-	if (priv->priv)
-		dwcmshc_rk35xx_postinit(host, priv);
+	if (pltfm_data->postinit)
+		pltfm_data->postinit(host, priv);
 
 	err = __sdhci_add_host(host);
 	if (err)
-- 
2.34.1

