Return-Path: <SRS0=aPfc=5B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61ECBC3F2CE
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Mar 2020 18:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5612074D
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Mar 2020 18:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MNSxQWsN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732352AbgCPSsG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Mar 2020 14:48:06 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:44372 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732347AbgCPSsG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Mar 2020 14:48:06 -0400
X-Greylist: delayed 9976 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Mar 2020 14:48:05 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584384484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ekwmu7W45TQdN9LA36Rx9eWztV1xeBA1ibw+29frj8s=;
        b=MNSxQWsNCc1mNAaMJeHtyjhKYNEdKriMmfUKKrHCzRuguoxujfNp4yjLpgVh5degZa/jiE
        CXTv3brYFe89oIieRCdRp/iAtMOJh313Bl7NEmttQr8rO57ggXj8URjOQ7hP4q1pN0po/I
        WNV881N5F5AGRjRmFwYwfW/TjD8W8nY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-1_N7h1iLOKyWNWAEgd87TQ-1; Mon, 16 Mar 2020 14:47:57 -0400
X-MC-Unique: 1_N7h1iLOKyWNWAEgd87TQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57C0F171E89;
        Mon, 16 Mar 2020 18:47:56 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-116-148.ams2.redhat.com [10.36.116.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A1165D9E2;
        Mon, 16 Mar 2020 18:47:54 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-mmc@vger.kernel.org,
        russianneuromancer <russianneuromancer@ya.ru>
Subject: [PATCH v3 1/2] mmc: sdhci-acpi: Switch signal voltage back to 3.3V on suspend on external microSD on Lenovo Miix 320
Date:   Mon, 16 Mar 2020 19:47:52 +0100
Message-Id: <20200316184753.393458-1-hdegoede@redhat.com>
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

This commit works around this issue by calling the Intel DSM to reset the
signal voltage to 3.3V after the host has been runtime suspended.
This will make the _PS0 method reprogram the DLDO3 voltage to 3.3V, which
leaves it at its original setting fixing the LCD going black.

This commit adds and uses a DMI quirk mechanism to only trigger this
workaround on the Lenovo Miix 320 while leaving the behavior of the
driver unchanged on other devices.

BugLink: https://bugs.freedesktop.org/show_bug.cgi?id=3D111294
BugLink: https://gitlab.freedesktop.org/drm/intel/issues/355
Reported-by: russianneuromancer <russianneuromancer@ya.ru>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
- Drop code to restore 1.8 signal voltage on suspend, this is not necessa=
ry
- Add an is_intel bool to sdhci_acpi_host instead of checking for:
  mmc_host_ops.start_signal_voltage_switch =3D=3D intel_start_signal_volt=
age_switch

Changes in v2:
- Make the quirk reset the signal voltage to 3.3V at the end of the
  (runtime) suspend handler instead of disabling 1.8V modes
- Drop the module option to allow overridig the quirks
---
 drivers/mmc/host/sdhci-acpi.c | 68 +++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.=
c
index 9651dca6863e..b4c1b2367066 100644
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
@@ -72,9 +73,15 @@ struct sdhci_acpi_host {
 	const struct sdhci_acpi_slot	*slot;
 	struct platform_device		*pdev;
 	bool				use_runtime_pm;
+	bool				is_intel;
+	bool				reset_signal_volt_on_suspend;
 	unsigned long			private[0] ____cacheline_aligned;
 };
=20
+enum {
+	DMI_QUIRK_RESET_SD_SIGNAL_VOLT_ON_SUSP			=3D BIT(0),
+};
+
 static inline void *sdhci_acpi_priv(struct sdhci_acpi_host *c)
 {
 	return (void *)c->private;
@@ -391,6 +398,8 @@ static int intel_probe_slot(struct platform_device *p=
dev, struct acpi_device *ad
 	host->mmc_host_ops.start_signal_voltage_switch =3D
 					intel_start_signal_voltage_switch;
=20
+	c->is_intel =3D true;
+
 	return 0;
 }
=20
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
+		.driver_data =3D (void *)DMI_QUIRK_RESET_SD_SIGNAL_VOLT_ON_SUSP,
+	},
+	{} /* Terminating entry */
+};
+
 static const struct sdhci_acpi_slot *sdhci_acpi_get_slot(struct acpi_dev=
ice *adev)
 {
 	const struct sdhci_acpi_uid_slot *u;
@@ -663,17 +690,23 @@ static int sdhci_acpi_probe(struct platform_device =
*pdev)
 	struct device *dev =3D &pdev->dev;
 	const struct sdhci_acpi_slot *slot;
 	struct acpi_device *device, *child;
+	const struct dmi_system_id *id;
 	struct sdhci_acpi_host *c;
 	struct sdhci_host *host;
 	struct resource *iomem;
 	resource_size_t len;
 	size_t priv_size;
+	int quirks =3D 0;
 	int err;
=20
 	device =3D ACPI_COMPANION(dev);
 	if (!device)
 		return -ENODEV;
=20
+	id =3D dmi_first_match(sdhci_acpi_quirks);
+	if (id)
+		quirks =3D (long)id->driver_data;
+
 	slot =3D sdhci_acpi_get_slot(device);
=20
 	/* Power on the SDHCI controller and its children */
@@ -759,6 +792,9 @@ static int sdhci_acpi_probe(struct platform_device *p=
dev)
 			dev_warn(dev, "failed to setup card detect gpio\n");
 			c->use_runtime_pm =3D false;
 		}
