From: Chuanxiao Dong <chuanxiao.dong@intel.com>
Subject: [PATCH v1 3/3]mmc: not clock gate host when host is in runtime
	suspended state
Date: Fri, 14 Jan 2011 16:23:24 +0800
Message-ID: <20110114082324.GD27523@intel.com>
Reply-To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:30367 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751046Ab1ANI3n (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 14 Jan 2011 03:29:43 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, cjb@laptop.org, ohad@wizery.com

Since mmc clock gating is done in a work queue which is not synchronized with
host runtime power management, when driver is doing clock gating, host may
has already been power gated.

So before driver clock gate host, check whether host is already suspended.

Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
---
 drivers/mmc/core/core.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index e296c5a..d2121fa 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -670,6 +670,17 @@ void mmc_gate_clock(struct mmc_host *host)
 	host->ios.clock = 0;
 	host->clk_gated = true;
 	spin_unlock_irqrestore(&host->clk_lock, flags);
+#ifdef CONFIG_PM_RUNTIME
+	/*
+	 * mmc clock gating is done in a work queue which
+	 * does not synchronized with host controller runtime
+	 * power management. So when mmc gate clock, host may
+	 * have already in runtime suspend state. In that case,
+	 * driver cannot touch host controller registers
+	 */
+	if (host->class_dev.power.runtime_status != RPM_ACTIVE)
+		return;
+#endif
 	mmc_set_ios(host);
 }
 
-- 
1.6.6.1

