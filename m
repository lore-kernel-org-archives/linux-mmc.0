Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC8B53365
	for <linux-mmc@vger.kernel.org>; Thu, 14 Nov 2024 15:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599779; cv=none; b=j1qFtBAJW7pOyTWKRdl9rHgqZrtc+x/WTrZr9uuy3bkRsuxZ2CH/e2xhM2X+uHTn5yB88bpeMe2Zrr2OczmpYtYOxYp5hWNle2i+FeThYWrB32EwOq2xJlvVIQxgNsPA2Yofqiu9EYJ1hG6bPC2Au9bg1RNy3r8rTQXPqxmMCYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599779; c=relaxed/simple;
	bh=OdCbfoVAZF7OYiwMfY18VTYsBvZ/jYiwJz1NXu2gnXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J0eo2/cS3Abz/ukmd+PbAoy08ET+mC1UdzLW/s/hLNcNAOJntyWvY3hLypyKZsXb64V9feDGA+3JFFLRl0igTa70gpmvMNkmtOxLvxQJ4FjVKzs8+IpgR45XU+SlRFMjBGgVy7B0KRUqJeOtXxmm1RV5wqe2bg2dktw94245oI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=crY+3Spr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="crY+3Spr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731599776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x5FjMPrMfsoiPNyeB17OLR1MoaJAprN50ibFXfotm7E=;
	b=crY+3Sprc1DeRL7oxeANWQd8MnK9qZNJ36g3B+aFGlrgGYLAgtHKCN4mcHZMbUUPhXetaI
	m+qug7iwvrK99xDvUgrDRvokQ4Q14dsIN3++3MW4/lydVqjioRwguhWilU8ZNgsa4nGvUs
	HVlBgWIWvTI/IMiDocUkrtGpBmqGFJc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-3uJ3j6D7Pu2DXTtO8XCILw-1; Thu,
 14 Nov 2024 10:56:15 -0500
X-MC-Unique: 3uJ3j6D7Pu2DXTtO8XCILw-1
X-Mimecast-MFC-AGG-ID: 3uJ3j6D7Pu2DXTtO8XCILw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 305201956088;
	Thu, 14 Nov 2024 15:56:14 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.193.206])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D292819560A3;
	Thu, 14 Nov 2024 15:56:12 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-mmc@vger.kernel.org
Subject: [PATCH v3] mmc: sdhci-pci: Add DMI quirk for missing CD GPIO on Vexia Edu Atla 10 tablet
Date: Thu, 14 Nov 2024 16:56:11 +0100
Message-ID: <20241114155611.59577-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The Vexia Edu Atla 10 tablet distributed to schools in the Spanish
Andalucía region has no ACPI fwnode associated with the SDHCI controller
for its microsd-slot and thus has no ACPI GPIO resource info.

This causes the following error to be logged and the slot to not work:
[   10.572113] sdhci-pci 0000:00:12.0: failed to setup card detect gpio

Add a DMI quirk table for providing gpiod_lookup_tables with manually
provided CD GPIO info and use this DMI table to provide the CD GPIO info
on this tablet. This fixes the microsd-slot not working.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
- Add a cd_gpio_override pointer to sdhci_pci_fixes
- Add sdhci_pci_add_gpio_lookup_table() helper which kmemdup-s a const
  struct gpiod_lookup_table to avoid races when using async probing

Changes in v2:
- Make sdhci_pci_dmi_cd_gpio_overrides static const instead of just const
- Drop duplicate #include <linux/dmi.h> (already there at the end)
---
 drivers/mmc/host/sdhci-pci-core.c | 67 +++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pci.h      |  1 +
 2 files changed, 68 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index ed45ed0bdafd..a2ddbe3d8742 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -21,6 +21,7 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_qos.h>
 #include <linux/debugfs.h>
@@ -1235,6 +1236,29 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_sdio = {
 	.priv_size	= sizeof(struct intel_host),
 };
 
