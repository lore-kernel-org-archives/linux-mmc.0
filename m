From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/6] mmc: moxart: Handle error from mmc_of_parse()
Date: Thu, 18 Dec 2014 10:41:39 +0100
Message-ID: <1418895704-25908-2-git-send-email-ulf.hansson@linaro.org>
References: <1418895704-25908-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:46425 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbaLRJl6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Dec 2014 04:41:58 -0500
Received: by mail-wi0-f176.google.com with SMTP id ex7so1118174wid.3
        for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2014 01:41:56 -0800 (PST)
In-Reply-To: <1418895704-25908-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: Jonas Jensen <jonas.jensen@gmail.com>

Since mmc_of_parse() may fail, let's deal with it and thus do proper
error handling.

Cc: Jonas Jensen <jonas.jensen@gmail.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/moxart-mmc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index f3e18d0..d2a1ef6 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -599,7 +599,9 @@ static int moxart_probe(struct platform_device *pdev)
 		goto out;
 	}
 
-	mmc_of_parse(mmc);
+	ret = mmc_of_parse(mmc);
+	if (ret)
+		goto out;
 
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
-- 
1.9.1

