From: Saurabh Sengar <saurabh.truth@gmail.com>
Subject: [PATCH] mmc: of_mmc_spi: Add IRQF_ONESHOT to interrupt flags
Date: Wed, 25 Nov 2015 23:56:24 +0530
Message-ID: <1448475984-11332-1-git-send-email-saurabh.truth@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36511 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbbKYS0b (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Nov 2015 13:26:31 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Saurabh Sengar <saurabh.truth@gmail.com>

If no primary handler is specified for threaded_irq then a
default one is assigned which always returns IRQ_WAKE_THREAD.
This handler requires the IRQF_ONESHOT, because the source of
interrupt is not disabled

Signed-off-by: Saurabh Sengar <saurabh.truth@gmail.com>
---
 drivers/mmc/host/of_mmc_spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/of_mmc_spi.c b/drivers/mmc/host/of_mmc_spi.c
index 6e218fb..660170c 100644
--- a/drivers/mmc/host/of_mmc_spi.c
+++ b/drivers/mmc/host/of_mmc_spi.c
@@ -55,8 +55,8 @@ static int of_mmc_spi_init(struct device *dev,
 {
 	struct of_mmc_spi *oms = to_of_mmc_spi(dev);
 
-	return request_threaded_irq(oms->detect_irq, NULL, irqhandler, 0,
-				    dev_name(dev), mmc);
+	return request_threaded_irq(oms->detect_irq, NULL, irqhandler,
+					IRQF_ONESHOT, dev_name(dev), mmc);
 }
 
 static void of_mmc_spi_exit(struct device *dev, void *mmc)
-- 
1.9.1

