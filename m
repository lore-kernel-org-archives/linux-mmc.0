Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4663D47C8
	for <linux-mmc@vger.kernel.org>; Sun, 18 Oct 2026 22:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792364152; cv=none; b=jYm8xDawbef2L1xyT9IvThHPDXlAWmRU43aDlylipNri1izVzyjweP4zrpnc6Ab3u6NcC4uWeH5G/86En37v/VDJFQxjOxInXjQFOdAllOqQ2QmbbzR65+VE1dQL7ZaZRfQgIk/NoPHphmmmrzg3alUwWgYTQza/U1xfNitL6Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792364152; c=relaxed/simple;
	bh=TKaLy7aolfOZc9na3Quuyn+sOLPx1YselcEhYe18e5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RSQ+PA/ZdWHBamI56Cqy+XyjPtAL1Wg4u+AA8yVUTKl+4UfK7I8vhS7SOy2ewJPFBkC5LI/45oeQmtABc9aV91qIcek7vpzH8YeFZ9ROZCTeuHkfpwykk7G9oa0j3F1hOOJnv2JQzhu4J9nE1ijDa3i5pD+wKe7NIvinci7tSiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjfmQUSA; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjfmQUSA"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e9ae391a05so8033765ad.1
        for <linux-mmc@vger.kernel.org>; Sun, 18 Oct 2026 15:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792364151; x=1792968951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DzYy7klBTOYzRHWT1wHpZj560FtZe1bJfKhgHl5yTyY=;
        b=NjfmQUSA2w02QF8nh4itjRNNWfDuPig9Vh6h+gf9FBh2Iu76+s8D+77DM3404Wxvhw
         I76UGDNcndH7QCq7c62WGO0U1Nk6vT1sp5/lHVn+X3top01f+COYvUFnSlt2XcsaWg8k
         jL0ugVunG8hT/0rJr8YhCW00j47S+8QDZGV2iuaGGDP06KPBNEE2YcnHHSDHlOgHD2Nc
         3lMSlUOPTZgIQMTX4Fd45hej4Ejaq4IbfzOu0Gb01EKdybQtKvebeJ+gGKXj/qqRrKev
         JWb8XzxgoDk1RnqzIn5ats6/TmherJypOWOliMunbOOdWZvwwMPmi2qyi1BthMaeEUF4
         ygzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792364151; x=1792968951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DzYy7klBTOYzRHWT1wHpZj560FtZe1bJfKhgHl5yTyY=;
        b=LJTFgsAQXgk9rnLjWcMS/0QpfCES6HxixMqZiu3DiUyJUfl5JwiCkkRxwQU2J4mJay
         l/odkfQr3BdsG4SeFQjkA3xP0FuYEsDIHt+0oghOWLsyfVboZ2fY6yXEH4E40xdLUyOJ
         Me9YexhIZoGHK2fYspMTgK2pb1UnFK3YmBwK+XEXWEEaMOKecB1tAHhlD3YxFXDHKcPd
         7iJXR6IcXnhjok6qlMj3csYR2HALv9PBhM/50ZS2FcxR0jLOam5VMi34iCRXKK8fmZHQ
         AmYZwAqRmZpGmuJU0KSYV6dMg6Nl/ej64OCFpmKxvJhRn/UqQSAHIJOzNDinj29BqHpr
         tJRA==
X-Gm-Message-State: AFq9FYIZUljRRouxlVw9zsZPUHiDmlDtmHt54tl9W95qiiGVTSWqDnQa
	gEBzSfqogeaUp/zyW9urQUWewmp7WRwiIPSfbajk6YR2IAhAEJKz6+PkDErt4I9N
