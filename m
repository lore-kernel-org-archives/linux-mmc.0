From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: dw_mmc-rockchip: add MMC_CAP_CMD23 capabilities
Date: Tue, 26 Apr 2016 14:53:59 +0800
Message-ID: <1461653639-14470-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:44314 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101AbcDZGzG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Apr 2016 02:55:06 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>

Add MMC_CAP_CMD23 for dw_mmc-rockchip, otherwise
failing to create rpmb partition. With it, we can
get rpmb successfully:

mmc1: new HS200 MMC card at address 0001
mmcblk0: mmc1:0001 DS2016 14.7 GiB
mmcblk0boot0: mmc1:0001 DS2016 partition 1 4.00 MiB
mmcblk0boot1: mmc1:0001 DS2016 partition 2 4.00 MiB
mmcblk0rpmb: mmc1:0001 DS2016 partition 3 4.00 MiB

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc-rockchip.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index 8c20b81..2b4bcd2 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -233,10 +233,10 @@ static int dw_mci_rockchip_init(struct dw_mci *host)
 
 /* Common capabilities of RK3288 SoC */
 static unsigned long dw_mci_rk3288_dwmmc_caps[4] = {
-	MMC_CAP_ERASE,
-	MMC_CAP_ERASE,
-	MMC_CAP_ERASE,
-	MMC_CAP_ERASE,
+	MMC_CAP_ERASE | MMC_CAP_CMD23,
+	MMC_CAP_ERASE | MMC_CAP_CMD23,
+	MMC_CAP_ERASE | MMC_CAP_CMD23,
+	MMC_CAP_ERASE | MMC_CAP_CMD23,
 };
 
 static const struct dw_mci_drv_data rk2928_drv_data = {
-- 
2.3.7


