Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BB4C433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Nov 2021 22:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CB3A61391
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Nov 2021 22:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240874AbhKQWEe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 17 Nov 2021 17:04:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36957 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236296AbhKQWEc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Nov 2021 17:04:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637186492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/7lUdT9Jc2F/pU7MWjZrV8GN5DxfN3+AZDDrymQB/Lg=;
        b=AamoPpLLeLjOX+Q4/Bl6vbmBx02SzHH1MgD8+D1OaqJf8l7kqY8eaUHB9pVxfPDsDnDaAb
        PzmlakBF6ujf6mx5pTNC291H5vq4c8w8MGFD00YKKnivbyaZgqXK25y1jltNLJWt1njJK2
        Qr/jcahwvOx+yk5v7y5Qe3AisWxB+X4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-227-xf6mkB1XOg-xeA3QOcpHGA-1; Wed, 17 Nov 2021 17:01:28 -0500
X-MC-Unique: xf6mkB1XOg-xeA3QOcpHGA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10AB6100CCC3;
        Wed, 17 Nov 2021 22:01:27 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 07F055D9DE;
        Wed, 17 Nov 2021 22:01:19 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH 5.16 regression fix 0/5] ACPI: scan: Skip turning off some unused objects during scan
Date:   Wed, 17 Nov 2021 23:01:13 +0100
Message-Id: <20211117220118.408953-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Rafael,

Commit c10383e8ddf4 ("ACPI: scan: Release PM resources blocked by
unused objects") adds a:

	bus_for_each_dev(&acpi_bus_type, NULL, NULL, acpi_dev_turn_off_if_unused);

call to acpi_scan_init(). On some devices with buggy DSDTs calling
_PS3 for one device may result in it turning off another device.

Specifically the DSDT of the GPD win and GPD pocket devices has a
"\\_SB_.PCI0.SDHB.BRC1" device for a non existing SDIO wifi module
which _PS3 method sets a GPIO causing the PCI wifi card to turn off.

I've an earlier, in some ways simpler, fix for this here:
https://fedorapeople.org/~jwrdegoede/0001-ACPI-scan-Skip-turning-off-some-unused-objects-durin.patch

But the sdhci-acpi.c MMC host code already has an older workaround
for it to not toggle power on this broken ACPI object; and this
simpler fix would require keeping that workaround. So then we would
have 2 workarounds for the same issue in the kernel.

Thus instead I've come up with a slightly different approach which
IMHO has ended up pretty well.

Patches 1-3 of this series are this different approach and assuming
they are considered ok must be merged into 5.16 to fix the regression
caused by commit c10383e8ddf4 on these devices.

Patch 4 removes the now no longer necessary workaround for the same
issue from the sdhci-acpi.c code. Once 1-3 are merged this could
also go to 5.16 but 5.17 is fine too.

Patch 5 is a small bonus cleanup to the sdhci-acpi.c code.

Regards,

Hans


Hans de Goede (5):
  ACPI: Change acpi_device_always_present() into
    acpi_device_override_status()
  ACPI: x86: Allow specifying acpi_device_override_status() quirks by
    path
  ACPI: x86: Add not-present quirk for the PCI0.SDHB.BRC1 device on the
    GPD win
  mmc: sdhci-acpi: Remove special handling for GPD win/pocket devices
  mmc: sdhci-acpi: Use the new soc_intel_is_byt() helper

 drivers/acpi/bus.c            |   4 +-
 drivers/acpi/x86/utils.c      | 114 ++++++++++++++++++++++++----------
 drivers/mmc/host/sdhci-acpi.c |  78 ++---------------------
 include/acpi/acpi_bus.h       |   5 +-
 4 files changed, 91 insertions(+), 110 deletions(-)

-- 
2.31.1

