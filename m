From: Hein Tibosch <hein_tibosch@yahoo.es>
Subject: [PATCH v2] avr32: at32ap700x: set DMA slave properties for MCI dw_dmac
Date: Fri, 31 Aug 2012 01:07:13 +0800
Message-ID: <503F9DC1.9030601@yahoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans-Christian Egtvedt <egtvedt@samfundet.no>, Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, "ludovic.desroches" <ludovic.desroches@atmel.com>, Havard Skinnemoen <havard@skinnemoen.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

The MCI makes use of the dw_dmac driver when DMA is being used.
Due to recent changes the driver was broken because:
- the SMS field in the CTLL register received the wrong value 0
- a patch in dw_dmac (http://lkml.org/lkml/2012/1/18/52)
allowed for 64-bit transfers on the memory side, giving an illegal
value of 3 in the SRC/DST_TR_WIDTH register.

This patch sets the SMS (Source Master Select) to 1 and limits
the maximum transfer width to 32 bits.

Note: this can only be applied after my patch:
[PATCH v2 2/2] dw_dmac: max_mem_width limits value for
SRC/DST_TR_WID register

Signed-off-by: Hein Tibosch <hein_tibosch@yahoo.es>

---
 arch/avr32/mach-at32ap/at32ap700x.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/avr32/mach-at32ap/at32ap700x.c b/arch/avr32/mach-at32ap/at32ap700x.c
index 0445c4f..7250c70 100644
--- a/arch/avr32/mach-at32ap/at32ap700x.c
+++ b/arch/avr32/mach-at32ap/at32ap700x.c
@@ -1356,6 +1356,11 @@ at32_add_device_mci(unsigned int id, struct mci_platform_data *data)
 	slave->sdata.cfg_lo &= ~(DWC_CFGL_HS_DST_POL
 				| DWC_CFGL_HS_SRC_POL);
 
+	/* Setup DMA controller: let source be master */
+	slave->sdata.src_master = 1;
+	/* Limit maximum transfer width to 32-bit */
+	slave->sdata.max_mem_width = DW_MEM_WIDTH_32;
+
 	data->dma_slave = slave;
 
 	if (platform_device_add_data(pdev, data,
-- 
1.7.8.0
