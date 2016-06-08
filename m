From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 2/4] mmc: core: expose MMC_CAP2_NO_SDIO to dt-binding
Date: Wed,  8 Jun 2016 16:20:46 +0800
Message-ID: <1465374046-2567-1-git-send-email-shawn.lin@rock-chips.com>
References: <1465373996-2485-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465373996-2485-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

Add cap-no-sdio property, so we can use MMC_CAP2_NO_SDIO
for different slots from dt.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/core/host.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index d7e86f9..933eeea 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -296,6 +296,8 @@ int mmc_of_parse(struct mmc_host *host)
 		host->caps |= MMC_CAP_SDIO_IRQ;
 	if (of_property_read_bool(np, "full-pwr-cycle"))
 		host->caps2 |= MMC_CAP2_FULL_PWR_CYCLE;
+	if (of_property_read_bool(np, "cap-no-sdio"))
+		host->caps2 |= MMC_CAP2_NO_SDIO;
 	if (of_property_read_bool(np, "keep-power-in-suspend"))
 		host->pm_caps |= MMC_PM_KEEP_POWER;
 	if (of_property_read_bool(np, "wakeup-source") ||
-- 
2.3.7
