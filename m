From: Kukjin Kim <kgene.kim@samsung.com>
Subject: [PATCH RESEND 1/2] sdhci-s3c: Add support additional host capabilities
Date: Fri,  8 Oct 2010 17:46:20 +0900
Message-ID: <1286527581-24903-2-git-send-email-kgene.kim@samsung.com>
References: <1286527581-24903-1-git-send-email-kgene.kim@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:34498 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754237Ab0JHIzC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Oct 2010 04:55:02 -0400
In-Reply-To: <1286527581-24903-1-git-send-email-kgene.kim@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ben-linux@fluff.org, akpm@linux-foundation.org, cjb@laptop.org, Jeongbae Seo <jeongbae.seo@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>

From: Jeongbae Seo <jeongbae.seo@samsung.com>

This patch adds to support additional host capabilities like SD/MMC high speed, SDHCI bus width and
etc.

Signed-off-by: Jeongbae Seo <jeongbae.seo@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index aacb862..a7710f5 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -427,6 +427,10 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
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

