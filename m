Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0391F139D12;
	Mon,  5 Aug 2024 09:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722849514; cv=none; b=MWJ7tfdxYCv0s/F2pKluSBrrezBwmEvseAAbJNbDKDHL0+ptiW1SnyG/AXu/vfyqLPxthB5S+zet2RKIuXVP5RAMLm/Wdzk7TZcw/HW7WvsE5wVTY5yNCeIh9yZFISUxS1huCXNGQCandOOSX6QInSRckZnTcUFnVpg0GBllz+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722849514; c=relaxed/simple;
	bh=eTuZ+aHAhbkq+3UlCiBExwS6jgikSXjl2/uk3rc3Ps0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PTUsfQAJgFZsFztNf4HKK4+O2sA3S1nNiiQ68/9tdbEm7gPj19uIgczzBnWu9uyZ8fx11cGMdQiy83nAvDrRlmvx6SMApMN/0msMaxUUZRD7VyNwyPc0Te6TFxdQ6mrc4l7kuWdIa/GM040drzxvg+0wwIGEYSZAmJuMJwG0HpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kI0cu6Re; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kI0cu6Re"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5d5de0e47b9so4283623eaf.0;
        Mon, 05 Aug 2024 02:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722849512; x=1723454312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmKZrnXukkShyh9UMVBbKCtUheE+m0Zm5Rm16FZ9/eQ=;
        b=kI0cu6Re6AG6f1FRjIMtIqsrxzR9/1r564myr4JjFStjkvKxAzDnGxdeE436jbTHhc
         zrsM77E8s+9o0Fn+rchd5q3mEXaH8Aga0/5awWhh59t2/SJK+x+ykJd4bCV3SYm15ZhW
         B5whEYi6+opiOZrl4mnlvI3WyiaYt8tos/2ta/yoa9xA5EFtIKeHx+dnHEjjj+INSmAR
         QlXS02bSDZFnSndx8fNwh3m8gmzG5qp2ZOGwae5DcDPNxj3NWQD6oPDvK0IuvNqY54yW
         DEa0Yg/6dGDRC8OAoKDVzlbwECG4iW01E0uzvkrgz8NAv/mC1lDpu+J8UNVxPI//unRS
         IGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722849512; x=1723454312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zmKZrnXukkShyh9UMVBbKCtUheE+m0Zm5Rm16FZ9/eQ=;
        b=KnYJljxHYAd0EL+4T5v0gKWDvIWC6Q6FXK80s/jHAJcUuCMmIHQ1Wykc+RqQOrWPIj
         BDmqlVbhTORK4WYjVojwVM3oqcJxMjiRK4o+pZBY4xoI/xKsETVxLvq2hfHGVDqyQio8
         U+a4j8KDC2WOSS24chKJuVIcJWggcPQdER9BjnRULLx+LCz88B8ucZUwNhWl1rktOi8q
         iJBIjoF7nuhiUtbPaqQhPY5GHirvowuqqJoVPFwTfuWQIN1ViBDOa2QMFFvMTB6hvulH
         b4jbXi+T9WTl6+oZxOTDVOKwBCBeUd/s9ImyCFMDQotMUqoxu0ThUEBUMuKDdJ8cGj8q
         4VwA==
X-Forwarded-Encrypted: i=1; AJvYcCX4Ffn7nOOm08wbm/enxhDb2N3nB+qS9VFhICm0xOSNAFT8GEKzrvkPag16L4hLuAOCZdMLcSi+oWFr+v4zfP3TfPSirmdRx3YG67A2UTth2hRsukE+S9IhBig6MP0rM6E8y04z/sHBvlJdK6ZryWr7SN6n8MMiS3kq8tVs7ghZ1/QGpA==
X-Gm-Message-State: AOJu0YzCgDKNCvTR3lwdCFAOQzU6ZtHpsDxbK576JvLSrMIuaeC+OKBU
	oXHrmAqL86C+DEZDjM7Jh73MxX68E6IlMF+s9vgiRdUT8M8gbYGB
