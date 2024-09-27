Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA171C1742
	for <linux-mmc@vger.kernel.org>; Fri, 27 Sep 2024 14:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727449135; cv=none; b=Z5DR0YLpWEGyXTOi1unQAmtwCjGVuAkqG0RSlK2H8RfUBmNzTi0vXesXSQpFOJuVtxrg3BA3adeALslLBFFok9UQMowY9HRsADQWspdi1zVJE7pP+qopCXR4YygQ9OiEj5we0OjKTJ3Xxr9mV/rOPeyqhsOM73jv1gEcCM+SxNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727449135; c=relaxed/simple;
	bh=ERAeL5/+cTjTWel8v+uvChscZ1r2dsarOaMD9uu02+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DXFyYxEwjqqyJCTg27Zcm7WWVQ672xTg2yj5TtEOuZv//p50VXiaPwXoTomBh++6+NTGsFKdHtTs+z49Z7+OmPoUsM1iEzO5o3zw+i4U+ekqJjieeo/efHBXJxU9JlsDBRw75029pD9jVs1LWxbLF2WrHuC+mg4xavSY9pv8HO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=j5jSgORZ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="j5jSgORZ"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cd46f3a26so19295665e9.2
        for <linux-mmc@vger.kernel.org>; Fri, 27 Sep 2024 07:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727449128; x=1728053928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UHPs555QpHijQgvQqSkIioANgYtoSv01gaRnWvcKWZs=;
        b=j5jSgORZr9bcMR9zvxZCw/7IozMLRskcZPhKgs5A0j5Im1j7fBhh65VITt9H80AnOl
         OIDYP/ophA4Dn8NfLy14mFukky9aFa7HJUYWgg/nUBmB7Hf2UZXpmL0xOQxjl7be/W6d
         UaIAqLzcyqpQszcv98ajYfljOmOvH+DGHkNDYEvA+nAeGZGQD9W9lsfOIEUhBEk5rvme
         mcWn5rPKnFCo5hd9IKTLmBZ5z2d2mi8PNMciFDFO6Zi32xRx/OIcBociAgrOi61dM2oB
         ucsIaWiap+VHyYIL7uYJmTaeUSjPRAwL+Oy1NGZ45ly5OP1ip0B1OuRyF1KGAy4LW6N1
         +e0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727449128; x=1728053928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UHPs555QpHijQgvQqSkIioANgYtoSv01gaRnWvcKWZs=;
        b=pSzXwGheVH1wXjJnLm2F/kniCZZKmM592QFOG2ABtjkzC6PHthluBvk7Y9EKLtCT0o
         s1GAlKKar5yxBxshy5qXRDif+5sDTshEl2ng/aRzhqU0hTUSamqS7mv5aZk8Zk0Lo/Dh
         G8lBzgac2tnzWJgEzAsMPATjFwNjxOiuP5ldelTrBqLnPXZ5xrJjIiJrQ4gQ/arn7wQA
         MYckKv5xDmXZX19A8lzO8npJaXarj7WZUyl/tEJxXMeNSXvymEWXkbDQrCYGmjbOdxNH
         CRnUQDKkvDzlouCQe/krGhImVWmRM+gGAdcF3s0lAAOphlch3ocuUd0Uf8j68yeREmNH
         58Ag==
X-Gm-Message-State: AOJu0YxND/A5iaqJJGvnYKSuk3zYA08lEc0kTu6HlvShUloJLrIMKli6
	yLewuIHKTlAsiwwxvACIe4Pyl++9Q1l667OFs0yBS31VMHehRERX2ej/BPGkaRSFG1tAhWmDv2+
	l
X-Google-Smtp-Source: AGHT+IGsAUOBAnkHALKpBTa+oa5O1WPTEcbq0O/BJAGn9vMCwHrEIyWy4XCY+gOc/4M9fHNVEsmpyw==
X-Received: by 2002:adf:ed4e:0:b0:374:bad2:6a5e with SMTP id ffacd0b85a97d-37cd5ab7535mr2087941f8f.28.1727449127770;
        Fri, 27 Sep 2024 07:58:47 -0700 (PDT)
Received: from localhost (amontpellier-556-1-151-252.w109-210.abo.wanadoo.fr. [109.210.7.252])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd564d35bsm2777651f8f.21.2024.09.27.07.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 07:58:47 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: Switch back to struct platform_driver::remove()
Date: Fri, 27 Sep 2024 16:58:33 +0200
Message-ID: <20240927145832.754697-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=42850; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=ERAeL5/+cTjTWel8v+uvChscZ1r2dsarOaMD9uu02+Q=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBm9sgYj7PxK9z4QtTCvEAns/iz3mKfo+7w+4j++ HXvbkjaWcqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZvbIGAAKCRCPgPtYfRL+ TloYCACVSDlDVL5vnhuqOqu07JPN51KREEEhnsM95oxBPpMgvsbsQ8pAtxGE4qwSNCpciBkNgPr xpnImuRYmPQU31nZoGavFOuyMUh167ZMcuXkcauxlOvqm9o8JULKuBCdYA7bn0zi/KdqPyj83sR FicH/O8I8JNc5c43MBE293fCFmkh69ZopPnP1ixtjxvaQEmkVpnUlfCHvXIyDsvQi3C2e1YqrpN bmfTKyO+uxad7tn68F0TnyyRZlNhFWsEsQitkhEuJDV2biDua5pTQx6/QbeWbaqFhYJ2BLV4Lha ucixvg3x3c9PWmoJZyIzx0Hf557VS5/2jGbj/2X41FiaHoS+
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
return void") .remove() is (again) the right callback to implement for
platform drivers.

Convert all platform drivers below drivers/mmc to use .remove(), with
the eventual goal to drop struct platform_driver::remove_new(). As
.remove() and .remove_new() have the same prototypes, conversion is done
by just changing the structure member name in the driver initializer.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

I did a single patch for all of drivers/mmc. While I usually prefer to
do one logical change per patch, this seems to be overengineering here
as the individual changes are really trivial and shouldn't be much in
the way for stable backports. But I'll happily split the patch if you
prefer it split.

Note I didn't Cc: the maintainers of each driver as this would hit
sending limits.

This is based on today's next, if conflicts arise when you apply it at
some later time and don't want to resolve them, feel free to just drop
the changes to the conflicting files. I'll notice and followup at a
later time then. Or ask me for a fixed resend.

