From: Kukjin Kim <kgene.kim@samsung.com>
Subject: [PATCH v2 1/2] sdhci-s3c: Add support additional host capabilities
Date: Fri, 17 Sep 2010 18:45:00 +0900
Message-ID: <1284716701-5140-2-git-send-email-kgene.kim@samsung.com>
References: <1284716701-5140-1-git-send-email-kgene.kim@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:43930 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753391Ab0IQKEA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Sep 2010 06:04:00 -0400
In-Reply-To: <1284716701-5140-1-git-send-email-kgene.kim@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ben-linux@fluff.org, akpm@linux-foundation.org, cjb@laptop.org, Jeongbae Seo <jeongbae.seo@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>

From: Jeongbae Seo <jeongbae.seo@samsung.com>

This patch adds to support additional host capabilities
like SD/MMC high speed, SDHCI bus width and etc.

Signed-off-by: Jeongbae Seo <jeongbae.seo@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 71ad416..e6e0438 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -425,6 +425,10 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 	/* HSMMC on Samsung SoCs uses SDCLK as timeout clock */
 	host->quirks |= SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK;
 
+	/* It supports additional host capabilities if needed */
+	if (pdata->host_caps)
+		host->mmc->caps |= pdata->host_caps;
+
 	ret = sdhci_add_host(host);
 	if (ret) {
 		dev_err(dev, "sdhci_add_host() failed\n");
-- 
1.6.2.5

