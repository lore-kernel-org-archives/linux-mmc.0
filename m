From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 4/4] mmc: core: improve initialization flow
Date: Wed,  8 Jun 2016 16:22:01 +0800
Message-ID: <1465374121-2652-1-git-send-email-shawn.lin@rock-chips.com>
References: <1465373996-2485-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465373996-2485-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

We should skip sending some unnecessary cmds
during initialization if we know that this controller
can't support the claimed function.

In this way, we provide the capabilities for DT to
decide whether they need to reduce booting time if they
know a slot is just only for one card type.

We also don't want to break the backward compatibility
if not assigning any one of these caps for existing dts
or dtb. So this patch should be safe.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/core/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index e864187..663bf18 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2503,13 +2503,13 @@ static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
 	mmc_send_if_cond(host, host->ocr_avail);
 
 	/* Order's important: probe SDIO, then SD, then MMC */
-	if (!(host->caps2 & MMC_CAP2_NO_SDIO))
-		if (!mmc_attach_sdio(host))
-			return 0;
+	if (!(host->caps2 & MMC_CAP2_NO_SDIO) && !mmc_attach_sdio(host))
+		return 0;
 
-	if (!mmc_attach_sd(host))
+	if (!(host->caps2 & MMC_CAP2_NO_SD) && !mmc_attach_sd(host))
 		return 0;
-	if (!mmc_attach_mmc(host))
+
+	if (!(host->caps2 & MMC_CAP2_NO_MMC) && !mmc_attach_mmc(host))
 		return 0;
 
 	mmc_power_off(host);
-- 
2.3.7
