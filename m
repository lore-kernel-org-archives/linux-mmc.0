From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 3/3 RESEND] mmc: sdhci: check voltage range only on regulators
 aware of voltage value
Date: Tue, 12 Feb 2013 09:01:36 +0100
Message-ID: <1360656096-1671-1-git-send-email-m.szyprowski@samsung.com>
References: <87bobqrcb4.fsf@octavius.laptop.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:57728 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752468Ab3BLICQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Feb 2013 03:02:16 -0500
In-reply-to: <87bobqrcb4.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Chris Ball <cjb@laptop.org>, Kevin Liu <keyuan.liu@gmail.com>

Some regulators don't report any voltage values, so checking supported
voltage range results in disabling all SDHCI_CAN_VDD_* flags and
registration failure. This patch finally provides a correct fix for the
registration of SDHCI driver with all possible voltage regulators:
dummy, fixed and regulated without using regulator_count_voltages()
hacks.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/mmc/host/sdhci.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ba586ae..735526b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2976,7 +2976,11 @@ int sdhci_add_host(struct sdhci_host *host)
 	}
 
 #ifdef CONFIG_REGULATOR
-	if (host->vmmc) {
+	/*
+	 * Voltage range check makes sense only if regulator reports
+	 * any voltage value.
+	 */
+	if (host->vmmc && regulator_get_voltage(host->vmmc) > 0) {
 		ret = regulator_is_supported_voltage(host->vmmc, 2700000,
 			3600000);
 		if ((ret <= 0) || (!(caps[0] & SDHCI_CAN_VDD_330)))
-- 
1.7.9.5

