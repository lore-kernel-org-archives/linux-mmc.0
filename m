From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH] mmc: omap_hsmmc: fix dependency on indirect header inclusion
Date: Thu, 11 Jul 2013 16:09:05 +0300
Message-ID: <1373548145-3833-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>, a-bindra@ti.com, Tony Lindgren <tony@atomide.com>, ezequiel.garcia@free-electrons.com, nm@ti.com, Felipe Balbi <balbi@ti.com>
List-Id: linux-mmc@vger.kernel.org

omap_hsmmc.c depends on <linux/sizes.h> being
included indirectly by another header. Once we
enable COMPILE_TEST for this driver, we might
compile under architectures which won't include
<linux/sizes.h> for us. In fact, one such case
is x86.

In order to prevent compile breakages, let's
explicitly include <linux/sizes.h>

Signed-off-by: Felipe Balbi <balbi@ti.com>
---

This should be applied before http://marc.info/?l=linux-omap&m=137347241524118&w=2
in order to maintain bisectability.

cheers

 drivers/mmc/host/omap_hsmmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 1865321..c937ffc 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -21,6 +21,7 @@
 #include <linux/debugfs.h>
 #include <linux/dmaengine.h>
 #include <linux/seq_file.h>
+#include <linux/sizes.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
-- 
1.8.2.1

