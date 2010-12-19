From: Arnd Hannemann <arnd@arndnet.de>
Subject: [PATCH] mmc: tmio_mmc: silence compiler warnings
Date: Sun, 19 Dec 2010 21:16:07 +0000
Message-ID: <1292793367-5638-1-git-send-email-arnd@arndnet.de>
References: <Pine.LNX.4.64.1011231723090.25676@axis700.grange>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1011231723090.25676@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: g.liakhovetski@gmx.de, linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>, Arnd Hannemann <arnd@arndnet.de>
List-Id: linux-mmc@vger.kernel.org

with "mmc: tmio: implement a bounce buffer for unaligned DMA"
gcc generates the following warnings:

drivers/mmc/host/tmio_mmc.c:654:6: warning: 'ret' may be used uninitialized in this function
drivers/mmc/host/tmio_mmc.c:730:6: warning: 'ret' may be used uninitialized in this function

This patch fixes these by setting ret to -EINVAL in the affected code paths.

This patch applies on top of -rc6 plus the following patches:
  mmc: tmio_mmc: allow multi-element scatter-gather lists
  mmc: tmio_mmc: fix PIO fallback on DMA descriptor allocation failure
  mmc: tmio: merge the private header into the driver
  mmc: tmio: implement a bounce buffer for unaligned DMA

Signed-off-by: Arnd Hannemann <arnd@arndnet.de>
---
 drivers/mmc/host/tmio_mmc.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index 57ece9d..61e97d1 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -665,8 +665,10 @@ static void tmio_mmc_start_dma_rx(struct tmio_mmc_host *host)
 	}
 
 	if ((!aligned && (host->sg_len > 1 || sg->length > PAGE_CACHE_SIZE ||
-			  align >= MAX_ALIGN)) || !multiple)
+			  align >= MAX_ALIGN)) || !multiple) {
+		ret = -EINVAL;
 		goto pio;
+	}
 
 	/* The only sg element can be unaligned, use our bounce buffer then */
 	if (!aligned) {
@@ -741,8 +743,10 @@ static void tmio_mmc_start_dma_tx(struct tmio_mmc_host *host)
 	}
 
 	if ((!aligned && (host->sg_len > 1 || sg->length > PAGE_CACHE_SIZE ||
-			  align >= MAX_ALIGN)) || !multiple)
+			  align >= MAX_ALIGN)) || !multiple) {
+		ret = -EINVAL;
 		goto pio;
+	}
 
 	/* The only sg element can be unaligned, use our bounce buffer then */
 	if (!aligned) {
-- 
1.7.2.3

