From: ludovic.desroches@atmel.com
Subject: [RFC PATCH 7/9] mmc: atmel-mci: use ATMEL_PDC_SCND_BUF_OFF instead of a literal value
Date: Thu, 28 Jul 2011 16:29:56 +0200
Message-ID: <1311863398-31579-8-git-send-email-ludovic.desroches@atmel.com>
References: <1311863398-31579-1-git-send-email-ludovic.desroches@atmel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:35366 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754106Ab1G1NYI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Jul 2011 09:24:08 -0400
In-Reply-To: <1311863398-31579-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: patrice.vilchez@atmel.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, Ludovic Desroches <ludovic.desroches@atmel.com>

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/mmc/host/atmel-mci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 7955697..c415322 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -603,8 +603,8 @@ static void atmci_pdc_set_single_buf(struct atmel_mci *host,
 	}
 
 	if (buf_nb == PDC_SECOND_BUF) {
-		pointer_reg += 0x10;
-		counter_reg += 0x10;
+		pointer_reg += ATMEL_PDC_SCND_BUF_OFF;
+		counter_reg += ATMEL_PDC_SCND_BUF_OFF;
 	}
 
 	atmci_writel(host, pointer_reg, sg_dma_address(host->sg));
-- 
1.7.0.4

