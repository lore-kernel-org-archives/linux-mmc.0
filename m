From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 2/4] mmc: include cd-gpio.h in the source file
Date: Fri, 13 Apr 2012 17:54:12 +0530
Message-ID: <1334319854-5989-3-git-send-email-svenkatr@ti.com>
References: <1334319854-5989-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42814 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754943Ab2DMMYw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 13 Apr 2012 08:24:52 -0400
In-Reply-To: <1334319854-5989-1-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org
Cc: Venkatraman S <svenkatr@ti.com>

Include the corresponding header file in cd-gpio.c
for prototype consistency. This gets rid of some
sparse warnings.

Signed-off-by: Venkatraman S <svenkatr@ti.com>
---

 drivers/mmc/core/cd-gpio.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/core/cd-gpio.c b/drivers/mmc/core/cd-gpio.c
index 29de31e..da7c3f9 100644
--- a/drivers/mmc/core/cd-gpio.c
+++ b/drivers/mmc/core/cd-gpio.c
@@ -13,6 +13,7 @@
 #include <linux/interrupt.h>
 #include <linux/jiffies.h>
 #include <linux/mmc/host.h>
+#include <linux/mmc/cd-gpio.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 
-- 
1.7.10.rc2

