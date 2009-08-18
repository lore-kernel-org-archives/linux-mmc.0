From: akpm@linux-foundation.org
Subject: [patch 4/9] mmc: add the new linux-mmc mailing list to MAINTAINERS
Date: Tue, 18 Aug 2009 14:11:12 -0700
Message-ID: <200908182111.n7ILBCSc017248@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59679 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750728AbZHRVMX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Aug 2009 17:12:23 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, HaraldWelte@viatech.com, JosephChan@via.com.tw, ben-linux@fluff.org, drzeus@drzeus.cx, ian@mnementh.co.uk, jarkko.lavinen@nokia.com, linux-mmc@vger.kernel.org, manuel.lauss@gmail.com, nico@cam.org, ppisa@pikron.com, saschasommer@freenet.de

From: Andrew Morton <akpm@linux-foundation.org>

There are a number of individual MMC drivers listed in MAINTAINERS.  I
didn't modify those records.  Perhaps I should have.

Cc: <linux-mmc@vger.kernel.org>
Cc: Manuel Lauss <manuel.lauss@gmail.com>
Cc: Nicolas Pitre <nico@cam.org>
Cc: Pierre Ossman <drzeus@drzeus.cx>
Cc: Pavel Pisa <ppisa@pikron.com>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Sascha Sommer <saschasommer@freenet.de>
Cc: Ian Molton <ian@mnementh.co.uk>
Cc: Joseph Chan <JosephChan@via.com.tw>
Cc: Harald Welte <HaraldWelte@viatech.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 MAINTAINERS |    1 +
 1 file changed, 1 insertion(+)

diff -puN MAINTAINERS~mmc-add-the-new-linux-mmc-mailing-list-to-maintainers MAINTAINERS
--- a/MAINTAINERS~mmc-add-the-new-linux-mmc-mailing-list-to-maintainers
+++ a/MAINTAINERS
@@ -3429,6 +3429,7 @@ F:	drivers/mfd/
 
 MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND SDIO SUBSYSTEM
 S:	Orphan
+L:	linux-mmc@vger.kernel.org
 F:	drivers/mmc/
 F:	include/linux/mmc/
 
_