Best regards
Uwe

 drivers/mmc/core/pwrseq_emmc.c                | 2 +-
 drivers/mmc/core/pwrseq_sd8787.c              | 2 +-
 drivers/mmc/core/pwrseq_simple.c              | 2 +-
 drivers/mmc/host/alcor.c                      | 2 +-
 drivers/mmc/host/atmel-mci.c                  | 2 +-
 drivers/mmc/host/au1xmmc.c                    | 2 +-
 drivers/mmc/host/bcm2835.c                    | 2 +-
 drivers/mmc/host/cavium-octeon.c              | 2 +-
 drivers/mmc/host/cb710-mmc.c                  | 2 +-
 drivers/mmc/host/davinci_mmc.c                | 2 +-
 drivers/mmc/host/dw_mmc-bluefield.c           | 2 +-
 drivers/mmc/host/dw_mmc-exynos.c              | 2 +-
 drivers/mmc/host/dw_mmc-hi3798cv200.c         | 2 +-
 drivers/mmc/host/dw_mmc-hi3798mv200.c         | 2 +-
 drivers/mmc/host/dw_mmc-k3.c                  | 2 +-
 drivers/mmc/host/dw_mmc-pltfm.c               | 2 +-
 drivers/mmc/host/dw_mmc-rockchip.c            | 2 +-
 drivers/mmc/host/dw_mmc-starfive.c            | 2 +-
 drivers/mmc/host/jz4740_mmc.c                 | 2 +-
 drivers/mmc/host/litex_mmc.c                  | 2 +-
 drivers/mmc/host/meson-gx-mmc.c               | 2 +-
 drivers/mmc/host/meson-mx-sdhc-mmc.c          | 2 +-
 drivers/mmc/host/meson-mx-sdio.c              | 2 +-
 drivers/mmc/host/moxart-mmc.c                 | 2 +-
 drivers/mmc/host/mtk-sd.c                     | 2 +-
 drivers/mmc/host/mvsdio.c                     | 2 +-
 drivers/mmc/host/mxcmmc.c                     | 2 +-
 drivers/mmc/host/mxs-mmc.c                    | 2 +-
 drivers/mmc/host/omap.c                       | 2 +-
 drivers/mmc/host/omap_hsmmc.c                 | 2 +-
 drivers/mmc/host/owl-mmc.c                    | 2 +-
 drivers/mmc/host/pxamci.c                     | 2 +-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 2 +-
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      | 2 +-
 drivers/mmc/host/rtsx_pci_sdmmc.c             | 2 +-
 drivers/mmc/host/rtsx_usb_sdmmc.c             | 2 +-
 drivers/mmc/host/sdhci-acpi.c                 | 2 +-
 drivers/mmc/host/sdhci-bcm-kona.c             | 2 +-
 drivers/mmc/host/sdhci-brcmstb.c              | 2 +-
 drivers/mmc/host/sdhci-cadence.c              | 2 +-
 drivers/mmc/host/sdhci-dove.c                 | 2 +-
 drivers/mmc/host/sdhci-esdhc-imx.c            | 2 +-
 drivers/mmc/host/sdhci-esdhc-mcf.c            | 2 +-
 drivers/mmc/host/sdhci-iproc.c                | 2 +-
 drivers/mmc/host/sdhci-milbeaut.c             | 2 +-
 drivers/mmc/host/sdhci-msm.c                  | 2 +-
 drivers/mmc/host/sdhci-npcm.c                 | 2 +-
 drivers/mmc/host/sdhci-of-arasan.c            | 2 +-
 drivers/mmc/host/sdhci-of-aspeed.c            | 4 ++--
 drivers/mmc/host/sdhci-of-at91.c              | 2 +-
 drivers/mmc/host/sdhci-of-dwcmshc.c           | 2 +-
 drivers/mmc/host/sdhci-of-esdhc.c             | 2 +-
 drivers/mmc/host/sdhci-of-hlwd.c              | 2 +-
 drivers/mmc/host/sdhci-of-ma35d1.c            | 2 +-
 drivers/mmc/host/sdhci-of-sparx5.c            | 2 +-
 drivers/mmc/host/sdhci-omap.c                 | 2 +-
 drivers/mmc/host/sdhci-pic32.c                | 2 +-
 drivers/mmc/host/sdhci-pxav2.c                | 2 +-
 drivers/mmc/host/sdhci-pxav3.c                | 2 +-
 drivers/mmc/host/sdhci-s3c.c                  | 2 +-
 drivers/mmc/host/sdhci-spear.c                | 2 +-
 drivers/mmc/host/sdhci-sprd.c                 | 2 +-
 drivers/mmc/host/sdhci-st.c                   | 2 +-
 drivers/mmc/host/sdhci-tegra.c                | 2 +-
 drivers/mmc/host/sdhci-xenon.c                | 2 +-
 drivers/mmc/host/sdhci_am654.c                | 2 +-
 drivers/mmc/host/sdhci_f_sdh30.c              | 2 +-
 drivers/mmc/host/sh_mmcif.c                   | 2 +-
 drivers/mmc/host/sunplus-mmc.c                | 2 +-
 drivers/mmc/host/sunxi-mmc.c                  | 2 +-
 drivers/mmc/host/uniphier-sd.c                | 2 +-
 drivers/mmc/host/usdhi6rol0.c                 | 2 +-
 drivers/mmc/host/wbsd.c                       | 2 +-
 drivers/mmc/host/wmt-sdmmc.c                  | 2 +-
 74 files changed, 75 insertions(+), 75 deletions(-)

diff --git a/drivers/mmc/core/pwrseq_emmc.c b/drivers/mmc/core/pwrseq_emmc.c
index 96fa4c508900..35af67e26945 100644
--- a/drivers/mmc/core/pwrseq_emmc.c
+++ b/drivers/mmc/core/pwrseq_emmc.c
@@ -107,7 +107,7 @@ MODULE_DEVICE_TABLE(of, mmc_pwrseq_emmc_of_match);
 
 static struct platform_driver mmc_pwrseq_emmc_driver = {
 	.probe = mmc_pwrseq_emmc_probe,
-	.remove_new = mmc_pwrseq_emmc_remove,
+	.remove = mmc_pwrseq_emmc_remove,
 	.driver = {
 		.name = "pwrseq_emmc",
 		.of_match_table = mmc_pwrseq_emmc_of_match,
diff --git a/drivers/mmc/core/pwrseq_sd8787.c b/drivers/mmc/core/pwrseq_sd8787.c
index f24bbd68e251..30282155a0e1 100644
--- a/drivers/mmc/core/pwrseq_sd8787.c
+++ b/drivers/mmc/core/pwrseq_sd8787.c
@@ -122,7 +122,7 @@ static void mmc_pwrseq_sd8787_remove(struct platform_device *pdev)
 
 static struct platform_driver mmc_pwrseq_sd8787_driver = {
 	.probe = mmc_pwrseq_sd8787_probe,
-	.remove_new = mmc_pwrseq_sd8787_remove,
+	.remove = mmc_pwrseq_sd8787_remove,
 	.driver = {
 		.name = "pwrseq_sd8787",
 		.of_match_table = mmc_pwrseq_sd8787_of_match,
diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index 154a8921ae75..9e016b0746f5 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -151,7 +151,7 @@ static void mmc_pwrseq_simple_remove(struct platform_device *pdev)
 
 static struct platform_driver mmc_pwrseq_simple_driver = {
 	.probe = mmc_pwrseq_simple_probe,
-	.remove_new = mmc_pwrseq_simple_remove,
+	.remove = mmc_pwrseq_simple_remove,
 	.driver = {
 		.name = "pwrseq_simple",
 		.of_match_table = mmc_pwrseq_simple_of_match,
diff --git a/drivers/mmc/host/alcor.c b/drivers/mmc/host/alcor.c
index 42aa43740ba8..b6b6dd677ae5 100644
--- a/drivers/mmc/host/alcor.c
+++ b/drivers/mmc/host/alcor.c
@@ -1175,7 +1175,7 @@ MODULE_DEVICE_TABLE(platform, alcor_pci_sdmmc_ids);
 
 static struct platform_driver alcor_pci_sdmmc_driver = {
 	.probe		= alcor_pci_sdmmc_drv_probe,
-	.remove_new	= alcor_pci_sdmmc_drv_remove,
+	.remove		= alcor_pci_sdmmc_drv_remove,
 	.id_table	= alcor_pci_sdmmc_ids,
 	.driver		= {
 		.name	= DRV_NAME_ALCOR_PCI_SDMMC,
diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 6490df54a6f5..3ed86fda147a 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2653,7 +2653,7 @@ static const struct dev_pm_ops atmci_dev_pm_ops = {
 
 static struct platform_driver atmci_driver = {
 	.probe		= atmci_probe,
-	.remove_new	= atmci_remove,
+	.remove		= atmci_remove,
 	.driver		= {
 		.name		= "atmel_mci",
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index 6e80bcb668ec..27c666eab506 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -1185,7 +1185,7 @@ static int au1xmmc_resume(struct platform_device *pdev)
 
 static struct platform_driver au1xmmc_driver = {
 	.probe         = au1xmmc_probe,
-	.remove_new    = au1xmmc_remove,
+	.remove        = au1xmmc_remove,
 	.suspend       = au1xmmc_suspend,
 	.resume        = au1xmmc_resume,
 	.driver        = {
diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 35d8fdea668b..349f1c50b096 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -1459,7 +1459,7 @@ MODULE_DEVICE_TABLE(of, bcm2835_match);
 
 static struct platform_driver bcm2835_driver = {
 	.probe      = bcm2835_probe,
-	.remove_new = bcm2835_remove,
+	.remove     = bcm2835_remove,
 	.driver     = {
 		.name		= "sdhost-bcm2835",
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
diff --git a/drivers/mmc/host/cavium-octeon.c b/drivers/mmc/host/cavium-octeon.c
index 060ec4f4800f..72817c5f4578 100644
--- a/drivers/mmc/host/cavium-octeon.c
+++ b/drivers/mmc/host/cavium-octeon.c
@@ -326,7 +326,7 @@ MODULE_DEVICE_TABLE(of, octeon_mmc_match);
 
 static struct platform_driver octeon_mmc_driver = {
 	.probe		= octeon_mmc_probe,
-	.remove_new	= octeon_mmc_remove,
+	.remove		= octeon_mmc_remove,
 	.driver		= {
 		.name	= KBUILD_MODNAME,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
diff --git a/drivers/mmc/host/cb710-mmc.c b/drivers/mmc/host/cb710-mmc.c
index 902f7f20abaa..d741c1f9cf87 100644
--- a/drivers/mmc/host/cb710-mmc.c
+++ b/drivers/mmc/host/cb710-mmc.c
@@ -771,7 +771,7 @@ static void cb710_mmc_exit(struct platform_device *pdev)
 static struct platform_driver cb710_mmc_driver = {
 	.driver.name = "cb710-mmc",
 	.probe = cb710_mmc_init,
-	.remove_new = cb710_mmc_exit,
+	.remove = cb710_mmc_exit,
 #ifdef CONFIG_PM
 	.suspend = cb710_mmc_suspend,
 	.resume = cb710_mmc_resume,
diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 9cbde800685d..7ed533758dbe 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1400,7 +1400,7 @@ static struct platform_driver davinci_mmcsd_driver = {
 		.of_match_table = davinci_mmc_dt_ids,
 	},
 	.probe		= davinci_mmcsd_probe,
-	.remove_new	= davinci_mmcsd_remove,
+	.remove		= davinci_mmcsd_remove,
 	.id_table	= davinci_mmc_devtype,
 };
 
diff --git a/drivers/mmc/host/dw_mmc-bluefield.c b/drivers/mmc/host/dw_mmc-bluefield.c
index 24e0b604b405..3cf526ab0387 100644
--- a/drivers/mmc/host/dw_mmc-bluefield.c
+++ b/drivers/mmc/host/dw_mmc-bluefield.c
@@ -68,7 +68,7 @@ static int dw_mci_bluefield_probe(struct platform_device *pdev)
 
 static struct platform_driver dw_mci_bluefield_pltfm_driver = {
 	.probe		= dw_mci_bluefield_probe,
-	.remove_new	= dw_mci_pltfm_remove,
+	.remove		= dw_mci_pltfm_remove,
 	.driver		= {
 		.name		= "dwmmc_bluefield",
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 6dc057718d2c..53d32d0f2709 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -682,7 +682,7 @@ static const struct dev_pm_ops dw_mci_exynos_pmops = {
 
 static struct platform_driver dw_mci_exynos_pltfm_driver = {
 	.probe		= dw_mci_exynos_probe,
-	.remove_new	= dw_mci_exynos_remove,
+	.remove		= dw_mci_exynos_remove,
 	.driver		= {
 		.name		= "dwmmc_exynos",
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
diff --git a/drivers/mmc/host/dw_mmc-hi3798cv200.c b/drivers/mmc/host/dw_mmc-hi3798cv200.c
index 6099756e59b3..0ccfae1b2dbe 100644
--- a/drivers/mmc/host/dw_mmc-hi3798cv200.c
+++ b/drivers/mmc/host/dw_mmc-hi3798cv200.c
@@ -189,7 +189,7 @@ static const struct of_device_id dw_mci_hi3798cv200_match[] = {
 MODULE_DEVICE_TABLE(of, dw_mci_hi3798cv200_match);
 static struct platform_driver dw_mci_hi3798cv200_driver = {
 	.probe = dw_mci_hi3798cv200_probe,
-	.remove_new = dw_mci_hi3798cv200_remove,
+	.remove = dw_mci_hi3798cv200_remove,
 	.driver = {
 		.name = "dwmmc_hi3798cv200",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
diff --git a/drivers/mmc/host/dw_mmc-hi3798mv200.c b/drivers/mmc/host/dw_mmc-hi3798mv200.c
index 96af693e3e37..cce174b5249b 100644
--- a/drivers/mmc/host/dw_mmc-hi3798mv200.c
+++ b/drivers/mmc/host/dw_mmc-hi3798mv200.c
@@ -237,7 +237,7 @@ static void dw_mci_hi3798mv200_remove(struct platform_device *pdev)
 MODULE_DEVICE_TABLE(of, dw_mci_hi3798mv200_match);
 static struct platform_driver dw_mci_hi3798mv200_driver = {
 	.probe = dw_mci_hi3798mv200_probe,
-	.remove_new = dw_mci_hi3798mv200_remove,
+	.remove = dw_mci_hi3798mv200_remove,
 	.driver = {
 		.name = "dwmmc_hi3798mv200",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
index e8ee7c43f60b..0311a37dd4ab 100644
--- a/drivers/mmc/host/dw_mmc-k3.c
+++ b/drivers/mmc/host/dw_mmc-k3.c
@@ -470,7 +470,7 @@ static const struct dev_pm_ops dw_mci_k3_dev_pm_ops = {
 
 static struct platform_driver dw_mci_k3_pltfm_driver = {
 	.probe		= dw_mci_k3_probe,
-	.remove_new	= dw_mci_pltfm_remove,
+	.remove		= dw_mci_pltfm_remove,
 	.driver		= {
 		.name		= "dwmmc_k3",
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index 2353fadceda1..de820ffd2133 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -131,7 +131,7 @@ EXPORT_SYMBOL_GPL(dw_mci_pltfm_remove);
 
 static struct platform_driver dw_mci_pltfm_driver = {
 	.probe		= dw_mci_pltfm_probe,
-	.remove_new	= dw_mci_pltfm_remove,
+	.remove		= dw_mci_pltfm_remove,
 	.driver		= {
 		.name		= "dw_mmc",
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index f96260fd143b..baa23b517731 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -577,7 +577,7 @@ static const struct dev_pm_ops dw_mci_rockchip_dev_pm_ops = {
 
 static struct platform_driver dw_mci_rockchip_pltfm_driver = {
 	.probe		= dw_mci_rockchip_probe,
-	.remove_new	= dw_mci_rockchip_remove,
+	.remove		= dw_mci_rockchip_remove,
 	.driver		= {
 		.name		= "dwmmc_rockchip",
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
diff --git a/drivers/mmc/host/dw_mmc-starfive.c b/drivers/mmc/host/dw_mmc-starfive.c
index b4d81ef0f3af..34964b0dab21 100644
--- a/drivers/mmc/host/dw_mmc-starfive.c
+++ b/drivers/mmc/host/dw_mmc-starfive.c
@@ -115,7 +115,7 @@ static int dw_mci_starfive_probe(struct platform_device *pdev)
 
 static struct platform_driver dw_mci_starfive_driver = {
 	.probe = dw_mci_starfive_probe,
-	.remove_new = dw_mci_pltfm_remove,
+	.remove = dw_mci_pltfm_remove,
 	.driver = {
 		.name = "dwmmc_starfive",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 6a45991ca056..596012d5afac 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -1191,7 +1191,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(jz4740_mmc_pm_ops, jz4740_mmc_suspend,
 
 static struct platform_driver jz4740_mmc_driver = {
 	.probe = jz4740_mmc_probe,
-	.remove_new = jz4740_mmc_remove,
+	.remove = jz4740_mmc_remove,
 	.driver = {
 		.name = "jz4740-mmc",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
diff --git a/drivers/mmc/host/litex_mmc.c b/drivers/mmc/host/litex_mmc.c
index 4ec8072dc60b..b338ccfa8f33 100644
--- a/drivers/mmc/host/litex_mmc.c
+++ b/drivers/mmc/host/litex_mmc.c
@@ -644,7 +644,7 @@ MODULE_DEVICE_TABLE(of, litex_match);
 
 static struct platform_driver litex_mmc_driver = {
 	.probe = litex_mmc_probe,
-	.remove_new = litex_mmc_remove,
+	.remove = litex_mmc_remove,
 	.driver = {
 		.name = "litex-mmc",
 		.of_match_table = litex_match,
diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index c7c067b9415a..a9e7c8ddc5a1 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1334,7 +1334,7 @@ MODULE_DEVICE_TABLE(of, meson_mmc_of_match);
 
 static struct platform_driver meson_mmc_driver = {
 	.probe		= meson_mmc_probe,
-	.remove_new	= meson_mmc_remove,
+	.remove		= meson_mmc_remove,
 	.driver		= {
 		.name = DRIVER_NAME,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
diff --git a/drivers/mmc/host/meson-mx-sdhc-mmc.c b/drivers/mmc/host/meson-mx-sdhc-mmc.c
index 31f750301dc1..b4e56ccffca2 100644
--- a/drivers/mmc/host/meson-mx-sdhc-mmc.c
+++ b/drivers/mmc/host/meson-mx-sdhc-mmc.c
@@ -904,7 +904,7 @@ MODULE_DEVICE_TABLE(of, meson_mx_sdhc_of_match);
 
 static struct platform_driver meson_mx_sdhc_driver = {
 	.probe   = meson_mx_sdhc_probe,
-	.remove_new = meson_mx_sdhc_remove,
+	.remove = meson_mx_sdhc_remove,
 	.driver  = {
 		.name = "meson-mx-sdhc",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
index a11577f2ee69..ad351805eed4 100644
--- a/drivers/mmc/host/meson-mx-sdio.c
+++ b/drivers/mmc/host/meson-mx-sdio.c
@@ -754,7 +754,7 @@ MODULE_DEVICE_TABLE(of, meson_mx_mmc_of_match);
 
 static struct platform_driver meson_mx_mmc_driver = {
 	.probe   = meson_mx_mmc_probe,
-	.remove_new = meson_mx_mmc_remove,
+	.remove = meson_mx_mmc_remove,
 	.driver  = {
 		.name = "meson-mx-sdio",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index 8ede4ce93271..a12048e5de63 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -719,7 +719,7 @@ MODULE_DEVICE_TABLE(of, moxart_mmc_match);
 
 static struct platform_driver moxart_mmc_driver = {
 	.probe      = moxart_probe,
-	.remove_new = moxart_remove,
+	.remove = moxart_remove,
 	.driver     = {
 		.name		= "mmc-moxart",
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 89018b6c97b9..1a0f6b04d863 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -3112,7 +3112,7 @@ static const struct dev_pm_ops msdc_dev_pm_ops = {
 
 static struct platform_driver mt_msdc_driver = {
 	.probe = msdc_drv_probe,
-	.remove_new = msdc_drv_remove,
+	.remove = msdc_drv_remove,
 	.driver = {
 		.name = "mtk-msdc",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index af7f21888e27..1024b3ebff00 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -854,7 +854,7 @@ MODULE_DEVICE_TABLE(of, mvsdio_dt_ids);
 
 static struct platform_driver mvsd_driver = {
 	.probe		= mvsd_probe,
-	.remove_new	= mvsd_remove,
+	.remove		= mvsd_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 1edf65291354..e7a286c3216f 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -1225,7 +1225,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(mxcmci_pm_ops, mxcmci_suspend, mxcmci_resume);
 
 static struct platform_driver mxcmci_driver = {
 	.probe		= mxcmci_probe,
-	.remove_new	= mxcmci_remove,
+	.remove		= mxcmci_remove,
 	.driver		= {
 		.name		= DRIVER_NAME,
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 6751da9b60f9..80e6f48c83aa 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -714,7 +714,7 @@ static SIMPLE_DEV_PM_OPS(mxs_mmc_pm_ops, mxs_mmc_suspend, mxs_mmc_resume);
 
 static struct platform_driver mxs_mmc_driver = {
 	.probe		= mxs_mmc_probe,
-	.remove_new	= mxs_mmc_remove,
+	.remove		= mxs_mmc_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 335350a4e99a..62252ad4e20d 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1554,7 +1554,7 @@ MODULE_DEVICE_TABLE(of, mmc_omap_match);
 
 static struct platform_driver mmc_omap_driver = {
 	.probe		= mmc_omap_probe,
-	.remove_new	= mmc_omap_remove,
+	.remove		= mmc_omap_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index e120aeb869b8..59e36e0ebbbf 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2121,7 +2121,7 @@ static const struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
 
 static struct platform_driver omap_hsmmc_driver = {
 	.probe		= omap_hsmmc_probe,
-	.remove_new	= omap_hsmmc_remove,
+	.remove		= omap_hsmmc_remove,
 	.driver		= {
 		.name = DRIVER_NAME,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
diff --git a/drivers/mmc/host/owl-mmc.c b/drivers/mmc/host/owl-mmc.c
index fc08f25c34eb..797ef48d9204 100644
--- a/drivers/mmc/host/owl-mmc.c
+++ b/drivers/mmc/host/owl-mmc.c
@@ -692,7 +692,7 @@ static struct platform_driver owl_mmc_driver = {
 		.of_match_table = owl_mmc_of_match,
 	},
 	.probe		= owl_mmc_probe,
-	.remove_new	= owl_mmc_remove,
+	.remove		= owl_mmc_remove,
 };
 module_platform_driver(owl_mmc_driver);
 
diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index fae3192c3a14..2d0ad006913d 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -810,7 +810,7 @@ static void pxamci_remove(struct platform_device *pdev)
 
 static struct platform_driver pxamci_driver = {
 	.probe		= pxamci_probe,
-	.remove_new	= pxamci_remove,
+	.remove		= pxamci_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 1dcaa050f264..4b389e92399e 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -613,7 +613,7 @@ static struct platform_driver renesas_internal_dmac_sdhi_driver = {
 		.of_match_table = renesas_sdhi_internal_dmac_of_match,
 	},
 	.probe		= renesas_sdhi_internal_dmac_probe,
-	.remove_new	= renesas_sdhi_remove,
+	.remove		= renesas_sdhi_remove,
 };
 
 module_platform_driver(renesas_internal_dmac_sdhi_driver);
diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index 0ba3f62a9b49..822a310c9bba 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -471,7 +471,7 @@ static struct platform_driver renesas_sys_dmac_sdhi_driver = {
 		.of_match_table = renesas_sdhi_sys_dmac_of_match,
 	},
 	.probe		= renesas_sdhi_sys_dmac_probe,
-	.remove_new	= renesas_sdhi_remove,
+	.remove		= renesas_sdhi_remove,
 };
 
 module_platform_driver(renesas_sys_dmac_sdhi_driver);
diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 7dfe7c4e0077..e99f2bca3717 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -1591,7 +1591,7 @@ MODULE_DEVICE_TABLE(platform, rtsx_pci_sdmmc_ids);
 
 static struct platform_driver rtsx_pci_sdmmc_driver = {
 	.probe		= rtsx_pci_sdmmc_drv_probe,
-	.remove_new	= rtsx_pci_sdmmc_drv_remove,
+	.remove		= rtsx_pci_sdmmc_drv_remove,
 	.id_table       = rtsx_pci_sdmmc_ids,
 	.driver		= {
 		.name	= DRV_NAME_RTSX_PCI_SDMMC,
diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index ded9b6849e35..17e16d643b22 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -1453,7 +1453,7 @@ MODULE_DEVICE_TABLE(platform, rtsx_usb_sdmmc_ids);
 
 static struct platform_driver rtsx_usb_sdmmc_driver = {
 	.probe		= rtsx_usb_sdmmc_drv_probe,
-	.remove_new	= rtsx_usb_sdmmc_drv_remove,
+	.remove		= rtsx_usb_sdmmc_drv_remove,
 	.id_table       = rtsx_usb_sdmmc_ids,
 	.driver		= {
 		.name	= "rtsx_usb_sdmmc",
diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index eb8f427f9770..d1ce9193ece9 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -1080,7 +1080,7 @@ static struct platform_driver sdhci_acpi_driver = {
 		.pm			= &sdhci_acpi_pm_ops,
 	},
 	.probe	= sdhci_acpi_probe,
-	.remove_new = sdhci_acpi_remove,
+	.remove = sdhci_acpi_remove,
 };
 
 module_platform_driver(sdhci_acpi_driver);
diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
index e067c7f5c537..fda911fb28e5 100644
--- a/drivers/mmc/host/sdhci-bcm-kona.c
+++ b/drivers/mmc/host/sdhci-bcm-kona.c
@@ -328,7 +328,7 @@ static struct platform_driver sdhci_bcm_kona_driver = {
 		.of_match_table = sdhci_bcm_kona_of_match,
 	},
 	.probe		= sdhci_bcm_kona_probe,
-	.remove_new	= sdhci_bcm_kona_remove,
+	.remove		= sdhci_bcm_kona_remove,
 };
 module_platform_driver(sdhci_bcm_kona_driver);
 
diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 031a4b514d16..0ef4d578ade8 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -545,7 +545,7 @@ static struct platform_driver sdhci_brcmstb_driver = {
 		.of_match_table = of_match_ptr(sdhci_brcm_of_match),
 	},
 	.probe		= sdhci_brcmstb_probe,
-	.remove_new	= sdhci_pltfm_remove,
+	.remove		= sdhci_pltfm_remove,
 	.shutdown	= sdhci_brcmstb_shutdown,
 };
 
diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index be1505e8c536..a94b297fcf2a 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -608,7 +608,7 @@ static struct platform_driver sdhci_cdns_driver = {
 		.of_match_table = sdhci_cdns_match,
 	},
 	.probe = sdhci_cdns_probe,
-	.remove_new = sdhci_pltfm_remove,
+	.remove = sdhci_pltfm_remove,
 };
 module_platform_driver(sdhci_cdns_driver);
 
diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-dove.c
index 88ec23417808..77034b13fa66 100644
--- a/drivers/mmc/host/sdhci-dove.c
+++ b/drivers/mmc/host/sdhci-dove.c
@@ -106,7 +106,7 @@ static struct platform_driver sdhci_dove_driver = {
 		.of_match_table = sdhci_dove_of_match_table,
 	},
 	.probe		= sdhci_dove_probe,
-	.remove_new	= sdhci_pltfm_remove,
+	.remove		= sdhci_pltfm_remove,
 };
 
 module_platform_driver(sdhci_dove_driver);
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 8f0bc6dca2b0..ba3a81c04e74 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -2015,7 +2015,7 @@ static struct platform_driver sdhci_esdhc_imx_driver = {
 		.pm	= &sdhci_esdhc_pmops,
 	},
 	.probe		= sdhci_esdhc_imx_probe,
-	.remove_new	= sdhci_esdhc_imx_remove,
+	.remove		= sdhci_esdhc_imx_remove,
 };
 
 module_platform_driver(sdhci_esdhc_imx_driver);
diff --git a/drivers/mmc/host/sdhci-esdhc-mcf.c b/drivers/mmc/host/sdhci-esdhc-mcf.c
index 3ad87322f6a5..327662ba5bd9 100644
--- a/drivers/mmc/host/sdhci-esdhc-mcf.c
+++ b/drivers/mmc/host/sdhci-esdhc-mcf.c
@@ -512,7 +512,7 @@ static struct platform_driver sdhci_esdhc_mcf_driver = {
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = sdhci_esdhc_mcf_probe,
-	.remove_new = sdhci_esdhc_mcf_remove,
+	.remove = sdhci_esdhc_mcf_remove,
 };
 
 module_platform_driver(sdhci_esdhc_mcf_driver);
diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index 10235fdff246..80b2567a488b 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -424,7 +424,7 @@ static struct platform_driver sdhci_iproc_driver = {
 		.pm = &sdhci_pltfm_pmops,
 	},
 	.probe = sdhci_iproc_probe,
-	.remove_new = sdhci_pltfm_remove,
+	.remove = sdhci_pltfm_remove,
 	.shutdown = sdhci_iproc_shutdown,
 };
 module_platform_driver(sdhci_iproc_driver);
diff --git a/drivers/mmc/host/sdhci-milbeaut.c b/drivers/mmc/host/sdhci-milbeaut.c
index 83706edc9796..a4675456f9c7 100644
--- a/drivers/mmc/host/sdhci-milbeaut.c
+++ b/drivers/mmc/host/sdhci-milbeaut.c
@@ -335,7 +335,7 @@ static struct platform_driver sdhci_milbeaut_driver = {
 		.of_match_table = mlb_dt_ids,
 	},
 	.probe	= sdhci_milbeaut_probe,
-	.remove_new = sdhci_milbeaut_remove,
+	.remove = sdhci_milbeaut_remove,
 };
 
 module_platform_driver(sdhci_milbeaut_driver);
diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index e113b99a3eab..8dd180a42f72 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2753,7 +2753,7 @@ static const struct dev_pm_ops sdhci_msm_pm_ops = {
 
 static struct platform_driver sdhci_msm_driver = {
 	.probe = sdhci_msm_probe,
-	.remove_new = sdhci_msm_remove,
+	.remove = sdhci_msm_remove,
 	.driver = {
 		   .name = "sdhci_msm",
 		   .of_match_table = sdhci_msm_dt_match,
diff --git a/drivers/mmc/host/sdhci-npcm.c b/drivers/mmc/host/sdhci-npcm.c
index 5bf9d18f364e..bee0585ba5c1 100644
--- a/drivers/mmc/host/sdhci-npcm.c
+++ b/drivers/mmc/host/sdhci-npcm.c
@@ -85,7 +85,7 @@ static struct platform_driver npcm_sdhci_driver = {
 		.pm	= &sdhci_pltfm_pmops,
 	},
 	.probe		= npcm_sdhci_probe,
-	.remove_new	= sdhci_pltfm_remove,
+	.remove		= sdhci_pltfm_remove,
 };
 module_platform_driver(npcm_sdhci_driver);
 
diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 5edd024347bd..5eacc78e2620 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -2046,7 +2046,7 @@ static struct platform_driver sdhci_arasan_driver = {
 		.pm = &sdhci_arasan_dev_pm_ops,
 	},
 	.probe = sdhci_arasan_probe,
-	.remove_new = sdhci_arasan_remove,
+	.remove = sdhci_arasan_remove,
 };
 
 module_platform_driver(sdhci_arasan_driver);
diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index 37240895ffaa..d6de010551b9 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -519,7 +519,7 @@ static struct platform_driver aspeed_sdhci_driver = {
 		.of_match_table = aspeed_sdhci_of_match,
 	},
 	.probe		= aspeed_sdhci_probe,
-	.remove_new	= aspeed_sdhci_remove,
+	.remove		= aspeed_sdhci_remove,
 };
 
 static int aspeed_sdc_probe(struct platform_device *pdev)
@@ -596,7 +596,7 @@ static struct platform_driver aspeed_sdc_driver = {
 		.of_match_table = aspeed_sdc_of_match,
 	},
 	.probe		= aspeed_sdc_probe,
-	.remove_new	= aspeed_sdc_remove,
+	.remove		= aspeed_sdc_remove,
 };
 
 #if defined(CONFIG_MMC_SDHCI_OF_ASPEED_TEST)
diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index 23a9faad2ff8..97988ed37467 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -471,7 +471,7 @@ static struct platform_driver sdhci_at91_driver = {
 		.pm	= &sdhci_at91_dev_pm_ops,
 	},
 	.probe		= sdhci_at91_probe,
-	.remove_new	= sdhci_at91_remove,
+	.remove		= sdhci_at91_remove,
 };
 
 module_platform_driver(sdhci_at91_driver);
diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 8999b97263af..13f5fb3e3740 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -1618,7 +1618,7 @@ static struct platform_driver sdhci_dwcmshc_driver = {
 		.pm = &dwcmshc_pmops,
 	},
 	.probe	= dwcmshc_probe,
-	.remove_new = dwcmshc_remove,
+	.remove = dwcmshc_remove,
 };
 module_platform_driver(sdhci_dwcmshc_driver);
 
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 3ae9aa25745a..002d0d59b992 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -1521,7 +1521,7 @@ static struct platform_driver sdhci_esdhc_driver = {
 		.pm = &esdhc_of_dev_pm_ops,
 	},
 	.probe = sdhci_esdhc_probe,
-	.remove_new = sdhci_pltfm_remove,
+	.remove = sdhci_pltfm_remove,
 };
 
 module_platform_driver(sdhci_esdhc_driver);
diff --git a/drivers/mmc/host/sdhci-of-hlwd.c b/drivers/mmc/host/sdhci-of-hlwd.c
index 9c1c0ce610ef..5bb845d13599 100644
--- a/drivers/mmc/host/sdhci-of-hlwd.c
+++ b/drivers/mmc/host/sdhci-of-hlwd.c
@@ -85,7 +85,7 @@ static struct platform_driver sdhci_hlwd_driver = {
 		.pm = &sdhci_pltfm_pmops,
 	},
 	.probe = sdhci_hlwd_probe,
-	.remove_new = sdhci_pltfm_remove,
+	.remove = sdhci_pltfm_remove,
 };
 
 module_platform_driver(sdhci_hlwd_driver);
diff --git a/drivers/mmc/host/sdhci-of-ma35d1.c b/drivers/mmc/host/sdhci-of-ma35d1.c
index b84c2927bd4a..1e6d180100ad 100644
--- a/drivers/mmc/host/sdhci-of-ma35d1.c
+++ b/drivers/mmc/host/sdhci-of-ma35d1.c
@@ -305,7 +305,7 @@ static struct platform_driver sdhci_ma35_driver = {
 		.of_match_table = sdhci_ma35_dt_ids,
 	},
 	.probe	= ma35_probe,
-	.remove_new = ma35_remove,
+	.remove = ma35_remove,
 };
 module_platform_driver(sdhci_ma35_driver);
 
diff --git a/drivers/mmc/host/sdhci-of-sparx5.c b/drivers/mmc/host/sdhci-of-sparx5.c
index 64b77e7d14cd..d2aa684e786f 100644
--- a/drivers/mmc/host/sdhci-of-sparx5.c
+++ b/drivers/mmc/host/sdhci-of-sparx5.c
@@ -255,7 +255,7 @@ static struct platform_driver sdhci_sparx5_driver = {
 		.pm = &sdhci_pltfm_pmops,
 	},
 	.probe = sdhci_sparx5_probe,
-	.remove_new = sdhci_pltfm_remove,
+	.remove = sdhci_pltfm_remove,
 };
 
 module_platform_driver(sdhci_sparx5_driver);
diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 5841a9afeb9f..54d795205fb4 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -1478,7 +1478,7 @@ static const struct dev_pm_ops sdhci_omap_dev_pm_ops = {
 
 static struct platform_driver sdhci_omap_driver = {
 	.probe = sdhci_omap_probe,
-	.remove_new = sdhci_omap_remove,
+	.remove = sdhci_omap_remove,
 	.driver = {
 		   .name = "sdhci-omap",
 		   .probe_type = PROBE_PREFER_ASYNCHRONOUS,
diff --git a/drivers/mmc/host/sdhci-pic32.c b/drivers/mmc/host/sdhci-pic32.c
index 7a0351a9c74e..d6a299f49900 100644
--- a/drivers/mmc/host/sdhci-pic32.c
+++ b/drivers/mmc/host/sdhci-pic32.c
@@ -236,7 +236,7 @@ static struct platform_driver pic32_sdhci_driver = {
 		.of_match_table = of_match_ptr(pic32_sdhci_id_table),
 	},
 	.probe		= pic32_sdhci_probe,
-	.remove_new	= pic32_sdhci_remove,
+	.remove		= pic32_sdhci_remove,
 };
 
 module_platform_driver(pic32_sdhci_driver);
diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index 7b957f6d5588..45b6f0891c47 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -351,7 +351,7 @@ static struct platform_driver sdhci_pxav2_driver = {
 		.pm	= &sdhci_pltfm_pmops,
 	},
 	.probe		= sdhci_pxav2_probe,
-	.remove_new	= sdhci_pltfm_remove,
+	.remove		= sdhci_pltfm_remove,
 };
 
 module_platform_driver(sdhci_pxav2_driver);
diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 3af43ac05825..990723a008ae 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -568,7 +568,7 @@ static struct platform_driver sdhci_pxav3_driver = {
 		.pm	= &sdhci_pxav3_pmops,
 	},
 	.probe		= sdhci_pxav3_probe,
-	.remove_new	= sdhci_pxav3_remove,
+	.remove		= sdhci_pxav3_remove,
 };
 
 module_platform_driver(sdhci_pxav3_driver);
diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index a71d56c7031f..bdf4dc0d6b77 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -774,7 +774,7 @@ MODULE_DEVICE_TABLE(of, sdhci_s3c_dt_match);
 
 static struct platform_driver sdhci_s3c_driver = {
 	.probe		= sdhci_s3c_probe,
-	.remove_new	= sdhci_s3c_remove,
+	.remove		= sdhci_s3c_remove,
 	.id_table	= sdhci_s3c_driver_ids,
 	.driver		= {
 		.name	= "s3c-sdhci",
diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index c81bdfa97b89..770dc12b9ae9 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -182,7 +182,7 @@ static struct platform_driver sdhci_driver = {
 		.of_match_table = sdhci_spear_id_table,
 	},
 	.probe		= sdhci_probe,
-	.remove_new	= sdhci_remove,
+	.remove		= sdhci_remove,
 };
 
 module_platform_driver(sdhci_driver);
diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 8776f4287119..db5e253b0f79 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -975,7 +975,7 @@ static const struct dev_pm_ops sdhci_sprd_pm_ops = {
 
 static struct platform_driver sdhci_sprd_driver = {
 	.probe = sdhci_sprd_probe,
-	.remove_new = sdhci_sprd_remove,
+	.remove = sdhci_sprd_remove,
 	.driver = {
 		.name = "sdhci_sprd_r11",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
index d12532b96b51..4973e08a98f8 100644
--- a/drivers/mmc/host/sdhci-st.c
+++ b/drivers/mmc/host/sdhci-st.c
@@ -507,7 +507,7 @@ MODULE_DEVICE_TABLE(of, st_sdhci_match);
 
 static struct platform_driver sdhci_st_driver = {
 	.probe = sdhci_st_probe,
-	.remove_new = sdhci_st_remove,
+	.remove = sdhci_st_remove,
 	.driver = {
 		   .name = "sdhci-st",
 		   .probe_type = PROBE_PREFER_ASYNCHRONOUS,
diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 1ad0a6b3a2eb..4d402b601883 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1930,7 +1930,7 @@ static struct platform_driver sdhci_tegra_driver = {
 		.pm	= &sdhci_tegra_dev_pm_ops,
 	},
 	.probe		= sdhci_tegra_probe,
-	.remove_new	= sdhci_tegra_remove,
+	.remove		= sdhci_tegra_remove,
 };
 
 module_platform_driver(sdhci_tegra_driver);
diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index 0e52867f6e91..098f0ea45cbe 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -734,7 +734,7 @@ static struct platform_driver sdhci_xenon_driver = {
 		.pm = &sdhci_xenon_dev_pm_ops,
 	},
 	.probe	= xenon_probe,
-	.remove_new = xenon_remove,
+	.remove = xenon_remove,
 };
 
 module_platform_driver(sdhci_xenon_driver);
diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 0aa3c40ea6ed..f75c31815ab0 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -1100,7 +1100,7 @@ static struct platform_driver sdhci_am654_driver = {
 		.of_match_table = sdhci_am654_of_match,
 	},
 	.probe = sdhci_am654_probe,
-	.remove_new = sdhci_am654_remove,
+	.remove = sdhci_am654_remove,
 };
 
 module_platform_driver(sdhci_am654_driver);
diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
index c58e7cb1e2a7..ee66e4f3683d 100644
--- a/drivers/mmc/host/sdhci_f_sdh30.c
+++ b/drivers/mmc/host/sdhci_f_sdh30.c
@@ -247,7 +247,7 @@ static struct platform_driver sdhci_f_sdh30_driver = {
 		.pm	= &sdhci_pltfm_pmops,
 	},
 	.probe = sdhci_f_sdh30_probe,
-	.remove_new = sdhci_f_sdh30_remove,
+	.remove = sdhci_f_sdh30_remove,
 };
 
 module_platform_driver(sdhci_f_sdh30_driver);
diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 08b4312af94e..864e345a39f6 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1596,7 +1596,7 @@ static const struct dev_pm_ops sh_mmcif_dev_pm_ops = {
 
 static struct platform_driver sh_mmcif_driver = {
 	.probe		= sh_mmcif_probe,
-	.remove_new	= sh_mmcif_remove,
+	.remove		= sh_mmcif_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
diff --git a/drivers/mmc/host/sunplus-mmc.c b/drivers/mmc/host/sunplus-mmc.c
index 13c7cc0b6180..1cddea615a27 100644
--- a/drivers/mmc/host/sunplus-mmc.c
+++ b/drivers/mmc/host/sunplus-mmc.c
@@ -982,7 +982,7 @@ MODULE_DEVICE_TABLE(of, spmmc_of_table);
 
 static struct platform_driver spmmc_driver = {
 	.probe = spmmc_drv_probe,
-	.remove_new = spmmc_drv_remove,
+	.remove = spmmc_drv_remove,
 	.driver = {
 		.name = "spmmc",
 		.pm = pm_ptr(&spmmc_pm_ops),
diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index d3bd0ac99ec4..564f5fefe62a 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1554,7 +1554,7 @@ static struct platform_driver sunxi_mmc_driver = {
 		.pm = &sunxi_mmc_pm_ops,
 	},
 	.probe		= sunxi_mmc_probe,
-	.remove_new	= sunxi_mmc_remove,
+	.remove		= sunxi_mmc_remove,
 };
 module_platform_driver(sunxi_mmc_driver);
 
diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
index 46ee8a0b2b85..4ad02cfdc238 100644
--- a/drivers/mmc/host/uniphier-sd.c
+++ b/drivers/mmc/host/uniphier-sd.c
@@ -754,7 +754,7 @@ MODULE_DEVICE_TABLE(of, uniphier_sd_match);
 
 static struct platform_driver uniphier_sd_driver = {
 	.probe = uniphier_sd_probe,
-	.remove_new = uniphier_sd_remove,
+	.remove = uniphier_sd_remove,
 	.driver = {
 		.name = "uniphier-sd",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index 6e421445d56c..49efb960a052 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -1899,7 +1899,7 @@ static void usdhi6_remove(struct platform_device *pdev)
 
 static struct platform_driver usdhi6_driver = {
 	.probe		= usdhi6_probe,
-	.remove_new	= usdhi6_remove,
+	.remove		= usdhi6_remove,
 	.driver		= {
 		.name	= "usdhi6rol0",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
index 6e20405d0430..8b268e8a0ec9 100644
--- a/drivers/mmc/host/wbsd.c
+++ b/drivers/mmc/host/wbsd.c
@@ -1896,7 +1896,7 @@ static struct platform_device *wbsd_device;
 
 static struct platform_driver wbsd_driver = {
 	.probe		= wbsd_probe,
-	.remove_new	= wbsd_remove,
+	.remove		= wbsd_remove,
 	.suspend	= wbsd_platform_suspend,
 	.resume		= wbsd_platform_resume,
 	.driver		= {
diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
index 860380931b6c..cdb36a9f9e38 100644
--- a/drivers/mmc/host/wmt-sdmmc.c
+++ b/drivers/mmc/host/wmt-sdmmc.c
@@ -982,7 +982,7 @@ static const struct dev_pm_ops wmt_mci_pm = {
 
 static struct platform_driver wmt_mci_driver = {
 	.probe = wmt_mci_probe,
-	.remove_new = wmt_mci_remove,
+	.remove = wmt_mci_remove,
 	.driver = {
 		.name = DRIVER_NAME,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,

base-commit: 40e0c9d414f57d450e3ad03c12765e797fc3fede
-- 
2.45.2

