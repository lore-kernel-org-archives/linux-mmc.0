From: dragos.tatulea@intel.com
Subject: [PATCH v2 14/26] mmc: panic write: bypass bus ref locking
Date: Thu,  8 Nov 2012 15:06:12 +0200
Message-ID: <1352379984-18381-15-git-send-email-dragos.tatulea@intel.com>
References: <1352379984-18381-1-git-send-email-dragos.tatulea@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:24988 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755712Ab2KHNEI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 8 Nov 2012 08:04:08 -0500
In-Reply-To: <1352379984-18381-1-git-send-email-dragos.tatulea@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: kirill.shutemov@linux.intel.com, irina.tirdea@intel.com, octavian.purdila@intel.com, tony.luck@intel.com, keescook@chromium.org, dragos.tatulea@gmail.com, Adrian Hunter <adrian.hunter@intel.com>

From: Adrian Hunter <adrian.hunter@intel.com>

We want to avoid it while panic dumping.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 drivers/mmc/core/core.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 4fd7061..3daec19 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1418,6 +1418,11 @@ static inline void mmc_bus_get(struct mmc_host *host)
 {
 	unsigned long flags;
 
+	if (mmc_am_panic_task(host)) {
+		host->bus_refs++;
+		return;
+	}
+
 	spin_lock_irqsave(&host->lock, flags);
 	host->bus_refs++;
 	spin_unlock_irqrestore(&host->lock, flags);
@@ -1431,6 +1436,11 @@ static inline void mmc_bus_put(struct mmc_host *host)
 {
 	unsigned long flags;
 
+	if (mmc_am_panic_task(host)) {
+		host->bus_refs--;
+		return;
+	}
+
 	spin_lock_irqsave(&host->lock, flags);
 	host->bus_refs--;
 	if ((host->bus_refs == 0) && host->bus_ops)
-- 
1.7.9.5

