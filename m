From: akpm@linux-foundation.org
Subject: [patch 002/200] sdhci: orphan driver and list
Date: Mon, 21 Sep 2009 17:00:59 -0700
Message-ID: <200909220000.n8M00xNn026275@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53685 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754656AbZIVABe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Sep 2009 20:01:34 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, pierre@ossman.eu, linux-mmc@vger.kernel.org

From: Pierre Ossman <pierre@ossman.eu>

Remove myself as maintainer from the sdhci driver and steer people
towards the new MMC list for discussing it.

Signed-off-by: Pierre Ossman <pierre@ossman.eu>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 MAINTAINERS |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff -puN MAINTAINERS~sdhci-orphan-driver-and-list MAINTAINERS
--- a/MAINTAINERS~sdhci-orphan-driver-and-list
+++ a/MAINTAINERS
@@ -4533,20 +4533,20 @@ S:	Maintained
 F:	drivers/mmc/host/sdricoh_cs.c
 
 SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) DRIVER
-M:	Pierre Ossman <pierre@ossman.eu>
-L:	sdhci-devel@lists.ossman.eu
-S:	Maintained
+S:     Orphan
+L:     linux-mmc@vger.kernel.org
+F:     drivers/mmc/host/sdhci.*
 
 SECURE DIGITAL HOST CONTROLLER INTERFACE, OPEN FIRMWARE BINDINGS (SDHCI-OF)
 M:	Anton Vorontsov <avorontsov@ru.mvista.com>
 L:	linuxppc-dev@ozlabs.org
-L:	sdhci-devel@lists.ossman.eu
+L:     linux-mmc@vger.kernel.org
 S:	Maintained
-F:	drivers/mmc/host/sdhci.*
+F:     drivers/mmc/host/sdhci-of.*
 
 SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) SAMSUNG DRIVER
 M:	Ben Dooks <ben-linux@fluff.org>
-L:	sdhci-devel@lists.ossman.eu
+L:     linux-mmc@vger.kernel.org
 S:	Maintained
 F:	drivers/mmc/host/sdhci-s3c.c
 
_
