From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 11/11] mmc: sdhci-pltfm: Drop define for SDHCI_PLTFM_PMOPS
Date: Wed, 27 Jul 2016 13:32:07 +0200
Message-ID: <1469619127-29283-12-git-send-email-ulf.hansson@linaro.org>
References: <1469619127-29283-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:33993 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755831AbcG0Lcb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jul 2016 07:32:31 -0400
Received: by mail-lf0-f48.google.com with SMTP id l69so25161982lfg.1
        for <linux-mmc@vger.kernel.org>; Wed, 27 Jul 2016 04:32:30 -0700 (PDT)
In-Reply-To: <1469619127-29283-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>

Due to previous changes this define has no longer a purpose. Instead move
the sdhci-pltfm drivers over to use the exported struct sdhci_pltfm_pmops.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci-bcm-kona.c | 2 +-
 drivers/mmc/host/sdhci-cns3xxx.c  | 2 +-
 drivers/mmc/host/sdhci-dove.c     | 2 +-
 drivers/mmc/host/sdhci-iproc.c    | 2 +-
 drivers/mmc/host/sdhci-of-hlwd.c  | 2 +-
 drivers/mmc/host/sdhci-pltfm.h    | 1 -
 drivers/mmc/host/sdhci-pxav2.c    | 2 +-
 drivers/mmc/host/sdhci-tegra.c    | 2 +-
 drivers/mmc/host/sdhci_f_sdh30.c  | 2 +-
 9 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
index 1d64712..e5c634b 100644
--- a/drivers/mmc/host/sdhci-bcm-kona.c
+++ b/drivers/mmc/host/sdhci-bcm-kona.c
@@ -326,7 +326,7 @@ err_pltfm_free:
 static struct platform_driver sdhci_bcm_kona_driver = {
 	.driver		= {
 		.name	= "sdhci-kona",
-		.pm	= SDHCI_PLTFM_PMOPS,
+		.pm	= &sdhci_pltfm_pmops,
 		.of_match_table = sdhci_bcm_kona_of_match,
 	},
 	.probe		= sdhci_bcm_kona_probe,
diff --git a/drivers/mmc/host/sdhci-cns3xxx.c b/drivers/mmc/host/sdhci-cns3xxx.c
index 59f2923..bd286db 100644
--- a/drivers/mmc/host/sdhci-cns3xxx.c
+++ b/drivers/mmc/host/sdhci-cns3xxx.c
@@ -101,7 +101,7 @@ static int sdhci_cns3xxx_probe(struct platform_device *pdev)
 static struct platform_driver sdhci_cns3xxx_driver = {
 	.driver		= {
 		.name	= "sdhci-cns3xxx",
-		.pm	= SDHCI_PLTFM_PMOPS,
+		.pm	= &sdhci_pltfm_pmops,
 	},
 	.probe		= sdhci_cns3xxx_probe,
 	.remove		= sdhci_pltfm_unregister,
diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-dove.c
index 407c21f..de9f960 100644
--- a/drivers/mmc/host/sdhci-dove.c
+++ b/drivers/mmc/host/sdhci-dove.c
@@ -117,7 +117,7 @@ MODULE_DEVICE_TABLE(of, sdhci_dove_of_match_table);
 static struct platform_driver sdhci_dove_driver = {
 	.driver		= {
 		.name	= "sdhci-dove",
-		.pm	= SDHCI_PLTFM_PMOPS,
+		.pm	= &sdhci_pltfm_pmops,
 		.of_match_table = sdhci_dove_of_match_table,
 	},
 	.probe		= sdhci_dove_probe,
diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index 53abecc..7262466 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -260,7 +260,7 @@ static struct platform_driver sdhci_iproc_driver = {
 	.driver = {
 		.name = "sdhci-iproc",
 		.of_match_table = sdhci_iproc_of_match,
-		.pm = SDHCI_PLTFM_PMOPS,
+		.pm = &sdhci_pltfm_pmops,
 	},
 	.probe = sdhci_iproc_probe,
 	.remove = sdhci_pltfm_unregister,
diff --git a/drivers/mmc/host/sdhci-of-hlwd.c b/drivers/mmc/host/sdhci-of-hlwd.c
index 4079a96..ac00c5e 100644
--- a/drivers/mmc/host/sdhci-of-hlwd.c
+++ b/drivers/mmc/host/sdhci-of-hlwd.c
@@ -85,7 +85,7 @@ static struct platform_driver sdhci_hlwd_driver = {
 	.driver = {
 		.name = "sdhci-hlwd",
 		.of_match_table = sdhci_hlwd_of_match,
-		.pm = SDHCI_PLTFM_PMOPS,
+		.pm = &sdhci_pltfm_pmops,
 	},
 	.probe = sdhci_hlwd_probe,
 	.remove = sdhci_pltfm_unregister,
diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index 0883a2a..3280f20 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -110,6 +110,5 @@ static inline void *sdhci_pltfm_priv(struct sdhci_pltfm_host *host)
 }
 
 extern const struct dev_pm_ops sdhci_pltfm_pmops;
-#define SDHCI_PLTFM_PMOPS (&sdhci_pltfm_pmops)
 
 #endif /* _DRIVERS_MMC_SDHCI_PLTFM_H */
diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index 1d8dd35..347eae2 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -252,7 +252,7 @@ static struct platform_driver sdhci_pxav2_driver = {
 	.driver		= {
 		.name	= "sdhci-pxav2",
 		.of_match_table = of_match_ptr(sdhci_pxav2_of_match),
-		.pm	= SDHCI_PLTFM_PMOPS,
+		.pm	= &sdhci_pltfm_pmops,
 	},
 	.probe		= sdhci_pxav2_probe,
 	.remove		= sdhci_pxav2_remove,
diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index bd11998..1e93dc4 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -483,7 +483,7 @@ static struct platform_driver sdhci_tegra_driver = {
 	.driver		= {
 		.name	= "sdhci-tegra",
 		.of_match_table = sdhci_tegra_dt_match,
-		.pm	= SDHCI_PLTFM_PMOPS,
+		.pm	= &sdhci_pltfm_pmops,
 	},
 	.probe		= sdhci_tegra_probe,
 	.remove		= sdhci_pltfm_unregister,
diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
index 983b8b3..111b66f 100644
--- a/drivers/mmc/host/sdhci_f_sdh30.c
+++ b/drivers/mmc/host/sdhci_f_sdh30.c
@@ -222,7 +222,7 @@ static struct platform_driver sdhci_f_sdh30_driver = {
 	.driver = {
 		.name = "f_sdh30",
 		.of_match_table = f_sdh30_dt_ids,
-		.pm	= SDHCI_PLTFM_PMOPS,
+		.pm	= &sdhci_pltfm_pmops,
 	},
 	.probe	= sdhci_f_sdh30_probe,
 	.remove	= sdhci_f_sdh30_remove,
-- 
1.9.1

