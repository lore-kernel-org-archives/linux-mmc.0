Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E5B314B73
	for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 07:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779435129; cv=none; b=TvNeOctyVrclCGYeuqXAPZwuSpA3cG3w/0Z+ke0BUWciYNyP7U5LaBeBv1fizPawHiomlPZzLVU5PbKRYX229TP1uNe3yb+3/QH8Lx86Y+jWvrAEYEHxjU+osL89Qq3van7hv2xzZM/mhHeyxrQMKtrM5wg0CaF9o7wMaHTO2yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779435129; c=relaxed/simple;
	bh=OV3FSPuX5tKaoq2qrJVNtQ+IVuAXWfO/iPawTJkYaZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XurGDdTXXD0Zd9A7UhSgHfiYHSvjesC9o+8XJ7h0MwA5E4+SSbpVHe84SG2tOEjODL9X8ZZVjKciiu9/KY2qTWGf4Wf0L7vhGV+ECSueJ5AqvL3nol9opLxiS6p0iGe5JbN2AafTqLGfBuB9wRZagg60RTDQDKse9k17vSPdNEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbDqPuXm; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbDqPuXm"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39393c1b5aaso14649111fa.3
        for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 00:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779435127; x=1780039927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zV/xYY/R3r3zJuAs6jjVdbRqPC9QZozg8Q0lLxCFZbM=;
        b=DbDqPuXmGUqXODAMmyAUOLYkXDsWGnhNap/KOi816/nASkkSwz+XW5xYgW3mY79PMu
         pG+cPyv+v+xgDYkvs5BHaWT2Vm91UtcAUqBhRC31ghT/V23nffCpLd4MpgdemUwUHwQK
         UtfJk18zaonWmAcTitWXXFllYHw0OG3CqKE10nzx407X0IPt/9XgtLQTJfe0IDpqtfgi
         /RVEkDN2eIQ8E0VgnO8Qs4ecotSoQIsElEvUI1jJrJyVhayIPHEK6gazS6IUW64h4DSd
         fPi2/IZB2zLEKkjDfn9wLL1Qt53sONwltAuTHXfSjRj3Q8j38+Ett4ESPs+rOewrSSEn
         ztQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779435127; x=1780039927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zV/xYY/R3r3zJuAs6jjVdbRqPC9QZozg8Q0lLxCFZbM=;
        b=blKdmvG6TIdY6uYRTv+qcqVZz7c6i6nEK9oP7zpHcuRx01b2Kg48cnk9vS+j6cAd5w
         mpBCARr5+Hjtt3wsTlBoJxh7po5x38xObUQWiDuSFh6re5Hp1I2VbNazKDcgxDBJo/we
         MrCe/vQHHdAk0yT+JD2FKGDCN5SUumOOJsUXjteZPUOyjhAAb21CUIqHSeYXOfKtwAEi
         GJEXAGFo6HWA88eEXF16gd38N8aCtzOfChQ1KGSJGjgbIMF+CcwQnqz0fXJVjYLnBPcs
         mtPwVDSRrI/z6Bn9zBMUvCUo2ooSltuNIisJRscMSQuV/T9ShKIBthAypivzYDl7EwAe
         Svow==
X-Forwarded-Encrypted: i=1; AFNElJ+7nEeoDsYWdD1bRlKUDu3qNJvaRs3wu4+PaCZHWoZKwi9/SvQphetxSbysz6EsAAnyJCmic/+BRCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwINRxm3TVfCr5h99WPUjuj+tX+cYO2QWa49QrxboAe1yJel5ql
	I7ddD64ybH9R2TGahMr4kPXjp6u3STKaq1pj95r8CWaYY7i3GwGq9PgM
X-Gm-Gg: Acq92OEFkFnrusTSm5cgMVLh6f9TbZmRRxeiuwZimF3uwMWuE1AMriXrj6bZOZiA0ac
	9dzFBJNChYND1qGHnNnqbmg9mkisJUvLBkgRuDaDYBeIIpIdYGXd0DfZB6eOs32tZYNKca13vgn
	yGyIDl4BZp7m0lYouqh3oTjKzximKulH9iDQZx9hcIb7Ph7+cNvnfzXUGAvqoWzapKO07+aSQ8T
	DjPah2IRWnxbguwp0VlTH9sHR7zquPnikUnRckz3kCeDVybnogEtdjnrLmf/7MGuMPtHx7UUHOc
	6Gr/TRR9hMKzi3mbjSp0J7MlFxtkxslmdRizdrAhoM2Wu7VDIMQJ8fVyrs1m9RPEf9MEMWOOuYy
	IoMBx/mQVxQiLBizOu4Vr6Ox1evs5TPc6AWpZaIG4vwWmUCEUMhFgsj5eE0acJKs0zzmnr+YF9h
	JdOgMlI+UvU3+mwF3a27fvyqKd1QBx0Dd08SwsdH/T
X-Received: by 2002:a2e:959a:0:b0:38e:9667:f21a with SMTP id 38308e7fff4ca-395d8d1d1f1mr4691941fa.20.1779435126479;
        Fri, 22 May 2026 00:32:06 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([91.132.132.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395dcc0a4e3sm1818751fa.22.2026.05.22.00.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 00:32:06 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: andriy.shevchenko@intel.com,
	adrian.hunter@intel.com,
	ulfh@kernel.org,
	p.zabel@pengutronix.de
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] mmc: sdhci-of-dwcmshc: use dev_err_probe() to simplify error paths
Date: Fri, 22 May 2026 10:31:32 +0300
Message-ID: <20260522073133.409844-3-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522073133.409844-1-a.shimko.dev@gmail.com>
References: <20260522073133.409844-1-a.shimko.dev@gmail.com>
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

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 30 +++++++++++------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index c1ed7f28d75b..c758e904f5c8 100644
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

