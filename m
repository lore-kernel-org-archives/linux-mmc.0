From: seedshope <bocui107@gmail.com>
Subject: about MicroSD transport issue for the current mainline kernel
Date: Wed, 17 Aug 2011 22:11:41 +0800
Message-ID: <4E4BCC1D.7080400@gmail.com>
References: <CANYdXnoZK3OoWOnJhyq645GofnsXuk7tJm09Wv8=Y+gLujPSkQ@mail.gmail.com> <CANYdXnrHWGPCeAEJQq6cmsZAyYfvvcSZ_1_3jKhcMbTARJpGVw@mail.gmail.com> <4E4BC770.90708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:46105 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843Ab1HQOLs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Aug 2011 10:11:48 -0400
Received: by pzk37 with SMTP id 37so1155610pzk.1
        for <linux-mmc@vger.kernel.org>; Wed, 17 Aug 2011 07:11:48 -0700 (PDT)
In-Reply-To: <4E4BC770.90708@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

On 08/17/2011 09:51 PM, seedshope wrote:
> Hi All,
> 
> I uses potevio MicroSD 512M to test the SD/MMC driver in current master
> kernel. I found some issue:
> 
> 1. The issue
> (1) After I insert the microSD,Why The SD card probe finish(The
> parrition and device has already register). But The more and more data
> transport between card and host? Who can told me the function of this
> data.(The log information as following).
> 
> (2) The MicroSD can be probe successful. But The error information
> display on the processor of multi-block data transfer.
> 
> Any advices are welcome!
> 
> 
> 2. Kernel configure:
> CONFIG_MMC = y
> CONFIG_MMC_DEBUG = y
> CONFIG_MMC_BLOCK = y
> CONFIG_MMC_SDHCI = y
> CONFIG_MMC_SDHCI_PCI = y
> 
> 3. Debug information:
> mmc0: clock 0Hz busmode 1 powermode 1 cs 0 Vdd 20 width 0 timing 0
> mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 20 width 0 timing 0
> mmc0: clock 400000Hz busmode 1 powermode 2 cs 1 Vdd 20 width 0 timing 0
> mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 20 width 0 timing 0
> mmc0: req failed (CMD5): -110, retrying...
> mmc0: req failed (CMD5): -110, retrying...
> mmc0: req failed (CMD5): -110, retrying...
> mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 20 width 0 timing 0
> mmc0: clock 400000Hz busmode 1 powermode 2 cs 1 Vdd 20 width 0 timing 0
> mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 20 width 0 timing 0
> mmc0: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 0 timing 0
> mmc0: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 0 timing 2
> mmc0: clock 50000000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 0 timing 2
> mmc0: clock 50000000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 2 timing 2
> mmc0: new high speed SD card at address 0002
> mmcblk0: mmc0:0002 N/A   484 MiB
>  mmcblk0: p1
> mmcblk0: retrying using single block read
> mmcblk0: error -84 transferring data, sector 57, nr 71, card status  0x900
> end_request: I/O error, dev mmcblk0, sector 57
> mmcblk0: error -84 transferring data, sector 61, nr 67, card status 0x900
> end_request: I/O error, dev mmcblk0, sector 61
> quiet_error: 15 callbacks suppressed
> Buffer I/O error on device mmcblk0, logical block 7
> mmcblk0: error -84 transferring data, sector 65, nr 63, card status 0x900
> end_request: I/O error, dev mmcblk0, sector 65
> mmcblk0: error -84 transferring data, sector 69, nr 59, card status 0x900
> end_request: I/O error, dev mmcblk0, sector 69
> mmcblk0: error -84 transferring data, sector 71, nr 57, card status 0x900
> end_request: I/O error, dev mmcblk0, sector 71
> Buffer I/O error on device mmcblk0, logical block 8
> mmcblk0: error -84 transferring data, sector 73, nr 55, card status 0x900
> end_request: I/O error, dev mmcblk0, sector 73
> mmcblk0: error -84 transferring data, sector 77, nr 51, card status 0x900
> end_request: I/O error, dev mmcblk0, sector 77
> Buffer I/O error on device mmcblk0, logical block 9
> mmcblk0: error -84 transferring data, sector 87, nr 41, card status 0x900
> end_request: I/O error, dev mmcblk0, sector 87
> Buffer I/O error on device mmcblk0, logical block 10
> mmcblk0: error -84 transferring data, sector 127, nr 1, card status 0x900
> end_request: I/O error, dev mmcblk0, sector 127
> Buffer I/O error on device mmcblk0, logical block 15
> mmcblk0: retrying using single block read
> mmcblk0: error -84 transferring data, sector 143, nr 113, card status 0x900
> end_request: I/O error, dev mmcblk0, sector 143
> Buffer I/O error on device mmcblk0, logical block 17
> mmcblk0: error -84 transferring data, sector 151, nr 105, card status 0x900
> end_request: I/O error, dev mmcblk0, sector 151
> Buffer I/O error on device mmcblk0, logical block 18
> mmcblk0: error -84 transferring data, sector 161, nr 95, card status 0x900
> end_request: I/O error, dev mmcblk0, sector 161
> mmcblk0: error -84 transferring data, sector 215, nr 41, card status 0x900
> end_request: I/O error, dev mmcblk0, sector 215
> Buffer I/O error on device mmcblk0, logical block 26
> mmcblk0: error -84 transferring data, sector 217, nr 39, card status 0x900
> end_request: I/O error, dev mmcblk0, sector 217
> mmcblk0: retrying using single block read
> mmcblk0: error -84 transferring data, sector 57, nr 7, card status 0x900
> end_request: I/O error, dev mmcblk0, sector 57
> mmcblk0: retrying using single block read
> mmcblk0: error -84 transferring data, sector 535, nr 9, card status 0x900
> end_request: I/O error, dev mmcblk0, sector 535
> mmcblk0: retrying using single block read
> mmcblk0: error -84 transferring data, sector 535, nr 1, card status 0x900
> end_request: I/O error, dev mmcblk0, sector 535
> mmcblk0: retrying using single block read
> mmcblk0: retrying using single block read
> mmcblk0: error -84 transferring data, sector 193, nr 116, card status 0x900
> end_request: I/O error, dev mmcblk0, sector 193
> mmcblk0: error -84 transferring data, sector 215, nr 94, card status 0x900
> end_request: I/O error, dev mmcblk0, sector 215
> mmcblk0: error -84 transferring data, sector 217, nr 92, card status 0x900
> end_request: I/O error, dev mmcblk0, sector 217
> mmcblk0: error -84 transferring data, sector 279, nr 30, card status 0x900
> end_request: I/O error, dev mmcblk0, sector 279
> mmcblk0: error -84 transferring data, sector 289, nr 20, card status 0x900
> end_request: I/O error, dev mmcblk0, sector 289
> mmcblk0: retrying using single block read
> mmcblk0: error -84 transferring data, sector 57, nr 124, card status 0x900
> end_request: I/O error, dev mmcblk0, sector 57
> mmcblk0: error -84 transferring data, sector 61, nr 120, card status 0x900
> end_request: I/O error, dev mmcblk0, sector 61
> mmcblk0: error -84 transferring data, sector 65, nr 116, card status 0x900
> end_request: I/O error, dev mmcblk0, sector 65
> mmcblk0: error -84 transferring data, sector 71, nr 110, card status 0x900
> end_request: I/O error, dev mmcblk0, sector 71
> mmcblk0: error -84 transferring data, sector 75, nr 106, card status 0x900
> end_request: I/O error, dev mmcblk0, sector 75
> mmcblk0: error -84 transferring data, sector 77, nr 104, card status 0x900
> end_request: I/O error, dev mmcblk0, sector 77
> mmcblk0: error -84 transferring data, sector 79, nr 102, card status 0x900
> end_request: I/O error, dev mmcblk0, sector 79
> mmcblk0: error -84 transferring data, sector 81, nr 100, card status 0x900
> end_request: I/O error, dev mmcblk0, sector 81
> mmcblk0: error -84 transferring data, sector 85, nr 96, card status 0x900
> end_request: I/O error, dev mmcblk0, sector 85
> mmcblk0: error -84 transferring data, sector 87, nr 94, card status 0x900
> end_request: I/O error, dev mmcblk0, sector 87
> mmcblk0: error -84 transferring data, sector 103, nr 78, card status 0x900
> end_request: I/O error, dev mmcblk0, sector 103
> mmcblk0: error -84 transferring data, sector 127, nr 54, card status 0x900
> end_request: I/O error, dev mmcblk0, sector 127
> mmcblk0: error -84 transferring data, sector 143, nr 38, card status 0x900
> end_request: I/O error, dev mmcblk0, sector 143
> mmcblk0: error -84 transferring data, sector 151, nr 30, card status 0x900
> end_request: I/O error, dev mmcblk0, sector 151
> mmcblk0: error -84 transferring data, sector 161, nr 20, card status 0x900
> end_request: I/O error, dev mmcblk0, sector 161
> mmcblk0: error -84 transferring data, sector 177, nr 4, card status 0x900
> end_request: I/O error, dev mmcblk0, sector 177
> mmcblk0: error -84 transferring data, sector 57, nr 1, card status 0x900
> end_request: I/O error, dev mmcblk0, sector 57
> 
> 
> Thanks
> hongbo

