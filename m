From: Colin King <colin.king@canonical.com>
Subject: [PATCH] memstick: jmb38x_ms: clean up indentation issue
Date: Sun, 22 Sep 2019 13:47:00 +0200
Message-ID: <20190922114700.10563-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a hunk of code that is indented one level too deep, fix
this by removing the extraneous tabs.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/memstick/host/jmb38x_ms.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/memstick/host/jmb38x_ms.c b/drivers/memstick/host/jmb38x_ms.c
index 32747425297d..3394164a7968 100644
--- a/drivers/memstick/host/jmb38x_ms.c
+++ b/drivers/memstick/host/jmb38x_ms.c
@@ -433,13 +433,13 @@ static int jmb38x_ms_issue_cmd(struct memstick_host *msh)
 		writel(((1 << 16) & BLOCK_COUNT_MASK)
 		       | (data_len & BLOCK_SIZE_MASK),
 		       host->addr + BLOCK);
-			t_val = readl(host->addr + INT_STATUS_ENABLE);
-			t_val |= host->req->data_dir == READ
-				 ? INT_STATUS_FIFO_RRDY
-				 : INT_STATUS_FIFO_WRDY;
+		t_val = readl(host->addr + INT_STATUS_ENABLE);
+		t_val |= host->req->data_dir == READ
+			 ? INT_STATUS_FIFO_RRDY
+			 : INT_STATUS_FIFO_WRDY;
 
-			writel(t_val, host->addr + INT_STATUS_ENABLE);
-			writel(t_val, host->addr + INT_SIGNAL_ENABLE);
+		writel(t_val, host->addr + INT_STATUS_ENABLE);
+		writel(t_val, host->addr + INT_SIGNAL_ENABLE);
 	} else {
 		cmd &= ~(TPC_DATA_SEL | 0xf);
 		host->cmd_flags |= REG_DATA;
-- 
2.20.1
