Return-Path: <SRS0=VpFb=4X=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3242C10DCE
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 14:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A736920717
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 14:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ga7Hl0ZG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgCFObO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:31:14 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40633 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726733AbgCFObO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Mar 2020 09:31:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583505073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1WsT4u0i16h3vKEnqv0N3Kxg+eLPrpkEV282Z7os4E0=;
        b=Ga7Hl0ZGRP+T08X6YhkqhTrAtqH8C6d6MLTORJ/FHemkFg+TuBkH/jzbrJJOAESHYoKoCx
        oUU/egPOFEqRBYrna65/FdMXoh5QTjFZ3DzijtLUqSSrf+aI7kfoqgskeDrc9TpfMjadV9
        nufVIMdRX3RRcFjPyZbzy3QX/polJC8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-TEZvO78WOVGnvq1hHFuupA-1; Fri, 06 Mar 2020 09:31:09 -0500
X-MC-Unique: TEZvO78WOVGnvq1hHFuupA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 694DB8017DF;
        Fri,  6 Mar 2020 14:31:08 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.36.118.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B61B48;
        Fri,  6 Mar 2020 14:31:05 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>,
        linux-mmc@vger.kernel.org
Subject: [PATCH v2 2/2] mmc: sdhci-acpi: Disable write protect detection on Acer Aspire Switch 10 (SW5-012)
Date:   Fri,  6 Mar 2020 15:31:00 +0100
Message-Id: <20200306143100.164975-2-hdegoede@redhat.com>
In-Reply-To: <20200306143100.164975-1-hdegoede@redhat.com>
References: <20200306143100.164975-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
index d54a3592f40f..f17d5e556b43 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -79,6 +79,7 @@ struct sdhci_acpi_host {
=20
 enum {
 	DMI_QUIRK_RESET_SD_SIGNAL_VOLT_ON_SUSP			=3D BIT(0),
+	DMI_QUIRK_SD_NO_WRITE_PROTECT				=3D BIT(1),
 };
=20
 static inline void *sdhci_acpi_priv(struct sdhci_acpi_host *c)
@@ -668,6 +669,18 @@ static const struct dmi_system_id sdhci_acpi_quirks[=
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
@@ -792,6 +805,9 @@ static int sdhci_acpi_probe(struct platform_device *p=
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

