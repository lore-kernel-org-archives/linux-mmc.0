From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 3/6] mmc: tmio: remove outdated comment
Date: Mon,  1 May 2017 11:03:43 +0200
Message-ID: <20170501090346.10801-4-wsa+renesas@sang-engineering.com>
References: <20170501090346.10801-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170501090346.10801-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

The obviously wrong comment was added in 2011 with commit df3ef2d3c92c0a
("mmc: protect the tmio_mmc driver against a theoretical race") but
already obsoleted half a year later with commit b9269fdd4f61aa ("mmc:
tmio: fix recursive spinlock, don't schedule with interrupts disabled").

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/tmio_mmc_pio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 9d86e3ac626444..36539950347fbc 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -279,7 +279,6 @@ static void tmio_mmc_reset_work(struct work_struct *work)
 	mmc_request_done(host->mmc, mrq);
 }
 
-/* called with host->lock held, interrupts disabled */
 static void tmio_mmc_finish_request(struct tmio_mmc_host *host)
 {
 	struct mmc_request *mrq;
-- 
2.11.0
