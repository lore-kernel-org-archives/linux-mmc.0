Return-Path: <SRS0=QNIT=25=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC00C33C9E
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Jan 2020 09:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22335206DA
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Jan 2020 09:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gPt3qGjh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgAHJjL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 8 Jan 2020 04:39:11 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44519 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726079AbgAHJjL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jan 2020 04:39:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578476349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ucdMpNBbGXBTkeXu903VBIVtK19pACZHTp0j1oDnBuY=;
        b=gPt3qGjh3N9rPeJPVv0zxcE4K7j6nkgd5F3acYW/xdQj8UEo0PZzAbeC/gx9g0tmS79ybY
        WZ2lC3Jl+yF72FjsjAuragRqUQhioHAFIUHq6Oess59S4kAJqo7gS2Z7yTGqWhGKxkjzBm
        66tw61wHlNHcyZnMBFLsRktDvAHwPO8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-63xeSvhfMBqn9F_TL1YwLQ-1; Wed, 08 Jan 2020 04:39:08 -0500
X-MC-Unique: 63xeSvhfMBqn9F_TL1YwLQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17445593A0;
        Wed,  8 Jan 2020 09:39:07 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-117-178.ams2.redhat.com [10.36.117.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F39CA5D9E1;
        Wed,  8 Jan 2020 09:39:05 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>,
        linux-mmc@vger.kernel.org
Subject: [PATCH 1/2] mmc: sdhci-acpi: Disable 1.8V modes on external microSD on Lenovo Miix 320
Date:   Wed,  8 Jan 2020 10:39:02 +0100
Message-Id: <20200108093903.57620-2-hdegoede@redhat.com>
In-Reply-To: <20200108093903.57620-1-hdegoede@redhat.com>
References: <20200108093903.57620-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Based on a sample of 7 DSDTs from Cherry Trail devices using an AXP288
PMIC depending on the design one of 2 possible LDOs on the PMIC is used
for the MMC signalling voltage, either DLDO3 or GPIO1LDO (GPIO1 pin in
low noise LDO mode).

The Lenovo Miix 320-10ICR uses GPIO1LDO in the SHC1 ACPI device's DSM
methods to set 3.3 or 1.8 signalling voltage and this appears to work
as advertised, so presumably the device is actually using GPIO1LDO for
the external microSD signalling voltage.

But this device has a bug in the _PS0 method of the SHC1 ACPI device,
the DSM remembers the last set signalling voltage and the _PS0 restores
this after a (runtime) suspend-resume cycle, but it "restores" the voltag=
e
on DLDO3 instead of setting it on GPIO1LDO as the DSM method does. DLDO3
is used for the LCD and setting it to 1.8V causes the LCD to go black.

This issue can be worked around by setting the SDHCI_QUIRK2_NO_1_8_V
quirk on the sdhci_host so that the DSM never gets used to program the
signalling voltage to 1.8V.

So far we have mostly been able to avoid using device specific quirks in
the sdhci-acpi code, but given that this issue is specific to this one
model and we certainly do not want to disable 1.8V modes everywhere I
see no other option.

This commit adds a new mechanism for setting sdhci-acpi specific quirks
and a matching sdhci-acpi.quirks module parameter to make testing quirks =
/
similar issues on other devices easier.

The first quirk supported by this mechanism is SDHCI_ACPI_QUIRK_SD_NO_1_8=
V,
which when set causes any slots with the SDHCI_ACPI_SD_CD flag to get the
SDHCI_QUIRK2_NO_1_8_V quirk set on their sdhci_host.

This commit also adds a DMI table for specifying default quirks for some
models and adds an entry for the Lenovo Miix 320-10ICR which enables the
SDHCI_QUIRK2_NO_1_8_V by default on this model, fixing the LCD going blac=
k
when the external microSD slot is used.

BugLink: https://bugs.freedesktop.org/show_bug.cgi?id=3D111294
BugLink: https://gitlab.freedesktop.org/drm/intel/issues/355
Reported-by: russianneuromancer <russianneuromancer@ya.ru>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mmc/host/sdhci-acpi.c | 39 +++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.=
c
index 105e73d4a3b9..9f150c73e958 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -23,6 +23,7 @@
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/delay.h>
+#include <linux/dmi.h>
=20
 #include <linux/mmc/host.h>
 #include <linux/mmc/pm.h>
@@ -75,6 +76,14 @@ struct sdhci_acpi_host {
 	unsigned long			private[0] ____cacheline_aligned;
 };
=20
+enum {
+	SDHCI_ACPI_QUIRK_SD_NO_1_8V			=3D BIT(0),
+};
+
+static int quirks =3D -1;
+module_param(quirks, int, 0444);
+MODULE_PARM_DESC(quirks, "Override sdhci-acpi specific quirks");
+
 static inline void *sdhci_acpi_priv(struct sdhci_acpi_host *c)
 {
 	return (void *)c->private;
@@ -647,6 +656,24 @@ static const struct acpi_device_id sdhci_acpi_ids[] =
=3D {
 };
 MODULE_DEVICE_TABLE(acpi, sdhci_acpi_ids);
=20
+static const struct dmi_system_id sdhci_acpi_quirks[] =3D {
+	{
+		/*
+		 * The Lenovo Miix 320-10ICR has a bug in the _PS0 method of
+		 * the SHC1 ACPI device, this bug causes it to reprogram the
+		 * wrong LDO (DLDO3) to 1.8V if 1.8V modes are used and the
+		 * card is (runtime) suspended + resumed. DLDO3 is used for
+		 * the LCD and setting it to 1.8V causes the LCD to go black.
+		 */
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo MIIX 320-10ICR"),
+		},
+		.driver_data =3D (void *)SDHCI_ACPI_QUIRK_SD_NO_1_8V,
+	},
+	{} /* Terminating entry */
+};
+
 static const struct sdhci_acpi_slot *sdhci_acpi_get_slot(struct acpi_dev=
ice *adev)
 {
 	const struct sdhci_acpi_uid_slot *u;
@@ -663,6 +690,7 @@ static int sdhci_acpi_probe(struct platform_device *p=
dev)
 	struct device *dev =3D &pdev->dev;
 	const struct sdhci_acpi_slot *slot;
 	struct acpi_device *device, *child;
+	const struct dmi_system_id *id;
 	struct sdhci_acpi_host *c;
 	struct sdhci_host *host;
 	struct resource *iomem;
@@ -670,6 +698,14 @@ static int sdhci_acpi_probe(struct platform_device *=
pdev)
 	size_t priv_size;
 	int err;
=20
+	if (quirks =3D=3D -1) {
+		id =3D dmi_first_match(sdhci_acpi_quirks);
+		if (id)
+			quirks =3D (long)id->driver_data;
+		else
+			quirks =3D 0;
+	}
+
 	device =3D ACPI_COMPANION(dev);
 	if (!device)
 		return -ENODEV;
@@ -759,6 +795,9 @@ static int sdhci_acpi_probe(struct platform_device *p=
dev)
 			dev_warn(dev, "failed to setup card detect gpio\n");
 			c->use_runtime_pm =3D false;
 		}
+
+		if (quirks & SDHCI_ACPI_QUIRK_SD_NO_1_8V)
+			host->quirks2 |=3D SDHCI_QUIRK2_NO_1_8_V;
 	}
=20
 	err =3D sdhci_setup_host(host);
--=20
2.24.1

