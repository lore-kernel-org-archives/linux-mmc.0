From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [RFC PATCH 3/4] mmc: sdhci-acpi: Fix device hang on Intel BayTrail
Date: Tue, 24 Mar 2015 15:40:39 +0200
Message-ID: <1427204440-3533-4-git-send-email-adrian.hunter@intel.com>
References: <1427204440-3533-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427204440-3533-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Intel Baytrail has been observed sometimes to hang
if host controllers are using DMA while deep C-states
are used. Workaround that by specifying a maximum
DMA latency that will prevent deep C-states.

Unfortunately, host controller ACPI HIDs are not unique
to Baytrail, so the CPU must be identified.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-acpi.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 22d929f..eaff09f 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -43,6 +43,24 @@
 
 #include "sdhci.h"
 
+#ifdef CONFIG_X86
+#include <asm/cpu_device_id.h>
+static bool sdhci_acpi_on_byt(void)
+{
+	static const struct x86_cpu_id byt[] = {
+		{ X86_VENDOR_INTEL, 6, 0x37 },
+		{}
+	};
+
+	return x86_match_cpu(byt);
+}
+#else
+static bool sdhci_acpi_on_byt(void)
+{
+	return false;
+}
+#endif
+
 enum {
 	SDHCI_ACPI_SD_CD		= BIT(0),
 	SDHCI_ACPI_RUNTIME_PM		= BIT(1),
@@ -146,6 +164,14 @@ static const struct sdhci_acpi_chip sdhci_acpi_chip_int = {
 	.ops = &sdhci_acpi_ops_int,
 };
 
+static void sdhci_acpi_int_dma_latency(struct sdhci_host *host)
+{
+	if (sdhci_acpi_on_byt()) {
+		host->dma_latency = 20;
+		host->lat_cancel_delay = 275;
+	}
+}
+
 static int sdhci_acpi_emmc_probe_slot(struct platform_device *pdev,
 				      const char *hid, const char *uid)
 {
@@ -164,6 +190,8 @@ static int sdhci_acpi_emmc_probe_slot(struct platform_device *pdev,
 	    sdhci_readl(host, SDHCI_CAPABILITIES_1) == 0x00000807)
 		host->timeout_clk = 1000; /* 1000 kHz i.e. 1 MHz */
 
+	sdhci_acpi_int_dma_latency(host);
+
 	return 0;
 }
 
@@ -178,6 +206,8 @@ static int sdhci_acpi_sdio_probe_slot(struct platform_device *pdev,
 
 	host = c->host;
 
+	sdhci_acpi_int_dma_latency(host);
+
 	/* Platform specific code during sdio probe slot goes here */
 
 	return 0;
@@ -194,6 +224,8 @@ static int sdhci_acpi_sd_probe_slot(struct platform_device *pdev,
 
 	host = c->host;
 
+	sdhci_acpi_int_dma_latency(host);
+
 	/* Platform specific code during sd probe slot goes here */
 
 	return 0;
-- 
1.9.1
