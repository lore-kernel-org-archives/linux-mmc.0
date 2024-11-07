Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3BC1922C4
	for <linux-mmc@vger.kernel.org>; Thu,  7 Nov 2024 10:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730973658; cv=none; b=j13hVKxCTrc9v0rBSiJU6IyZ/yilBtVXxPwjUlKY05hIhtELRLqHq48L7QzJcRZNEBAiONAPGed2wlynuDdlcpdjji4UJCgAYjoZgoGHUic61O/wj7jQ5HF+HVDTXmV/ta+RZ6NrHx0arbrEf6HwQ5aS3zQmt0VUstuPHKXua10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730973658; c=relaxed/simple;
	bh=FHXhvwE2tKBGAde0ayUVSYrfUopwCzky38irnVNGqK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nyoPfT651Mj5r3F/4Vh1ws/I7/fkQDxTRCqjUji1h2mMz13AmQZr/B6hdirN3lKubCR04KQmBGM2Tq2dAXLps1K7bgr0krWS976fPETW1dwZhmSq9hLuou4z1gMDYQq6Io/JSBwh+HHSErfsVTLd7q8QnalBjVaC44WbEPqSlmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fP2acWyh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fP2acWyh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730973656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9Hmks1frbOUe9h5C4Hqx3XNkOLRQekMQjAjcWR5hP2E=;
	b=fP2acWyha+wa+rsb4opGGU5QYuFljd9clsEFRq/ArvcFP0D6tGDB+aAZ4JGMkMQkVHS5hE
	e6HBhgGEPbVZXaoJKLG9GuvFMJZS30ApOHi0Fnx1l6B1CCniOYQvkRkgMEbxvKGP18AyWF
	t0qH+0m8GhhA2aAPln+Ceiosfvjk4tg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-1ynO922KPji2n_MZjS9bKA-1; Thu,
 07 Nov 2024 05:00:52 -0500
X-MC-Unique: 1ynO922KPji2n_MZjS9bKA-1
X-Mimecast-MFC-AGG-ID: 1ynO922KPji2n_MZjS9bKA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CEC4A1955F45;
	Thu,  7 Nov 2024 10:00:51 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.194.177])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 78EF5196BC05;
	Thu,  7 Nov 2024 10:00:50 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-mmc@vger.kernel.org
Subject: [PATCH v2] mmc: sdhci-pci: Add DMI quirk for missing CD GPIO on Vexia Edu Atla 10 tablet
Date: Thu,  7 Nov 2024 11:00:48 +0100
Message-ID: <20241107100048.11661-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

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
Changes in v2:
- Make sdhci_pci_dmi_cd_gpio_overrides static const instead of just const
- Drop duplicate #include <linux/dmi.h> (already there at the end)
---
 drivers/mmc/host/sdhci-pci-core.c | 38 +++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index ed45ed0bdafd..9c2bce5e88d9 100644
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
@@ -2054,6 +2055,29 @@ static const struct dev_pm_ops sdhci_pci_pm_ops = {
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
+static const struct dmi_system_id sdhci_pci_dmi_cd_gpio_overrides[] = {
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
@@ -2129,8 +2153,22 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
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

