From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [RFC] mmc: core: add the capability for broken voltage
Date: Mon, 16 Jan 2012 17:49:01 +0900
Message-ID: <4F13E47D.8040505@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:44901 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753603Ab2APItF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jan 2012 03:49:05 -0500
Received: from epcpsbgm2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LXV001GDV1O80G0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 16 Jan 2012 17:49:02 +0900 (KST)
Received: from [165.213.219.108] by mmp2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LXV001SQV5QHG80@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 16 Jan 2012 17:49:02 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>

This patch is added the MMC_CAP2_BROKEN_VOLTAGE.

if the voltage didn't satisfy between min_uV and max_uV,
try to change the voltage in core.c.
When change the voltage, maybe use the regulator_set_voltage().

In regulator_set_voltage(), check the below condition.

	/* sanity check */
	if (!rdev->desc->ops->set_voltage &&
	    !rdev->desc->ops->set_voltage_sel) {
		ret = -EINVAL;
		goto out;
	}

If Some-board should use the fixed-regulator, always return -EINVAL.
Then, eMMC didn't initialize always.

So if use the fixed-regulator or etc, we need to add the MMC_CAP2_BROKEN_VOLTAGE.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/core/core.c  |    4 ++++
 include/linux/mmc/host.h |    1 +
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index bec0bf2..6848789 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1121,6 +1121,10 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
 		 * might not allow this operation
 		 */
 		voltage = regulator_get_voltage(supply);
+
+		if (mmc->caps2 & MMC_CAP2_BROKEN_VOLTAGE)
+			min_uV = max_uV = voltage;
+
 		if (voltage < 0)
 			result = voltage;
 		else if (voltage < min_uV || voltage > max_uV)
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index dd13e05..5659aee 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -257,6 +257,7 @@ struct mmc_host {
 #define MMC_CAP2_HS200_1_2V_SDR	(1 << 6)        /* can support */
 #define MMC_CAP2_HS200		(MMC_CAP2_HS200_1_8V_SDR | \
 				 MMC_CAP2_HS200_1_2V_SDR)
+#define MMC_CAP2_BROKEN_VOLTAGE	(1 << 7)	/* Use the broken voltage */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 	unsigned int        power_notify_type;
