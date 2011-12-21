From: Dmitry Antipov <dmitry.antipov@linaro.org>
Subject: [PATCH] mmc: use usleep_range() in mmc_delay()
Date: Wed, 21 Dec 2011 10:56:16 +0400
Message-ID: <4EF18310.6080801@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:53598 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432Ab1LUGzl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Dec 2011 01:55:41 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linaro-dev@lists.linaro.org
Cc: patches@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

 From f447d78db65c6675e69466e8ed08364ff065ac08 Mon Sep 17 00:00:00 2001
From: Dmitry Antipov <dmitry.antipov@linaro.org>
Date: Wed, 21 Dec 2011 10:51:03 +0400
Subject: [PATCH] mmc: use usleep_range() in mmc_delay()

---
  drivers/mmc/core/core.h |    8 ++------
  1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 14664f1..a77851e 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -47,12 +47,8 @@ void mmc_power_off(struct mmc_host *host);

  static inline void mmc_delay(unsigned int ms)
  {
-	if (ms < 1000 / HZ) {
-		cond_resched();
-		mdelay(ms);
-	} else {
-		msleep(ms);
-	}
+	unsigned long us = ms * USEC_PER_MSEC;
+	usleep_range(us, us + 1000);
  }

  void mmc_rescan(struct work_struct *work);
-- 
1.7.7.4

