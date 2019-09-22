From: Colin King <colin.king@canonical.com>
Subject: [PATCH] mmc: dw_mmc: fix indentation issue
Date: Sun, 22 Sep 2019 13:54:43 +0200
Message-ID: <20190922115443.11693-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are a couple of statements that are indented by an extra
space, clean this up by remove the extraneous spaces.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mmc/host/dw_mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 79c55c7b4afd..bf0048ebbda3 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3441,8 +3441,8 @@ int dw_mci_runtime_resume(struct device *dev)
 	 * Restore the initial value at FIFOTH register
 	 * And Invalidate the prev_blksz with zero
 	 */
-	 mci_writel(host, FIFOTH, host->fifoth_val);
-	 host->prev_blksz = 0;
+	mci_writel(host, FIFOTH, host->fifoth_val);
+	host->prev_blksz = 0;
 
 	/* Put in max timeout */
 	mci_writel(host, TMOUT, 0xFFFFFFFF);
-- 
2.20.1