X-Google-Smtp-Source: AGHT+IHt5AjerbbszibT04CTu+Jr9V86wxjhGeMFu/4kABcPnvtNQ1BSOPHfj2k8UNkcshgOsmiD1Q==
X-Received: by 2002:a05:6820:1504:b0:5d5:d5ad:35f8 with SMTP id 006d021491bc7-5d67155434dmr12279312eaf.8.1722849511973;
        Mon, 05 Aug 2024 02:18:31 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5d762052c46sm1902121eaf.27.2024.08.05.02.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 02:18:31 -0700 (PDT)
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
Subject: [PATCH v6 4/8] mmc: sdhci-of-dwcmshc: factor out code into dwcmshc_rk35xx_init
Date: Mon,  5 Aug 2024 17:18:19 +0800
Message-Id: <4f1f2fa403ce7f0b4d79afb7d7e8a1690cde5d6c.1722847198.git.unicorn_wang@outlook.com>
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

Continue factor out code fron probe into dwcmshc_rk35xx_init.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
Tested-by: Drew Fustini <drew@pdp7.com> # TH1520
Tested-by: Inochi Amaoto <inochiama@outlook.com> # Duo and Huashan Pi
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 34 ++++++++++++++---------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index b272ec2ab232..55fba5ef37ba 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -711,12 +711,22 @@ static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
 	sdhci_reset(host, mask);
 }
 
-static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
+static int dwcmshc_rk35xx_init(struct device *dev, struct sdhci_host *host,
+			       struct dwcmshc_priv *dwc_priv)
 {
 	static const char * const clk_ids[] = {"axi", "block", "timer"};
-	struct rk35xx_priv *priv = dwc_priv->priv;
+	struct rk35xx_priv *priv;
 	int err;
 
+	priv = devm_kzalloc(dev, sizeof(struct rk35xx_priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	if (of_device_is_compatible(dev->of_node, "rockchip,rk3588-dwcmshc"))
+		priv->devtype = DWCMSHC_RK3588;
+	else
+		priv->devtype = DWCMSHC_RK3568;
+
 	priv->reset = devm_reset_control_array_get_optional_exclusive(mmc_dev(host->mmc));
 	if (IS_ERR(priv->reset)) {
 		err = PTR_ERR(priv->reset);
@@ -739,6 +749,8 @@ static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc
 	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_TXCLK);
 	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_STRBIN);
 
+	dwc_priv->priv = priv;
+
 	return 0;
 }
 
@@ -1184,7 +1196,6 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_host *host;
 	struct dwcmshc_priv *priv;
-	struct rk35xx_priv *rk_priv = NULL;
 	const struct sdhci_pltfm_data *pltfm_data;
 	int err;
 	u32 extra, caps;
@@ -1241,20 +1252,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	host->mmc_host_ops.execute_tuning = dwcmshc_execute_tuning;
 
 	if (pltfm_data == &sdhci_dwcmshc_rk35xx_pdata) {
-		rk_priv = devm_kzalloc(&pdev->dev, sizeof(struct rk35xx_priv), GFP_KERNEL);
-		if (!rk_priv) {
-			err = -ENOMEM;
-			goto err_clk;
-		}
-
-		if (of_device_is_compatible(pdev->dev.of_node, "rockchip,rk3588-dwcmshc"))
-			rk_priv->devtype = DWCMSHC_RK3588;
-		else
-			rk_priv->devtype = DWCMSHC_RK3568;
-
-		priv->priv = rk_priv;
-
-		err = dwcmshc_rk35xx_init(host, priv);
+		err = dwcmshc_rk35xx_init(dev, host, priv);
 		if (err)
 			goto err_clk;
 	}
@@ -1290,7 +1288,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
 		dwcmshc_cqhci_init(host, pdev);
 	}
 
-	if (rk_priv)
+	if (pltfm_data == &sdhci_dwcmshc_rk35xx_pdata)
 		dwcmshc_rk35xx_postinit(host, priv);
 
 	err = __sdhci_add_host(host);
-- 
2.34.1

