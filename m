From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH 3/3] MAINTAINERS: add entry for Atmel sdhci-of-at91 driver
Date: Fri, 3 Jul 2015 16:17:17 +0200
Message-ID: <1435933037-12889-4-git-send-email-ludovic.desroches@atmel.com>
References: <1435933037-12889-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:18267 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755456AbbGCORU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Jul 2015 10:17:20 -0400
In-Reply-To: <1435933037-12889-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: ulf.hansson@linaro.org, nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com, Ludovic Desroches <ludovic.desroches@atmel.com>

Add an entry for Atmel SDMMC device.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e7bdbac..6480ce9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1880,6 +1880,12 @@ L:	linux-mtd@lists.infradead.org
 S:	Supported
 F:	drivers/mtd/nand/atmel_nand*
 
+ATMEL SDMMC DRIVER
+M:	Ludovic Desroches <ludovic.desroches@atmel.com>
+L:	linux-mmc@vger.kernel.org
+S:	Supported
+F:	drivers/mmc/host/sdhci-of-at91.c
+
 ATMEL SPI DRIVER
 M:	Nicolas Ferre <nicolas.ferre@atmel.com>
 S:	Supported
-- 
2.2.0

