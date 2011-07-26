From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/2] MMC / TMIO: Fix build issue related to struct scatterlist
Date: Tue, 26 Jul 2011 20:50:23 +0200
Message-ID: <201107262050.23379.rjw@sisk.pl>
References: <201107262049.15333.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:51890 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753079Ab1GZSuO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 26 Jul 2011 14:50:14 -0400
In-Reply-To: <201107262049.15333.rjw@sisk.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Fix build issue caused by undefined struct scatterlist in
drivers/mmc/host/tmio_mmc.c.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/mmc/host/tmio_mmc.h      |    1 +
 drivers/usb/renesas_usbhs/fifo.c |    1 +
 2 files changed, 2 insertions(+)

Index: linux-2.6/drivers/mmc/host/tmio_mmc.h
===================================================================
--- linux-2.6.orig/drivers/mmc/host/tmio_mmc.h
+++ linux-2.6/drivers/mmc/host/tmio_mmc.h
@@ -21,6 +21,7 @@
 #include <linux/mutex.h>
 #include <linux/pagemap.h>
 #include <linux/spinlock.h>
+#include <linux/scatterlist.h>
 
 /* Definitions for values the CTRL_SDIO_STATUS register can take. */
 #define TMIO_SDIO_STAT_IOIRQ	0x0001

