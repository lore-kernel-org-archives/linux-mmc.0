From: Shawn Guo <shawn.guo@freescale.com>
Subject: [PATCH] mmc: sdhci: change CONFIG of MMC_SDHCI_TEGRA from 'tristate' to 'bool'
Date: Thu, 31 Mar 2011 09:31:19 +0800
Message-ID: <1301535079-21714-1-git-send-email-shawn.guo@freescale.com>
References: <1300114465-3769-1-git-send-email-shawn.guo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1outboundpool.messaging.microsoft.com ([216.32.181.181]:17640
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755487Ab1CaBaQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Mar 2011 21:30:16 -0400
In-Reply-To: <1300114465-3769-1-git-send-email-shawn.guo@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, lars@metafoo.de, patches@linaro.org, Shawn Guo <shawn.guo@freescale.com>, Shawn Guo <shawn.guo@linaro.org>

From: Shawn Guo <shawn.guo@linaro.org>

This config option is used to decide whether tegra sdhci support
should be build into the sdhci-platform module.  So setting it 'm'
is nonsense, since we can't build part of an module as a module.
The effect for 'm' will probably be the same as for 'n'.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
The commit message comes from the comment given by Lars-Peter Clausen
on another Naked patch :)

 drivers/mmc/host/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 94df405..b981715 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -154,7 +154,7 @@ config MMC_SDHCI_DOVE
 	  If unsure, say N.
 
 config MMC_SDHCI_TEGRA
-	tristate "SDHCI platform support for the Tegra SD/MMC Controller"
+	bool "SDHCI platform support for the Tegra SD/MMC Controller"
 	depends on MMC_SDHCI_PLTFM && ARCH_TEGRA
 	select MMC_SDHCI_IO_ACCESSORS
 	help
-- 
1.7.1


