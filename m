From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] ACPI / LPSS: Work around wrong sdio _ADR 0 entry on some byt/cht devices
Date: Sun, 25 Dec 2016 11:21:48 +0100
Message-ID: <20161225102148.7706-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-acpi@vger.kernel.org, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-mmc@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The firmware on some cherrytrail devices wrongly adds _ADR 0 to their
entry describing the 80860F14 uid "2" sd-controller.

I believe the firmware writers intended this as a sdio function address,
but it is in the wrong place for this, so it gets interpreted as a pci
address, causing the node describing the sd-controller used for the
sdio-wifi to get seen as a firmware_node for the pci host bridge, rather
then being stand-alone device.

This commit adds a byt_sdio_setup function which detects this scenario
and removes the wrong firmware_node link from the pci host bridge, which
fixes acpi_create_platform_device returning NULL, leading to non-working
sdio-wifi.

BugLink: https://github.com/hadess/rtl8723bs/issues/80
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpi_lpss.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 373657f..df9cc66 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -84,6 +84,7 @@ static const struct lpss_device_desc lpss_dma_desc = {
 };
 
 struct lpss_private_data {
+	struct acpi_device *adev;
 	void __iomem *mmio_base;
 	resource_size_t mmio_size;
 	unsigned int fixed_clk_rate;
@@ -154,6 +155,33 @@ static void byt_i2c_setup(struct lpss_private_data *pdata)
 	writel(0, pdata->mmio_base + LPSS_I2C_ENABLE);
 }
 
+static void byt_sdio_setup(struct lpss_private_data *pdata)
+{
+	unsigned long long adr;
+	acpi_status status;
+	struct device *dev;
+
+	/*
+	 * Some firmware has a broken _ADR 0 enter for the 80860F14:2
+	 * device, which causes it to get seen as the firmware_node
+	 * for the pci host bridge, rather then a stand alone device.
+	 *
+	 * Check if this is the case, and if it is remove the link.
+	 */
+	if (strcmp(acpi_device_uid(pdata->adev), "2") != 0)
+		return;
+
+	status = acpi_evaluate_integer(pdata->adev->handle, "_ADR", NULL, &adr);
+	if (ACPI_FAILURE(status) || adr != 0)
+		return;
+
+	dev = acpi_get_first_physical_node(pdata->adev);
+	if (!dev)
+		return;
+
+	acpi_unbind_one(dev);
+}
+
 static const struct lpss_device_desc lpt_dev_desc = {
 	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_LTR,
 	.prv_offset = 0x800,
@@ -217,6 +245,7 @@ static const struct lpss_device_desc byt_spi_dev_desc = {
 
 static const struct lpss_device_desc byt_sdio_dev_desc = {
 	.flags = LPSS_CLK,
+	.setup = byt_sdio_setup,
 };
 
 static const struct lpss_device_desc byt_i2c_dev_desc = {
@@ -425,6 +454,7 @@ static int acpi_lpss_create_device(struct acpi_device *adev,
 		goto err_out;
 	}
 
+	pdata->adev = adev;
 	pdata->dev_desc = dev_desc;
 
 	if (dev_desc->setup)
-- 
2.9.3

