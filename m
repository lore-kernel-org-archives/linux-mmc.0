Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A66F320A34
	for <linux-mmc@vger.kernel.org>; Tue,  1 Sep 2026 00:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788223368; cv=none; b=pZluUF33s7MUrrCd8x3D33vsjuXv5vtR188y7bdk1qDGfQHbMgC8x5W7yT4cif6Ukv2w4vG8Pl+/rflXu7SWjl275OXTExZn7U0wZWPM442rUngXf7HaJZnETstTObN4YEh+rmW8MDMngsSJFaM7raJor766n4N++VOP38GSshk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788223368; c=relaxed/simple;
	bh=KdMNDBqZqxmcpTa/hgYEqTjCMbfkO3FX5YQNlA4Ocdg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VBVIaFXXkjZtmLYfb9+r8U01MybyfLJGNOKKbeuXLDrQ9SQKtbsQs9uo6SbQKeaacSvtzEq9en7CcaKbT9DfFY01zGu3Lio0oLG1QoFREFMnWZ0+fIPGXGBk5YeAKdz3iXVLJxlR9RXxADNv20Az5cVKsw4aoi7FGkNIiMhiZO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVWYl8xX; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVWYl8xX"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d72ae08fa1so34896695ad.2
        for <linux-mmc@vger.kernel.org>; Mon, 31 Aug 2026 17:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788223365; x=1788828165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Drs41gfRbkz9E/g2UXqU53W+EdIQvwTjq1Q9bophnJo=;
        b=TVWYl8xXhG+rb+mpzEcHhBC+I7NU8qfwANjeOaqMO5FKBuSSKDKkmzurQKzCWsmmxv
         j2OyNbU2PFQRxOOfht8l98YSPf7IAvUBYNBEoXAtonHHogxW67py6yIE7v9oTK6jRbD7
         Of7TB6OxQL9fi8OTt9cTkEBN97arJVOJe6f64Zc1v/B1t3AAafQmNKdm4HwqbDi3o1MA
         4EYU2Pi1lGO2i1VD2DsVwiOoMItrjIZij2U9ADYUBOXQzjowb7kSHprsL6fSzzCQd860
         uogH5KPhBaPbA76Iei/cjiG30d1yL/8uRyWwuylOr0CDzh4kxE2aWneTvt+OCmV2xiQC
         JP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788223365; x=1788828165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Drs41gfRbkz9E/g2UXqU53W+EdIQvwTjq1Q9bophnJo=;
        b=TKQL0L+l3jefP7HsBDe9Z3Zlpx9Xta+fSEWCBhEIulDfSIVu6malkLUJaFBCVFjIEz
         UjsHQVw+B7bBHe+gbNVQJEAaogNPtVSA6akJTeQJw6yYRAzHjlyOkB54N13BoQHcbNFx
         s4Z0wN+khb5wJBpULakzX52FX1QaNookWS1E6gzx5teNTHK6W+N83D3dDNT42tNjQ19X
         k97MDi+g7YtPs2iGKoshX1O2dTuGgv23pPo9ss2ktsRauvfaXKG7OBo4pgCKRM/V9Eg0
         SyXHwqn49Byz4ypo+LONWFoURMPRbq4EpfQUWPe5SZTKmBcLZezYgCoYqljKjDDZ8+RY
         JOUw==
X-Gm-Message-State: AFuF++mlxhIVCIyNbP5vHWkozF7zNqgF0ELb8pC4JaWAZXzeN8OCbUcc
	zYWU+GKGhwDIw71m/EY4jMtnTQGe8qdPpNnuNbjSeV4zOfWKz+Q8Bymt4Ix9uA==
X-Gm-Gg: AYBFou2EFiKdMWzwWfERnPpddkjqgTTS9XBirEy9zLqtZeNQcjBQPRxQ4cRSrNyIyCj
	hfQqVU5wv3e1tELO2FaD0sHOd0z0myOeyHsbpFDu59i6RuwgD4lB8NWa+C+lYU4il2HcbHUZABh
	pJmwXi0bApML7YqlLrN+jwFDXudHiwNO+VTJZUMb4+8aZ3cRRmgmkRgICNtLujN5qOUepu89TNp
	s/l4g9plWsn+0MlSIw7TqOQp93bIE0075Mdz0lzd0LKaJTg7Fb8T9MFne85Ea4PUNHP9FWVvUOR
	K/YsnCwt6GZ81hLilaBhjHJhwKgAB1D9p+UGq0JbHEMsWN9xVHsEeSpW2jutH+7n+yGqvazUO+7
	vXs07+oII8/9wVAFQAVs/b5BkZUDVhVjImHcfmMUghyYh3uxHl4Sg6kgHYqNRg/cOvjxmf5ZDYb
	jLD2QNbB11xIffX6HzOyAsGp0Mx/nEtKzPdWrhdnupna/sXAFOB5VRSUTAzVlBudu47oGiDHI7s
	RzstVpao3WD86bY/ozaJSq8vrEqTYrNGS2o8TTg/yoDIVIl6lI4HlDAkXdYUWAc/i3hpGi9Zt3j
	39Y595ovaDNRMuGALDp7iqU9bDZcmFLbGq2P/0r/glY2Hwkv
