Return-Path: <SRS0=5biu=AE=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DF2C433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Jun 2020 04:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C13E2065D
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Jun 2020 04:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgFWESc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 23 Jun 2020 00:18:32 -0400
Received: from inva021.nxp.com ([92.121.34.21]:55466 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728386AbgFWESc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 23 Jun 2020 00:18:32 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A55BE200015;
        Tue, 23 Jun 2020 06:18:29 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 634B520002C;
        Tue, 23 Jun 2020 06:18:25 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id ED23B4029C;
        Tue, 23 Jun 2020 12:18:19 +0800 (SGT)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, jh80.chung@samsung.com,
        kgene@kernel.org, krzk@kernel.org, michal.simek@xilinx.com,
        linux-samsung-soc@vger.kernel.org
Cc:     linux-imx@nxp.com, haibo.chen@nxp.com
Subject: [PATCH] mmc: host: dereference null return value
Date:   Tue, 23 Jun 2020 12:06:49 +0800
Message-Id: <1592885209-25839-1-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

of_match_node() has the opportunity to return NULL, so need to
dereference null return value.
This is reported by Coverity.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/dw_mmc-exynos.c   | 5 +++--
 drivers/mmc/host/dw_mmc-k3.c       | 5 +++--
 drivers/mmc/host/dw_mmc-pltfm.c    | 3 ++-
 drivers/mmc/host/sdhci-of-arasan.c | 2 ++
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 5e3d95b63676..27ab55abb03f 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -545,12 +545,13 @@ MODULE_DEVICE_TABLE(of, dw_mci_exynos_match);
 
 static int dw_mci_exynos_probe(struct platform_device *pdev)
 {
-	const struct dw_mci_drv_data *drv_data;
+	const struct dw_mci_drv_data *drv_data = NULL;
 	const struct of_device_id *match;
 	int ret;
 
 	match = of_match_node(dw_mci_exynos_match, pdev->dev.of_node);
-	drv_data = match->data;
+	if (match)
+		drv_data = match->data;
 
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
index 50977ff18074..e8a148c306b3 100644
--- a/drivers/mmc/host/dw_mmc-k3.c
+++ b/drivers/mmc/host/dw_mmc-k3.c
@@ -451,11 +451,12 @@ MODULE_DEVICE_TABLE(of, dw_mci_k3_match);
 
 static int dw_mci_k3_probe(struct platform_device *pdev)
 {
-	const struct dw_mci_drv_data *drv_data;
+	const struct dw_mci_drv_data *drv_data = NULL;
 	const struct of_device_id *match;
 
 	match = of_match_node(dw_mci_k3_match, pdev->dev.of_node);
-	drv_data = match->data;
+	if (match)
+		drv_data = match->data;
 
 	return dw_mci_pltfm_register(pdev, drv_data);
 }
diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index 7de37f524a96..d3dcb96efd13 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -78,7 +78,8 @@ static int dw_mci_pltfm_probe(struct platform_device *pdev)
 
 	if (pdev->dev.of_node) {
 		match = of_match_node(dw_mci_pltfm_match, pdev->dev.of_node);
-		drv_data = match->data;
+		if (match)
+			drv_data = match->data;
 	}
 
 	return dw_mci_pltfm_register(pdev, drv_data);
diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index fb26e743e1fd..f2090f944a0e 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -1520,6 +1520,8 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	const struct sdhci_arasan_of_data *data;
 
 	match = of_match_node(sdhci_arasan_of_match, pdev->dev.of_node);
+	if (match == NULL)
+		return -ENOPARAM;
 	data = match->data;
 	host = sdhci_pltfm_init(pdev, data->pdata, sizeof(*sdhci_arasan));
 
-- 
2.17.1

