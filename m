From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 040/102] mmc: sunxi: explicitly request exclusive reset control
Date: Wed, 19 Jul 2017 17:25:44 +0200
Message-ID: <20170719152646.25903-41-p.zabel@pengutronix.de>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719152646.25903-1-p.zabel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
reset lines") started to transition the reset control request API calls
to explicitly state whether the driver needs exclusive or shared reset
control behavior. Convert all drivers requesting exclusive resets to the
explicit API call so the temporary transition helpers can be removed.

No functional changes.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: linux-mmc@vger.kernel.org
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/mmc/host/sunxi-mmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index d6fa2214aaae8..522b09d446494 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1168,7 +1168,8 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
 		}
 	}
 
-	host->reset = devm_reset_control_get_optional(&pdev->dev, "ahb");
+	host->reset = devm_reset_control_get_optional_exclusive(&pdev->dev,
+								"ahb");
 	if (PTR_ERR(host->reset) == -EPROBE_DEFER)
 		return PTR_ERR(host->reset);
 
-- 
2.11.0
