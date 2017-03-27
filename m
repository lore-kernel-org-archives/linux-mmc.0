From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 1/2] mmc: core: add functions mmc_dma_(un)map_sg
Date: Mon, 27 Mar 2017 20:25:11 +0200
Message-ID: <11e5aed4-c3ca-0d04-484a-9387302eaff2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:32776 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751564AbdC0Scw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Mar 2017 14:32:52 -0400
Received: by mail-wr0-f193.google.com with SMTP id 20so15757722wrx.0
        for <linux-mmc@vger.kernel.org>; Mon, 27 Mar 2017 11:32:46 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

After the recent introduction of mmc_get_dma_dir next step is to
factor out the typical usage of dma_(un)map_sg to the core.
Several host drivers use dma_(un)map_sg with these parameters:
data->sg, data->sg_len, mmc_get_dma_dir(data)
Therefore factor this out to the core and introduce
mmc_dma_(un)map_sg.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/linux/mmc/host.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 21385ac0..8d28a600 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -17,7 +17,7 @@
 #include <linux/mmc/core.h>
 #include <linux/mmc/card.h>
 #include <linux/mmc/pm.h>
-#include <linux/dma-direction.h>
+#include <linux/dma-mapping.h>
 
 struct mmc_ios {
 	unsigned int	clock;			/* clock rate */
@@ -505,6 +505,16 @@ static inline enum dma_data_direction mmc_get_dma_dir(struct mmc_data *data)
 	return data->flags & MMC_DATA_WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
 }
 
+static inline int mmc_dma_map_sg(struct device *dev, struct mmc_data *data)
+{
+	return dma_map_sg(dev, data->sg, data->sg_len, mmc_get_dma_dir(data));
+}
+
+static inline void mmc_dma_unmap_sg(struct device *dev, struct mmc_data *data)
+{
+	dma_unmap_sg(dev, data->sg, data->sg_len, mmc_get_dma_dir(data));
+}
+
 int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error);
 int mmc_abort_tuning(struct mmc_host *host, u32 opcode);
 
-- 
2.12.1

