From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH 2/2] mmc: android-goldfish: fix bad logic of sg_copy_{from,to}_buffer conversion
Date: Mon, 20 Aug 2018 10:54:45 +0200
Message-ID: <20180820085445.14632-3-ludovic.desroches@microchip.com>
References: <20180820085445.14632-1-ludovic.desroches@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180820085445.14632-1-ludovic.desroches@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: ulf.hansson@linaro.org, linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, dgilbert@interlog.com, Ludovic Desroches <ludovic.desroches@microchip.com>
List-Id: linux-mmc@vger.kernel.org

The conversion to sg_copy_{from,to}_buffer has been done in the wrong
way. sg_copy_to_buffer is a copy from an SG list to a linear buffer so
it can't replace memcpy(dest, host->virt_base, data->sg->length) where
dest is the virtual address of the SG. Same for sg_copy_from_buffer
but in the opposite way.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Suggested-by: Douglas Gilbert <dgilbert@interlog.com>
Fixes: 53d7e098ba08 ("mmc: android-goldfish: use sg_copy_{from,to}_buffer")
---
 drivers/mmc/host/android-goldfish.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/android-goldfish.c b/drivers/mmc/host/android-goldfish.c
index 294de177632c..61e4e2a213c9 100644
--- a/drivers/mmc/host/android-goldfish.c
+++ b/drivers/mmc/host/android-goldfish.c
@@ -217,7 +217,7 @@ static void goldfish_mmc_xfer_done(struct goldfish_mmc_host *host,
 			 * We don't really have DMA, so we need
 			 * to copy from our platform driver buffer
 			 */
-			sg_copy_to_buffer(data->sg, 1, host->virt_base,
+			sg_copy_from_buffer(data->sg, 1, host->virt_base,
 					data->sg->length);
 		}
 		host->data->bytes_xfered += data->sg->length;
@@ -393,7 +393,7 @@ static void goldfish_mmc_prepare_data(struct goldfish_mmc_host *host,
 		 * We don't really have DMA, so we need to copy to our
 		 * platform driver buffer
 		 */
-		sg_copy_from_buffer(data->sg, 1, host->virt_base,
+		sg_copy_to_buffer(data->sg, 1, host->virt_base,
 				data->sg->length);
 	}
 }
-- 
2.12.2
