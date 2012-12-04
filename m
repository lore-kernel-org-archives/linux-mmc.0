From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 3/3] mmc: sdhci: check voltage range only on regulators aware
 of voltage value
Date: Tue, 04 Dec 2012 15:01:03 +0100
Message-ID: <1354629663-29091-4-git-send-email-m.szyprowski@samsung.com>
References: <1354629663-29091-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1354629663-29091-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Chris Ball <cjb@laptop.org>, Kevin Liu <keyuan.liu@gmail.com>
List-Id: linux-mmc@vger.kernel.org

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
index a9ad2cd..d244dc0 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2930,7 +2930,11 @@ int sdhci_add_host(struct sdhci_host *host)
 	}
 
 #ifdef CONFIG_REGULATOR
-	if (host->vmmc && regulator_count_voltages(host->vmmc) > 1) {
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
