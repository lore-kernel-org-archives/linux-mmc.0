From: Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] mmc: renesas_sdhi: add checks for pinctrl_lookup_state
Date: Fri, 18 Oct 2019 21:13:38 +0800
Message-ID: <20191018131338.11713-1-hslester96@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
List-Id: linux-mmc@vger.kernel.org

renesas_sdhi_probe misses checks for pinctrl_lookup_state and may miss
failures.
Add checks for them to fix the problem.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index d4ada5cca2d1..dc5ad6632df3 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -694,8 +694,13 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	if (!IS_ERR(priv->pinctrl)) {
 		priv->pins_default = pinctrl_lookup_state(priv->pinctrl,
 						PINCTRL_STATE_DEFAULT);
+		if (IS_ERR(priv->pins_default))
+			return PTR_ERR(priv->pins_default);
+
 		priv->pins_uhs = pinctrl_lookup_state(priv->pinctrl,
 						"state_uhs");
+		if (IS_ERR(priv->pins_uhs))
+			return PTR_ERR(priv->pins_uhs);
 	}
 
 	host = tmio_mmc_host_alloc(pdev, mmc_data);
-- 
2.20.1
