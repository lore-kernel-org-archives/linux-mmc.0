From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/1] mmc: sdhci-pci: add another device id
Date: Fri, 28 Jun 2013 10:20:15 +0300
Message-ID: <51CD392F.7020702@intel.com>
References: <1371722279-16975-1-git-send-email-adrian.hunter@intel.com> <1371722279-16975-2-git-send-email-adrian.hunter@intel.com> <874ncjmtc3.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:53878 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750813Ab3F1HOU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 28 Jun 2013 03:14:20 -0400
In-Reply-To: <874ncjmtc3.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

On 27/06/13 19:06, Chris Ball wrote:
> Hi Adrian,
> 
> On Thu, Jun 20 2013, Adrian Hunter wrote:
>> Add another PCI device id for an eMMC host controller.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  drivers/mmc/host/sdhci-pci.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
>> index e082fac..d7d6bc8 100644
>> --- a/drivers/mmc/host/sdhci-pci.c
>> +++ b/drivers/mmc/host/sdhci-pci.c
>> @@ -36,6 +36,7 @@
>>  #define PCI_DEVICE_ID_INTEL_BYT_EMMC	0x0f14
>>  #define PCI_DEVICE_ID_INTEL_BYT_SDIO	0x0f15
>>  #define PCI_DEVICE_ID_INTEL_BYT_SD	0x0f16
>> +#define PCI_DEVICE_ID_INTEL_BYT_EMMC2	0x0f50
>>  
>>  /*
>>   * PCI registers
>> @@ -931,6 +932,14 @@ static const struct pci_device_id pci_ids[] = {
>>  	},
>>  
>>  	{
>> +		.vendor		= PCI_VENDOR_ID_INTEL,
>> +		.device		= PCI_DEVICE_ID_INTEL_BYT_EMMC2,
>> +		.subvendor	= PCI_ANY_ID,
>> +		.subdevice	= PCI_ANY_ID,
>> +		.driver_data	= (kernel_ulong_t)&sdhci_intel_byt_emmc,
>> +	},
>> +
>> +	{
>>  		.vendor		= PCI_VENDOR_ID_O2,
>>  		.device		= PCI_DEVICE_ID_O2_8120,
>>  		.subvendor	= PCI_ANY_ID,
> 
> Thanks, pushed to mmc-next for 3.11.

Thanks, but the patch on mmc-next has been mixed with someone else's patch
i.e. it now looks like this:

commit 058f4266c105df59b036625f9afbe96d3fc3ec1d
Author: Adrian Hunter <adrian.hunter@intel.com>
Date:   Thu Jun 20 12:57:59 2013 +0300

    mmc: sdhci-pci: add another device id

    Add another PCI device id for an eMMC host controller.

    Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
    Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 17 +++++++++++++++++
 drivers/mmc/host/sdhci-pci.c      |  9 +++++++++
 include/linux/mmc/sdhci.h         |  2 ++
 3 files changed, 28 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c
b/drivers/mmc/host/sdhci-of-esdhc.c
index b2a635e..15039e2 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -121,6 +121,13 @@ static void esdhc_writeb(struct sdhci_host *host, u8
val, int reg)
 	if (reg == SDHCI_HOST_CONTROL) {
 		u32 dma_bits;

+		/*
+		 * If host control register is not standard, exit
+		 * this function
+		 */
+		if (host->quirks2 & SDHCI_QUIRK2_BROKEN_HOST_CONTROL)
+			return;
+
 		/* DMA select is 22,23 bits in Protocol Control Register */
 		dma_bits = (val & SDHCI_CTRL_DMA_MASK) << 5;
 		clrsetbits_be32(host->ioaddr + reg , SDHCI_CTRL_DMA_MASK << 5,
@@ -289,6 +296,7 @@ static const struct sdhci_pltfm_data sdhci_esdhc_pdata = {
 static int sdhci_esdhc_probe(struct platform_device *pdev)
 {
 	struct sdhci_host *host;
+	struct device_node *np;
 	int ret;

 	host = sdhci_pltfm_init(pdev, &sdhci_esdhc_pdata, 0);
@@ -297,6 +305,15 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)

 	sdhci_get_of_property(pdev);

+	np = pdev->dev.of_node;
+	if (of_device_is_compatible(np, "fsl,p2020-esdhc")) {
+		/*
+		 * Freescale messed up with P2020 as it has a non-standard
+		 * host control register
+		 */
+		host->quirks2 |= SDHCI_QUIRK2_BROKEN_HOST_CONTROL;
+	}
+
 	/* call to generic mmc_of_parse to support additional capabilities */
 	mmc_of_parse(host->mmc);

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index e082fac..d7d6bc8 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -36,6 +36,7 @@
 #define PCI_DEVICE_ID_INTEL_BYT_EMMC	0x0f14
 #define PCI_DEVICE_ID_INTEL_BYT_SDIO	0x0f15
 #define PCI_DEVICE_ID_INTEL_BYT_SD	0x0f16
+#define PCI_DEVICE_ID_INTEL_BYT_EMMC2	0x0f50

 /*
  * PCI registers
@@ -931,6 +932,14 @@ static const struct pci_device_id pci_ids[] = {
 	},

 	{
+		.vendor		= PCI_VENDOR_ID_INTEL,
+		.device		= PCI_DEVICE_ID_INTEL_BYT_EMMC2,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_intel_byt_emmc,
+	},
+
+	{
 		.vendor		= PCI_VENDOR_ID_O2,
 		.device		= PCI_DEVICE_ID_O2_8120,
 		.subvendor	= PCI_ANY_ID,
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index a745180..e3c6a74 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -96,6 +96,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_NO_1_8_V				(1<<2)
 #define SDHCI_QUIRK2_PRESET_VALUE_BROKEN		(1<<3)
 #define SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON		(1<<4)
+/* Controller has a non-standard host control register */
+#define SDHCI_QUIRK2_BROKEN_HOST_CONTROL		(1<<5)

 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */

