From: Peter Chen <peter.chen@nxp.com>
Subject: [PATCH 03/12] power: pwrseq: Enable COMPILE_TEST for drivers
Date: Fri, 17 Jun 2016 18:09:16 +0800
Message-ID: <1466158165-9380-4-git-send-email-peter.chen@nxp.com>
References: <1466158165-9380-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0055.outbound.protection.outlook.com ([65.55.169.55]:30439
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932139AbcFQKQM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 17 Jun 2016 06:16:12 -0400
In-Reply-To: <1466158165-9380-1-git-send-email-peter.chen@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org
Cc: k.kozlowski@samsung.com, linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org, javier@osg.samsung.com, pawel.moll@arm.com, mark.rutland@arm.com, linux-usb@vger.kernel.org, arnd@arndb.de, s.hauer@pengutronix.de, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, festevam@gmail.com, oscar@naiandei.net, stephen.boyd@linaro.org, linux-pm@vger.kernel.org, linux-mmc@vger.kernel.org

From: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Allow build testing for power sequence drivers.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
 drivers/power/pwrseq/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/pwrseq/Kconfig b/drivers/power/pwrseq/Kconfig
index 7ecd66a..c7e9271 100644
--- a/drivers/power/pwrseq/Kconfig
+++ b/drivers/power/pwrseq/Kconfig
@@ -10,7 +10,7 @@ if POWER_SEQ
 config POWER_SEQ_EMMC
 	tristate "HW reset support for eMMC"
 	default y
-	depends on OF
+	depends on OF || COMPILE_TEST
 	help
 	  This selects Hardware reset support aka pwrseq-emmc for eMMC
 	  devices. By default this option is set to y.
@@ -21,7 +21,7 @@ config POWER_SEQ_EMMC
 config POWER_SEQ_SIMPLE
 	tristate "Simple HW reset support for MMC"
 	default y
-	depends on OF
+	depends on OF || COMPILE_TEST
 	help
 	  This selects simple hardware reset support aka pwrseq-simple for MMC
 	  devices. By default this option is set to y.
-- 
1.9.1

