From: James Hogan <james.hogan@imgtec.com>
Subject: [PATCH v2 4/4] mmc: dw_mmc: reset FIFO after an error
Date: Wed, 06 Jul 2011 10:40:25 +0100
Message-ID: <4E142D89.2070704@imgtec.com>
References: <4E142C10.3050508@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:65213 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752204Ab1GFJk2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 6 Jul 2011 05:40:28 -0400
In-Reply-To: <4E142C10.3050508@imgtec.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: Chris Ball <cjb@laptop.org>, Will <will.newton@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

If an error occurs mid way through a transaction (such as a missing CRC
status response after the 2nd block written out of 3), then the FIFO may
still contain data which will interfere with the next transaction.
Therefore after an error has been detected, reset the fifo using the
CTRL register.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Acked-by: Will Newton <will.newton@imgtec.com>
Tested-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 0dac397..0c839d3 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -849,7 +849,7 @@ static void dw_mci_tasklet_func(unsigned long priv)
 	struct mmc_command *cmd;
 	enum dw_mci_state state;
 	enum dw_mci_state prev_state;
-	u32 status;
+	u32 status, ctrl;
 
 	spin_lock(&host->lock);
 
@@ -929,6 +929,16 @@ static void dw_mci_tasklet_func(unsigned long priv)
 						status);
 					data->error = -EIO;
 				}
+				/*
+				 * After an error, there may be data lingering
+				 * in the FIFO, so reset it - doing so
+				 * generates a block interrupt, hence setting
+				 * the scatter-gather pointer to NULL.
+				 */
+				host->sg = NULL;
+				ctrl = mci_readl(host, CTRL);
+				ctrl |= SDMMC_CTRL_FIFO_RESET;
+				mci_writel(host, CTRL, ctrl);
 			} else {
 				data->bytes_xfered = data->blocks * data->blksz;
 				data->error = 0;
-- 
1.7.2.3


