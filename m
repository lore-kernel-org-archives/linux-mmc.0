From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0693/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:37:22 +0800
Message-ID: <20160802113722.28263-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, jirislaby@gmail.com, mchehab@redhat.com, m.chehab@samsung.com, pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, jonathanh@nvidia.com, grundler@chromium.org, lporzio@micron.com
List-Id: linux-mmc@vger.kernel.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/mmc/host/sdhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0e3d7c0..01a6fc3 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3450,8 +3450,8 @@ static void __exit sdhci_drv_exit(void)
 module_init(sdhci_drv_init);
 module_exit(sdhci_drv_exit);
 
-module_param(debug_quirks, uint, 0444);
-module_param(debug_quirks2, uint, 0444);
+module_param(debug_quirks, uint, S_IRUSR | S_IRGRP | S_IROTH);
+module_param(debug_quirks2, uint, S_IRUSR | S_IRGRP | S_IROTH);
 
 MODULE_AUTHOR("Pierre Ossman <pierre@ossman.eu>");
 MODULE_DESCRIPTION("Secure Digital Host Controller Interface core driver");
-- 
2.9.2
