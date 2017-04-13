From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v3 2/3] mmc: sdhci-acpi: Add blacklist module option
Date: Thu, 13 Apr 2017 14:50:00 +0300
Message-ID: <994652a8-2b08-b4b6-fe42-d35af09d19c0@intel.com>
References: <20170412181922.31833-1-hdegoede@redhat.com>
 <20170412181922.31833-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:12373 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751349AbdDMLzl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 13 Apr 2017 07:55:41 -0400
In-Reply-To: <20170412181922.31833-2-hdegoede@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Takashi Iwai <tiwai@suse.de>, linux-mmc@vger.kernel.org

On 12/04/17 21:19, Hans de Goede wrote:
> Commit e5bbf30733f9 ("mmc: sdhci-acpi: Ensure connected devices are
> powered when probing") introduced unconditional calling of
> acpi_device_fix_up_power() on the mmc controller and its children.
> 
> This broke wifi on some systems because acpi_device_fix_up_power()
> was called even for disabled children sometimes leaving gpio-s in
> a state where wifi would not work, this was fixed in
> commit e1d070c3793a ("mmc: sdhci-acpi: Only powered up enabled acpi
> child devices").
> 
> Unfortunately on some devices calling acpi_device_fix_up_power()
> still causes issues. Specifically on the GPD-win mini clam-shell PC
> which has a pci-e wifi module, it causes the wifi module to get
> turned off. This is a BIOS bug and I've tried to get the manufacturer
> to fix this but sofar they have not responded (and even if they do
> then we cannot assume all users will update their BIOS).
> 
> Since the GPD-win uses a pci-e wifi module the sdhci controller for
> sdio cards really should not get initialized on it at all.

What if we move the call to acpi_device_fix_up_power() for the child
devices into the ->init_card() callback? i.e. it won't happen if there
is no card:


diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index c6a9a1bfaa22..dd97978f0361 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -81,6 +81,7 @@ struct sdhci_acpi_host {
 	const struct sdhci_acpi_slot	*slot;
 	struct platform_device		*pdev;
 	bool				use_runtime_pm;
+	bool				child_fixup_power_done;
 };
 
 static inline bool sdhci_acpi_flag(struct sdhci_acpi_host *c, unsigned int flag)
@@ -374,11 +375,29 @@ static const struct sdhci_acpi_slot *sdhci_acpi_get_slot(const char *hid,
 	return NULL;
 }
 
+static void sdhci_acpi_init_card(struct mmc_host *mmc, struct mmc_card *card)
+{
+	struct device *dev = mmc_dev(mmc);
+	struct sdhci_acpi_host *c = dev_get_drvdata(dev);
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	struct acpi_device *child;
+
+	if (c->child_fixup_power_done || !adev)
+		return;
+
+	/* Ensure child devices are powered on */
+	list_for_each_entry(child, &adev->children, node)
+		if (child->status.present && child->status.enabled)
+			acpi_device_fix_up_power(child);
+
+	c->child_fixup_power_done = true;
+}
+
 static int sdhci_acpi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	acpi_handle handle = ACPI_HANDLE(dev);
-	struct acpi_device *device, *child;
+	struct acpi_device *device;
 	struct sdhci_acpi_host *c;
 	struct sdhci_host *host;
 	struct resource *iomem;
@@ -390,11 +409,8 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	if (acpi_bus_get_device(handle, &device))
 		return -ENODEV;
 
-	/* Power on the SDHCI controller and its children */
+	/* Power on the SDHCI controller */
 	acpi_device_fix_up_power(device);
-	list_for_each_entry(child, &device->children, node)
-		if (child->status.present && child->status.enabled)
-			acpi_device_fix_up_power(child);
 
 	if (acpi_bus_get_status(device) || !device->status.present)
 		return -ENODEV;
@@ -432,6 +448,8 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	host->ops	= &sdhci_acpi_ops_dflt;
 	host->irq	= platform_get_irq(pdev, 0);
 
+	host->mmc_host_ops.init_card = sdhci_acpi_init_card;
+
 	host->ioaddr = devm_ioremap_nocache(dev, iomem->start,
 					    resource_size(iomem));
 	if (host->ioaddr == NULL) {

