From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0694/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:37:27 +0800
Message-ID: <20160802113727.28329-1-baolex.ni@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:10577 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934573AbcHBMUm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 2 Aug 2016 08:20:42 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: saschasommer@freenet.de, ulf.hansson@linaro.org, jirislaby@gmail.com, mchehab@redhat.com, m.chehab@samsung.com, pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, jonathanh@nvidia.com, grundler@chromium.org, lporzio@micron.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/mmc/host/sdricoh_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdricoh_cs.c b/drivers/mmc/host/sdricoh_cs.c
index 5ff26ab..63f05e0 100644
--- a/drivers/mmc/host/sdricoh_cs.c
+++ b/drivers/mmc/host/sdricoh_cs.c
@@ -538,7 +538,7 @@ static struct pcmcia_driver sdricoh_driver = {
 };
 module_pcmcia_driver(sdricoh_driver);
 
-module_param(switchlocked, uint, 0444);
+module_param(switchlocked, uint, S_IRUSR | S_IRGRP | S_IROTH);
 
 MODULE_AUTHOR("Sascha Sommer <saschasommer@freenet.de>");
 MODULE_DESCRIPTION("Ricoh PCMCIA Secure Digital Interface driver");
-- 
2.9.2