X-Gm-Gg: AYBFou212ukJeRZwL58mYH5mx2gQz1w3w2dZhP6/OwGIs7kbXQ2+uYILIsaLoculasp
	q6BkWqdIFW6qLFwamNLjHgBLJXMAjHeoSqJfHG47IYzrjUOx7O4fU+6H4+nKJ8/LPYSjPuxUl+f
	jl3+fIeQYbwG7RlQJNwtioLsQl4HngdEs7E+edtLGpew/M2GRSSs8WG98dtmoFDJPcBFjzPffT3
	Z/ZG4Er063fWVglenyNx251q5QJ8DsQ7gcVbGe94CBGtnv1312ACvaIxuJB3U4jIpLpbYMB/e14
	i4Wh1/8RzdNPSzQ0RJ+OpkXuN9XIcZKPeorFVsemNmYyIDHIYSVN4JiQRKzCKqnN4ogqSya+vA/
	RHl5cWXvshipezqvdOsfhCqm6v70TOr+1ok9K7YOG7YUK4sYR2PRdrMmZHV8MVBLXfAET9Kgs7U
	cGWUVBGBs0j0jbMumdOFtdr68FluecjdPAnhJ8pK9wYKif0F+7mjfMWsO4ccj6hi7ZaSHcYy66b
	+praUoR/fUN8afrSkvRNoP9LnYBVlLjKIBNowi+7KHg6GyNc6XjqSM/0mKDUMMSrUyPtOxvgmrb
	OI0EFa09dKY+T3ieDAGl5oZcSmUZ27p/EjJWa4SLLg9XZ/Q9
X-Received: by 2002:a17:90b:560d:b0:3a0:bf71:eccf with SMTP id 98e67ed59e1d1-3aceefbde01mr3408912a91.14.1792364150929;
        Sun, 18 Oct 2026 15:55:50 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac9461d71esm18270624a91.7.2026.10.18.15.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 15:55:49 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4] mmc: sdhci-pxav3: use managed clock enablement
Date: Sun, 18 Oct 2026 15:55:48 -0700
Message-ID: <20261018225548.18373-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace devm_clk_get() plus clk_prepare_enable() with the managed
variants devm_clk_get_enabled() and devm_clk_get_optional_enabled(),
using the same io clock lookup as sdhci-pxav2: the "io" clock if
present, otherwise the unnamed clock. Clock lookup errors, including
-EPROBE_DEFER, are now propagated instead of being ignored.

The core clock becomes optional, which removes the IS_ERR() guards in
runtime suspend/resume, as clk_prepare_enable() and friends are NULL
safe. devm now unwinds the clocks, so the manual clk_disable_unprepare()
calls in the probe error paths and remove() are dropped.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v4: v1 + sdhci-pxav2-style io clock lookup
 v3: fix sashiko errors.
 v2: fix resume paths.
 drivers/mmc/host/sdhci-pxav3.c | 38 +++++++++++-----------------------
 1 file changed, 12 insertions(+), 26 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index f39764ffd4a0..0bbf782fc235 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -413,19 +413,16 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 	pltfm_host = sdhci_priv(host);
 	pxa = sdhci_pltfm_priv(pltfm_host);
 
-	pxa->clk_io = devm_clk_get(dev, "io");
+	pxa->clk_io = devm_clk_get_optional_enabled(dev, "io");
+	if (!pxa->clk_io)
+		pxa->clk_io = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(pxa->clk_io))
-		pxa->clk_io = devm_clk_get(dev, NULL);
-	if (IS_ERR(pxa->clk_io)) {
-		dev_err(dev, "failed to get io clock\n");
-		return PTR_ERR(pxa->clk_io);
-	}
+		return dev_err_probe(dev, PTR_ERR(pxa->clk_io), "failed to get io clock\n");
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
@@ -434,17 +431,17 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 	if (device_is_compatible(dev, "marvell,armada-380-sdhci")) {
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
@@ -499,27 +496,18 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
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
@@ -560,8 +548,7 @@ static int sdhci_pxav3_runtime_suspend(struct device *dev)
 		mmc_retune_needed(host->mmc);
 
 	clk_disable_unprepare(pxa->clk_io);
-	if (!IS_ERR(pxa->clk_core))
-		clk_disable_unprepare(pxa->clk_core);
+	clk_disable_unprepare(pxa->clk_core);
 
 	return 0;
 }
@@ -573,8 +560,7 @@ static int sdhci_pxav3_runtime_resume(struct device *dev)
 	struct sdhci_pxa *pxa = sdhci_pltfm_priv(pltfm_host);
 
 	clk_prepare_enable(pxa->clk_io);
-	if (!IS_ERR(pxa->clk_core))
-		clk_prepare_enable(pxa->clk_core);
+	clk_prepare_enable(pxa->clk_core);
 
 	sdhci_runtime_resume_host(host, 0);
 	return 0;
-- 
2.56.0

