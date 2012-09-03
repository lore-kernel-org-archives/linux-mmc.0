From: Vinit Shenoy <vinit.shenoy@st.com>
Subject: [PATCH 1/1] mmc: debugfs: Set frequency to maximum possible on higher request
Date: Mon, 3 Sep 2012 16:38:39 +0530
Message-ID: <1346670519-13097-1-git-send-email-vinit.shenoy@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog108.obsmtp.com ([207.126.144.125]:56027 "EHLO
	eu1sys200aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756254Ab2ICLJs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Sep 2012 07:09:48 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, per.forlin@linaro.org, andy.shevchenko@gmail.com, viresh.kumar@linaro.org
Cc: linux-mmc@vger.kernel.org, spear-devel@list.st.com, Vinit Shenoy <vinit.shenoy@st.com>

Currently if we enter a frequency greater than maximum supported,
-EINVAL is returned. Due to this clock is not switched to maximum
supported frequency.

For example consider the max supported frequency to be 48MHz

echo 20000000 > /sys/kernel/debug/mmc0/clock Here clock is switched to 20Mhz.

echo 80000000 > /sys/kernel/debug/mmc0/clock
Ideally clock should be set back to 48MHz, but it is still set to 20MHz.

This patch sets value to f_max when the requested frequency is greater
than f_max

Signed-off-by: Vinit Shenoy <vinit.shenoy@st.com>
---
 drivers/mmc/core/debugfs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index 9ab5b17..c71d3eb 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -174,7 +174,7 @@ static int mmc_clock_opt_set(void *data, u64 val)
 
 	/* We need this check due to input value is u64 */
 	if (val > host->f_max)
-		return -EINVAL;
+		val = host->f_max;
 
 	mmc_claim_host(host);
 	mmc_set_clock(host, (unsigned int) val);
-- 
1.7.3.4

