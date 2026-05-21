Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4313812F0
	for <linux-mmc@vger.kernel.org>; Thu, 21 May 2026 08:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352540; cv=none; b=T/EUXPJ9vVRY/+gvcD32vpXQItkLk/mGnKGb5crKpejobPzwY8S72Q3mpIm2VA2GJqqf+9chfrwuh/Os0tUxJE26/2NhsX+9Sd55NrB6d3QMiqQZYzg0SIkAczMZRU9r6b4H3PsGSBaqt3BDCyB1zdvTyEDdPbEBThlff18QcOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352540; c=relaxed/simple;
	bh=ZIBqVu48Sz4Y6VXLaWmf1G3Q9+5Gz36/KsTgbXSfNNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kh6ROFhTCJJ58FKqa7mptMGkQYfMNv/r4AQzwrUm0yeIHQJ8j5vU99b8ERBO2gLWXWR+0A25iwuvwsbMRr+nGHW4SBI3lvrPwbW17LPA78FMZoRVCiuj2wI5bi68T0COd2Hjo7hPfmIZfwK2zQC7UrYx2U2D8TMez9LGiD34ml4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVGesbne; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVGesbne"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38e7b0903cdso47766281fa.3
        for <linux-mmc@vger.kernel.org>; Thu, 21 May 2026 01:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779352530; x=1779957330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDHRIt+Xzwup3rn7oBseYJ+pZthdkwsUcMhMoWoBRnE=;
        b=bVGesbneaOdkI+UVYx9Yv2xeftS6grryu9Mz0Tj8yiQFB3BbpJsxBS7irSZVxKdnM/
         FIVt4lMhns0yAVISleT2dpoLk94LSDvj7QY3pKFzbTo4VDsVWWI35VJbTDznh3sM41BX
         QNvA0L8mor51ZlDgcJkvo7C6F0lhyc3ltd/JT5ziMVAg9nkSsaBYncAWK7+GBABDGIh9
         GyQgANd3NDeoGpxiGcM6Im2l6tmZE4hmoeB7UyYy60xRP4hNFjbprQH9CWD7e+f52QNL
         A/7AGr0yqIyEIrAcJdudqO2KNTXFlfC8vuGluCdm+rVp0iuqWfKRf+8FWKwcldZfUQsz
         gbDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352530; x=1779957330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eDHRIt+Xzwup3rn7oBseYJ+pZthdkwsUcMhMoWoBRnE=;
        b=NGzMcCD3HbJiptxZYF+Z+qBDdidLEzXqvOneRlhPLF/Akki6Qyb73z5Kh3TRqhtAqH
         FFf9DGxhRg8SF77I4d2VCRWGetq5PGzWZGCFIhlUNsb3rfJAhkzdKNqkq75BzsJ4Kie6
         YifOqC3t/i33YtVZlrZd2yIFOdNTiLu7+2eyyYiLxkNacmfvBLF3uGo0BstA2y9ufDcX
         1zpq5OLxBHhwFz6qP2adQ1EkyCRR8UFmnoTnLJJfb8oGf/PoI/9SzrffNl6qWFNcONvs
         EiVcBCSGWxdHzd82yu/eR7sN8AQetOrNMkuV8SyssWn+y654iBFiTz9phPrKYVDBg8KH
         aH1w==
X-Forwarded-Encrypted: i=1; AFNElJ/iUZL/8HyWi/2YDtWhApmKmSAvbMfU/1Sx8M1N9wvNlEvKXTqBCU4EGwWn0s2Ra43VB+iuSPGBeaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGAaNyTprfX4w6rpYdas9jVsUlj6pFR2QNsyTfGyKDGNh188ui
	9KqhIfMNpn0WQvmztuOjMuoVUmPlnE7Qen46pfRKR1jRuHLcB9NI2ERv
X-Gm-Gg: Acq92OEFBPWTLq9D3yxE0zoMCld5A6GGK09MgnwPko2qd6BYoXvO7yqSCuQktIaEinV
	rggJ7ZuT/L/tld/16nYG/hxC1x5WbQtYCaIzGiO/tA/+zujp/0jgnsN5M1U+7UPdxiirb1pYlWp
	eyP78ZOZk3fx+inSgiN4F9RomqEtQz8ha9sjUNgKaHzzf/n7rNubOi5uE/yP7qWPEoTHeTLSi8M
	cLCnNpkICZFc9CBHlJq9K0lqrklGegVil+NKB7Lbdb/R/K5Bi2nGKczY8Ola5HD2XGxUpzyWmAO
	vvArmqmgke9fIWeonRsRkvQxm9JNTGgG/gli1OlsjCJiERgcNJSu+qDgZULZhej2qniurk6ygLp
	HJqEfazYVU4x39WNhlqnf1fiK3e4ljUUwDBq2nATguFKv/qaTKr21MnMd3XrHNskooc3lHhnBpK
	2S1Zp/qntXBPjf73wH1ImdlsMIx3DkqfmcOX+dqkrl3ptqjHkRfPQ=
