Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749B2C433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Jan 2021 00:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F45D23108
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Jan 2021 00:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730959AbhATAF0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 Jan 2021 19:05:26 -0500
Received: from foss.arm.com ([217.140.110.172]:58266 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730796AbhATAEy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 19 Jan 2021 19:04:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33DFA11D4;
        Tue, 19 Jan 2021 16:04:08 -0800 (PST)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2BBBE3F68F;
        Tue, 19 Jan 2021 16:04:08 -0800 (PST)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-mmc@vger.kernel.org
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        f.fainelli@gmail.com, stefan.wahren@i2se.com,
        nsaenzjulienne@suse.de, ardb@kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v2] mmc: sdhci-iproc: Add ACPI bindings for the rpi
Date:   Tue, 19 Jan 2021 18:04:06 -0600
Message-Id: <20210120000406.1843400-2-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210120000406.1843400-1-jeremy.linton@arm.com>
References: <20210120000406.1843400-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The RPi4 has an Arasan controller it carries over
from the RPi3 and a newer eMMC2 controller.
Because of a couple of quirks, it seems wiser to bind
these controllers to the same driver that DT is using
on this platform rather than the generic sdhci_acpi
driver with PNP0D40.

So, BCM2847 describes the older Arasan and
BRCME88C describes the newer eMMC2. The older
Arasan is reusing an existing ACPI _HID used
by other OSs booting these tables on the RPi.

With this change, Linux is capable of utilizing the
SD card slot, and the wifi when booted with
UEFI+ACPI on the rpi4.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/mmc/host/sdhci-iproc.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index c9434b461aab..ddeaf8e1f72f 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -296,9 +296,27 @@ static const struct of_device_id sdhci_iproc_of_match[] = {
 MODULE_DEVICE_TABLE(of, sdhci_iproc_of_match);
 
 #ifdef CONFIG_ACPI
+/*
+ * This is a duplicate of bcm2835_(pltfrm_)data without caps quirks
+ * which are provided by the ACPI table.
+ */
+static const struct sdhci_pltfm_data sdhci_bcm_arasan_data = {
+	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
+		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
+		  SDHCI_QUIRK_NO_HISPD_BIT,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.ops = &sdhci_iproc_32only_ops,
+};
+
+static const struct sdhci_iproc_data bcm_arasan_data = {
+	.pdata = &sdhci_bcm_arasan_data,
+};
+
 static const struct acpi_device_id sdhci_iproc_acpi_ids[] = {
 	{ .id = "BRCM5871", .driver_data = (kernel_ulong_t)&iproc_cygnus_data },
 	{ .id = "BRCM5872", .driver_data = (kernel_ulong_t)&iproc_data },
+	{ .id = "BCM2847",  .driver_data = (kernel_ulong_t)&bcm_arasan_data },
+	{ .id = "BRCME88C", .driver_data = (kernel_ulong_t)&bcm2711_data },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(acpi, sdhci_iproc_acpi_ids);
-- 
2.26.2

