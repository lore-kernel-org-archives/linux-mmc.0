From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH] ARM: multi_v7_defconfig: Enable PBIAS regulator
Date: Thu, 3 Sep 2015 15:25:11 +0530
Message-ID: <1441274111-18049-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42906 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753325AbbICJzw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 3 Sep 2015 05:55:52 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, tony@atomide.com, broonie@kernel.org, linux@arm.linux.org.uk, olof@lixom.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: nsekhar@ti.com, kishon@ti.com

PBIAS regulator is required for MMC module in OMAP2, OMAP3, OMAP4,
OMAP5 and DRA7 SoCs. Enable it here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/configs/multi_v7_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 5fd8df6..f497c96 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -403,6 +403,7 @@ CONFIG_REGULATOR_MAX8973=y
 CONFIG_REGULATOR_MAX77686=y
 CONFIG_REGULATOR_MAX77693=m
 CONFIG_REGULATOR_PALMAS=y
+CONFIG_REGULATOR_PBIAS=y
 CONFIG_REGULATOR_S2MPS11=y
 CONFIG_REGULATOR_S5M8767=y
 CONFIG_REGULATOR_TPS51632=y
-- 
1.7.9.5

