From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH] mmc: renesas_sdhi: Add MODULE_LICENSE
Date: Wed, 13 Dec 2017 11:33:00 +0900
Message-ID: <1513132380-7421-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:23851 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752521AbdLMChj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Dec 2017 21:37:39 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: wsa+renesas@sang-engineering.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, stable@vger.kernel.org, Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

From: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>

The following error occurs when loading renesas_sdhi_core.c module,
so add MODULE_LICENSE("GPL v2").

 renesas_sdhi_core: module license 'unspecified' taints kernel.

Signed-off-by: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
Fixes: 9d08428afb72 ("mmc: renesas-sdhi: make renesas_sdhi_sys_dmac main module file")
Cc: <stable@vger.kernel.org> # v4.13+
[Shimoda: Added Fixes tag and Cc to the stable ML]
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index fcf7235..157e1d9 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -24,6 +24,7 @@
 #include <linux/kernel.h>
 #include <linux/clk.h>
 #include <linux/slab.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/mmc/host.h>
@@ -667,3 +668,5 @@ int renesas_sdhi_remove(struct platform_device *pdev)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(renesas_sdhi_remove);
+
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

