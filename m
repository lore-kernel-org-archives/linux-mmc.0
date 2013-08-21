From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH] mmc:core: Avoid useless detecting task when card is busy
Date: Wed, 21 Aug 2013 18:44:18 +0800
Message-ID: <1377081858-17430-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co9ehsobe004.messaging.microsoft.com ([207.46.163.27]:17113
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751238Ab3HUKpm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Aug 2013 06:45:42 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, galak@kernel.crashing.org
Cc: cbouatmailru@gmail.com, cjb@laptop.org, scottwood@freescale.com, X.Xie@freescale.com, Haijun Zhang <Haijun.Zhang@freescale.com>, Haijun Zhang <haijun.zhang@freescale.com>

When card is in cpu polling mode to detect card present. Card detecting
task will be scheduled about once every second. When card is busy in large
file transfer, detecting task will be hang and call trace will be prompt.
In this case, when card is busy assume that card is present and just return
in detecting task. Only polling card in case card is free to reduce conflict
with data transfer.

<7>mmc0: req done (CMD13): 0: 00000e00 00000000 00000000 00000000
INFO: task kworker/u:1:12 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/u:1     D 00000000     0    12      2 0x00000000
Call Trace:
[ee06dd50] [44042028] 0x44042028
 (unreliable)
 [ee06de10] [c0007a0c] __switch_to+0xa0/0xf0
 [ee06de30] [c04dd50c] __schedule+0x1f8/0x4a4

 [ee06dea0] [c04dd898] schedule+0x30/0xbc

 [ee06deb0] [c03816a4] __mmc_claim_host+0x98/0x19c

 [ee06df00] [c0385f88] mmc_sd_detect+0x38/0xc0

 [ee06df10] [c0382b0c] mmc_rescan+0x294/0x2e0
 [ee06df40] [c00661cc] process_one_work+0x140/0x3e0

 [ee06df70] [c0066bf8] worker_thread+0x18c/0x36c
 [ee06dfb0] [c006bf10] kthread+0x7c/0x80

 [ee06dff0] [c000de58] kernel_thread+0x4c/0x68
 <7>sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001

Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
---
 drivers/mmc/core/core.c | 5 +++++
 drivers/mmc/core/mmc.c  | 3 ++-
 drivers/mmc/core/sd.c   | 3 ++-
 drivers/mmc/core/sdio.c | 3 ++-
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 49a5bca..d51d9bd 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -924,15 +924,20 @@ EXPORT_SYMBOL(__mmc_claim_host);
  */
 int mmc_try_claim_host(struct mmc_host *host)
 {
+	struct mmc_card *card;
 	int claimed_host = 0;
 	unsigned long flags;
 
+	card = host->card;
+	pm_runtime_get_sync(&card->dev);
+
 	spin_lock_irqsave(&host->lock, flags);
 	if (!host->claimed || host->claimer == current) {
 		host->claimed = 1;
 		host->claimer = current;
 		host->claim_cnt += 1;
 		claimed_host = 1;
+		set_current_state(TASK_RUNNING);
 	}
 	spin_unlock_irqrestore(&host->lock, flags);
 	if (host->ops->enable && claimed_host && host->claim_cnt == 1)
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 6d02012..90e5555 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1447,7 +1447,8 @@ static void mmc_detect(struct mmc_host *host)
 	BUG_ON(!host);
 	BUG_ON(!host->card);
 
-	mmc_get_card(host->card);
+	if (!mmc_try_claim_host(host))
+		return;
 
 	/*
 	 * Just check if our card has been removed.
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 176d125..6aae8d1 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1042,7 +1042,8 @@ static void mmc_sd_detect(struct mmc_host *host)
 	BUG_ON(!host);
 	BUG_ON(!host->card);
 
-	mmc_get_card(host->card);
+	if (!mmc_try_claim_host(host))
+		return;
 
 	/*
 	 * Just check if our card has been removed.
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 80d89cff..e0cabf5 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -875,7 +875,8 @@ static void mmc_sdio_detect(struct mmc_host *host)
 		}
 	}
 
-	mmc_claim_host(host);
+	if (!mmc_try_claim_host(host))
+		return;
 
 	/*
 	 * Just check if our card has been removed.
-- 
1.8.0


