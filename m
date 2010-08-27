From: Chris Ball <cjb@laptop.org>
Subject: [PATCH RESEND] mmc: at91_mci: add missing linux/highmem.h include
Date: Fri, 27 Aug 2010 21:10:24 +0100
Message-ID: <20100827201023.GQ23079@void.printf.net>
References: <1276968257-21016-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:55423 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751141Ab0H0UKd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 Aug 2010 16:10:33 -0400
Content-Disposition: inline
In-Reply-To: <1276968257-21016-1-git-send-email-mkl@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: akpm@linux-foundation.org, linux-mmc@vger.kernel.org, Andrew Victor <avictor.za@gmail.com>, Wolfgang Muees <wolfgang.mues@auerswald.de>

Hi Andrew,

This patch wasn't merged, and Marc adds that he think his kernel config
could have been to blame.  Looks harmless, though; want to take it?

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 19 Jun 2010 19:24:17 +0200

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

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
