From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH] mmc: Use regulator framework correctly
Date: Thu, 05 Aug 2010 11:10:06 +0300
Message-ID: <4C5A71DE.5020904@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:36683 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759851Ab0HEIKV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Aug 2010 04:10:21 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

>From 3f382fcf80afc4f28f471138ceb7b69b4055c9c3 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Thu, 5 Aug 2010 10:45:24 +0300
Subject: [PATCH] mmc: Use regulator framework correctly

Issues with the regulator framework no longer exist, so
regulator_enable() / regulator_disable() should be used
correctly.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/core/core.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 2cfefa6..da73899 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -784,11 +784,6 @@ int mmc_regulator_set_ocr(struct regulator *supply, unsigned short vdd_bit)
 {
 	int			result = 0;
 	int			min_uV, max_uV;
-	int			enabled;
-
-	enabled = regulator_is_enabled(supply);
-	if (enabled < 0)
-		return enabled;
 
 	if (vdd_bit) {
 		int		tmp;
@@ -819,9 +814,9 @@ int mmc_regulator_set_ocr(struct regulator *supply, unsigned short vdd_bit)
 		else
 			result = 0;
 
-		if (result == 0 && !enabled)
+		if (result == 0)
 			result = regulator_enable(supply);
-	} else if (enabled) {
+	} else {
 		result = regulator_disable(supply);
 	}
 
-- 
1.6.3.3
