From: akpm@linux-foundation.org
Subject: [patch 096/160] mmc: bfin_sdh: drop redundant MMC depend string
Date: Fri, 05 Mar 2010 13:43:24 -0800
Message-ID: <201003052143.o25LhOoM029749@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34427 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755337Ab0CEVn1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Mar 2010 16:43:27 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, vapier@gentoo.org, linux-mmc@vger.kernel.org

From: Mike Frysinger <vapier@gentoo.org>

The host/Kconfig file is only included when MMC is selected.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/mmc/host/Kconfig~mmc-bfin_sdh-drop-redundant-mmc-depend-string drivers/mmc/host/Kconfig
--- a/drivers/mmc/host/Kconfig~mmc-bfin_sdh-drop-redundant-mmc-depend-string
+++ a/drivers/mmc/host/Kconfig
@@ -396,7 +396,7 @@ config MMC_VIA_SDMMC
 
 config SDH_BFIN
 	tristate "Blackfin Secure Digital Host support"
-	depends on MMC && ((BF54x && !BF544) || (BF51x && !BF512))
+	depends on (BF54x && !BF544) || (BF51x && !BF512)
 	help
 	  If you say yes here you will get support for the Blackfin on-chip
 	  Secure Digital Host interface.  This includes support for MMC and
_
