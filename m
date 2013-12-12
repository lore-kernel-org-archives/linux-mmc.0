From: <dinguyen@altera.com>
Subject: [PATCHv6 5/5] ARM: socfpga_defconfig: enable SD/MMC support
Date: Thu, 12 Dec 2013 14:30:45 -0600
Message-ID: <1386880245-10192-6-git-send-email-dinguyen@altera.com>
References: <1386880245-10192-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:50023
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751849Ab3LLVG4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Dec 2013 16:06:56 -0500
In-Reply-To: <1386880245-10192-1-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinh.linux@gmail.com, arnd@arndb.de, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, heiko@sntech.de, dianders@chromium.org, alim.akhtar@samsung.com, bzhao@marvell.com, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, mturquette@linaro.org
Cc: zhangfei.gao@linaro.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dinh Nguyen <dinguyen@altera.com>

From: Dinh Nguyen <dinguyen@altera.com>

Enables the dw_mmc driver for SOCFPGA.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
---
v6: none
v5: Add dw_mmc driver into socfpga_defconfig
v4: none
v3: none
v2: none
---
 arch/arm/configs/socfpga_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index 4e1ce21..8fff96ba 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -82,3 +82,5 @@ CONFIG_DEBUG_INFO=y
 CONFIG_ENABLE_DEFAULT_TRACERS=y
 CONFIG_DEBUG_USER=y
 CONFIG_XZ_DEC=y
+CONFIG_MMC=y
+CONFIG_MMC_DW=y
-- 
1.7.9.5


