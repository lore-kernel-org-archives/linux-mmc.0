From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: Linux v3.1-rc8 : SDHC card do not switch to high speed mode
Date: Thu, 13 Oct 2011 20:19:27 +0530
Message-ID: <C82BA3053CFD354AACBD25EFBD2A4EC603F959EF6E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34706 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752470Ab1JMOtd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Oct 2011 10:49:33 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi all,

We are porting existing OMAP HSMMC driver (omap_hsmmc.c) to an upcoming SOC. 

When testing the driver with SanDisk 16GB SDHC Card (SanDisk Extreme HD Video 16GB 20Mb/s), we observed that the card doesn't switch to High Speed mode. 

The card shows that it is compatible with SDA spec3. 

We are testing on Linux v3.1-rc8


In mmc_sd_init_card(), rocr received from card is 0xc0ff8000, (S18A bit not set).

During mmc_sd_setup_card() --> mmc_decode_scr(), when decoding scr, the card specifies that it is sda spec3 compatible 

	if (scr->sda_vsn == SCR_SPEC_VER_2)
		/* Check if Physical Layer Spec v3.0 is supported */
		scr->sda_spec3 = UNSTUFF_BITS(resp, 47, 1);			--> true

Then during mmc_read_switch(), since it's a sda spec3 card, the code goes to read sd3_drv_type & sd3_curr_limit and skips settings hs_max_dtr.

mmc_sd_switch_hs() returns back since hs_max_dtr == 0

	if (card->sw_caps.hs_max_dtr == 0)
		return 0;

Because of this Card isn't switched to High Speed mode.

Is there any solution for this? Has anyone seen this issue.

Thanks in advance.


I am also attaching the log I get from the sd dev attr

Regards
Gururaja

root@arago-armv7:/sys/devices/platform/omap/omap_hsmmc.0/mmc_host/mmc0/mmc0:aaaa# cat cid
0353445344313647800c03994400ac6f

root@arago-armv7:/sys/devices/platform/omap/omap_hsmmc.0/mmc_host/mmc0/mmc0:aaaa# cat csd
400e00325b59000076b27f800a404013

root@arago-armv7:/sys/devices/platform/omap/omap_hsmmc.0/mmc_host/mmc0/mmc0:aaaa# cat date
12/2010

root@arago-armv7:/sys/devices/platform/omap/omap_hsmmc.0/mmc_host/mmc0/mmc0:aaaa# cat erase_size
512

root@arago-armv7:/sys/devices/platform/omap/omap_hsmmc.0/mmc_host/mmc0/mmc0:aaaa# cat fwrev
0x0

root@arago-armv7:/sys/devices/platform/omap/omap_hsmmc.0/mmc_host/mmc0/mmc0:aaaa# cat hwrev
0x8

root@arago-armv7:/sys/devices/platform/omap/omap_hsmmc.0/mmc_host/mmc0/mmc0:aaaa# cat name
SD16G

root@arago-armv7:/sys/devices/platform/omap/omap_hsmmc.0/mmc_host/mmc0/mmc0:aaaa# cat manfid
0x000003

root@arago-armv7:/sys/devices/platform/omap/omap_hsmmc.0/mmc_host/mmc0/mmc0:aaaa# cat oemid
0x5344

root@arago-armv7:/sys/devices/platform/omap/omap_hsmmc.0/mmc_host/mmc0/mmc0:aaaa# cat preferred_erase_size
4194304

root@arago-armv7:/sys/devices/platform/omap/omap_hsmmc.0/mmc_host/mmc0/mmc0:aaaa# cat scr
0235800000000000

root@arago-armv7:/sys/devices/platform/omap/omap_hsmmc.0/mmc_host/mmc0/mmc0:aaaa# cat serial
0x0c039944

root@arago-armv7:/sys/devices/platform/omap/omap_hsmmc.0/mmc_host/mmc0/mmc0:aaaa# cat type
SD

root@arago-armv7:/sys/devices/platform/omap/omap_hsmmc.0/mmc_host/mmc0/mmc0:aaaa# cat uevent
DRIVER=mmcblk
MMC_TYPE=SD
MMC_NAME=SD16G
MODALIAS=mmc:block


