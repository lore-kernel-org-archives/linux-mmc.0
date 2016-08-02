From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0692/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:37:16 +0800
Message-ID: <20160802113716.28197-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@armlinux.org.uk, ulf.hansson@linaro.org, jirislaby@gmail.com, mchehab@redhat.com, m.chehab@samsung.com, pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
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
 drivers/mmc/host/mmci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index df990bb..7303448 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1901,7 +1901,7 @@ static struct amba_driver mmci_driver = {
 
 module_amba_driver(mmci_driver);
 
-module_param(fmax, uint, 0444);
+module_param(fmax, uint, S_IRUSR | S_IRGRP | S_IROTH);
 
 MODULE_DESCRIPTION("ARM PrimeCell PL180/181 Multimedia Card Interface driver");
 MODULE_LICENSE("GPL");
-- 
2.9.2
