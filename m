From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2] mmc: sdhci: apply voltage range check only for non-fixed
 regulators
Date: Tue, 13 Nov 2012 14:32:14 +0100
Message-ID: <1352813534-6795-1-git-send-email-m.szyprowski@samsung.com>
References: <87fw4dn030.fsf@octavius.laptop.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:21240 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499Ab2KMNdE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Nov 2012 08:33:04 -0500
In-reply-to: <87fw4dn030.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Chris Ball <cjb@laptop.org>

Fixed regulators cannot change their voltage, so disable all voltage
range checking for them, otherwise the driver fails to operate with
fixed regulators. Up to now it worked only by luck, because
regulator_is_supported_voltage() function returned incorrect values.
Commit "regulator: fix voltage check in regulator_is_supported_voltage()"
fixed that function and now additional check is needed for fixed
regulators.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/mmc/host/sdhci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c7851c0..6f6534e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2923,7 +2923,7 @@ int sdhci_add_host(struct sdhci_host *host)
 		regulator_enable(host->vmmc);
 
 #ifdef CONFIG_REGULATOR
-	if (host->vmmc) {
+	if (host->vmmc && regulator_count_voltages(host->vmmc) > 1) {
 		ret = regulator_is_supported_voltage(host->vmmc, 3300000,
 			3300000);
 		if ((ret <= 0) || (!(caps[0] & SDHCI_CAN_VDD_330)))
-- 
1.7.9.5

