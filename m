From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 01/25] mmc: sdhci: Do not disable interrupts while waiting for clock
Date: Mon, 20 Mar 2017 19:50:29 +0200
Message-ID: <1490032253-6030-2-git-send-email-adrian.hunter@intel.com>
References: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:15128 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756528AbdCTR7j (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Mar 2017 13:59:39 -0400
In-Reply-To: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Al Cooper <alcooperx@gmail.com>, Jaedon Shin <jaedon.shin@gmail.com>, Haibo Chen <haibo.chen@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>, Douglas Anderson <dianders@chromium.org>, Zach Brown <zach.brown@ni.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Jisheng Zhang <jszhang@marvell.com>, Yangbo Lu <yangbo.lu@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Weijun Yang <Weijun.Yang@csr.com>, Barry Song <Baohua.Song@csr.com>, Peter Griffin <peter.griffin@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Harjani Ritesh <riteshh@codeaurora.org>

Disabling interrupts for even a millisecond can cause problems for some
devices. That can happen when sdhci changes clock frequency because it
waits for the clock to become stable under a spin lock.

The spin lock is not necessary here. Anything that is racing with changes
to the I/O state is already broken. The mmc core already provides
synchronization via "claiming" the host.

Although the spin lock probably should be removed from the code paths that
lead to this point, such a patch would touch too much code to be suitable
for stable trees. Consequently, for this patch, just drop the spin lock
while waiting.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
---
 drivers/mmc/host/sdhci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6fdd7a70f229..9c1a099afbbe 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1362,7 +1362,9 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
 			return;
 		}
 		timeout--;
-		mdelay(1);
+		spin_unlock_irq(&host->lock);
+		usleep_range(900, 1100);
+		spin_lock_irq(&host->lock);
 	}
 
 	clk |= SDHCI_CLOCK_CARD_EN;
-- 
1.9.1

