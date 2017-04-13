From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH 1/2] mmc: cavium: Remove redundant pointer check
Date: Thu, 13 Apr 2017 14:10:50 +0200
Message-ID: <20170413121051.10507-2-jglauber@cavium.com>
References: <20170413121051.10507-1-jglauber@cavium.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34755 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752250AbdDMMLO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Apr 2017 08:11:14 -0400
In-Reply-To: <20170413121051.10507-1-jglauber@cavium.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: David Daney <david.daney@cavium.com>, "Steven J . Hill" <steven.hill@cavium.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Jan Glauber <jglauber@cavium.com>

Remove redundant mmc->card check reported by smatch:

drivers/mmc/host/cavium.c:694 cvm_mmc_dma_request()
	warn: variable dereferenced before check 'mmc->card' (see line 675)

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/mmc/host/cavium.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cavium.c b/drivers/mmc/host/cavium.c
index d842b69..ddf902c 100644
--- a/drivers/mmc/host/cavium.c
+++ b/drivers/mmc/host/cavium.c
@@ -691,7 +691,7 @@ static void cvm_mmc_dma_request(struct mmc_host *mmc,
 	 * bit mask to check for CRC errors and timeouts only.
 	 * Otherwise, use the default power reset value.
 	 */
-	if (mmc->card && mmc_card_sd(mmc->card))
+	if (mmc_card_sd(mmc->card))
 		writeq(0x00b00000ull, host->base + MIO_EMM_STS_MASK(host));
 	else
 		writeq(0xe4390080ull, host->base + MIO_EMM_STS_MASK(host));
-- 
2.9.0.rc0.21.g7777322

