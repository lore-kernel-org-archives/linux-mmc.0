From: "Torne (Richard Coles)" <torne@google.com>
Subject: [PATCH] MMC: sdhci: remove too large timeout warning
Date: Tue,  6 Mar 2012 10:27:28 +0000
Message-ID: <1331029648-29175-1-git-send-email-torne@google.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, "Torne (Richard Coles)" <torne@google.com>
List-Id: linux-mmc@vger.kernel.org

From: "Torne (Richard Coles)" <torne@google.com>

Some MMC cards specify timeouts that are larger than the highest
possible timeout in the host controller. sdhci is the only host
controller driver which complains about this; remove the warning to
match the behaviour of the other drivers.

Signed-off-by: Torne (Richard Coles) <torne@google.com>
---
 drivers/mmc/host/sdhci.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 8d66706..85d4d05 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -680,8 +680,6 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 	}
 
 	if (count >= 0xF) {
-		pr_warning("%s: Too large timeout requested for CMD%d!\n",
-		       mmc_hostname(host->mmc), cmd->opcode);
 		count = 0xE;
 	}
 
-- 
1.7.7.3
