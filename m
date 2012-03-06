From: joancarles <joancarles@fqingenieria.es>
Subject: [MX25][MMC] mmc esdhc failure in 3.3-rc5
Date: Tue, 06 Mar 2012 11:29:50 +0000
Message-ID: <5e57eb999780335721212bb8d411406f@mail.fqingenieria.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from llsa731-a03.servidoresdns.net ([82.223.190.25]:45948 "EHLO
	llsa731-a03.servidoresdns.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759094Ab2CFLi3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Mar 2012 06:38:29 -0500
Received: from webmail.fqingenieria.es (llrg757-a.servidoresdns.net [82.223.191.57])
	by llsa731-a03.servidoresdns.net (Postfix) with ESMTPA id 8BC09540394
	for <linux-mmc@vger.kernel.org>; Tue,  6 Mar 2012 12:29:50 +0100 (CET)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi

I have the following error when trying to access the SD-card on my MX25
device:

root@mx25-noah:~$> mount /media/card/
root@mx25-noah:~$> df -kh /media/card
Filesystem                Size      Used Available Use% Mounted on
/dev/mmcblk0p1          123.6M      2.7M    120.9M   2% /media/card
root@mx25-noah:~$> touch /media/card/file
[   82.982920] mmcblk0: error -110 transferring data, sector 559, nr 1,
cmd response 0x900, card status 0x0
[   82.993544] end_request: I/O error, dev mmcblk0, sector 559
[   82.999169] Buffer I/O error on device mmcblk0p1, logical block 497
[   83.005458] lost page write due to I/O error on mmcblk0p1
[   83.013922] mmcblk0: error -84 transferring data, sector 559, nr 1, 
cmd
response 0x900, card status 0x0
[   83.024114] end_request: I/O error, dev mmcblk0, sector 559
[   83.029965] FAT-fs (mmcblk0p1): Directory bread(block 497) failed
[   83.038051] mmcblk0: error -84 transferring data, sector 560, nr 1, 
cmd
response 0x900, card status 0x0
[   83.048579] end_request: I/O error, dev mmcblk0, sector 560
[   83.054205] Buffer I/O error on device mmcblk0p1, logical block 498
[   83.060494] lost page write due to I/O error on mmcblk0p1
touch: /media/card/file: Input/output error

I have compiled the kernel 3.3-rc5 with driver core debug support and I
get the following information:

root@mx25-noah:~$> dmesg | grep -i mmc
[    0.228098] bus: 'mmc': registered
[    0.228139] device class 'mmc_host': registering
[    1.405180] bus: 'mmc': add driver mmcblk
[    1.429969] device: 'mmc0::': device_add
[    1.430249] PM: Adding info for No Bus:mmc0::
[    1.430837] Registered led device: mmc0::
[    1.430884] device: 'mmc0': device_add
[    1.431114] PM: Adding info for No Bus:mmc0
[    1.432953] mmc0: SDHCI controller on sdhci-esdhc-imx25.0
[sdhci-esdhc-imx25.0] using DMA
[    1.771322] mmc0: host does not support reading read-only switch.
assuming write-enable.
[    1.798584] mmc0: new high speed SD card at address 0002
[    1.804018] device: 'mmc0:0002': device_add
[    1.804283] bus: 'mmc': add device mmc0:0002
[    1.804445] PM: Adding info for mmc:mmc0:0002
[    1.815198] bus: 'mmc': driver_probe_device: matched device 
mmc0:0002
with driver mmcblk
[    1.815256] bus: 'mmc': really_probe: probing driver mmcblk with 
device
mmc0:0002
[    1.825154] mmcblk0: mmc0:0002 00000 1.86 GiB
[    1.835076] device: 'mmcblk0': device_add
[    1.835680] PM: Adding info for No Bus:mmcblk0
[    1.849286]  mmcblk0: p1 p2
[    1.852252] device: 'mmcblk0p1': device_add
[    1.855232] PM: Adding info for No Bus:mmcblk0p1
[    1.855371] device: 'mmcblk0p2': device_add
[    1.855874] PM: Adding info for No Bus:mmcblk0p2
[    1.866667] driver: 'mmc0:0002': driver_bound: bound to device 
'mmcblk'
[    1.866720] bus: 'mmc': really_probe: bound device mmc0:0002 to 
driver
mmcblk
[   82.982920] mmcblk0: error -110 transferring data, sector 559, nr 1,
cmd response 0x900, card status 0x0
[   82.993544] end_request: I/O error, dev mmcblk0, sector 559
[   82.999169] Buffer I/O error on device mmcblk0p1, logical block 497
[   83.005458] lost page write due to I/O error on mmcblk0p1
[   83.013922] mmcblk0: error -84 transferring data, sector 559, nr 1, 
cmd
response 0x900, card status 0x0
[   83.024114] end_request: I/O error, dev mmcblk0, sector 559
[   83.029965] FAT-fs (mmcblk0p1): Directory bread(block 497) failed
[   83.038051] mmcblk0: error -84 transferring data, sector 560, nr 1, 
cmd
response 0x900, card status 0x0
[   83.048579] end_request: I/O error, dev mmcblk0, sector 560
[   83.054205] Buffer I/O error on device mmcblk0p1, logical block 498
[   83.060494] lost page write due to I/O error on mmcblk0p1

The same device booted into a 2.6.39.3 kernel works just fine. The
initialization of the esdhc driver in the device section is as follows:

imx25_add_sdhci_esdhc_imx(0, NULL);

Changing it to a pdata init as shown below does not change anything 
with
regard to the failure:

imx25_add_sdhci_esdhc_imx(0, &noah_esdhc_pdata);
static const struct esdhc_platform_data noah_esdhc_pdata __initconst = 
{
         .wp_gpio = -EINVAL,
         .cd_gpio = -EINVAL,
         .wp_type = ESDHC_WP_NONE,
         .cd_type = ESDHC_CD_NONE,
};

What could have changed between 2.6.39.3 and 3.3-rc5 to trigger this
behaviour? A quick look at

git diff v2.6.39 drivers/mmc/host/sdhci-esdhc-imx.c

only confuses me with regard to this issue.

Regards
-- 
Joan C. Abelaira

