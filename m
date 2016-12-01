From: Daniel Drake <drake@endlessm.com>
Subject: [PATCH] mmc: sdhci-acpi: support 80860F14 UID 2 SDIO bus
Date: Thu,  1 Dec 2016 14:33:03 -0600
Message-ID: <20161201203303.24676-1-drake@endlessm.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f179.google.com ([209.85.217.179]:35827 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759322AbcLAUdL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Dec 2016 15:33:11 -0500
Received: by mail-ua0-f179.google.com with SMTP id 12so260665609uas.2
        for <linux-mmc@vger.kernel.org>; Thu, 01 Dec 2016 12:33:11 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux@endlessm.com

Add an entry for the SDIO bus in the ECS EF20 cherry trail laptop:

  Device (SDHB) {
    Name (_ADR, 0x00110000)
    Name (_HID, "80860F14" /* Intel Baytrail SDIO/MMC Host Controller */)
    Name (_CID, "PNP0D40" /* SDA Standard Compliant SD Host Controller */)
    Name (_DDN, "Intel(R) SDIO Controller - 80862295")
    Name (_UID, 0x02)
    Name (_HRV, One)

A SDHB device with the same _HID and _UID can also be found on other
cherry trail products like Chuwi Hi10.

Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 drivers/mmc/host/sdhci-acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 81d4dc0..160f695 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -328,6 +328,7 @@ static const struct sdhci_acpi_uid_slot sdhci_acpi_uids[] = {
 	{ "80865ACC", NULL, &sdhci_acpi_slot_int_emmc },
 	{ "80865AD0", NULL, &sdhci_acpi_slot_int_sdio },
 	{ "80860F14" , "1" , &sdhci_acpi_slot_int_emmc },
+	{ "80860F14" , "2" , &sdhci_acpi_slot_int_sdio },
 	{ "80860F14" , "3" , &sdhci_acpi_slot_int_sd   },
 	{ "80860F16" , NULL, &sdhci_acpi_slot_int_sd   },
 	{ "INT33BB"  , "2" , &sdhci_acpi_slot_int_sdio },
-- 
2.9.3

