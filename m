From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH] mmc: sunxi: Use devm_reset_control_get_optional() for reset control
Date: Tue,  3 Mar 2015 09:44:40 +0800
Message-ID: <1425347080-1789-1-git-send-email-wens@csie.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: david.lanzendoerfer@o2s.ch, Hans de Goede <hdegoede@redhat.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The reset control for the sunxi mmc controller is optional. Some
newer platforms (sun6i, sun8i, sun9i) have it, while older ones
(sun4i, sun5i, sun7i) don't.

Use the properly stubbed _optional version so the driver does not
fail to compile when RESET_CONTROLLER=n.

This patch also adds a check for deferred probing on the reset
control.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Cc: <stable@vger.kernel.org> # 3.16+
---

Arnd had some proposals about the reset control API.
Not sure if the sunxi-mmc driver was on that list.

---
 drivers/mmc/host/sunxi-mmc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index e8a4218b5726..459ed1b601db 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -930,7 +930,9 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
 		return PTR_ERR(host->clk_sample);
 	}
 
-	host->reset = devm_reset_control_get(&pdev->dev, "ahb");
+	host->reset = devm_reset_control_get_optional(&pdev->dev, "ahb");
+	if (PTR_ERR(host->reset) == -EPROBE_DEFER)
+		return PTR_ERR(host->reset);
 
 	ret = clk_prepare_enable(host->clk_ahb);
 	if (ret) {
-- 
2.1.4
