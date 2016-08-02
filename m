From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0695/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:37:32 +0800
Message-ID: <20160802113732.28395-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: oakad@yahoo.com, ulf.hansson@linaro.org, jirislaby@gmail.com, mchehab@redhat.com, m.chehab@samsung.com, pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
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
 drivers/mmc/host/tifm_sd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tifm_sd.c b/drivers/mmc/host/tifm_sd.c
index 93c4b40..5f86ece 100644
--- a/drivers/mmc/host/tifm_sd.c
+++ b/drivers/mmc/host/tifm_sd.c
@@ -24,8 +24,8 @@
 
 static bool no_dma = 0;
 static bool fixed_timeout = 0;
-module_param(no_dma, bool, 0644);
-module_param(fixed_timeout, bool, 0644);
+module_param(no_dma, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+module_param(fixed_timeout, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
 /* Constants here are mostly from OMAP5912 datasheet */
 #define TIFM_MMCSD_RESET      0x0002
-- 
2.9.2
