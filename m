Return-Path: <SRS0=aPfc=5B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881C4C2BB1D
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Mar 2020 18:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F1B120752
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Mar 2020 18:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hd8cU9bw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732347AbgCPSsG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Mar 2020 14:48:06 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:30708 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732349AbgCPSsG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Mar 2020 14:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584384485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qoper2IUJx3KzlcJelMZ1frM9tNAPTFzfibv8ucIWjU=;
        b=Hd8cU9bwvdNHsKdMwxT5m9M40DI0C/+EdQ3ME5g0FWyt9pbq18JQASosKElovAl2JF9bO1
        JilrdqA/QxuFya62zqpf4FddMmis3+nap86wvJery/rvcSR+FaeTAYWxuj8l9IMwPKM9fy
        ydkcFm2cLCChyM5LHbgW0sXXcDhv2T4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-wH9eWvPeMM2UqC2eU80D4Q-1; Mon, 16 Mar 2020 14:48:01 -0400
X-MC-Unique: wH9eWvPeMM2UqC2eU80D4Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84265171E8F;
        Mon, 16 Mar 2020 18:47:58 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-116-148.ams2.redhat.com [10.36.116.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9EE7E5D9E2;
        Mon, 16 Mar 2020 18:47:56 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-mmc@vger.kernel.org
Subject: [PATCH v3 2/2] mmc: sdhci-acpi: Disable write protect detection on Acer Aspire Switch 10 (SW5-012)
Date:   Mon, 16 Mar 2020 19:47:53 +0100
Message-Id: <20200316184753.393458-2-hdegoede@redhat.com>
In-Reply-To: <20200316184753.393458-1-hdegoede@redhat.com>
References: <20200316184753.393458-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On the Acer Aspire Switch 10 (SW5-012) microSD slot always reports the ca=
rd
being write-protected even though microSD cards do not have a write-prote=
ct
switch at all.

Add a new DMI_QUIRK_SD_NO_WRITE_PROTECT quirk which when set sets
the MMC_CAP2_NO_WRITE_PROTECT flag on the controller for the external SD
slot; and add a DMI quirk table entry which selects this quirk for the
Acer SW5-012.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Drop the module option to allow overridig the quirks
---
 drivers/mmc/host/sdhci-acpi.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.=
c
index b4c1b2367066..2a2173d953f5 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -80,6 +80,7 @@ struct sdhci_acpi_host {
=20
 enum {
 	DMI_QUIRK_RESET_SD_SIGNAL_VOLT_ON_SUSP			=3D BIT(0),
+	DMI_QUIRK_SD_NO_WRITE_PROTECT				=3D BIT(1),
 };
=20
 static inline void *sdhci_acpi_priv(struct sdhci_acpi_host *c)
@@ -671,6 +672,18 @@ static const struct dmi_system_id sdhci_acpi_quirks[=
] =3D {
 		},
 		.driver_data =3D (void *)DMI_QUIRK_RESET_SD_SIGNAL_VOLT_ON_SUSP,
 	},
+	{
+		/*
+		 * The Acer Aspire Switch 10 (SW5-012) microSD slot always
+		 * reports the card being write-protected even though microSD
+		 * cards do not have a write-protect switch at all.
+		 */
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire SW5-012"),
+		},
+		.driver_data =3D (void *)DMI_QUIRK_SD_NO_WRITE_PROTECT,
+	},
 	{} /* Terminating entry */
 };
=20
@@ -795,6 +808,9 @@ static int sdhci_acpi_probe(struct platform_device *p=
dev)
=20
 		if (quirks & DMI_QUIRK_RESET_SD_SIGNAL_VOLT_ON_SUSP)
 			c->reset_signal_volt_on_suspend =3D true;
+
+		if (quirks & DMI_QUIRK_SD_NO_WRITE_PROTECT)
+			host->mmc->caps2 |=3D MMC_CAP2_NO_WRITE_PROTECT;
 	}
=20
 	err =3D sdhci_setup_host(host);
--=20
2.25.1

