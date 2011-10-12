From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH] mmc: sdhci: fix debug_quirks2 module parameter description
Date: Wed, 12 Oct 2011 15:44:39 +0300
Message-ID: <1318423479-3805-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:44442 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752862Ab1JLMpB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 12 Oct 2011 08:45:01 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

debug_quirks2 module parameter description was inadvertently added
as debug_quirks.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f530de6..2cc3ffa 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3058,4 +3058,4 @@ MODULE_DESCRIPTION("Secure Digital Host Controller Interface core driver");
 MODULE_LICENSE("GPL");
 
 MODULE_PARM_DESC(debug_quirks, "Force certain quirks.");
-MODULE_PARM_DESC(debug_quirks, "Force certain other quirks.");
+MODULE_PARM_DESC(debug_quirks2, "Force certain other quirks.");
-- 
1.7.6.4

