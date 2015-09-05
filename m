From: Michele Curti <michele.curti@gmail.com>
Subject: [PATCH] mmc: sdhci-acpi: detect sd card reader on asus x205ta
Date: Sat,  5 Sep 2015 08:49:52 +0200
Message-ID: <1441435792-446-1-git-send-email-michele.curti@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:38901 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbbIEGuF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 5 Sep 2015 02:50:05 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: adrian.hunter@intel.com, andriy.shevchenko@linux.intel.com, yunpeng.gao@intel.com, peter.griffin@linaro.org, rafael.j.wysocki@intel.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Michele Curti <michele.curti@gmail.com>

Add an entry to the sdhci_acpi_uids list to detect the SD card 
reader on the Asus X205Ta laptop.

dstd table:

Device (SDHC)
{
    Name (_ADR, Zero)  // _ADR: Address
    Name (_HID, "PNP0FFF")  // _HID: Hardware ID
    Name (_CID, "PNP0D40" /* SDA Standard Compliant SD Host Controller */)
    Name (_DDN, "Intel(R) SD Card Controller - 80860F16")  // _DDN: DOS Dev
    Name (_UID, 0x03)  // _UID: Unique ID
    Name (RDEP, Package (0x02)

Signed-off-by: Michele Curti <michele.curti@gmail.com>
---
 drivers/mmc/host/sdhci-acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 22d929f..78aa16a 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -247,6 +247,7 @@ static const struct sdhci_acpi_uid_slot sdhci_acpi_uids[] = {
 	{ "INT33C6"  , NULL, &sdhci_acpi_slot_int_sdio },
 	{ "INT3436"  , NULL, &sdhci_acpi_slot_int_sdio },
 	{ "INT344D"  , NULL, &sdhci_acpi_slot_int_sdio },
+	{ "PNP0FFF"  , "3" , &sdhci_acpi_slot_int_sd   },
 	{ "PNP0D40"  },
 	{ },
 };
-- 
2.5.1

