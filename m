From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH RESEND 6/7] mmc: host: dw_mmc: change idmac descriptor files to __le32
Date: Wed, 25 Mar 2015 11:27:51 +0000
Message-ID: <1427282872-10563-7-git-send-email-ben.dooks@codethink.co.uk>
References: <1427282872-10563-1-git-send-email-ben.dooks@codethink.co.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:52432 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500AbbCYL2A (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Mar 2015 07:28:00 -0400
In-Reply-To: <1427282872-10563-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@lists.codethink.co.uk, marc.dunford@codethink.co.uk, sam.bishop@codethink.co.uk, Dinh Nguyen <dinguyen@opensource.altera.com>, Ben Dooks <ben.dooks@codethink.co.uk>, Linux MCC <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>

The dw_mmc driver does not take into account the processor may be in
big endian when writing the descriptors. Change the descriptors for
the 32bit IDMA to use __le32 and ensure they are suitably swapped
before writing.

Note, this has not been tested as the socfpga driver does not try to
use idma.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
CC: Linux MCC <linux-mmc@vger.kernel.org>
CC: Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
CC: Dinh Nguyen <dinguyen@opensource.altera.com>
CC: Chris Ball <chris@printf.net>
CC: Ulf Hansson <ulf.hansson@linaro.org>
CC: Jaehoon Chung <jh80.chung@samsung.com>
CC: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 4d2e3c2..12e681c 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -69,7 +69,7 @@ struct idmac_desc_64addr {
 
 	u32		des2;	/*Buffer sizes */
 #define IDMAC_64ADDR_SET_BUFFER1_SIZE(d, s) \
-	((d)->des2 = ((d)->des2 & 0x03ffe000) | ((s) & 0x1fff))
+	((d)->des2 = ((d)->des2 & cpu_to_le32(0x03ffe000)) | ((cpu_to_le32(s)) & cpu_to_le32(0x1fff)))
 
 	u32		des3;	/* Reserved */
 
@@ -81,7 +81,7 @@ struct idmac_desc_64addr {
 };
 
 struct idmac_desc {
-	u32		des0;	/* Control Descriptor */
+	__le32		des0;	/* Control Descriptor */
 #define IDMAC_DES0_DIC	BIT(1)
 #define IDMAC_DES0_LD	BIT(2)
 #define IDMAC_DES0_FD	BIT(3)
@@ -90,13 +90,13 @@ struct idmac_desc {
 #define IDMAC_DES0_CES	BIT(30)
 #define IDMAC_DES0_OWN	BIT(31)
 
-	u32		des1;	/* Buffer sizes */
+	__le32		des1;	/* Buffer sizes */
 #define IDMAC_SET_BUFFER1_SIZE(d, s) \
 	((d)->des1 = ((d)->des1 & 0x03ffe000) | ((s) & 0x1fff))
 
-	u32		des2;	/* buffer 1 physical address */
+	__le32		des2;	/* buffer 1 physical address */
 
-	u32		des3;	/* buffer 2 physical address */
+	__le32		des3;	/* buffer 2 physical address */
 };
 #endif /* CONFIG_MMC_DW_IDMAC */
 
@@ -477,23 +477,23 @@ static void dw_mci_translate_sglist(struct dw_mci *host, struct mmc_data *data,
 			 * Set the OWN bit and disable interrupts for this
 			 * descriptor
 			 */
-			desc->des0 = IDMAC_DES0_OWN | IDMAC_DES0_DIC |
-						IDMAC_DES0_CH;
+			desc->des0 = cpu_to_le32(IDMAC_DES0_OWN | IDMAC_DES0_DIC |
+						 IDMAC_DES0_CH);
 			/* Buffer length */
 			IDMAC_SET_BUFFER1_SIZE(desc, length);
 
 			/* Physical address to DMA to/from */
-			desc->des2 = mem_addr;
+			desc->des2 = cpu_to_le32(mem_addr);
 		}
 
 		/* Set first descriptor */
 		desc = host->sg_cpu;
-		desc->des0 |= IDMAC_DES0_FD;
+		desc->des0 |= cpu_to_le32(IDMAC_DES0_FD);
 
 		/* Set last descriptor */
 		desc = host->sg_cpu + (i - 1) * sizeof(struct idmac_desc);
-		desc->des0 &= ~(IDMAC_DES0_CH | IDMAC_DES0_DIC);
-		desc->des0 |= IDMAC_DES0_LD;
+		desc->des0 &= cpu_to_le32(~(IDMAC_DES0_CH | IDMAC_DES0_DIC));
+		desc->des0 |= cpu_to_le32(IDMAC_DES0_LD);
 	}
 
 	wmb();
@@ -562,12 +562,12 @@ static int dw_mci_idmac_init(struct dw_mci *host)
 
 		/* Forward link the descriptor list */
 		for (i = 0, p = host->sg_cpu; i < host->ring_size - 1; i++, p++)
-			p->des3 = host->sg_dma + (sizeof(struct idmac_desc) *
-								(i + 1));
+			p->des3 = cpu_to_le32(host->sg_dma + (sizeof(struct idmac_desc) *
+							      (i + 1)));
 
 		/* Set the last descriptor as the end-of-ring descriptor */
-		p->des3 = host->sg_dma;
-		p->des0 = IDMAC_DES0_ER;
+		p->des3 = cpu_to_le32(host->sg_dma);
+		p->des0 = cpu_to_le32(IDMAC_DES0_ER);
 	}
 
 	dw_mci_idmac_reset(host);
-- 
2.1.4

