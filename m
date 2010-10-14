From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH -next] mmc: fix cb710 kconfig dependency warning
Date: Wed, 13 Oct 2010 18:15:19 -0700
Message-ID: <20101013181519.6ff00e10.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:48751 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754420Ab0JNEEd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Oct 2010 00:04:33 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@linux-foundation.org>
Cc: Chris Ball <cjb@laptop.org>, MM <mirq-linux@rere.qmqm.pl>, linux-mmc@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix kconfig dependency warning to satisfy dependencies:

warning: (MMC_CB710 && MMC && PCI) selects CB710_CORE which has unmet direct dependencies (MISC_DEVICES && PCI)

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Cc: <mirq-linux@rere.qmqm.pl>
---
 drivers/mmc/host/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20101013.orig/drivers/mmc/host/Kconfig
+++ linux-next-20101013/drivers/mmc/host/Kconfig
@@ -394,7 +394,7 @@ config MMC_TMIO
 
 config MMC_CB710
 	tristate "ENE CB710 MMC/SD Interface support"
-	depends on PCI
+	depends on PCI && MISC_DEVICES
 	select CB710_CORE
 	help
 	  This option enables support for MMC/SD part of ENE CB710/720 Flash
