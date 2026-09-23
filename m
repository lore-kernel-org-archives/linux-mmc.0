Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FF242464B
	for <linux-mmc@vger.kernel.org>; Wed, 23 Sep 2026 18:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188037; cv=none; b=pZYaGcZfdlZlaw6WMkYlQetlyKKoJCO/IbNVMO2/a8FPaQ2CZlRlvQxgftsaFGb4JUdTbxm4YJFjOdI1rwZH/pEorGKOMQcQiCf0q61iFvtDur3jBwu+hhl/PdACuIPqoIk03YYL2GsbP3ibhlb1BXgdkfcNQ1oY1wwOaxXEJbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188037; c=relaxed/simple;
	bh=kMsADWclO35EPB90d1sPTn3rvaV1vsaZa6HnTlSBI0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WF1P3gRK9QivSitakWKwO7BW2PlW9wG5OKVeR6h2t5+rXezBnKp7/HeF4TmR1MZjz1fPJ+EeoF8rW+hosdUGgds978/7Rg+2I34raBOHfBIbOBameoY7RyoUBl3z+b7JRWIMz5UqGLV1qwer97ws3xu05ljp2dhEs4AnAxryabY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rWBbtK2S; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWBbtK2S"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910ad2273so137566385a.0
        for <linux-mmc@vger.kernel.org>; Wed, 23 Sep 2026 11:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790188034; x=1790792834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1fGR8UzTdFSd/DkqLSEBQCibxjhyjIqBXG52eLVjeL8=;
        b=rWBbtK2SUc7Nq0dIv45GvDUGkyHakIRN1C4TA9HXfoXFXtesKhBUmfCj/5WWl9Z9qS
         ZtCk0RaxVAwQG0nHdpggFxNypd31huIaI7KAqD6YuD1u+BpJNqJt4+kkRx9vXSANYe+m
         4V6P3GAMY39Y9+9dmHxScZsf8E1JFRTrqigo+UXcqeHgWo63mcFhfEK86VCmcI3ppR+u
         R3vQUNitwf2ihXA4TvglNhtYvJBeTp+IKAy4/o/bNvJgn2hj+kivVx8z3XbQPAXXhex7
         dnxgFl2cAc4Jn5qmZJSurCQECHsIO65Z7HaoJ983LEVmaGR5sehFWhNoWUUUtgSFFBSJ
         3Zdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790188034; x=1790792834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1fGR8UzTdFSd/DkqLSEBQCibxjhyjIqBXG52eLVjeL8=;
        b=kIW9xaUyn+hyeVzXLjoHHntiFzyQBsEXOi62Xi80MfnK5P7iNV4E3nexv16RrrQ3V4
         eZzzhVMQVHFSmVblNJKEkArmHyaXFzKi5H8awfJt+GTzs9hud9hV8YpaYDlzF4sEqE8K
         3mP+Qwm1gpIxMTLJFIVtE4PE2u5+SDn4gNW+WZ+LT5fGY9UVf1+TNSuzJvPz8T8iq3J/
         JaebW6kKWs6NRTBoUJM7YgFuxLdnXYVHOF7OZKemzI4UqSAUTl/qGl2QQeHCc0A6OSd/
         UKRjFDGUSbV5xGkfGb7kLZuuIAdzXkIULh4OGFkYNcOtFWe/t3qqVRPKDQahmFLLnmA9
         BOKA==
X-Gm-Message-State: AFuF++n6gHpqOfgt3aU7+uM+eJxiGHrTU20Q5taHRUFryYAva/Y8eV71
	2GNWV5W+Kwzsv7WWMEXFU1U9SH6Sw+k+yZfG+x/+d9PzFA2PqD9yWzcGiN7uhQ==
X-Gm-Gg: AYBFou29QkQStuD5AsBC1sIHIhfoEOVhsJQ61bPFWuaj0epRhUdpKqQoz+3yzrgXbEJ
	8boTUAyRfsgsuhIsz7dZsUQ22hZoB/HvRGj0Xtq5eqHPeuDAzmVagGvP5TB1OP1/w0xMY8vRd7Y
	aJEbk6xbssnPc3afO8LcQ1556v/y+StYX0vv7AgGbzvNTRlT55v/1G7tUPI3TVM4yGNY8KH1RSS
	hKYGOOja6ZwVqEis7zHggiWV6Glpi0C3tggOHAi4MQ3c4tec1Um5xGB2j3BPrMDLfaiyPUa8yp+
	LtnU1ellw34LCxLvh3boBS6tEUyJyKX3whijkW56CwJdt2tBO9WnELmVaD78x29MxzwQjv7RLRg
	5IHGGoluIej2hJ7MYB7EGwf919tIhIyejmjzShxZx4Bd6yfLYKZi7SNadaMq4efGyRoojYCXepL
	8OKcOAzT+ghUivn1TBbC5M5T4fMleHXW0PwISAVWbW0irvLYtGDcO0PpvfO4UhY9TwvgBSxISgw
	TWc20YS2w3G5NA67HyRWfzqCdu5y1w6e/U18mEns1T+onaGSilMMnj+/tgRyG3XdBGNH+iHZHtd
	OHAUrlf6gHPvW3Zd51b+E/4ghRRqYhuLyTt1z7NeYObmwscI
