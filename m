From: Hein Tibosch <hein_tibosch@yahoo.es>
Subject: [PATCH] avr32-linux: at32ap700x: set DMA slave properties for MCI
 dw_dmac
Date: Mon, 27 Aug 2012 04:56:55 +0800
Message-ID: <503A8D97.4070403@yahoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: egtvedt@samfundet.no, Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, "ludovic.desroches" <ludovic.desroches@atmel.com>, Havard Skinnemoen <havard@skinnemoen.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

@Andrew: could you please push the patch below? Hans-Christian
doesn't have a GIT tree on kernel.org

Thanks, Hein

The MCI makes use of the dw_dmac driver when DMA is being used.
Due to recent changes the driver was broken because:
- the SMS field in the CTLL register received the wrong value 0
- a patch in dw_dmac allowed for 64-bit transfers on the
memory side, giving an illegal value of 3 in the SRC/DST_TR_WIDTH
register.
This patch sets the SMS to 1 and limits the maximum transfer
width to 2 (32 bits)

Note: this can only be applied after my patch:
[PATCH 2/2] dw_dmac: max_mem_width limits value for
SRC/DST_TR_WID register

Signed-off-by: Hein Tibosch <hein_tibosch@yahoo.es>
---
 arch/avr32/mach-at32ap/at32ap700x.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)
 diff --git a/arch/avr32/mach-at32ap/at32ap700x.c b/arch/avr32/mach-at32ap/at32ap700x.c
index 0445c4f..e7202af 100644
--- a/arch/avr32/mach-at32ap/at32ap700x.c
+++ b/arch/avr32/mach-at32ap/at32ap700x.c
@@ -1355,6 +1355,10 @@ at32_add_device_mci(unsigned int id, struct mci_platform_data *data)
 				| DWC_CFGH_DST_PER(1));
 	slave->sdata.cfg_lo &= ~(DWC_CFGL_HS_DST_POL
 				| DWC_CFGL_HS_SRC_POL);
+	/* Give CTLL SMS value 1 */
+	slave->sdata.src_master = 1;
+	/* SRC/DST_TR_WIDTH register only accepts 0,1,2 */
+	slave->sdata.max_mem_width = 2;
 
 	data->dma_slave = slave;
 
-- 
1.7.8.0
