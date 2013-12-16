From: <dinguyen@altera.com>
Subject: [RESEND LIST PATCHv7 4/4] ARM: socfpga_defconfig: enable SD/MMC support
Date: Mon, 16 Dec 2013 11:04:36 -0600
Message-ID: <1387213476-22122-5-git-send-email-dinguyen@altera.com>
References: <1387213476-22122-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db9lp0252.outbound.messaging.microsoft.com ([213.199.154.252]:16294
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754973Ab3LPRGi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Dec 2013 12:06:38 -0500
In-Reply-To: <1387213476-22122-1-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinh.linux@gmail.com, arnd@arndb.de, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, heiko@sntech.de, dianders@chromium.org, alim.akhtar@samsung.com, bzhao@marvell.com, mturquette@linaro.org
Cc: zhangfei.gao@linaro.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Dinh Nguyen <dinguyen@altera.com>

From: Dinh Nguyen <dinguyen@altera.com>

Enables the dw_mmc driver for SOCFPGA.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
---
v7: none
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


