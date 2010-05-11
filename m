From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH] MMC: at91_mci: modify cache flush routines
Date: Tue, 11 May 2010 19:09:53 +0200
Message-ID: <1273597793-28104-1-git-send-email-nicolas.ferre@atmel.com>
References: <20100511134409.GB27201@n2100.arm.linux.org.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100511134409.GB27201@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, linux-mmc@vger.kernel.org, avictor.za@gmail.com, linux@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>
List-Id: linux-mmc@vger.kernel.org

As we were using an internal dma flushing routine, this patch changes to the
DMA API flush_kernel_dcache_page(). Driver is able to compile now.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/mmc/host/at91_mci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/at91_mci.c b/drivers/mmc/host/at91_mci.c
index a6dd7da..813d208 100644
--- a/drivers/mmc/host/at91_mci.c
+++ b/drivers/mmc/host/at91_mci.c
@@ -315,7 +315,7 @@ static void at91_mci_post_dma_read(struct at91mci_host *host)
 		}
 
 		kunmap_atomic(sgbuffer, KM_BIO_SRC_IRQ);
-		dmac_flush_range((void *)sgbuffer, ((void *)sgbuffer) + amount);
+		flush_kernel_dcache_page(sg_page(sg));
 		data->bytes_xfered += amount;
 		if (size == 0)
 			break;
-- 
1.5.6.5
