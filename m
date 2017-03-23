From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 1/2] mmc: core: add mmc_get_dma_dir
Date: Thu, 23 Mar 2017 22:20:40 +0100
Message-ID: <1dbd7d7c-3f0a-20b1-b7c3-22872cf9341d@gmail.com>
References: <44d784c1-ab30-db59-9037-db8c87935b43@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34239 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751336AbdCWV1h (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Mar 2017 17:27:37 -0400
Received: by mail-wm0-f66.google.com with SMTP id u132so1817546wmg.1
        for <linux-mmc@vger.kernel.org>; Thu, 23 Mar 2017 14:27:36 -0700 (PDT)
In-Reply-To: <44d784c1-ab30-db59-9037-db8c87935b43@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Add function for determining DMA direction to core.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
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
2.12.0