+
+		if (quirks & DMI_QUIRK_RESET_SD_SIGNAL_VOLT_ON_SUSP)
+			c->reset_signal_volt_on_suspend =3D true;
 	}
=20
 	err =3D sdhci_setup_host(host);
@@ -823,17 +859,39 @@ static int sdhci_acpi_remove(struct platform_device=
 *pdev)
 	return 0;
 }
=20
+static void __maybe_unused sdhci_acpi_reset_signal_voltage_if_needed(
+	struct device *dev)
+{
+	struct sdhci_acpi_host *c =3D dev_get_drvdata(dev);
+	struct sdhci_host *host =3D c->host;
+
+	if (c->is_intel && c->reset_signal_volt_on_suspend &&
+	    host->mmc->ios.signal_voltage !=3D MMC_SIGNAL_VOLTAGE_330) {
+		struct intel_host *intel_host =3D sdhci_acpi_priv(c);
+		unsigned int fn =3D INTEL_DSM_V33_SWITCH;
+		u32 result =3D 0;
+
+		intel_dsm(intel_host, dev, fn, &result);
+	}
+}
+
 #ifdef CONFIG_PM_SLEEP
=20
 static int sdhci_acpi_suspend(struct device *dev)
 {
 	struct sdhci_acpi_host *c =3D dev_get_drvdata(dev);
 	struct sdhci_host *host =3D c->host;
+	int ret;
=20
 	if (host->tuning_mode !=3D SDHCI_TUNING_MODE_3)
 		mmc_retune_needed(host->mmc);
=20
-	return sdhci_suspend_host(host);
+	ret =3D sdhci_suspend_host(host);
+	if (ret)
+		return ret;
+
+	sdhci_acpi_reset_signal_voltage_if_needed(dev);
+	return 0;
 }
=20
 static int sdhci_acpi_resume(struct device *dev)
@@ -853,11 +911,17 @@ static int sdhci_acpi_runtime_suspend(struct device=
 *dev)
 {
 	struct sdhci_acpi_host *c =3D dev_get_drvdata(dev);
 	struct sdhci_host *host =3D c->host;
+	int ret;
=20
 	if (host->tuning_mode !=3D SDHCI_TUNING_MODE_3)
 		mmc_retune_needed(host->mmc);
=20
-	return sdhci_runtime_suspend_host(host);
+	ret =3D sdhci_runtime_suspend_host(host);
+	if (ret)
+		return ret;
+
+	sdhci_acpi_reset_signal_voltage_if_needed(dev);
+	return 0;
 }
=20
 static int sdhci_acpi_runtime_resume(struct device *dev)
--=20
2.25.1

