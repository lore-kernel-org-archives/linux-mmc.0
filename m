From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 6/6] mmc i.MX sdhci: use IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX to depend on
Date: Thu,  3 Mar 2011 14:31:00 +0100
Message-ID: <1299159060-9289-7-git-send-email-s.hauer@pengutronix.de>
References: <1299159060-9289-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33191 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928Ab1CCNbS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Mar 2011 08:31:18 -0500
In-Reply-To: <1299159060-9289-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

The i.MX architecture provides IMX_HAVE_PLATFORM_* macros to signal
that a selected SoC supports a certain hardware. Use them instead of
depending on ARCH_* directly.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Cc: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org
---
 drivers/mmc/host/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index afe8c6f..326d78b 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -134,7 +134,7 @@ config MMC_SDHCI_CNS3XXX
=20
 config MMC_SDHCI_ESDHC_IMX
 	bool "SDHCI platform support for the Freescale eSDHC i.MX controller"
-	depends on MMC_SDHCI_PLTFM && (ARCH_MX25 || ARCH_MX35 || ARCH_MX5)
+	depends on MMC_SDHCI_PLTFM && IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	select MMC_SDHCI_IO_ACCESSORS
 	help
 	  This selects the Freescale eSDHC controller support on the platform
--=20
1.7.2.3

