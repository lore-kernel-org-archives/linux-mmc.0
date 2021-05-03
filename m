Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038A8C433ED
	for <linux-mmc@archiver.kernel.org>; Mon,  3 May 2021 09:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBE35611BE
	for <linux-mmc@archiver.kernel.org>; Mon,  3 May 2021 09:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhECJWz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 3 May 2021 05:22:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54844 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231523AbhECJWz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 3 May 2021 05:22:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620033722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vcyQRtRsM37goxV5DGkNo9BAHkn8V/njhLa1npQUZP4=;
        b=FyqLuWirZtX8TIqbcBrklFxNJUHz72RepnmojJ3MqZ/YX9bcPPhPcMLAS3xXgdWgsluy9B
        qzpSKeeujUmzppb+0Cv2lhm577w15AakqlNJ5stlYmMl0qQhfEd2V2AYHia3axtbFDx7cJ
        KmZyX5dNm0PHrDlFB/mKS4iV6FqtaMk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-zKQ43IkDNteEpI0HsU4D8g-1; Mon, 03 May 2021 05:22:00 -0400
X-MC-Unique: zKQ43IkDNteEpI0HsU4D8g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03E3F6123C;
        Mon,  3 May 2021 09:21:59 +0000 (UTC)
Received: from x1.localdomain (ovpn-114-176.ams2.redhat.com [10.36.114.176])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1838C60C0F;
        Mon,  3 May 2021 09:21:57 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: sdhci-acpi: Disable write protect detection on Toshiba Encore 2 WT8-B
Date:   Mon,  3 May 2021 11:21:57 +0200
Message-Id: <20210503092157.5689-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On the Toshiba Encore 2 WT8-B the  microSD slot always reports the card
being write-protected even though microSD cards do not have a write-protect
switch at all.

Add a new DMI_QUIRK_SD_NO_WRITE_PROTECT quirk entry to sdhci-acpi.c's
DMI quirk table for this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mmc/host/sdhci-acpi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index b6574e7fd26b..9e4358d7a0a6 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -820,6 +820,17 @@ static const struct dmi_system_id sdhci_acpi_quirks[] = {
 		},
 		.driver_data = (void *)DMI_QUIRK_SD_NO_WRITE_PROTECT,
 	},
+	{
+		/*
+		 * The Toshiba WT8-B's microSD slot always reports the card being
+		 * write-protected.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TOSHIBA ENCORE 2 WT8-B"),
+		},
+		.driver_data = (void *)DMI_QUIRK_SD_NO_WRITE_PROTECT,
+	},
 	{} /* Terminating entry */
 };
 
-- 
2.31.1

