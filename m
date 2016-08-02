From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0697/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:37:42 +0800
Message-ID: <20160802113742.28527-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: pierre@ossman.eu, ulf.hansson@linaro.org, jirislaby@gmail.com, mchehab@redhat.com, m.chehab@samsung.com, pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, grundler@chromium.org, lporzio@micron.com
List-Id: linux-mmc@vger.kernel.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/mmc/host/wbsd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
index c3fd16d..f3bc95d 100644
--- a/drivers/mmc/host/wbsd.c
+++ b/drivers/mmc/host/wbsd.c
@@ -1995,11 +1995,11 @@ static void __exit wbsd_drv_exit(void)
 module_init(wbsd_drv_init);
 module_exit(wbsd_drv_exit);
 #ifdef CONFIG_PNP
-module_param_named(nopnp, param_nopnp, uint, 0444);
+module_param_named(nopnp, param_nopnp, uint, S_IRUSR | S_IRGRP | S_IROTH);
 #endif
-module_param_named(io, param_io, uint, 0444);
-module_param_named(irq, param_irq, uint, 0444);
-module_param_named(dma, param_dma, int, 0444);
+module_param_named(io, param_io, uint, S_IRUSR | S_IRGRP | S_IROTH);
+module_param_named(irq, param_irq, uint, S_IRUSR | S_IRGRP | S_IROTH);
+module_param_named(dma, param_dma, int, S_IRUSR | S_IRGRP | S_IROTH);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Pierre Ossman <pierre@ossman.eu>");
-- 
2.9.2
