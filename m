From: Addy Ke <addy.ke@rock-chips.com>
Subject: [PATCH] mmc: dw_mmc: rockchip: add support MMC_CAP_RUNTIME_RESUME capability
Date: Fri, 13 Feb 2015 15:22:20 +0800
Message-ID: <1423812140-24196-1-git-send-email-addy.ke@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.135]:33671 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535AbbBMHYt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Feb 2015 02:24:49 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: jh80.chung@samsung.com, ulf.hansson@linaro.org, olof@lixom.net, dianders@chromium.org
Cc: heiko@sntech.de, cf@rock-chips.com, lintao@rock-chips.com, huangtao@rock-chips.com, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, Addy Ke <addy.ke@rock-chips.com>

To support HS200 and UHS mode, mmc core will call init_card() to
execute tuning:
- sdio: init_card can be executed at runtime resume.
- sd and mmc: init_card can be executed at resume or runtime resume,
  which depends on MMC_CAP_RUNTIME_RESUME capability.

On rk3288 SoC, host will get DRTO interrupt when host send command
to read tuning data. This will spend more than 111ms:
drto_ms = drto_clks * 1000 / bus_hz = 111ms.

And the total tuning time will be more than 400ms.

So we should add MMC_CAP_RUNTIME_RESUME capability to execute tuning
at runtime resume. Only if we do so, can we pass resume test.

Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
---
 drivers/mmc/host/dw_mmc-rockchip.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index e2a726a..e5f57b5 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -76,12 +76,20 @@ static int dw_mci_rockchip_init(struct dw_mci *host)
 	return 0;
 }
 
+/* Common capabilities of RK3288 SoC */
+static unsigned long dw_mci_rk3288_dwmmc_caps[4] = {
+	MMC_CAP_RUNTIME_RESUME, /* emmc */
+	MMC_CAP_RUNTIME_RESUME, /* sdmmc */
+	0, /* sdio0 */
+	0, /* sdio1 */
+};
 static const struct dw_mci_drv_data rk2928_drv_data = {
 	.prepare_command        = dw_mci_rockchip_prepare_command,
 	.init			= dw_mci_rockchip_init,
 };
 
 static const struct dw_mci_drv_data rk3288_drv_data = {
+	.caps			= dw_mci_rk3288_dwmmc_caps,
 	.prepare_command        = dw_mci_rockchip_prepare_command,
 	.set_ios		= dw_mci_rk3288_set_ios,
 	.setup_clock    = dw_mci_rk3288_setup_clock,
-- 
1.8.3.2


