From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH -next v2] mmc: fix cb710 kconfig dependency warning
Date: Thu, 14 Oct 2010 11:30:55 -0700
Message-ID: <4CB74C5F.4000905@oracle.com>
References: <20101013181519.6ff00e10.randy.dunlap@oracle.com> <20101014090442.GA14454@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:20421 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754722Ab0JNSbr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Oct 2010 14:31:47 -0400
In-Reply-To: <20101014090442.GA14454@rere.qmqm.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@linux-foundation.org>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix kconfig dependency warning to satisfy dependencies:

warning: (MMC_CB710 && MMC && PCI) selects CB710_CORE which has unmet direct dependencies (MISC_DEVICES && PCI)

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Cc: <mirq-linux@rere.qmqm.pl>
---
 drivers/mmc/host/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20101013.orig/drivers/mmc/host/Kconfig
+++ linux-next-20101013/drivers/mmc/host/Kconfig
@@ -395,6 +395,7 @@ config MMC_TMIO
 config MMC_CB710
 	tristate "ENE CB710 MMC/SD Interface support"
 	depends on PCI
+	select MISC_DEVICES
 	select CB710_CORE
 	help
 	  This option enables support for MMC/SD part of ENE CB710/720 Flash
