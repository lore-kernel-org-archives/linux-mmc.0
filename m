From: Petr Cvek <petr.cvek@tul.cz>
Subject: [PATCH 1/4] mmc: pxamci: Use the right flags for DMA callback init
Date: Wed, 19 Apr 2017 01:16:26 +0200
Message-ID: <fbc663e3-4de5-7370-afa8-0f8747f50ca7@tul.cz>
References: <cover.1492492523.git.petr.cvek@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bubo.tul.cz ([147.230.16.1]:32922 "EHLO bubo.tul.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752196AbdDRXP7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 18 Apr 2017 19:15:59 -0400
In-Reply-To: <cover.1492492523.git.petr.cvek@tul.cz>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, robert.jarzmik@free.fr
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The MMC_DATA_READ and the MMC_DATA_WRITE flags for the mmc request are not
mutually exclusive (two different bits). Change the callback initialization
code to use the proper one.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 drivers/mmc/host/pxamci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index c763b404510f..80bc8065b50f 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -235,7 +235,7 @@ static void pxamci_setup_data(struct pxamci_host *host, struct mmc_data *data)
 		return;
 	}
 
-	if (!(data->flags & MMC_DATA_READ)) {
+	if (data->flags & MMC_DATA_WRITE) {
 		tx->callback = pxamci_dma_irq;
 		tx->callback_param = host;
 	}
-- 
2.11.0

