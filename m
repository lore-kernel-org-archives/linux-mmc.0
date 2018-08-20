From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH 1/2] mmc: atmel-mci: fix bad logic of sg_copy_{from,to}_buffer conversion
Date: Mon, 20 Aug 2018 10:54:44 +0200
Message-ID: <20180820085445.14632-2-ludovic.desroches@microchip.com>
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
it can't replace memcpy(buf + offset, &value, remaining) where buf is
the virtual address of the SG. Same for sg_copy_to_buffer but in the
opposite way.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Suggested-by: Douglas Gilbert <dgilbert@interlog.com>
Fixes: 5b4277814e3f ("mmc: atmel-mci: use sg_copy_{from,to}_buffer")
---
 drivers/mmc/host/atmel-mci.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 5aa2c9404e92..be53044086c7 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -1976,7 +1976,7 @@ static void atmci_read_data_pio(struct atmel_mci *host)
 	do {
 		value = atmci_readl(host, ATMCI_RDR);
 		if (likely(offset + 4 <= sg->length)) {
-			sg_pcopy_to_buffer(sg, 1, &value, sizeof(u32), offset);
+			sg_pcopy_from_buffer(sg, 1, &value, sizeof(u32), offset);
 
 			offset += 4;
 			nbytes += 4;
@@ -1993,7 +1993,7 @@ static void atmci_read_data_pio(struct atmel_mci *host)
 		} else {
 			unsigned int remaining = sg->length - offset;
 
-			sg_pcopy_to_buffer(sg, 1, &value, remaining, offset);
+			sg_pcopy_from_buffer(sg, 1, &value, remaining, offset);
 			nbytes += remaining;
 
 			flush_dcache_page(sg_page(sg));
@@ -2003,7 +2003,7 @@ static void atmci_read_data_pio(struct atmel_mci *host)
 				goto done;
 
 			offset = 4 - remaining;
-			sg_pcopy_to_buffer(sg, 1, (u8 *)&value + remaining,
+			sg_pcopy_from_buffer(sg, 1, (u8 *)&value + remaining,
 					offset, 0);
 			nbytes += offset;
 		}
@@ -2042,7 +2042,7 @@ static void atmci_write_data_pio(struct atmel_mci *host)
 
 	do {
 		if (likely(offset + 4 <= sg->length)) {
-			sg_pcopy_from_buffer(sg, 1, &value, sizeof(u32), offset);
+			sg_pcopy_to_buffer(sg, 1, &value, sizeof(u32), offset);
 			atmci_writel(host, ATMCI_TDR, value);
 
 			offset += 4;
@@ -2059,7 +2059,7 @@ static void atmci_write_data_pio(struct atmel_mci *host)
 			unsigned int remaining = sg->length - offset;
 
 			value = 0;
-			sg_pcopy_from_buffer(sg, 1, &value, remaining, offset);
+			sg_pcopy_to_buffer(sg, 1, &value, remaining, offset);
 			nbytes += remaining;
 
 			host->sg = sg = sg_next(sg);
@@ -2070,7 +2070,7 @@ static void atmci_write_data_pio(struct atmel_mci *host)
 			}
 
 			offset = 4 - remaining;
-			sg_pcopy_from_buffer(sg, 1, (u8 *)&value + remaining,
+			sg_pcopy_to_buffer(sg, 1, (u8 *)&value + remaining,
 					offset, 0);
 			atmci_writel(host, ATMCI_TDR, value);
 			nbytes += offset;
-- 
2.12.2
