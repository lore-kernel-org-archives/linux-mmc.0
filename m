From: Andrew Bresticker <abrestic@chromium.org>
Subject: [PATCH v2 2/2] mmc: dw_mmc: Add support for MIPS
Date: Thu, 14 Aug 2014 09:45:28 -0700
Message-ID: <1408034728-4952-2-git-send-email-abrestic@chromium.org>
References: <1408034728-4952-1-git-send-email-abrestic@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f73.google.com ([209.85.219.73]:42012 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbaHNQu6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Aug 2014 12:50:58 -0400
Received: by mail-oa0-f73.google.com with SMTP id g18so328178oah.2
        for <linux-mmc@vger.kernel.org>; Thu, 14 Aug 2014 09:50:57 -0700 (PDT)
In-Reply-To: <1408034728-4952-1-git-send-email-abrestic@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Doug Anderson <dianders@chromium.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Alim Akhtar <alim.akhtar@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Andrew Bresticker <abrestic@chromium.org>

There are upcoming MIPS SoCs with dw_mmc hosts.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 drivers/mmc/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 385674b..6acc2ab 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -564,7 +564,7 @@ config SDH_BFIN_MISSING_CMD_PULLUP_WORKAROUND
 config MMC_DW
 	tristate "Synopsys DesignWare Memory Card Interface"
 	depends on HAS_DMA
-	depends on ARC || ARM || COMPILE_TEST
+	depends on ARC || ARM || MIPS || COMPILE_TEST
 	help
 	  This selects support for the Synopsys DesignWare Mobile Storage IP
 	  block, this provides host support for SD and MMC interfaces, in both
-- 
2.1.0.rc2.206.gedb03e5

