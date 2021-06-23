Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C31C4743C
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Jun 2021 10:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88FA061164
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Jun 2021 10:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhFWKT2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 23 Jun 2021 06:19:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:15880 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229833AbhFWKT2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 23 Jun 2021 06:19:28 -0400
IronPort-SDR: 48OgBCeQ7QyssF+0HCGf3WgQtphdeJ0IdN0IES1EO7Fm2qRkpbpH92M3z8+z8Xf3zZPMrBj9pB
 gw5KVCehEv3A==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="207171294"
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="207171294"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2021 03:17:10 -0700
IronPort-SDR: EIuF4L3ycT8/hvv56l8I+BGfmhJ+BFTROkuRe9snHvH8R2U/xoLiviiEBCkH/P3tms9/h7JNe3
 BTsboYVqvllA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="417685362"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 23 Jun 2021 03:17:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DF94F23A; Wed, 23 Jun 2021 13:17:33 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v1 1/1] mmc: mmc_spi: Simplify busy loop in mmc_spi_skip()
Date:   Wed, 23 Jun 2021 13:17:31 +0300
Message-Id: <20210623101731.87885-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Infinite loops are hard to read and understand because of
hidden main loop condition. Simplify such one in mmc_spi_skip().

Using schedule() to schedule (and be friendly to others)
is discouraged and cond_resched() should be used instead.
Hence, replace schedule() with cond_resched() at the same
time.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/mmc_spi.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 65c65bb5737f..a1bcde3395a6 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -180,7 +180,7 @@ static int mmc_spi_skip(struct mmc_spi_host *host, unsigned long timeout,
 	u8 *cp = host->data->status;
 	unsigned long start = jiffies;
 
-	while (1) {
+	do {
 		int		status;
 		unsigned	i;
 
@@ -193,16 +193,9 @@ static int mmc_spi_skip(struct mmc_spi_host *host, unsigned long timeout,
 				return cp[i];
 		}
 
-		if (time_is_before_jiffies(start + timeout))
-			break;
-
-		/* If we need long timeouts, we may release the CPU.
-		 * We use jiffies here because we want to have a relation
-		 * between elapsed time and the blocking of the scheduler.
-		 */
-		if (time_is_before_jiffies(start + 1))
-			schedule();
-	}
+		/* If we need long timeouts, we may release the CPU */
+		cond_resched();
+	} while (time_is_after_jiffies(start + timeout));
 	return -ETIMEDOUT;
 }
 
-- 
2.30.2

