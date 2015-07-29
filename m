From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH v2 3/3] MAINTAINERS: add entry for Atmel sdhci-of-at91 driver
Date: Wed, 29 Jul 2015 16:22:48 +0200
Message-ID: <1438179768-818-4-git-send-email-ludovic.desroches@atmel.com>
References: <1438179768-818-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438179768-818-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: ulf.hansson@linaro.org, nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com, pebolle@tiscali.nl, arnd@arndb.de, Ludovic Desroches <ludovic.desroches@atmel.com>
List-Id: linux-mmc@vger.kernel.org

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
2.5.0
