From: akpm@linux-foundation.org
Subject: [patch 094/160] mmc: Atmel host kconfig cleanup for everyone else
Date: Fri, 05 Mar 2010 13:43:22 -0800
Message-ID: <201003052143.o25LhMtJ029741@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51062 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755358Ab0CEVnb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Mar 2010 16:43:31 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, nicolas.ferre@atmel.com, jic23@cam.ac.uk, linux-mmc@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@atmel.com>

This prevents those without an Atmel chip having a line in kernel
configuration which says "Atmel SD/MMC Driver" without any option.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff -puN drivers/mmc/host/Kconfig~mmc-atmel-host-kconfig-cleanup-for-everyone-else drivers/mmc/host/Kconfig
--- a/drivers/mmc/host/Kconfig~mmc-atmel-host-kconfig-cleanup-for-everyone-else
+++ a/drivers/mmc/host/Kconfig
@@ -189,6 +189,7 @@ config MMC_AU1X
 
 choice
 	prompt "Atmel SD/MMC Driver"
+	depends on AVR32 || ARCH_AT91
 	default MMC_ATMELMCI if AVR32
 	help
 	  Choose which driver to use for the Atmel MCI Silicon
_
