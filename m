From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RESEND PATCH] ARM: multi_v7_defconfig: Enable PBIAS regulator
Date: Fri, 4 Sep 2015 17:43:15 +0530
Message-ID: <1441368795-21420-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arm@kernel.org
Cc: ulf.hansson@linaro.org, tony@atomide.com, broonie@kernel.org, linux@arm.linux.org.uk, olof@lixom.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

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
