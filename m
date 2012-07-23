From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 19/25] of: add const to struct *of_device_id.data
Date: Mon, 23 Jul 2012 11:13:24 +0200
Message-ID: <1343034810-3386-20-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36060 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582Ab2GWJO3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Jul 2012 05:14:29 -0400
In-Reply-To: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <rob.herring@calxeda.com>
Cc: kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>, Ben Dooks <ben-linux@fluff.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, cbe-oss-dev@lists.ozlabs.org, Chris Ball <cjb@laptop.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>kernel@pengutronix.de, Kevin Hilman <khilman@ti.com>, Kumar Gala <galak@kernel.crashing.org>, Linus Walleij <linus.walleij@stericsson.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Paul Mackerras <paulus@samba.org>, Russell King <linux@arm.linux.org.uk>, Samuel Ortiz <sameo@linux.intel.com>, spi-devel-general@lists.sourceforge.net, Timur Tabi <timur@freescale.com>, Vinod Koul <vinod.koul@intel.com>, Wim Van Sebroeck <wim@iguana.be>, Wolfram Sang <w.sang@pengutronix.de>

Drivers should never need to modify the data of a device id. So it can
be const which in turn allows more consts in the driver.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 include/linux/mod_devicetable.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_device=
table.h
index 5db9382..98fb3fe 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -224,7 +224,7 @@ struct of_device_id
 	char	type[32];
 	char	compatible[128];
 #ifdef __KERNEL__
-	void	*data;
+	const void *data;
 #else
 	kernel_ulong_t data;
 #endif
--=20
1.7.10.4

