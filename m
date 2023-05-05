Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01800C77B7C
	for <linux-mmc@archiver.kernel.org>; Fri,  5 May 2023 22:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjEEWPV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 5 May 2023 18:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbjEEWPU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 5 May 2023 18:15:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACED4EC7
        for <linux-mmc@vger.kernel.org>; Fri,  5 May 2023 15:15:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pv3hp-0003oi-Hq; Sat, 06 May 2023 00:15:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pv3hm-001OQ4-JC; Sat, 06 May 2023 00:15:10 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pv3hl-001dr5-Qp; Sat, 06 May 2023 00:15:09 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     William Qiu <william.qiu@starfivetech.com>,
        linux-mmc@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] mmc: dw_mmc: Make dw_mci_pltfm_remove() return void
Date:   Sat,  6 May 2023 00:15:06 +0200
Message-Id: <20230505221506.1247424-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3862; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=b8NPveXYkALYLyFvPZ58Lmk3hmZ8EWhtUchC8u/yW7A=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkVX/prnMjYzWpe7s6eIr/zlXr4ipxr8q8Axy+M cVTlScA/WqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZFV/6QAKCRCPgPtYfRL+ TnP7CAC6lqMThHsVk7yCHu0ih5vdEMTcqv6FwnEFYtu7rlwUJdoApEgiM1/HnBVxP+QsTuv8C8k OXPErdl1ek2KyiSdUu2+GRkXgGydbu7zdAGQeYzAzVqf38Pz8pMkvDJPtKoxw/2mhTGNDULG0Om puH4UfPEDjSEDl0ijVLFyR1pQIanZWhkIuNJXdosiQrgu+CaRtNPzqqxAeWmKGJJGIFAzZu05tm GwD1BZ+FGFx5B79C7VX5AXvKdpvCL/3RJ89PJmFYvK4BAhH3Hs7wsCf+gpH9QVt6AmrOLFu8Mn6 vQ9fuOSPgIugyQGKS6OYQ9jhDdnhEk3aXWrgLGyQpWm0XCb4
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

dw_mci_pltfm_remove() returned zero unconditionally. Make it return void
instead which makes its semantics a bit clearer.

Convert the drivers that use this function as .remove() callback to
.remove_new() which has the right prototype. This helps getting rid of
the platform_driver's remove callback that returns an int (which is
error prone). The other users didn't check the return value anyhow.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/mmc/host/dw_mmc-bluefield.c | 2 +-
 drivers/mmc/host/dw_mmc-k3.c        | 2 +-
 drivers/mmc/host/dw_mmc-pltfm.c     | 5 ++---
 drivers/mmc/host/dw_mmc-pltfm.h     | 2 +-
 drivers/mmc/host/dw_mmc-starfive.c  | 2 +-
 5 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-bluefield.c b/drivers/mmc/host/dw_mmc-bluefield.c
index 10baf122bc15..4747e5698f48 100644
--- a/drivers/mmc/host/dw_mmc-bluefield.c
+++ b/drivers/mmc/host/dw_mmc-bluefield.c
@@ -52,7 +52,7 @@ static int dw_mci_bluefield_probe(struct platform_device *pdev)
 
 static struct platform_driver dw_mci_bluefield_pltfm_driver = {
 	.probe		= dw_mci_bluefield_probe,
-	.remove		= dw_mci_pltfm_remove,
+	.remove_new	= dw_mci_pltfm_remove,
 	.driver		= {
 		.name		= "dwmmc_bluefield",
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
index 0311a37dd4ab..e8ee7c43f60b 100644
--- a/drivers/mmc/host/dw_mmc-k3.c
+++ b/drivers/mmc/host/dw_mmc-k3.c
@@ -470,7 +470,7 @@ static const struct dev_pm_ops dw_mci_k3_dev_pm_ops = {
 
 static struct platform_driver dw_mci_k3_pltfm_driver = {
 	.probe		= dw_mci_k3_probe,
-	.remove		= dw_mci_pltfm_remove,
+	.remove_new	= dw_mci_pltfm_remove,
 	.driver		= {
 		.name		= "dwmmc_k3",
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index 13e55cff8237..567dce73f205 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -122,18 +122,17 @@ static int dw_mci_pltfm_probe(struct platform_device *pdev)
 	return dw_mci_pltfm_register(pdev, drv_data);
 }
 
-int dw_mci_pltfm_remove(struct platform_device *pdev)
+void dw_mci_pltfm_remove(struct platform_device *pdev)
 {
 	struct dw_mci *host = platform_get_drvdata(pdev);
 
 	dw_mci_remove(host);
-	return 0;
 }
 EXPORT_SYMBOL_GPL(dw_mci_pltfm_remove);
 
 static struct platform_driver dw_mci_pltfm_driver = {
 	.probe		= dw_mci_pltfm_probe,
-	.remove		= dw_mci_pltfm_remove,
+	.remove_new	= dw_mci_pltfm_remove,
 	.driver		= {
 		.name		= "dw_mmc",
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
diff --git a/drivers/mmc/host/dw_mmc-pltfm.h b/drivers/mmc/host/dw_mmc-pltfm.h
index 2d50d7da2e36..64cf7522a3d4 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.h
+++ b/drivers/mmc/host/dw_mmc-pltfm.h
@@ -10,7 +10,7 @@
 
 extern int dw_mci_pltfm_register(struct platform_device *pdev,
 				const struct dw_mci_drv_data *drv_data);
-extern int dw_mci_pltfm_remove(struct platform_device *pdev);
+extern void dw_mci_pltfm_remove(struct platform_device *pdev);
 extern const struct dev_pm_ops dw_mci_pltfm_pmops;
 
 #endif /* _DW_MMC_PLTFM_H_ */
diff --git a/drivers/mmc/host/dw_mmc-starfive.c b/drivers/mmc/host/dw_mmc-starfive.c
index dab1508bf83c..fd05a648a8bb 100644
--- a/drivers/mmc/host/dw_mmc-starfive.c
+++ b/drivers/mmc/host/dw_mmc-starfive.c
@@ -172,7 +172,7 @@ static int dw_mci_starfive_probe(struct platform_device *pdev)
 
 static struct platform_driver dw_mci_starfive_driver = {
 	.probe = dw_mci_starfive_probe,
-	.remove = dw_mci_pltfm_remove,
+	.remove_new = dw_mci_pltfm_remove,
 	.driver = {
 		.name = "dwmmc_starfive",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,

base-commit: 457391b0380335d5e9a5babdec90ac53928b23b4
-- 
2.39.2

