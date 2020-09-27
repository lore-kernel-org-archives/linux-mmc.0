Return-Path: <SRS0=02U7=DE=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922BFC4346E
	for <linux-mmc@archiver.kernel.org>; Sun, 27 Sep 2020 10:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47DBF2399C
	for <linux-mmc@archiver.kernel.org>; Sun, 27 Sep 2020 10:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GsX7Ti1M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgI0Ks3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 27 Sep 2020 06:48:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46202 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726265AbgI0Ks3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 27 Sep 2020 06:48:29 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601203708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=l6v8Ilvexf6lKmkJdhHxHDXJVpZFHuORrlcNuqX8Szo=;
        b=GsX7Ti1MGtXH3rws45n7oVj5LcGYwBWZxDP1Fb9LbrCLcFDZb95nVURDKT9ZgEqY7ll+/V
        sXrwaSo6VuJsw+1D/za+L2RPb6Vr56FPvawg85zxf+00rU77be5CKMG1MNtLQsXwNjUkKa
        G2vt5B1xBCnaBW7/O9yoK9biUDsVjLQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-v48QP2M6No6iIukJO56HFg-1; Sun, 27 Sep 2020 06:48:25 -0400
X-MC-Unique: v48QP2M6No6iIukJO56HFg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 486DE801AAD;
        Sun, 27 Sep 2020 10:48:24 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-80.ams2.redhat.com [10.36.112.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B72F78801;
        Sun, 27 Sep 2020 10:48:22 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        RussianNeuroMancer <russianneuromancer@ya.ru>,
        linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: sdhci: Workaround broken command queuing on Intel GLK based IRBIS models
Date:   Sun, 27 Sep 2020 12:48:21 +0200
Message-Id: <20200927104821.5676-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Commit bedf9fc01ff1 ("mmc: sdhci: Workaround broken command queuing on
Intel GLK"), disabled command-queuing on Intel GLK based LENOVO models
because of it being broken due to what is believed to be a bug in
the BIOS.

It seems that the BIOS of some IRBIS models, including the IRBIS NB111
model has the same issue, so disable command queuing there too.

Fixes: bedf9fc01ff1 ("mmc: sdhci: Workaround broken command queuing on Intel GLK")
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=209397
Reported-and-tested-by: RussianNeuroMancer <russianneuromancer@ya.ru>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index af413805bbf1..914f5184295f 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -794,7 +794,8 @@ static int byt_emmc_probe_slot(struct sdhci_pci_slot *slot)
 static bool glk_broken_cqhci(struct sdhci_pci_slot *slot)
 {
 	return slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_GLK_EMMC &&
-	       dmi_match(DMI_BIOS_VENDOR, "LENOVO");
+	       (dmi_match(DMI_BIOS_VENDOR, "LENOVO") ||
+		dmi_match(DMI_SYS_VENDOR, "IRBIS"));
 }
 
 static int glk_emmc_probe_slot(struct sdhci_pci_slot *slot)
-- 
2.28.0

