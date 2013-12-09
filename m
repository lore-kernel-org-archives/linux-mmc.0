From: <dinguyen@altera.com>
Subject: [PATCHv5 4/4] ARM: socfpga_defconfig: enable SD/MMC support
Date: Mon, 9 Dec 2013 07:57:42 -0600
Message-ID: <1386597462-29471-5-git-send-email-dinguyen@altera.com>
References: <1386597462-29471-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:2416 "EHLO
	va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933546Ab3LIN7f (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Dec 2013 08:59:35 -0500
In-Reply-To: <1386597462-29471-1-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinh.linux@gmail.com, arnd@arndb.de, mturquette@linaro.org, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dinh Nguyen <dinguyen@altera.com>

From: Dinh Nguyen <dinguyen@altera.com>

Enables the dw_mmc driver for SOCFPGA.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
---
v5: none
v4: Added patch
v3: none
v3: none
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


