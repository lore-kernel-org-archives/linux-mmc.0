From: Michael Weiser <michael.weiser@gmx.de>
Subject: [PATCH 4/5] mmc: sunxi-mmc: change idma descriptor to __le32
Date: Mon, 22 Aug 2016 18:42:18 +0200
Message-ID: <20160822164219.14272-5-michael.weiser@gmx.de>
References: <20160822164219.14272-1-michael.weiser@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from heinz.dinsnail.net ([85.214.155.104]:35556 "EHLO
        heinz.dinsnail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754533AbcHVQsc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Aug 2016 12:48:32 -0400
In-Reply-To: <20160822164219.14272-1-michael.weiser@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Michael Weiser <michael.weiser@gmx.de>, Ulf Hansson <ulf.hansson@linaro.org>, Chen-Yu Tsai <wens@csie.org>, linux-mmc@vger.kernel.org

The sunxi-mmc driver does not take into account the processor may be big
endian when writing the DMA descriptors. This causes cards not to be
detected when running a big-endian kernel. Change the descriptors for
IDMA to use __le32 and ensure they are suitably swapped before writing.
Tested successfully on the Cubieboard2.

Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: linux-mmc@vger.kernel.org
---
 drivers/mmc/host/sunxi-mmc.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 2ec91ce..a1935a1 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -223,10 +223,10 @@ struct sunxi_mmc_clk_delay {
 };
 
 struct sunxi_idma_des {
-	u32	config;
-	u32	buf_size;
-	u32	buf_addr_ptr1;
-	u32	buf_addr_ptr2;
+	__le32 config;
+	__le32 buf_size;
+	__le32 buf_addr_ptr1;
+	__le32 buf_addr_ptr2;
 };
 
 struct sunxi_mmc_cfg {
@@ -329,22 +329,25 @@ static void sunxi_mmc_init_idma_des(struct sunxi_mmc_host *host,
 	int i, max_len = (1 << host->cfg->idma_des_size_bits);
 
 	for (i = 0; i < data->sg_len; i++) {
-		pdes[i].config = SDXC_IDMAC_DES0_CH | SDXC_IDMAC_DES0_OWN |
-				 SDXC_IDMAC_DES0_DIC;
+		pdes[i].config = cpu_to_le32(SDXC_IDMAC_DES0_CH |
+					     SDXC_IDMAC_DES0_OWN |
+					     SDXC_IDMAC_DES0_DIC);
 
 		if (data->sg[i].length == max_len)
 			pdes[i].buf_size = 0; /* 0 == max_len */
 		else
-			pdes[i].buf_size = data->sg[i].length;
+			pdes[i].buf_size = cpu_to_le32(data->sg[i].length);
 
 		next_desc += sizeof(struct sunxi_idma_des);
-		pdes[i].buf_addr_ptr1 = sg_dma_address(&data->sg[i]);
-		pdes[i].buf_addr_ptr2 = (u32)next_desc;
+		pdes[i].buf_addr_ptr1 =
+			cpu_to_le32(sg_dma_address(&data->sg[i]));
+		pdes[i].buf_addr_ptr2 = cpu_to_le32((u32)next_desc);
 	}
 
-	pdes[0].config |= SDXC_IDMAC_DES0_FD;
-	pdes[i - 1].config |= SDXC_IDMAC_DES0_LD | SDXC_IDMAC_DES0_ER;
-	pdes[i - 1].config &= ~SDXC_IDMAC_DES0_DIC;
+	pdes[0].config |= cpu_to_le32(SDXC_IDMAC_DES0_FD);
+	pdes[i - 1].config |= cpu_to_le32(SDXC_IDMAC_DES0_LD |
+					  SDXC_IDMAC_DES0_ER);
+	pdes[i - 1].config &= cpu_to_le32(~SDXC_IDMAC_DES0_DIC);
 	pdes[i - 1].buf_addr_ptr2 = 0;
 
 	/*
-- 
2.9.2