+/* DMI quirks for devices with missing or broken CD GPIO info */
+static const struct gpiod_lookup_table vexia_edu_atla10_cd_gpios = {
+	.dev_id = "0000:00:12.0",
+	.table = {
+		GPIO_LOOKUP("INT33FC:00", 38, "cd", GPIO_ACTIVE_HIGH),
+		{ }
+	},
+};
+
+static const struct dmi_system_id sdhci_intel_byt_cd_gpio_override[] = {
+	{
+		/* Vexia Edu Atla 10 tablet 9V version */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
+			DMI_MATCH(DMI_BOARD_NAME, "Aptio CRB"),
+			/* Above strings are too generic, also match on BIOS date */
+			DMI_MATCH(DMI_BIOS_DATE, "08/25/2014"),
+		},
+		.driver_data = (void *)&vexia_edu_atla10_cd_gpios,
+	},
+	{ }
+};
+
 static const struct sdhci_pci_fixes sdhci_intel_byt_sd = {
 #ifdef CONFIG_PM_SLEEP
 	.resume		= byt_resume,
@@ -1253,6 +1277,7 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_sd = {
 	.add_host	= byt_add_host,
 	.remove_slot	= byt_remove_slot,
 	.ops		= &sdhci_intel_byt_ops,
+	.cd_gpio_override = sdhci_intel_byt_cd_gpio_override,
 	.priv_size	= sizeof(struct intel_host),
 };
 
@@ -2054,6 +2079,37 @@ static const struct dev_pm_ops sdhci_pci_pm_ops = {
  *                                                                           *
 \*****************************************************************************/
 
+static struct gpiod_lookup_table *sdhci_pci_add_gpio_lookup_table(
+	struct sdhci_pci_chip *chip)
+{
+	struct gpiod_lookup_table *cd_gpio_lookup_table;
+	const struct dmi_system_id *dmi_id = NULL;
+
+	if (chip->fixes && chip->fixes->cd_gpio_override)
+		dmi_id = dmi_first_match(chip->fixes->cd_gpio_override);
+
+	if (!dmi_id)
+		return NULL;
+
+	cd_gpio_lookup_table = kmemdup(dmi_id->driver_data,
+				       /* 1 GPIO lookup entry + 1 terminating entry */
+				       struct_size(cd_gpio_lookup_table, table, 2),
+				       GFP_KERNEL);
+	if (!cd_gpio_lookup_table)
+		return ERR_PTR(-ENOMEM);
+
+	gpiod_add_lookup_table(cd_gpio_lookup_table);
+	return cd_gpio_lookup_table;
+}
+
+static void sdhci_pci_remove_gpio_lookup_table(struct gpiod_lookup_table *lookup_table)
+{
+	if (lookup_table) {
+		gpiod_remove_lookup_table(lookup_table);
+		kfree(lookup_table);
+	}
+}
+
 static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 	struct pci_dev *pdev, struct sdhci_pci_chip *chip, int first_bar,
 	int slotno)
@@ -2129,8 +2185,19 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 		device_init_wakeup(&pdev->dev, true);
 
 	if (slot->cd_idx >= 0) {
+		struct gpiod_lookup_table *cd_gpio_lookup_table;
+
+		cd_gpio_lookup_table = sdhci_pci_add_gpio_lookup_table(chip);
+		if (IS_ERR(cd_gpio_lookup_table)) {
+			ret = PTR_ERR(cd_gpio_lookup_table);
+			goto remove;
+		}
+
 		ret = mmc_gpiod_request_cd(host->mmc, "cd", slot->cd_idx,
 					   slot->cd_override_level, 0);
+
+		sdhci_pci_remove_gpio_lookup_table(cd_gpio_lookup_table);
+
 		if (ret && ret != -EPROBE_DEFER)
 			ret = mmc_gpiod_request_cd(host->mmc, NULL,
 						   slot->cd_idx,
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index 153704f812ed..4973fa859217 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -156,6 +156,7 @@ struct sdhci_pci_fixes {
 #endif
 
 	const struct sdhci_ops	*ops;
+	const struct dmi_system_id *cd_gpio_override;
 	size_t			priv_size;
 };
 
-- 
2.47.0

