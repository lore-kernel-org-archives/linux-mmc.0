From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] mmc: at91_mci: add missing linux/highmem.h include
Date: Sat, 19 Jun 2010 19:24:17 +0200
Message-ID: <1276968257-21016-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44876 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003Ab0FSRYX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 19 Jun 2010 13:24:23 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Andrew Victor <avictor.za@gmail.com>, Wolfgang Muees <wolfgang.mues@auerswald.de>

This patch fixes the following error:

at91_mci.c: In function 'at91_mci_sg_to_dma':
at91_mci.c:236: error: implicit declaration of function 'kmap_atomic'
at91_mci.c:236: error: 'KM_BIO_SRC_IRQ' undeclared (first use in this function)
at91_mci.c:236: error: (Each undeclared identifier is reported only once
at91_mci.c:236: error: for each function it appears in.)
at91_mci.c:236: warning: assignment makes pointer from integer without a cast
at91_mci.c:252: error: implicit declaration of function 'kunmap_atomic'
at91_mci.c: In function 'at91_mci_post_dma_read':
at91_mci.c:302: error: 'KM_BIO_SRC_IRQ' undeclared (first use in this function)
at91_mci.c:302: warning: assignment makes pointer from integer without a cast
at91_mci.c:317: error: implicit declaration of function 'flush_kernel_dcache_page'

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Andrew Victor <avictor.za@gmail.com>
Cc: Wolfgang Muees <wolfgang.mues@auerswald.de>
---
 drivers/mmc/host/at91_mci.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/at91_mci.c b/drivers/mmc/host/at91_mci.c
index 5f3a599..87226cd 100644
--- a/drivers/mmc/host/at91_mci.c
+++ b/drivers/mmc/host/at91_mci.c
@@ -66,6 +66,7 @@
 #include <linux/clk.h>
 #include <linux/atmel_pdc.h>
 #include <linux/gfp.h>
+#include <linux/highmem.h>
 
 #include <linux/mmc/host.h>
 
-- 
1.7.1

