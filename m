Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248D618FDA5
	for <linux-mmc@vger.kernel.org>; Wed,  6 Nov 2024 21:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730930376; cv=none; b=sqXzlrMdhnjT/0a+8Y5HRm/9HO1xutUOvQFKxktnCxm8VccJOkQ0T4/uSlAF9G7GeWYx51PEq6+HQuTCwT33pSnqzK3PfX2oi0MAvf0TvLiVzArXMuFMOhbpueIJSRuiSHZ7PJIi7jBp+J0nXojwqmgecDrU7z4rVxVyLWBGcLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730930376; c=relaxed/simple;
	bh=BsP0lygsoPPdaSn/KPoHtOSlu19u5SR52npiUH7UM9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fNgf3V1uzSEvrv/dwhVqr3lm+3DHhYRlV2VeE0LNkPeu0FlKKnCwbjojrRDyLHpFqw8BxedKiyhFo/n43BLMuyOz9qsT0tOazzHrV5L3Ag0lGudvNVDYIXT6I7GXL8S60O3oD85bosS4Bs1XeF1EGIQ+NQSvKkNJ7n+vs25Dg40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VxcclEzz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VxcclEzz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730930374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Mq1ovykBQxiIueFkqwLikLav8MbZd2NlWdg5r+aRm/k=;
	b=VxcclEzzRpAer5SR7m4pPX9ktT59Vk2IX8yHxkdTz1XkfZYc6P64fQo8f7xfJmJxuWm1uP
	6ZBfxXPocrEv71ofwVUtJbRj/Zt3wk2DMKy1bp5nY8gUAd+sRYz+w1MbD1lD5x336NIfzD
	9b/3SpjbIJrfPkBqfsMvn6CPfBk6Di8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-IbioooD9OCWc0GI2uGzIzA-1; Wed,
 06 Nov 2024 16:59:31 -0500
X-MC-Unique: IbioooD9OCWc0GI2uGzIzA-1
X-Mimecast-MFC-AGG-ID: IbioooD9OCWc0GI2uGzIzA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2296D195608A;
	Wed,  6 Nov 2024 21:59:30 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.71])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C2DDC19560AA;
	Wed,  6 Nov 2024 21:59:28 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: sdhci-pci: Add DMI quirk for missing CD GPIO on Vexia Edu Atla 10 tablet
Date: Wed,  6 Nov 2024 22:59:27 +0100
Message-ID: <20241106215927.40482-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

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
 drivers/mmc/host/sdhci-pci-core.c | 39 +++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index ed45ed0bdafd..eb9fb4ccd31b 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -11,6 +11,7 @@
 #include <linux/bitfield.h>
 #include <linux/string.h>
 #include <linux/delay.h>
+#include <linux/dmi.h>
 #include <linux/highmem.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -21,6 +22,7 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_qos.h>
 #include <linux/debugfs.h>
@@ -2054,6 +2056,29 @@ static const struct dev_pm_ops sdhci_pci_pm_ops = {
  *                                                                           *
 \*****************************************************************************/
 
+/* DMI quirks for devices with missing or broken CD GPIO info */
+static struct gpiod_lookup_table vexia_edu_atla10_cd_gpios = {
+	.dev_id = "0000:00:12.0",
+	.table = {
+		GPIO_LOOKUP("INT33FC:00", 38, "cd", GPIO_ACTIVE_HIGH),
+		{ }
+	},
+};
+
+const struct dmi_system_id sdhci_pci_dmi_cd_gpio_overrides[] = {
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
 static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 	struct pci_dev *pdev, struct sdhci_pci_chip *chip, int first_bar,
 	int slotno)
@@ -2129,8 +2154,22 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 		device_init_wakeup(&pdev->dev, true);
 
 	if (slot->cd_idx >= 0) {
+		struct gpiod_lookup_table *cd_gpio_lookup_table = NULL;
+		const struct dmi_system_id *dmi_id;
+
+		dmi_id = dmi_first_match(sdhci_pci_dmi_cd_gpio_overrides);
+		if (dmi_id)
+			cd_gpio_lookup_table = dmi_id->driver_data;
+
+		if (cd_gpio_lookup_table)
+			gpiod_add_lookup_table(cd_gpio_lookup_table);
+
 		ret = mmc_gpiod_request_cd(host->mmc, "cd", slot->cd_idx,
 					   slot->cd_override_level, 0);
+
+		if (cd_gpio_lookup_table)
+			gpiod_remove_lookup_table(cd_gpio_lookup_table);
+
 		if (ret && ret != -EPROBE_DEFER)
 			ret = mmc_gpiod_request_cd(host->mmc, NULL,
 						   slot->cd_idx,
-- 
2.47.0

