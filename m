From: James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 2/4] mmc: dw_mmc: remove unnecessary error messages
Date: Wed, 06 Jul 2011 10:38:24 +0100
Message-ID: <4E142D10.6080206@imgtec.com>
References: <4E142C10.3050508@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:65291 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750955Ab1GFJi1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 6 Jul 2011 05:38:27 -0400
In-Reply-To: <4E142C10.3050508@imgtec.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: Chris Ball <cjb@laptop.org>, Will <will.newton@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

Remove error messages for timeout and CRC failure, since the error code
already indicates the problem.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Acked-by: Will Newton <will.newton@imgtec.com>
Tested-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index fcff3c0..bf2157a 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -908,12 +908,8 @@ static void dw_mci_tasklet_func(unsigned long priv)
 
 			if (status & DW_MCI_DATA_ERROR_FLAGS) {
 				if (status & SDMMC_INT_DTO) {
-					dev_err(&host->pdev->dev,
-						"data timeout error\n");
 					data->error = -ETIMEDOUT;
 				} else if (status & SDMMC_INT_DCRC) {
-					dev_err(&host->pdev->dev,
-						"data CRC error\n");
 					data->error = -EILSEQ;
 				} else {
 					dev_err(&host->pdev->dev,
-- 
1.7.2.3

