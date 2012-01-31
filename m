From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 1/2] mmc: core: add the capability for broken voltage.
Date: Tue, 31 Jan 2012 15:55:53 +0900
Message-ID: <4F279079.4000302@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:21229 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087Ab2AaG4B (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Jan 2012 01:56:01 -0500
Received: from epcpsbgm2.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LYN00BKTHSRNT90@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 31 Jan 2012 15:56:01 +0900 (KST)
Received: from [165.213.219.108] by mmp2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LYN008EJHXD2PB0@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 31 Jan 2012 15:56:01 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, m.szyprowski@samsung.com

This patch is added the MMC_CAP2_BROKEN_VOLTAGE.

"There is an understood mismatch between the voltage the host controller is
set to and the voltage supplied to the card by a fixed voltage regulator.
Teaching the driver to accept the mismatch is overly complicated.  Instead
just accept the regulator's voltage."

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
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
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
