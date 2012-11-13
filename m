From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 3/3] mmc: sdhci: apply voltage range check only for non-fixed
 regulators
Date: Tue, 13 Nov 2012 09:48:53 +0100
Message-ID: <1352796533-12350-4-git-send-email-m.szyprowski@samsung.com>
References: <1352796533-12350-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1352796533-12350-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

Fixed regulators cannot change their voltage, so disable all voltage range
checking for them, otherwise the driver fails to operate with fixed
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
