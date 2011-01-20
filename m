From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] mmc: mmc_mxc: Allow selection only for the correct platforms
Date: Thu, 20 Jan 2011 15:02:59 -0200
Message-ID: <1295542979-10329-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe001.messaging.microsoft.com ([213.199.154.204]:18732
	"EHLO AM1EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752039Ab1ATQ4G (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Jan 2011 11:56:06 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, kernel@pengutronix.de, u.kleine-koenig@pengutronix.de, linux-arm-kernel@lists.infradead.org, Fabio Estevam <fabio.estevam@freescale.com>

Currently MMC_MXC driver can be selected by all i.MX devices.

Restrict its use only for the appropriate processors.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/mmc/host/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index d618e86..a3a9ec1 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -288,7 +288,7 @@ config MMC_MSM
 
 config MMC_MXC
 	tristate "Freescale i.MX2/3 Multimedia Card Interface support"
-	depends on ARCH_MXC
+	depends on MACH_MX21 || MACH_MX27 || ARCH_MX31
 	help
 	  This selects the Freescale i.MX2/3 Multimedia card Interface.
 	  If you have a i.MX platform with a Multimedia Card slot,
-- 
1.6.0.4


