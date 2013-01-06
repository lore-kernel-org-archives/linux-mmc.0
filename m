From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: FW: SD card reader stopped working in kernel 3.6:
 CONFIG_REGULATOR troubles (solved)
Date: Sun, 6 Jan 2013 09:19:07 +0800
Message-ID: <CADz5_gK-=66A3L5LBDr094j0SKDzA1QMkynf0yx90Y9TsNiWJw@mail.gmail.com>
References: <25B60CDC2F704E4E9D88FFD52780CB4C08B026B6EC@SC-VEXCH1.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:57994 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754609Ab3AFBTI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 5 Jan 2013 20:19:08 -0500
Received: by mail-wg0-f45.google.com with SMTP id dq12so8389695wgb.0
        for <linux-mmc@vger.kernel.org>; Sat, 05 Jan 2013 17:19:07 -0800 (PST)
In-Reply-To: <25B60CDC2F704E4E9D88FFD52780CB4C08B026B6EC@SC-VEXCH1.marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rainer Kaluscha <rainer.kaluscha@web.de>
Cc: linux-mmc@vger.kernel.org

> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Rainer Kaluscha
> Sent: Sunday, January 06, 2013 12:20 AM
> To: linux-mmc@vger.kernel.org
> Subject: SD card reader stopped working in kernel 3.6: CONFIG_REGULATOR troubles (solved)
>
> My SD card reader which worked fine with kernel 3.5 stopped working with kernel
> 3.6 and 3.7. It is a "SD Host controller: Ricoh Co Ltd R5C822
> SD/SDIO/MMC/MS/MSPro Host Adapter (rev 22)", PCI-ID 0e:06.1
>
> I finally noticed messages like "mmc0: Hardware doesn't report any support
> voltages." so I tried disabling CONFIG_REGULATOR in kernel config which solved
> the issue.
>
> Maybe this is also of interest to others. Feel free to contact me if you need
> more details.
>
>

Can you try below patch? or you can try with latest 3.8 kernel which
has integrated the patch.

>From cec2e216f72c6b5ccdadb60aadbe99821d744503 Mon Sep 17 00:00:00 2001
From: Kevin Liu <kliu5@marvell.com>
Date: Tue, 20 Nov 2012 08:24:32 -0500
Subject: [PATCH] mmc: sdhci: Use regulator min/max voltage range according to
 spec

For regulator vmmc/vmmcq, use voltage range as below
3.3v/3.0v: (2.7v, 3.6v)
1.8v: (1.7v, 1.95v)
Original code uses the precise value which may fail in regulator
driver if it does NOT support the precise voltage.

Signed-off-by: Jialing Fu <jlfu@marvell.com>
Signed-off-by: Kevin Liu <kliu5@marvell.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/host/sdhci.c |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 2f62fe4..ec3e984 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1618,7 +1618,7 @@ static int
sdhci_do_3_3v_signal_voltage_switch(struct sdhci_host *host,
 	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);

 	if (host->vqmmc) {
-		ret = regulator_set_voltage(host->vqmmc, 3300000, 3300000);
+		ret = regulator_set_voltage(host->vqmmc, 2700000, 3600000);
 		if (ret) {
 			pr_warning("%s: Switching to 3.3V signalling voltage "
 				   " failed\n", mmc_hostname(host->mmc));
@@ -1662,7 +1662,7 @@ static int
sdhci_do_1_8v_signal_voltage_switch(struct sdhci_host *host,
 		 */
 		if (host->vqmmc)
 			ret = regulator_set_voltage(host->vqmmc,
-				1800000, 1800000);
+				1700000, 1950000);
 		else
 			ret = 0;

@@ -2860,8 +2860,8 @@ int sdhci_add_host(struct sdhci_host *host)
 		}
 	} else {
 		regulator_enable(host->vqmmc);
-		if (!regulator_is_supported_voltage(host->vqmmc, 1800000,
-			1800000))
+		if (!regulator_is_supported_voltage(host->vqmmc, 1700000,
+			1950000))
 			caps[1] &= ~(SDHCI_SUPPORT_SDR104 |
 					SDHCI_SUPPORT_SDR50 |
 					SDHCI_SUPPORT_DDR50);
@@ -2925,16 +2925,14 @@ int sdhci_add_host(struct sdhci_host *host)

 #ifdef CONFIG_REGULATOR
 	if (host->vmmc) {
-		ret = regulator_is_supported_voltage(host->vmmc, 3300000,
-			3300000);
+		ret = regulator_is_supported_voltage(host->vmmc, 2700000,
+			3600000);
 		if ((ret <= 0) || (!(caps[0] & SDHCI_CAN_VDD_330)))
 			caps[0] &= ~SDHCI_CAN_VDD_330;
-		ret = regulator_is_supported_voltage(host->vmmc, 3000000,
-			3000000);
 		if ((ret <= 0) || (!(caps[0] & SDHCI_CAN_VDD_300)))
 			caps[0] &= ~SDHCI_CAN_VDD_300;
-		ret = regulator_is_supported_voltage(host->vmmc, 1800000,
-			1800000);
+		ret = regulator_is_supported_voltage(host->vmmc, 1700000,
+			1950000);
 		if ((ret <= 0) || (!(caps[0] & SDHCI_CAN_VDD_180)))
 			caps[0] &= ~SDHCI_CAN_VDD_180;
 	}
-- 
1.7.9.5

Thanks
Kevin
