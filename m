From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v9 6/7] ARM: OMAP: enable SYSCON and REGULATOR_PBIAS in omap2plus_defconfig
Date: Fri, 10 Jan 2014 23:00:47 +0530
Message-ID: <1389375049-5248-7-git-send-email-balajitk@ti.com>
References: <1389279062-32291-1-git-send-email-balajitk@ti.com>
 <1389375049-5248-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1389375049-5248-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, chris@printf.net, broonie@kernel.org, tony@atomide.com
Cc: mark.rutland@arm.com, Balaji T K <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

Enable REGULATOR_PBIAS needed for SD card on most OMAPs.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index bfa80a1..f67baa9 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -169,6 +169,7 @@ CONFIG_DRA752_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_OMAP_WATCHDOG=y
 CONFIG_TWL4030_WATCHDOG=y
+CONFIG_MFD_SYSCON=y
 CONFIG_MFD_PALMAS=y
 CONFIG_MFD_TPS65217=y
 CONFIG_MFD_TPS65910=y
@@ -180,6 +181,7 @@ CONFIG_REGULATOR_TPS6507X=y
 CONFIG_REGULATOR_TPS65217=y
 CONFIG_REGULATOR_TPS65910=y
 CONFIG_REGULATOR_TWL4030=y
+CONFIG_REGULATOR_PBIAS=y
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_MODE_HELPERS=y
-- 
1.7.5.4