X-Received: by 2002:a05:620a:2a0a:b0:93b:d7a1:ba0d with SMTP id af79cd13be357-93c2521be10mr526654885a.56.1790188034049;
        Wed, 23 Sep 2026 11:27:14 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c2474fa2asm283542885a.2.2026.09.23.11.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 11:27:13 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv3] mmc: sdhci-pxav3: use managed clock enablement
Date: Wed, 23 Sep 2026 11:27:11 -0700
Message-ID: <20260923182711.10301-1-rosenp@gmail.com>
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
remove are dropped. The NULL version of clk_io was removed as all dts
files that use sdhci-pxav3 specify io as a clock name. Strictly speaking
that could break pdata users but all of that is slated for removal.

clk_prepare_enable() and friends are NULL safe, so no need to check if
the optional clock is present.

Handle failures of clk_prepare_enable() in runtime resume instead
of ignoring them: a failed enable would leave controller register
accesses hitting unclocked hardware. Bail out before resuming the host
and unwind clk_io when enabling clk_core fails. This also drops the
now unused pltfm_host variable from remove().

Handle result of the forced resumes in remove(), suspend() and resume().
Use pm_runtime_resume_and_get(), which does not bump the usage counter on
error.

Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v3: fix sashiko errors.
 v2: fix resume paths.
 drivers/mmc/host/sdhci-pxav3.c | 91 ++++++++++++++++++++++------------
 1 file changed, 59 insertions(+), 32 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index f39764ffd4a0..fda1eafe5685 100644
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
@@ -499,35 +496,56 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
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
+	struct device *dev = &pdev->dev;
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_pxa *pxa = sdhci_pltfm_priv(pltfm_host);
+	int ret;
 
-	pm_runtime_get_sync(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
-	pm_runtime_put_noidle(&pdev->dev);
+	ret = pm_runtime_resume_and_get(dev);
+	pm_runtime_disable(dev);
+	if (ret) {
+		/*
+		 * Runtime resume failed, so the controller may still be
+		 * unclocked.  Restore the clocks so the register accesses in
+		 * sdhci_remove_host() do not hit unclocked hardware.
+		 */
+		dev_warn(dev, "failed to resume controller, %pe\n",
+			 ERR_PTR(ret));
+		ret = clk_prepare_enable(pxa->clk_io);
+		if (ret) {
+			dev_warn(dev, "failed to re-enable io clock, %pe\n",
+				 ERR_PTR(ret));
+			return;
+		}
+		ret = clk_prepare_enable(pxa->clk_core);
+		if (ret) {
+			clk_disable_unprepare(pxa->clk_io);
+			dev_warn(dev, "failed to re-enable core clock, %pe\n",
+				 ERR_PTR(ret));
+			return;
+		}
+	} else {
+		pm_runtime_put_noidle(dev);
+	}
 
 	sdhci_remove_host(host, 1);
-
-	clk_disable_unprepare(pxa->clk_io);
-	clk_disable_unprepare(pxa->clk_core);
 }
 
 static int sdhci_pxav3_suspend(struct device *dev)
 {
-	int ret;
 	struct sdhci_host *host = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
 
-	pm_runtime_get_sync(dev);
 	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
 		mmc_retune_needed(host->mmc);
 	ret = sdhci_suspend_host(host);
@@ -538,10 +556,13 @@ static int sdhci_pxav3_suspend(struct device *dev)
 
 static int sdhci_pxav3_resume(struct device *dev)
 {
-	int ret;
 	struct sdhci_host *host = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
 
-	pm_runtime_get_sync(dev);
 	ret = sdhci_resume_host(host);
 	pm_runtime_put_autosuspend(dev);
 
@@ -560,8 +581,7 @@ static int sdhci_pxav3_runtime_suspend(struct device *dev)
 		mmc_retune_needed(host->mmc);
 
 	clk_disable_unprepare(pxa->clk_io);
-	if (!IS_ERR(pxa->clk_core))
-		clk_disable_unprepare(pxa->clk_core);
+	clk_disable_unprepare(pxa->clk_core);
 
 	return 0;
 }
@@ -571,10 +591,17 @@ static int sdhci_pxav3_runtime_resume(struct device *dev)
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

