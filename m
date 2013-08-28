From: Mischa Jonker <Mischa.Jonker@synopsys.com>
Subject: [PATCH] mmc/dw_mmc: Add support for ARC
Date: Wed, 28 Aug 2013 20:40:29 +0200
Message-ID: <1377715229-2414-1-git-send-email-mjonker@synopsys.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from vaxjo.synopsys.com ([198.182.60.75]:59362 "EHLO
	vaxjo.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754008Ab3H1Skz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Aug 2013 14:40:55 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Vineet.Gupta1@synopsys.com
Cc: Mischa Jonker <Mischa.Jonker@synopsys.com>

Adapt Kconfig to include ARC in supported architectures

Signed-off-by: Mischa Jonker <mjonker@synopsys.com>
---
 drivers/mmc/host/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 8a4c066..6496d50 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -530,7 +530,7 @@ config SDH_BFIN_MISSING_CMD_PULLUP_WORKAROUND
 
 config MMC_DW
 	tristate "Synopsys DesignWare Memory Card Interface"
-	depends on ARM
+	depends on ARC || ARM
 	help
 	  This selects support for the Synopsys DesignWare Mobile Storage IP
 	  block, this provides host support for SD and MMC interfaces, in both
-- 
1.7.9.5

