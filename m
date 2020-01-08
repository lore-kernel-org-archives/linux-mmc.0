Return-Path: <SRS0=QNIT=25=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CD9C00523
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Jan 2020 09:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0FCD206DA
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Jan 2020 09:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AL69Ais+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgAHJjL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 8 Jan 2020 04:39:11 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59378 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726276AbgAHJjL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jan 2020 04:39:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578476350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eM1uGwh8VVmZ6cIDPHTHCs/4ViYZmWvL5osn0w16oWg=;
        b=AL69Ais+b5B8P5ZvSe4e/TQ914BIa6mqi68cfbb+J1v99yvktX3MkMJj515Wf+daoycIJX
        UiVtzIQQuIriUs2BbovOHC3tj+se1N+DVP4YJhUqSOTUZhM3/0/TGAi+ah0ZEexiA9zCXz
        qOAb+9PyV6vsh70ofsBgw0DSBk8T4JE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-RLTu6sVCOryA6GlAuUbURQ-1; Wed, 08 Jan 2020 04:39:09 -0500
X-MC-Unique: RLTu6sVCOryA6GlAuUbURQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 747F91800D4E;
        Wed,  8 Jan 2020 09:39:08 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-117-178.ams2.redhat.com [10.36.117.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C3EF5D9E1;
        Wed,  8 Jan 2020 09:39:07 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>,
        linux-mmc@vger.kernel.org
Subject: [PATCH 2/2] mmc: sdhci-acpi: Disable write protect detection on Acer Aspire Switch 10 (SW5-012)
Date:   Wed,  8 Jan 2020 10:39:03 +0100
Message-Id: <20200108093903.57620-3-hdegoede@redhat.com>
In-Reply-To: <20200108093903.57620-1-hdegoede@redhat.com>
References: <20200108093903.57620-1-hdegoede@redhat.com>
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

Add a new SDHCI_ACPI_QUIRK_SD_NO_WRITE_PROTECT quirk which when set sets
the MMC_CAP2_NO_WRITE_PROTECT flag on the controller for the external SD
slot, and add a DMI quirk which enables this new quirk by default on the
Acer SW5-012.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mmc/host/sdhci-acpi.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.=
c
index 9f150c73e958..69485d29b6bc 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -78,6 +78,7 @@ struct sdhci_acpi_host {
=20
 enum {
 	SDHCI_ACPI_QUIRK_SD_NO_1_8V			=3D BIT(0),
+	SDHCI_ACPI_QUIRK_SD_NO_WRITE_PROTECT		=3D BIT(1),
 };
=20
 static int quirks =3D -1;
@@ -671,6 +672,18 @@ static const struct dmi_system_id sdhci_acpi_quirks[=
] =3D {
 		},
 		.driver_data =3D (void *)SDHCI_ACPI_QUIRK_SD_NO_1_8V,
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
+		.driver_data =3D (void *)SDHCI_ACPI_QUIRK_SD_NO_WRITE_PROTECT,
+	},
 	{} /* Terminating entry */
 };
=20
@@ -798,6 +811,9 @@ static int sdhci_acpi_probe(struct platform_device *p=
dev)
=20
 		if (quirks & SDHCI_ACPI_QUIRK_SD_NO_1_8V)
 			host->quirks2 |=3D SDHCI_QUIRK2_NO_1_8_V;
+
+		if (quirks & SDHCI_ACPI_QUIRK_SD_NO_WRITE_PROTECT)
+			host->mmc->caps2 |=3D MMC_CAP2_NO_WRITE_PROTECT;
 	}
=20
 	err =3D sdhci_setup_host(host);
--=20
2.24.1

