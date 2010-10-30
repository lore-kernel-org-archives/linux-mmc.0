From: Philip Rakity <prakity@marvell.com>
Subject: RE: commit mmc: sdhci: add MMC_CAP_8_BIT_DATA in the host
Date: Sat, 30 Oct 2010 05:47:05 -0700
Message-ID: <16C48D64-3B93-450C-8C92-EFE4D70BD5ED@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:51023 "HELO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751903Ab0J3MrM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 30 Oct 2010 08:47:12 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>


eMMC unlike SD does not have a field to inside the card data to say the bit width of the card.  
In addition some mmc cards (from Transcend) only support 1 bit mode.  The physical pins to support 4 bit data are not there as well as no card specific data saying the bus width of the card.

The only solution is to probe the bus by sending a CMD19 and CMD14 (BUSTEST_W/BUSTEST_R).  
This procedure is defined in the JEDEC Standard No. 84-A441 spec -- Annex A.8.3 and this has been working in our linux 2.6.28/2.6.29 for quite a while.   I can submit a patch if this makes sense.
However, it may not work all the time; some controllers do not send out the CMD19 sequence.  The  (BUSTEST_W/BUSTEST_R) procedure is used in BSD. Also, in SD v3.0 CMD19 is defined for tuning and its definition is slightly different then in the JEDEC standard.

One option for the problem you are seeing would be for my patch 
http://permalink.gmane.org/gmane.linux.kernel.mmc/3966
or something like it to be accepted.   As well as adding the bustest procedure. 

At least the board specific data can then say 8 bit data lines are supported on the physical slot.  The controller can say 8 bit works but normally does not have knowledge of the lower level board design.



>Hi, 
>
>I just bisected and reverted this commit.
>With it I am unable to read MMC cards via Ricoh MMC function,
>support for which I added recently.
>
>07:00.2 System peripheral: Ricoh Co Ltd R5C843 MMC Host Controller (rev
>12)
>
>The logs show lot of errors like this:
>
>[  219.590748] mmc1: new MMC card at address 0001
>[  219.639449] mmcblk0: mmc1:0001 MMC    483 MiB 
>[  219.647008] mmcblk0: retrying using single block read
>[  219.649262] mmcblk0: error -84 transferring data, sector 0, nr 8, card status 0x900
>[  219.649271] end_request: I/O error, dev mmcblk0, sector 0
>[  219.651964] mmcblk0: error -84 transferring data, sector 1, nr 7, card status 0x900
>[  219.651969] end_request: I/O error, dev mmcblk0, sector 1
>[  219.654202] mmcblk0: error -84 transferring data, sector 2, nr 6, card status 0x900
>[  219.654206] end_request: I/O error, dev mmcblk0, sector 2
>[  219.657049] mmcblk0: error -84 transferring data, sector 3, nr 5, card status 0x900
>[  219.657054] end_request: I/O error, dev mmcblk0, sector 3
>[  219.661094] mmcblk0: error -84 transferring data, sector 4, nr 4, card status 0x900
>[  219.661100] end_request: I/O error, dev mmcblk0, sector 4
>[  219.663347] mmcblk0: error -84 transferring data, sector 5, nr 3, card status 0x900
>[  219.663352] end_request: I/O error, dev mmcblk0, sector 5
>[  219.665593] mmcblk0: error -84 transferring data, sector 6, nr 2, card status 0x900
>[  219.665598] end_request: I/O error, dev mmcblk0, sector 6
>[  219.667905] mmcblk0: error -84 transferring data, sector 7, nr 1, card status 0x900
>[  219.667910] end_request: I/O error, dev mmcblk0, sector 7
>[  219.667915] Buffer I/O error on device mmcblk0, logical block 0
>[  219.672258] mmcblk0: retrying using single block read
>....
>
>
>Now that reader in not standard (it doesn't claim SDHCI, but work very similiar), 
>so it might be device specific bug or not.
>
>One thing for sure, it doesn't physicaly support 8-bit (although the MMC Plus card I tested
>probably does via extra connectors).

>Best regards,
>	Maxim Levitsky 


