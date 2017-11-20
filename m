From: Jesse Chan <jc@linux.com>
Subject: [PATCH] mmc: renesas_sdhi: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
Date: Mon, 20 Nov 2017 13:32:36 -0800
Message-ID: <20171120213236.53266-1-jc@linux.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38938 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753161AbdKTVcm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Nov 2017 16:32:42 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: Jesse Chan <jc@linux.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

This change resolves a new compile-time warning
when built as a loadable module:

WARNING: modpost: missing MODULE_LICENSE() in drivers/mmc/host/renesas_sdhi_core.o
see include/linux/module.h for more information

This adds the license as "GPL v2", which matches the header of the file.

MODULE_DESCRIPTION and MODULE_AUTHOR are also added.

Signed-off-by: Jesse Chan <jc@linux.com>
---
 drivers/mmc/host/renesas_sdhi.h               | 1 +
 drivers/mmc/host/renesas_sdhi_core.c          | 5 +++++
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 1 -
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      | 1 -
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index b9dfea5d8193..090cf86d7cd3 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -13,6 +13,7 @@
 #define RENESAS_SDHI_H
 
 #include <linux/platform_device.h>
+#include <linux/module.h>
 #include "tmio_mmc.h"
 
 struct renesas_sdhi_scc {
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index fcf7235d5742..0a0daa7a342f 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -667,3 +667,8 @@ int renesas_sdhi_remove(struct platform_device *pdev)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(renesas_sdhi_remove);
+
+MODULE_DESCRIPTION("Renesas SDHI driver");
+MODULE_AUTHOR("Phil Blundell <pb@handhelds.org>");
+MODULE_AUTHOR("Samuel Ortiz <sameo@openedhand.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 41cbe84c1d18..a9b452b42fac 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -15,7 +15,6 @@
 #include <linux/mfd/tmio.h>
 #include <linux/mmc/host.h>
 #include <linux/mod_devicetable.h>
-#include <linux/module.h>
 #include <linux/pagemap.h>
 #include <linux/scatterlist.h>
 #include <linux/sys_soc.h>
diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index 9ab10436e4b8..fe6a09f14682 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -17,7 +17,6 @@
 #include <linux/mfd/tmio.h>
 #include <linux/mmc/host.h>
 #include <linux/mod_devicetable.h>
-#include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/pagemap.h>
 #include <linux/scatterlist.h>
-- 
2.14.1