X-Received: by 2002:a05:651c:98b:b0:393:6480:8924 with SMTP id 38308e7fff4ca-395ca4ee2edmr7756061fa.1.1779352529733;
        Thu, 21 May 2026 01:35:29 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([91.132.132.206])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395d0b68afcsm917611fa.32.2026.05.21.01.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:35:28 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: andriy.shevchenko@intel.com,
	adrian.hunter@intel.com,
	ulfh@kernel.org,
	p.zabel@pengutronix.de
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] mmc: sdhci-of-dwcmshc: use dev_err_probe() to simplify error paths
Date: Thu, 21 May 2026 11:35:04 +0300
Message-ID: <20260521083506.356422-4-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260521083506.356422-1-a.shimko.dev@gmail.com>
References: <20260521083506.356422-1-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace common pattern of dev_err() + return with dev_err_probe() in
probe functions and their callees. This macro provides standardized
error message format with symbolic error names and adds deferred probe
debugging information.

The conversion makes the code more compact and ensures consistent error
logging across all initialization paths.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 30 +++++++++++------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 925fff1c0f3a..b16027f5dd8c 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -917,11 +917,9 @@ static int dwcmshc_rk35xx_init(struct device *dev, struct sdhci_host *host,
 		return -ENOMEM;
 
 	priv->reset = devm_reset_control_array_get_optional_exclusive(mmc_dev(host->mmc));
-	if (IS_ERR(priv->reset)) {
-		err = PTR_ERR(priv->reset);
-		dev_err(mmc_dev(host->mmc), "failed to get reset control %d\n", err);
-		return err;
-	}
+	if (IS_ERR(priv->reset))
+		return dev_err_probe(mmc_dev(host->mmc), PTR_ERR(priv->reset),
+				     "failed to get reset control\n");
 
 	err = dwcmshc_get_enable_other_clks(mmc_dev(host->mmc), dwc_priv,
 					    ARRAY_SIZE(clk_ids), clk_ids);
@@ -1781,10 +1779,8 @@ static int eic7700_init(struct device *dev, struct sdhci_host *host, struct dwcm
 	dwc_priv->priv = priv;
 
 	ret = sdhci_eic7700_reset_init(dev, dwc_priv->priv);
-	if (ret) {
-		dev_err(dev, "failed to reset\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to reset\n");
 
 	ret = dwcmshc_get_enable_other_clks(mmc_dev(host->mmc), dwc_priv,
 					    ARRAY_SIZE(clk_ids), clk_ids);
@@ -1792,16 +1788,14 @@ static int eic7700_init(struct device *dev, struct sdhci_host *host, struct dwcm
 		return ret;
 
 	ret = of_parse_phandle_with_fixed_args(dev->of_node, "eswin,hsp-sp-csr", 2, 0, &args);
-	if (ret) {
-		dev_err(dev, "Fail to parse 'eswin,hsp-sp-csr' phandle (%d)\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Fail to parse 'eswin,hsp-sp-csr' phandle\n");
 
 	hsp_regmap = syscon_node_to_regmap(args.np);
 	if (IS_ERR(hsp_regmap)) {
-		dev_err(dev, "Failed to get regmap for 'eswin,hsp-sp-csr'\n");
 		of_node_put(args.np);
-		return PTR_ERR(hsp_regmap);
+		return dev_err_probe(dev, PTR_ERR(hsp_regmap),
+				     "Failed to get regmap for 'eswin,hsp-sp-csr'\n");
 	}
 	hsp_int_status = args.args[0];
 	hsp_pwr_ctrl = args.args[1];
@@ -2408,10 +2402,8 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	u32 extra, caps;
 
 	pltfm_data = device_get_match_data(&pdev->dev);
-	if (!pltfm_data) {
-		dev_err(&pdev->dev, "Error: No device match data found\n");
-		return -ENODEV;
-	}
+	if (!pltfm_data)
+		return dev_err_probe(&pdev->dev, -ENODEV, "No device match data found\n");
 
 	host = sdhci_pltfm_init(pdev, &pltfm_data->pdata,
 				sizeof(struct dwcmshc_priv));
-- 
2.43.0

