From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: [RFC PATCH 3/3] ARM: mmc: davinci: clock rate is an unsigned long
Date: Wed, 22 Jan 2014 12:46:05 +0100
Message-ID: <1390391165-27906-4-git-send-email-michael@amarulasolutions.com>
References: <1390391165-27906-1-git-send-email-michael@amarulasolutions.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1390391165-27906-1-git-send-email-michael@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Manjunathappa Prakash <prakash.pm@ti.com>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 drivers/mmc/host/davinci_mmc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 13ac664..0181780 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -183,7 +183,7 @@ struct mmc_davinci_host {
 	struct mmc_data *data;
 	struct mmc_host *mmc;
 	struct clk *clk;
-	unsigned int mmc_input_clk;
+	unsigned long mmc_input_clk;
 	void __iomem *base;
 	struct resource *mem_res;
 	int mmc_irq, sdio_irq;
@@ -654,9 +654,10 @@ static void mmc_davinci_request(struct mmc_host *mmc, struct mmc_request *req)
 }
 
 static unsigned int calculate_freq_for_card(struct mmc_davinci_host *host,
-	unsigned int mmc_req_freq)
+	unsigned long mmc_req_freq)
 {
-	unsigned int mmc_freq = 0, mmc_pclk = 0, mmc_push_pull_divisor = 0;
+	unsigned long mmc_freq = 0, mmc_pclk = 0;
+	unsigned int mmc_push_pull_divisor = 0;
 
 	mmc_pclk = host->mmc_input_clk;
 	if (mmc_req_freq && mmc_pclk > (2 * mmc_req_freq))
@@ -1105,7 +1106,7 @@ static int mmc_davinci_cpufreq_transition(struct notifier_block *nb,
 				     unsigned long val, void *data)
 {
 	struct mmc_davinci_host *host;
-	unsigned int mmc_pclk;
+	unsigned long mmc_pclk;
 	struct mmc_host *mmc;
 	unsigned long flags;
 
-- 
1.8.1.2
