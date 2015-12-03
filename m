From: Philip Elcan <pelcan@codeaurora.org>
Subject: [PATCH] mmc: sdhci-acpi: set non-removable in ACPI table
Date: Thu,  3 Dec 2015 08:48:00 -0500
Message-ID: <1449150480-1173-1-git-send-email-pelcan@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, Timur Tabi <timur@codeaurora.org>, Jon Masters <jcm@redhat.org>, Mark Langsdorf <mlangsdo@redhat.com>, Philip Elcan <pelcan@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

This allows setting an SDHC controller as non-removable
by using the _RMV method in the ACPI table. It doesn't
mark it as non-removable if GPIO card detection is
already setup.

Signed-off-by: Philip Elcan <pelcan@codeaurora.org>
---
 drivers/mmc/host/sdhci-acpi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index f6047fc..8c06ba6 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -288,6 +288,20 @@ static const struct sdhci_acpi_slot *sdhci_acpi_get_slot(const char *hid,
 	return NULL;
 }
 
+static bool sdhci_acpi_is_removable(acpi_handle handle)
+{
+	acpi_status status;
+	unsigned long long removable = 1; /* default to removable */
+
+	if (acpi_has_method(handle, "_EJ0"))
+		return true;
+	status = acpi_evaluate_integer(handle, "_RMV", NULL, &removable);
+	if (ACPI_SUCCESS(status) && !removable)
+		return false;
+
+	return true;
+}
+
 static int sdhci_acpi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -300,6 +314,7 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	const char *hid;
 	const char *uid;
 	int err;
+	bool gpio_cd = false;
 
 	if (acpi_bus_get_device(handle, &device))
 		return -ENODEV;
@@ -373,9 +388,14 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 		if (mmc_gpiod_request_cd(host->mmc, NULL, 0, v, 0, NULL)) {
 			dev_warn(dev, "failed to setup card detect gpio\n");
 			c->use_runtime_pm = false;
+		} else {
+			gpio_cd = true;
 		}
 	}
 
+	if (!gpio_cd && !sdhci_acpi_is_removable(handle))
+		host->mmc->caps |= MMC_CAP_NONREMOVABLE;
+
 	err = sdhci_add_host(host);
 	if (err)
 		goto err_free;
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
