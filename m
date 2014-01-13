From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v10 6/7] ARM: OMAP: enable SYSCON and REGULATOR_PBIAS in omap2plus_defconfig
Date: Mon, 13 Jan 2014 21:06:14 +0530
Message-ID: <1389627375-9107-7-git-send-email-balajitk@ti.com>
References: <1389279062-32291-1-git-send-email-balajitk@ti.com>
 <1389627375-9107-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40960 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751948AbaAMPgt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 13 Jan 2014 10:36:49 -0500
In-Reply-To: <1389627375-9107-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, chris@printf.net, broonie@kernel.org, tony@atomide.com
Cc: Balaji T K <balajitk@ti.com>

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

