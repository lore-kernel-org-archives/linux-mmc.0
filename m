From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 1/2] mmc: core: move freqs table into core.h
Date: Wed, 20 Jul 2016 09:57:39 +0800
Message-ID: <1468979860-28712-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:48035 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753093AbcGTCAV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jul 2016 22:00:21 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>

We will reuse it outside the core.c file, so let's
move it to the header file.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 drivers/mmc/core/core.c | 2 --
 drivers/mmc/core/core.h | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 94cbf4e..0cec7f4 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -58,8 +58,6 @@
  */
 #define MMC_BKOPS_MAX_TIMEOUT	(4 * 60 * 1000) /* max time to wait in ms */
 
-static const unsigned freqs[] = { 400000, 300000, 200000, 100000 };
-
 /*
  * Enabling software CRCs on the data blocks can be a significant (30%)
  * performance cost, and for other reasons may not always be desired.
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 0fa86a2..5456000 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -54,6 +54,8 @@ void mmc_power_off(struct mmc_host *host);
 void mmc_power_cycle(struct mmc_host *host, u32 ocr);
 void mmc_set_initial_state(struct mmc_host *host);
 
+static const unsigned int freqs[] = { 400000, 300000, 200000, 100000 };
+
 static inline void mmc_delay(unsigned int ms)
 {
 	if (ms < 1000 / HZ) {
-- 
2.3.7