X-Received: by 2002:a17:903:1b47:b0:2ca:1479:d9dc with SMTP id d9443c01a7336-2d94a8e0e7dmr64909435ad.12.1788223365199;
        Mon, 31 Aug 2026 17:42:45 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d9055ddfdcsm27702395ad.18.2026.08.31.17.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 17:42:44 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mmc: sdhci-pxav3: use managed clock enablement
Date: Mon, 31 Aug 2026 17:42:43 -0700
Message-ID: <20260901004243.50052-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace devm_clk_get() plus clk_prepare_enable() with the managed
variants devm_clk_get_enabled() and devm_clk_get_optional_enabled().
The core clock becomes optional, which removes the IS_ERR() guards
in runtime suspend/resume and lets devms unwind the clocks, so the
manual clk_disable_unprepare() calls in the probe error paths and
remove are dropped.

clk_prepare_enable() and friends are NULL safe, so no need to check if
the optional clock is present.

Also handle failures of clk_prepare_enable() in runtime resume instead
of ignoring them: a failed enable would leave controller register
accesses hitting unclocked hardware. Bail out before resuming the host
and unwind clk_io when enabling clk_core fails. This also drops the
now unused pltfm_host variable from remove().

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/mmc/host/sdhci-pxav3.c | 42 +++++++++++++++-------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index d082c4e21aa9..db9dfa92cb57 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -414,19 +414,18 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 	pltfm_host = sdhci_priv(host);
 	pxa = sdhci_pltfm_priv(pltfm_host);
 
-	pxa->clk_io = devm_clk_get(dev, "io");
+	pxa->clk_io = devm_clk_get_enabled(dev, "io");
 	if (IS_ERR(pxa->clk_io))
-		pxa->clk_io = devm_clk_get(dev, NULL);
+		pxa->clk_io = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(pxa->clk_io)) {
 		dev_err(dev, "failed to get io clock\n");
 		return PTR_ERR(pxa->clk_io);
 	}
 	pltfm_host->clk = pxa->clk_io;
-	clk_prepare_enable(pxa->clk_io);
 
-	pxa->clk_core = devm_clk_get(dev, "core");
-	if (!IS_ERR(pxa->clk_core))
-		clk_prepare_enable(pxa->clk_core);
+	pxa->clk_core = devm_clk_get_optional_enabled(dev, "core");
+	if (IS_ERR(pxa->clk_core))
+		return PTR_ERR(pxa->clk_core);
 
 	host->mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
 	/* enable 1/8V DDR capable */
@@ -435,17 +434,17 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 	if (of_device_is_compatible(np, "marvell,armada-380-sdhci")) {
 		ret = armada_38x_quirks(pdev, host);
 		if (ret < 0)
-			goto err_mbus_win;
+			return ret;
 		ret = mv_conf_mbus_windows(pdev, mv_mbus_dram_info());
 		if (ret < 0)
-			goto err_mbus_win;
+			return ret;
 	}
 
 	match = of_match_device(of_match_ptr(sdhci_pxav3_of_match), &pdev->dev);
 	if (match) {
 		ret = mmc_of_parse(host->mmc);
 		if (ret)
-			goto err_of_parse;
+			return ret;
 		sdhci_get_of_property(pdev);
 		pdata = pxav3_get_mmc_pdata(dev);
 		pdev->dev.platform_data = pdata;
@@ -500,27 +499,18 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 err_add_host:
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
-err_of_parse:
-err_mbus_win:
-	clk_disable_unprepare(pxa->clk_io);
-	clk_disable_unprepare(pxa->clk_core);
 	return ret;
 }
 
 static void sdhci_pxav3_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_pxa *pxa = sdhci_pltfm_priv(pltfm_host);
 
 	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 
 	sdhci_remove_host(host, 1);
-
-	clk_disable_unprepare(pxa->clk_io);
-	clk_disable_unprepare(pxa->clk_core);
 }
 
 static int sdhci_pxav3_suspend(struct device *dev)
@@ -561,8 +551,7 @@ static int sdhci_pxav3_runtime_suspend(struct device *dev)
 		mmc_retune_needed(host->mmc);
 
 	clk_disable_unprepare(pxa->clk_io);
-	if (!IS_ERR(pxa->clk_core))
-		clk_disable_unprepare(pxa->clk_core);
+	clk_disable_unprepare(pxa->clk_core);
 
 	return 0;
 }
@@ -572,10 +561,17 @@ static int sdhci_pxav3_runtime_resume(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_pxa *pxa = sdhci_pltfm_priv(pltfm_host);
+	int ret;
 
-	clk_prepare_enable(pxa->clk_io);
-	if (!IS_ERR(pxa->clk_core))
-		clk_prepare_enable(pxa->clk_core);
+	ret = clk_prepare_enable(pxa->clk_io);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(pxa->clk_core);
+	if (ret) {
+		clk_disable_unprepare(pxa->clk_io);
+		return ret;
+	}
 
 	sdhci_runtime_resume_host(host, 0);
 	return 0;
-- 
2.55.0

