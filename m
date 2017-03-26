From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v3 1/2] mmc: core: add mmc_get_dma_dir
Date: Sun, 26 Mar 2017 20:41:32 +0200
Message-ID: <ab2ec69b-b57e-958e-4f3e-319e73b8abe3@gmail.com>
References: <d3d01681-9456-0800-733f-369f6d3a26be@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33519 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751510AbdCZSxb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Mar 2017 14:53:31 -0400
Received: by mail-wr0-f196.google.com with SMTP id 20so6881765wrx.0
        for <linux-mmc@vger.kernel.org>; Sun, 26 Mar 2017 11:53:29 -0700 (PDT)
In-Reply-To: <d3d01681-9456-0800-733f-369f6d3a26be@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Add function for determining DMA direction to core.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
---
v2:
- no changes
v3:
- no changes
---
 include/linux/mmc/host.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 83f1c4a9..21385ac0 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -17,6 +17,7 @@
 #include <linux/mmc/core.h>
 #include <linux/mmc/card.h>
 #include <linux/mmc/pm.h>
+#include <linux/dma-direction.h>
 
 struct mmc_ios {
 	unsigned int	clock;			/* clock rate */
@@ -499,6 +500,11 @@ static inline bool mmc_can_retune(struct mmc_host *host)
 	return host->can_retune == 1;
 }
 
+static inline enum dma_data_direction mmc_get_dma_dir(struct mmc_data *data)
+{
+	return data->flags & MMC_DATA_WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
+}
+
 int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error);
 int mmc_abort_tuning(struct mmc_host *host, u32 opcode);
 
-- 
2.12.1


