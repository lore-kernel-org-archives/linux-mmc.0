From: James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 2/4] mmc: dw_mmc: remove unnecessary error messages
Date: Wed, 29 Jun 2011 09:29:17 +0100
Message-ID: <4E0AE25D.8040102@imgtec.com>
References: <4E0AE1FC.3070201@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4E0AE1FC.3070201@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: Chris Ball <cjb@laptop.org>, Will <will.newton@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Remove error messages for timeout and CRC failure, since the error code
already indicates the problem.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
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
