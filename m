Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21706139D12;
	Mon,  5 Aug 2024 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722849532; cv=none; b=oPgmgvmb3xbaeqgXk1BYrwbaiTobJouxkcY8nweirVZXkYwZJWLsTsFILTszwQcgNclHNeTO1gM/BL9G/ykxI6oQiL8626dS3JyE5GNsUpuWNr0cKhGm3jNDrooOwt0BdWEubRXeFSctgp1LmhaK52sZTUo9u0KQEMouMTIBHk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722849532; c=relaxed/simple;
	bh=OT1PAQFI1kISeEB6/Mju0shxPjUb/FrP6MLwj+WGzpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fUYpqhDaugBoLsKLAyD+PhZOYiXQsnfA+guG29yeN9CjepXtl1NThkFlcw8lJe05o5y8jL1nZ0e+isYwTG+TCQxIVgSj17kagxiIvyZ+lNlzFwLfaxrNGdqGoUq6pHtgb3pbp6R3zPSt3NsKg5qoLJt6LcP3RZMxNe70zu6N+Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9GVT82P; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9GVT82P"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5d5e97b8a22so4566127eaf.2;
        Mon, 05 Aug 2024 02:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722849530; x=1723454330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1MnlW12Z5yHzYi9o0JgUJzJS63Qd/F5nfYcYQI4OPQ=;
        b=C9GVT82P/0r/zjOMqsfEdDhXM0CaQp+R0Jg1lq/eMa4zp+vcWBPNZYb5KhgwvC3UDz
         VjKfjEILdewMWDDK2ioHLbrHqCrSvrOjverSi3KvBYt0x3hqef7wZB7GipaCgYQTewhj
         Lmyd07SldVVii11fvQiSDoudHuAORB0Y4QcofChT4Xk2H9RdRvvYrz+THtXwLO3UQ8g4
         UX9KMCfS78b4quAUxSWqb2EmUfbrA1oRTHnserCZg51NlibT4McEyuF3d88rXk0TNiuY
         wHbT6kKca+ypzwrVA7CdylE1sOCcBJCchB6gfc+TGUcni5H5uvnImkk/NPgJPETVXn1V
         pQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722849530; x=1723454330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T1MnlW12Z5yHzYi9o0JgUJzJS63Qd/F5nfYcYQI4OPQ=;
        b=Zd7Fopx7oRjuA+qvsYInOG57tZ5ugCPkkEu24XwsLDE9Q/HZPP9EdcH0Poj8EX71n6
         rLRfWvxNRtjtMXm6I91XjIbTsGu8MDWiWv+ODRuvS/fXAq5ybqrN8cFzIvtcM7RXjGl9
         uWrJrmCarzTs5bL5dnT/OUvt2UoOCo8l5BuY1K6WMgJKYyKKYfLU0OV4Y2l8M6s6YrrV
         JZDs/cdeM4gQnR2wfpicvzP86hdXckTUkQM0vS63HThZxPnqIuWiWII2TdyvrezwsuNa
         s5CzuY/OdhJLCSfOIqQYE9Z70+BsMfMoLHHDupxHv79g87v7wp9ve2PeWzfK8Ysh8Svu
         9tiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI6adqCCP0YJt/7s+XP58gVNu+cR8z3w78+mncjCLa1bfghOYW8ohBaq636qhvQKNlgPalQVnYucP/8ODdj6+gyiWer2zpfDpffYzgrb+DO/ZPZPW/xm/6d0kpoHA46yC8G80S6B1r+MQZk5ZrB9sJ4t6dazgbl4IWq65FSDgRuEfeSg==
X-Gm-Message-State: AOJu0YzVzkdzvWC/hqJ5A/pAFMXlCXlkLK3Oof1lTZKowzhKViRyQdyH
	f/sfKv5KhMirAGqkpG2vSIW9WysliLDSgu11fOaqsU4dZM+QAB/z
X-Google-Smtp-Source: AGHT+IE18FzxH3OoOcp5Zlherg/5bQthq69s9/T1LwkgOuOQJapvfIy1Z+YEqkBwYqUzxhpHCy3F+g==
X-Received: by 2002:a05:6820:2228:b0:5c4:7b18:b8eb with SMTP id 006d021491bc7-5d6553365f8mr13200926eaf.2.1722849530205;
        Mon, 05 Aug 2024 02:18:50 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5d76261a27fsm1901822eaf.39.2024.08.05.02.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 02:18:49 -0700 (PDT)
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
Cc: Chen Wang <unicorn_wang@outlook.com>,
	Drew Fustini <drew@pdp7.com>
Subject: [PATCH v6 5/8] mmc: sdhci-of-dwcmshc: add dwcmshc_pltfm_data
Date: Mon,  5 Aug 2024 17:18:43 +0800
Message-Id: <cb2c68c594286e9588c53acb76163e60c140c02b.1722847198.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722847198.git.unicorn_wang@outlook.com>
References: <cover.1722847198.git.unicorn_wang@outlook.com>
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
Tested-by: Drew Fustini <drew@pdp7.com> # TH1520
Tested-by: Inochi Amaoto <inochiama@outlook.com> # Duo and Huashan Pi
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 81 +++++++++++++++++------------
 1 file changed, 48 insertions(+), 33 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 55fba5ef37ba..16f420994519 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -218,6 +218,12 @@ struct dwcmshc_priv {
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
@@ -1048,39 +1054,52 @@ static const struct sdhci_ops sdhci_dwcmshc_cv18xx_ops = {
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
@@ -1196,7 +1215,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_host *host;
 	struct dwcmshc_priv *priv;
-	const struct sdhci_pltfm_data *pltfm_data;
+	const struct dwcmshc_pltfm_data *pltfm_data;
 	int err;
 	u32 extra, caps;
 
@@ -1206,7 +1225,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	host = sdhci_pltfm_init(pdev, pltfm_data,
+	host = sdhci_pltfm_init(pdev, &pltfm_data->pdata,
 				sizeof(struct dwcmshc_priv));
 	if (IS_ERR(host))
 		return PTR_ERR(host);
@@ -1251,16 +1270,12 @@ static int dwcmshc_probe(struct platform_device *pdev)
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
@@ -1288,8 +1303,8 @@ static int dwcmshc_probe(struct platform_device *pdev)
 		dwcmshc_cqhci_init(host, pdev);
 	}
 
-	if (pltfm_data == &sdhci_dwcmshc_rk35xx_pdata)
-		dwcmshc_rk35xx_postinit(host, priv);
+	if (pltfm_data->postinit)
+		pltfm_data->postinit(host, priv);
 
 	err = __sdhci_add_host(host);
 	if (err)
-- 
2.34.1

