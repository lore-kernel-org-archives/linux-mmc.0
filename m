Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DA23ECBD1
	for <linux-mmc@vger.kernel.org>; Mon, 18 May 2026 11:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779102054; cv=none; b=YAUriHRqDBYYsx6WdnTwtG+jfIoGnrHXJbZ4Q3c+lorcnIXUpH0GjBfZf7LMKo5q/BEoZrHv6eVaIVPVc5GJoZBApbPNq2W5X/9otH1WQX23glAtlWVBO7GuQi2DZ3bhVx2wDWQ7mzj2U48MCigQNGQ72B8U7/DQt1bPkpuuztY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779102054; c=relaxed/simple;
	bh=vjcxSjLNhxaVag18gaVizf2BPlU5CIRtAWRHBJWIrkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bXUuVO6/O51amFhIBsGoRdcZmdHB5+PDcCPaUUudHnUIs2gL2vxVtRBc5ZnOjSH5N1bcgKu6p+GYqOSDtsRdVabkm1GPDRFxniz/BNhCLoZi86BQtmVBekYxra26jUCmA4HgM86NuTeztGS8FHFe/i78SRa7boCfl54Z7JEdDps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kzd7BFic; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kzd7BFic"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aa1b2327c8so1931872e87.0
        for <linux-mmc@vger.kernel.org>; Mon, 18 May 2026 04:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779102046; x=1779706846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnmrA8CV6GUqaooh5wLr8Nhglv5SXozFN3O1CcZvuCU=;
        b=Kzd7BFiccAIr5ZJJX9Se3KCsTDW0+uWvt4LKRvDShDdezra7F8ZzHZ8I5LLh8ufGcM
         53+f/8epQPzISBPnuIjL80DgUVvPJJnGFCfkFvlvIXIwVOLtgZn7Jt0auuJhU8PxKpGI
         vC8sst/J2BGu7/bRoHwWR7AXYrr4ta4TOgRXdPPygRzRnZtq+7QxSRjnVgNs3dqoLihE
         4G2K3Ki2P0TPMZf1iv6N6JcpQR2JaWyEz3vC790S87mbxcKWw+0anVzDSp8e/fqjyqaj
         +TmAtDnQ/YvDWM7YN0J9v/1kD+p4io9n2YHRLeF+xjW4LPClxngXdTD9I+CuSfcRZWFI
         DXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779102046; x=1779706846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vnmrA8CV6GUqaooh5wLr8Nhglv5SXozFN3O1CcZvuCU=;
        b=iFDPR/wmfBbyUgV8/qm1Eui/pAs7nf99stw5Mr+VEu1kvS44376TrnGHjY+LfoVU5E
         pq47/NdrpxWL/WLZEk/RBzbn/3llpXeNX2C3QzoEFzOuitqONUyy0l01mPEDlyuoIGP/
         UpBjiT2AypEVi94gYXdAeW9HWwBjZ9rw50+ylsgviUalSmHbhBcdYGhyH+IPhTE8RPOW
         UVNuDC4JO4j5R9PUuWD5B3mrH2SPnCLXs6eqKkWo2jg6EsMOcZot9dHdW1J/coWT6Fw8
         WZxTMwceCmm7bLbBXAf5gvMqqnKZXQfFlIT1FXKSf+Gi1ii2aVCOkC0sEY3bGnmdSE7w
         QgxA==
X-Forwarded-Encrypted: i=1; AFNElJ9JrjCBuQgQeopDzARlvharffk259Ygv8BfRfIJkieANR4XAnL+/p3Bk3o/2g/GkQkQ3/NMRj2qWqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnTA0zkEuoF5xowJkohyzZ2hwAi2yXm6mVoqsLH2k+UvQy61/H
	jiaSUsdSvIJ+dnzEwU6V8PoyNbyGoC4jFJO3nij+CShQFfu9IXKJAqYJ
X-Gm-Gg: Acq92OFrLbU0GhpnCtiJbgjr6yNqlXO6YeJBoxdr50ACPCegjFnKmyMaXTzc5uUENze
	QVR95n6a1GB99CxdWMlqHToDGjIvc5fBPrQnIqM37G+5cR2cxb1pycAllhi8RPG9cHMYDZwYUSC
	bQjUTjuHDsjR3dHvRJW0v2MLBgok+6FmDpZ/HO6DrfuMrmZH1XemWkxHmSX01PWzJ76CfFUn8+z
	NTuDsfu5bU4EEpRqAd0wlGhkGshrsCfwyx+h+S2H/omSGODmt6eF6xSqLhldSgsMbvT7EBSROoF
	/1a4SRRxLjEfZlYLKEDsoooEIZxChgITaOQUvKQx9kTJIb6pyNQnmeW4tBxqiGw1E1G82g+Si4C
	zNxGAQZu9cDLSnzdY8+h32ZbZtrXah+m1zQHmVYv2qwbfcFTxVhsGnXto8p9B5BEswdv6Wjcxg+
	uXMR1m+2Vkbde8OAHbWDqJ+Tar
X-Received: by 2002:a05:6512:3b9b:b0:5a8:950f:e92e with SMTP id 2adb3069b0e04-5aa0e73059dmr6146690e87.23.1779102045422;
        Mon, 18 May 2026 04:00:45 -0700 (PDT)
Received: from NB-6746.. ([188.243.183.222])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a9164bc462sm3239263e87.45.2026.05.18.04.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 04:00:44 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: andriy.shevchenko@intel.com,
	adrian.hunter@intel.com,
	ulfh@kernel.org,
	p.zabel@pengutronix.de
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mmc: sdhci-of-dwcmshc: use dev_err_probe() to simplify error paths
Date: Mon, 18 May 2026 14:00:33 +0300
Message-ID: <20260518110034.142587-4-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518110034.142587-1-a.shimko.dev@gmail.com>
References: <20260518110034.142587-1-a.shimko.dev@gmail.com>
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
 drivers/mmc/host/sdhci-of-dwcmshc.c | 31 +++++++++++------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 29bb46783ee5..ccd5f4d6fec0 100644
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
@@ -2408,10 +2402,9 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	u32 extra, caps;
 
 	pltfm_data = device_get_match_data(&pdev->dev);
-	if (!pltfm_data) {
-		dev_err(&pdev->dev, "Error: No device match data found\n");
-		return -ENODEV;
-	}
+	if (!pltfm_data)
+		return dev_err_probe(&pdev->dev, -ENODEV,
+				     "Error: No device match data found\n");
 
 	host = sdhci_pltfm_init(pdev, &pltfm_data->pdata,
 				sizeof(struct dwcmshc_priv));
-- 
2.43.0

