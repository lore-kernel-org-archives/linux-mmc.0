From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 1/4] mmc: dw_mmc: split out preparation of desc for IDMAC32 and IDMAC64
Date: Fri,  2 Sep 2016 12:14:36 +0800
Message-ID: <1472789679-15121-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

We intend to add more check for descriptors when
preparing desc. Let's spilt out the separate body
to make the dw_mci_translate_sglist not so lengthy.
After spliting out these two functions, we could
remove dw_mci_translate_sglist and call both of them
when staring idmac.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v2:
- remove dw_mci_translate_sglist

 drivers/mmc/host/dw_mmc.c | 149 ++++++++++++++++++++++++----------------------
 1 file changed, 79 insertions(+), 70 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 22dacae..782b303 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -467,112 +467,121 @@ static void dw_mci_dmac_complete_dma(void *arg)
 	}
 }
 
-static void dw_mci_translate_sglist(struct dw_mci *host, struct mmc_data *data,
-				    unsigned int sg_len)
+static inline void dw_mci_prepare_desc64(struct dw_mci *host,
+					 struct mmc_data *data,
+					 unsigned int sg_len)
 {
 	unsigned int desc_len;
+	struct idmac_desc_64addr *desc_first, *desc_last, *desc;
 	int i;
 
-	if (host->dma_64bit_address == 1) {
-		struct idmac_desc_64addr *desc_first, *desc_last, *desc;
-
-		desc_first = desc_last = desc = host->sg_cpu;
+	desc_first = desc_last = desc = host->sg_cpu;
 
-		for (i = 0; i < sg_len; i++) {
-			unsigned int length = sg_dma_len(&data->sg[i]);
+	for (i = 0; i < sg_len; i++) {
+		unsigned int length = sg_dma_len(&data->sg[i]);
 
-			u64 mem_addr = sg_dma_address(&data->sg[i]);
+		u64 mem_addr = sg_dma_address(&data->sg[i]);
 
-			for ( ; length ; desc++) {
-				desc_len = (length <= DW_MCI_DESC_DATA_LENGTH) ?
-					   length : DW_MCI_DESC_DATA_LENGTH;
+		for ( ; length ; desc++) {
+			desc_len = (length <= DW_MCI_DESC_DATA_LENGTH) ?
+				   length : DW_MCI_DESC_DATA_LENGTH;
 
-				length -= desc_len;
+			length -= desc_len;
 
-				/*
-				 * Set the OWN bit and disable interrupts
-				 * for this descriptor
-				 */
-				desc->des0 = IDMAC_DES0_OWN | IDMAC_DES0_DIC |
-							IDMAC_DES0_CH;
+			/*
+			 * Set the OWN bit and disable interrupts
+			 * for this descriptor
+			 */
+			desc->des0 = IDMAC_DES0_OWN | IDMAC_DES0_DIC |
+						IDMAC_DES0_CH;
 
-				/* Buffer length */
-				IDMAC_64ADDR_SET_BUFFER1_SIZE(desc, desc_len);
+			/* Buffer length */
+			IDMAC_64ADDR_SET_BUFFER1_SIZE(desc, desc_len);
 
-				/* Physical address to DMA to/from */
-				desc->des4 = mem_addr & 0xffffffff;
-				desc->des5 = mem_addr >> 32;
+			/* Physical address to DMA to/from */
+			desc->des4 = mem_addr & 0xffffffff;
+			desc->des5 = mem_addr >> 32;
 
-				/* Update physical address for the next desc */
-				mem_addr += desc_len;
+			/* Update physical address for the next desc */
+			mem_addr += desc_len;
 
-				/* Save pointer to the last descriptor */
-				desc_last = desc;
-			}
+			/* Save pointer to the last descriptor */
+			desc_last = desc;
 		}
+	}
 
-		/* Set first descriptor */
-		desc_first->des0 |= IDMAC_DES0_FD;
+	/* Set first descriptor */
+	desc_first->des0 |= IDMAC_DES0_FD;
 
-		/* Set last descriptor */
-		desc_last->des0 &= ~(IDMAC_DES0_CH | IDMAC_DES0_DIC);
-		desc_last->des0 |= IDMAC_DES0_LD;
+	/* Set last descriptor */
+	desc_last->des0 &= ~(IDMAC_DES0_CH | IDMAC_DES0_DIC);
+	desc_last->des0 |= IDMAC_DES0_LD;
+}
 
-	} else {
-		struct idmac_desc *desc_first, *desc_last, *desc;
 
-		desc_first = desc_last = desc = host->sg_cpu;
+static inline void dw_mci_prepare_desc32(struct dw_mci *host,
+					 struct mmc_data *data,
+					 unsigned int sg_len)
+{
+	unsigned int desc_len;
+	struct idmac_desc *desc_first, *desc_last, *desc;
+	int i;
 
-		for (i = 0; i < sg_len; i++) {
-			unsigned int length = sg_dma_len(&data->sg[i]);
+	desc_first = desc_last = desc = host->sg_cpu;
 
-			u32 mem_addr = sg_dma_address(&data->sg[i]);
+	for (i = 0; i < sg_len; i++) {
+		unsigned int length = sg_dma_len(&data->sg[i]);
 
-			for ( ; length ; desc++) {
-				desc_len = (length <= DW_MCI_DESC_DATA_LENGTH) ?
-					   length : DW_MCI_DESC_DATA_LENGTH;
+		u32 mem_addr = sg_dma_address(&data->sg[i]);
 
-				length -= desc_len;
+		for ( ; length ; desc++) {
+			desc_len = (length <= DW_MCI_DESC_DATA_LENGTH) ?
+				   length : DW_MCI_DESC_DATA_LENGTH;
 
-				/*
-				 * Set the OWN bit and disable interrupts
-				 * for this descriptor
-				 */
-				desc->des0 = cpu_to_le32(IDMAC_DES0_OWN |
-							 IDMAC_DES0_DIC |
-							 IDMAC_DES0_CH);
+			length -= desc_len;
 
-				/* Buffer length */
-				IDMAC_SET_BUFFER1_SIZE(desc, desc_len);
+			/*
+			 * Set the OWN bit and disable interrupts
+			 * for this descriptor
+			 */
+			desc->des0 = cpu_to_le32(IDMAC_DES0_OWN |
+						 IDMAC_DES0_DIC |
+						 IDMAC_DES0_CH);
 
-				/* Physical address to DMA to/from */
-				desc->des2 = cpu_to_le32(mem_addr);
+			/* Buffer length */
+			IDMAC_SET_BUFFER1_SIZE(desc, desc_len);
 
-				/* Update physical address for the next desc */
-				mem_addr += desc_len;
+			/* Physical address to DMA to/from */
+			desc->des2 = cpu_to_le32(mem_addr);
 
-				/* Save pointer to the last descriptor */
-				desc_last = desc;
-			}
-		}
-
-		/* Set first descriptor */
-		desc_first->des0 |= cpu_to_le32(IDMAC_DES0_FD);
+			/* Update physical address for the next desc */
+			mem_addr += desc_len;
 
-		/* Set last descriptor */
-		desc_last->des0 &= cpu_to_le32(~(IDMAC_DES0_CH |
-					       IDMAC_DES0_DIC));
-		desc_last->des0 |= cpu_to_le32(IDMAC_DES0_LD);
+			/* Save pointer to the last descriptor */
+			desc_last = desc;
+		}
 	}
 
-	wmb(); /* drain writebuffer */
+	/* Set first descriptor */
+	desc_first->des0 |= cpu_to_le32(IDMAC_DES0_FD);
+
+	/* Set last descriptor */
+	desc_last->des0 &= cpu_to_le32(~(IDMAC_DES0_CH |
+				       IDMAC_DES0_DIC));
+	desc_last->des0 |= cpu_to_le32(IDMAC_DES0_LD);
 }
 
 static int dw_mci_idmac_start_dma(struct dw_mci *host, unsigned int sg_len)
 {
 	u32 temp;
 
-	dw_mci_translate_sglist(host, host->data, sg_len);
+	if (host->dma_64bit_address == 1)
+		dw_mci_prepare_desc64(host, host->data, sg_len);
+	else
+		dw_mci_prepare_desc32(host, host->data, sg_len);
+
+	/* drain writebuffer */
+	wmb();
 
 	/* Make sure to reset DMA in case we did PIO before this */
 	dw_mci_ctrl_reset(host, SDMMC_CTRL_DMA_RESET);
-- 
2.3.7
