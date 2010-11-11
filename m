From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 4/6] dma: shdma: increase the number of DMA descriptors and
 add a MODULE_ALIAS()
Date: Thu, 11 Nov 2010 08:40:57 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1011110834130.15747@axis700.grange>
References: <Pine.LNX.4.64.1011110815070.15747@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:40515 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1757794Ab0KKHk4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 11 Nov 2010 02:40:56 -0500
In-Reply-To: <Pine.LNX.4.64.1011110815070.15747@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Yusuke Goda <yusuke.goda.sx@renesas.com>, Dan Williams <dan.j.williams@intel.com>

Currently shdma only works, if it manages to allocate DMA descriptors for all
sg elements during the prepare stage. Allocation is carried out from a
static pool of 32 DMA descriptors. This is not enough for, e.g., MMC, where up
to 61 sg elements can be sent at once. Ideally we should be able to reuse
descriptors, while processing one request, but for now increase their number
to 64.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/dma/shdma.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index eb6b54d..85dd0ad 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -39,7 +39,7 @@ enum sh_dmae_desc_status {
 	DESC_WAITING,	/* callback called, waiting for ack / re-submit */
 };
 
-#define NR_DESCS_PER_CHANNEL 32
+#define NR_DESCS_PER_CHANNEL 64
 /* Default MEMCPY transfer size = 2^2 = 4 bytes */
 #define LOG2_DEFAULT_XFER_SIZE	2
 
@@ -1213,3 +1213,4 @@ module_exit(sh_dmae_exit);
 MODULE_AUTHOR("Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>");
 MODULE_DESCRIPTION("Renesas SH DMA Engine driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:sh-dma-engine");
-- 
1.7.2.3

