From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 01/15] mmc: sdhci: Fix incorrect ADMA2 descriptor table size
Date: Tue,  4 Nov 2014 12:42:35 +0200
Message-ID: <1415097769-19032-2-git-send-email-adrian.hunter@intel.com>
References: <1415097769-19032-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:9170 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752617AbaKDKoW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 4 Nov 2014 05:44:22 -0500
In-Reply-To: <1415097769-19032-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

The ADMA2 descriptor table size was being calculated incorrectly
Fix it.

Note that it has been wrong for a long time and likely has not
caused any problems because of a combination of 1) not needing
alignment descriptors for block operations 2) more memory being
allocated than was requested 3) the use of
SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC which does not use an extra
descriptor for the end marker.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 062222a..41c6d3b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -44,7 +44,13 @@
 
 #define MAX_TUNING_LOOP 40
 
-#define ADMA_SIZE	((128 * 2 + 1) * 4)
+/*
+ * The ADMA2 descriptor table size is calculated as the maximum number of
+ * segments (128), times 2 to allow for an alignment descriptor for each
+ * segment, plus 1 for a nop end descriptor, all multipled by the 32-bit
+ * descriptor size (8).
+ */
+#define ADMA_SIZE	((128 * 2 + 1) * 8)
 
 static unsigned int debug_quirks = 0;
 static unsigned int debug_quirks2;
-- 
1.9.1

