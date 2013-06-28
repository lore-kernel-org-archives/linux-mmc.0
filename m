From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 0/2] mmc: add support for eMMC hardware reset for BYT
 eMMC
Date: Fri, 28 Jun 2013 10:26:35 +0300
Message-ID: <51CD3AAB.2090508@intel.com>
References: <1371113427-8257-1-git-send-email-adrian.hunter@intel.com> <87txkjmtvu.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:10033 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752072Ab3F1HUm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 28 Jun 2013 03:20:42 -0400
In-Reply-To: <87txkjmtvu.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

On 27/06/13 18:54, Chris Ball wrote:
> Hi Adrian,
> 
> On Thu, Jun 13 2013, Adrian Hunter wrote:
>> Here are 2 patches to add support for eMMC hardware reset for BYT eMMC.
>>
>>
>> Adrian Hunter (2):
>>       mmc: sdhci-pci: add support for eMMC hardware reset for BYT eMMC.
>>       mmc: sdhci-acpi: add support for eMMC hardware reset for HID 80860F14
>>
>>  drivers/mmc/host/sdhci-acpi.c | 28 +++++++++++++++++++++++++++-
>>  drivers/mmc/host/sdhci-pci.c  | 32 ++++++++++++++++++++++++++++++--
>>  2 files changed, 57 insertions(+), 3 deletions(-)
> 
> Thanks, both pushed to mmc-next for 3.11.

Thanks, but "mmc: sdhci-pci: add support for eMMC hardware reset for BYT
eMMC." has been mixed with someone else's patch. i.e. it now looks like this:


commit 4bef939873882b5f04b51e3e72e92dad1fdc527d
Author: Adrian Hunter <adrian.hunter@intel.com>
Date:   Thu Jun 13 11:50:26 2013 +0300

    mmc: sdhci-pci: add support for eMMC hardware reset for BYT eMMC.

    Add support for eMMC hardware reset for BYT eMMC.

    Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
    Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/host/dw_mmc.h    |  2 +-
 drivers/mmc/host/sdhci-pci.c | 32 ++++++++++++++++++++++++++++++--
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 81b2994..e3bf5a0 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -111,7 +111,7 @@
 #define SDMMC_INT_ERROR			0xbfc2
 /* Command register defines */
 #define SDMMC_CMD_START			BIT(31)
-#define SDMMC_CMD_USE_HOLD_REG	BIT(29)
+#define SDMMC_CMD_USE_HOLD_REG		BIT(29)
 #define SDMMC_CMD_CCS_EXP		BIT(23)
 #define SDMMC_CMD_CEATA_RD		BIT(22)
 #define SDMMC_CMD_UPD_CLK		BIT(21)
diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 611331a..e082fac 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -77,6 +77,8 @@ struct sdhci_pci_slot {
 	int			rst_n_gpio;
 	int			cd_gpio;
 	int			cd_irq;
+
+	void (*hw_reset)(struct sdhci_host *host);
 };

 struct sdhci_pci_chip {
@@ -307,10 +309,27 @@ static const struct sdhci_pci_fixes
sdhci_intel_pch_sdio = {
 	.probe_slot	= pch_hc_probe_slot,
 };

+static void sdhci_pci_int_hw_reset(struct sdhci_host *host)
+{
+	u8 reg;
+
+	reg = sdhci_readb(host, SDHCI_POWER_CONTROL);
+	reg |= 0x10;
+	sdhci_writeb(host, reg, SDHCI_POWER_CONTROL);
+	/* For eMMC, minimum is 1us but give it 9us for good measure */
+	udelay(9);
+	reg &= ~0x10;
+	sdhci_writeb(host, reg, SDHCI_POWER_CONTROL);
+	/* For eMMC, minimum is 200us but give it 300us for good measure */
+	usleep_range(300, 1000);
+}
+
 static int byt_emmc_probe_slot(struct sdhci_pci_slot *slot)
 {
-	slot->host->mmc->caps |= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE;
+	slot->host->mmc->caps |= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE |
+				 MMC_CAP_HW_RESET;
 	slot->host->mmc->caps2 |= MMC_CAP2_HC_ERASE_SZ;
+	slot->hw_reset = sdhci_pci_int_hw_reset;
 	return 0;
 }

@@ -1016,7 +1035,7 @@ static int sdhci_pci_bus_width(struct sdhci_host
*host, int width)
 	return 0;
 }

-static void sdhci_pci_hw_reset(struct sdhci_host *host)
+static void sdhci_pci_gpio_hw_reset(struct sdhci_host *host)
 {
 	struct sdhci_pci_slot *slot = sdhci_priv(host);
 	int rst_n_gpio = slot->rst_n_gpio;
@@ -1031,6 +1050,14 @@ static void sdhci_pci_hw_reset(struct sdhci_host *host)
 	usleep_range(300, 1000);
 }

+static void sdhci_pci_hw_reset(struct sdhci_host *host)
+{
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+
+	if (slot->hw_reset)
+		slot->hw_reset(host);
+}
+
 static const struct sdhci_ops sdhci_pci_ops = {
 	.enable_dma	= sdhci_pci_enable_dma,
 	.platform_bus_width	= sdhci_pci_bus_width,
@@ -1328,6 +1355,7 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 		if (!gpio_request(slot->rst_n_gpio, "eMMC_reset")) {
 			gpio_direction_output(slot->rst_n_gpio, 1);
 			slot->host->mmc->caps |= MMC_CAP_HW_RESET;
+			slot->hw_reset = sdhci_pci_gpio_hw_reset;
 		} else {
 			dev_warn(&pdev->dev, "failed to request rst_n_gpio\n");
 			slot->rst_n_gpio = -EINVAL;
