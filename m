From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: commit 'mmc: sdhci: add MMC_CAP_8_BIT_DATA in the host
 capabilities' breaks ricoh mmc device
Date: Sat, 30 Oct 2010 05:53:46 +0200
Message-ID: <1288410826.3119.5.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33271 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069Ab0J3Dxv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Oct 2010 23:53:51 -0400
Received: by fxm16 with SMTP id 16so3681898fxm.19
        for <linux-mmc@vger.kernel.org>; Fri, 29 Oct 2010 20:53:50 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>

Hi, 

I just bisected and reverted this commit.
With it I am unable to read MMC cards via Ricoh MMC function,
support for which I added recently.

07:00.2 System peripheral: Ricoh Co Ltd R5C843 MMC Host Controller (rev
12)

The logs show lot of errors like this:

[  219.590748] mmc1: new MMC card at address 0001
[  219.639449] mmcblk0: mmc1:0001 MMC    483 MiB 
[  219.647008] mmcblk0: retrying using single block read
[  219.649262] mmcblk0: error -84 transferring data, sector 0, nr 8, card status 0x900
[  219.649271] end_request: I/O error, dev mmcblk0, sector 0
[  219.651964] mmcblk0: error -84 transferring data, sector 1, nr 7, card status 0x900
[  219.651969] end_request: I/O error, dev mmcblk0, sector 1
[  219.654202] mmcblk0: error -84 transferring data, sector 2, nr 6, card status 0x900
[  219.654206] end_request: I/O error, dev mmcblk0, sector 2
[  219.657049] mmcblk0: error -84 transferring data, sector 3, nr 5, card status 0x900
[  219.657054] end_request: I/O error, dev mmcblk0, sector 3
[  219.661094] mmcblk0: error -84 transferring data, sector 4, nr 4, card status 0x900
[  219.661100] end_request: I/O error, dev mmcblk0, sector 4
[  219.663347] mmcblk0: error -84 transferring data, sector 5, nr 3, card status 0x900
[  219.663352] end_request: I/O error, dev mmcblk0, sector 5
[  219.665593] mmcblk0: error -84 transferring data, sector 6, nr 2, card status 0x900
[  219.665598] end_request: I/O error, dev mmcblk0, sector 6
[  219.667905] mmcblk0: error -84 transferring data, sector 7, nr 1, card status 0x900
[  219.667910] end_request: I/O error, dev mmcblk0, sector 7
[  219.667915] Buffer I/O error on device mmcblk0, logical block 0
[  219.672258] mmcblk0: retrying using single block read
....


Now that reader in not standard (it doesn't claim SDHCI, but work very similiar), 
so it might be device specific bug or not.

One thing for sure, it doesn't physicaly support 8-bit (although the MMC Plus card I tested
probably does via extra connectors).

Best regards,
	Maxim Levitsky 


