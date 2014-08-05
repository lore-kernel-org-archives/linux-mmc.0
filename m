From: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>
Subject: Sandisk MMC I/O errors
Date: Tue, 5 Aug 2014 16:26:39 +0200
Message-ID: <CAL8zT=iinDtm3_77jSDWG1RSjN5CgEtAgPjA_ju3-=ZS2Qco8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:63783 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbaHEO0z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Aug 2014 10:26:55 -0400
Received: by mail-ob0-f178.google.com with SMTP id nu7so729219obb.23
        for <linux-mmc@vger.kernel.org>; Tue, 05 Aug 2014 07:26:54 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: "jean-michel.hautbois@vodalys.com" <jean-michel.hautbois@vodalys.com>

Hi all,

I have a custom board based on a i.MX6 SoC and it has a Sandisk eMMC
(SDIN5D1-2G).
When booting a vanilla kernel, I get lots of I/O errors.
Before investigating, I would like to know if this is a known issue.

Here is the full dmesg :

[    1.346762] mmcblk1: mmc1:0001 SEM02G 1.82 GiB
[    1.350142] mmcblk1boot0: mmc1:0001 SEM02G partition 1 1.00 MiB
[    1.354901] mmcblk1boot1: mmc1:0001 SEM02G partition 2 1.00 MiB
[    1.359643] mmcblk1rpmb: mmc1:0001 SEM02G partition 3 128 KiB
[    1.366291] mmcblk1: error -84 transferring data, sector 0, nr 8,
cmd response 0x900, card status 0xb00
[    1.374409] mmcblk1: retrying using single block read
[    1.378810] mmcblk1: error -84 transferring data, sector 0, nr 8,
cmd response 0x900, card status 0x0
[    1.386762] end_request: I/O error, dev mmcblk1, sector 0
[    1.413406] mmcblk1: error -84 transferring data, sector 1, nr 7,
cmd response 0x900, card status 0x0
[    1.421363] end_request: I/O error, dev mmcblk1, sector 1
[    1.425771] mmcblk1: error -84 transferring data, sector 2, nr 6,
cmd response 0x900, card status 0x0
[    1.425778] end_request: I/O error, dev mmcblk1, sector 2
[    1.426069] mmcblk1: error -84 transferring data, sector 3, nr 5,
cmd response 0x900, card status 0x0
[    1.426076] end_request: I/O error, dev mmcblk1, sector 3
[    1.426366] mmcblk1: error -84 transferring data, sector 4, nr 4,
cmd response 0x900, card status 0x0
[    1.426373] end_request: I/O error, dev mmcblk1, sector 4
[    1.426663] mmcblk1: error -84 transferring data, sector 5, nr 3,
cmd response 0x900, card status 0x0
[    1.426670] end_request: I/O error, dev mmcblk1, sector 5
[    1.426958] mmcblk1: error -84 transferring data, sector 6, nr 2,
cmd response 0x900, card status 0x0
[    1.426965] end_request: I/O error, dev mmcblk1, sector 6
[    1.427253] mmcblk1: error -84 transferring data, sector 7, nr 1,
cmd response 0x900, card status 0x0
[    1.427260] end_request: I/O error, dev mmcblk1, sector 7
[    1.427267] Buffer I/O error on device mmcblk1, logical block 0
[    1.520695] mmcblk1: error -84 transferring data, sector 0, nr 8,
cmd response 0x900, card status 0xb00
[    1.557473] mmcblk1: retrying using single block read
[    1.566322] mmcblk1: error -84 transferring data, sector 0, nr 8,
cmd response 0x900, card status 0x0
[    1.604661] end_request: I/O error, dev mmcblk1, sector 0
[    1.609037] mmcblk1: error -84 transferring data, sector 1, nr 7,
cmd response 0x900, card status 0x0
[    1.616988] end_request: I/O error, dev mmcblk1, sector 1
[    1.621380] mmcblk1: error -84 transferring data, sector 2, nr 6,
cmd response 0x900, card status 0x0
[    1.629571] mmcblk1: error -84 transferring data, sector 3, nr 5,
cmd response 0x900, card status 0x0
[    1.637799] mmcblk1: error -84 transferring data, sector 4, nr 4,
cmd response 0x900, card status 0x0
[    1.646033] mmcblk1: error -84 transferring data, sector 5, nr 3,
cmd response 0x900, card status 0x0
[    1.654268] mmcblk1: error -84 transferring data, sector 6, nr 2,
cmd response 0x900, card status 0x0
[    1.662515] mmcblk1: error -84 transferring data, sector 7, nr 1,
cmd response 0x900, card status 0x0
[    1.670461] Buffer I/O error on device mmcblk1, logical block 0
[    1.675099]  mmcblk1: unable to read partition table
[    1.682365] mmcblk1boot1: error -84 transferring data, sector 0, nr
8, cmd response 0x900, card status 0xb00
[    1.691986] mmcblk1boot1: retrying using single block read
[    1.696442] mmcblk1boot1: error -84 transferring data, sector 0, nr
8, cmd response 0x900, card status 0x0
[    1.705449] mmcblk1boot1: error -84 transferring data, sector 1, nr
7, cmd response 0x900, card status 0x0
[    1.714322] mmcblk1boot1: error -84 transferring data, sector 2, nr
6, cmd response 0x900, card status 0x0
[    1.723424] mmcblk1boot1: error -84 transferring data, sector 3, nr
5, cmd response 0x900, card status 0x0
[    1.732507] mmcblk1boot1: error -84 transferring data, sector 4, nr
4, cmd response 0x900, card status 0x0
[    1.741569] mmcblk1boot1: error -84 transferring data, sector 5, nr
3, cmd response 0x900, card status 0x0
[    1.750762] mmcblk1boot1: error -84 transferring data, sector 6, nr
2, cmd response 0x900, card status 0x0
[    1.759745] mmcblk1boot1: error -84 transferring data, sector 7, nr
1, cmd response 0x900, card status 0x0
[    1.768105] Buffer I/O error on device mmcblk1boot1, logical block 0
[    1.774224] mmcblk1boot1: error -84 transferring data, sector 0, nr
8, cmd response 0x900, card status 0xb00
[    1.783320] mmcblk1boot1: retrying using single block read
[    1.787776] mmcblk1boot1: error -84 transferring data, sector 0, nr
8, cmd response 0x900, card status 0x0
[    1.796600] mmcblk1boot1: error -84 transferring data, sector 1, nr
7, cmd response 0x900, card status 0x0
[    1.806249] mmcblk1boot1: error -84 transferring data, sector 2, nr
6, cmd response 0x900, card status 0x0
[    1.815130] mmcblk1boot1: error -84 transferring data, sector 3, nr
5, cmd response 0x900, card status 0x0
[    1.824109] mmcblk1boot1: error -84 transferring data, sector 4, nr
4, cmd response 0x900, card status 0x0
[    1.832785] mmcblk1boot1: error -84 transferring data, sector 5, nr
3, cmd response 0x900, card status 0x0
[    1.842041] mmcblk1boot1: error -84 transferring data, sector 6, nr
2, cmd response 0x900, card status 0x0
[    1.850854] mmcblk1boot1: error -84 transferring data, sector 7, nr
1, cmd response 0x900, card status 0x0
[    1.859403] Buffer I/O error on device mmcblk1boot1, logical block 0
[    1.864681]  mmcblk1boot1: unable to read partition table
[    1.869905] mmcblk1boot0: error -84 transferring data, sector 0, nr
8, cmd response 0x900, card status 0xb00
[    1.878753] mmcblk1boot0: retrying using single block read
[    1.883798] mmcblk1boot0: error -84 transferring data, sector 0, nr
8, cmd response 0x900, card status 0x0
[    1.892674] mmcblk1boot0: error -84 transferring data, sector 1, nr
7, cmd response 0x900, card status 0x0
[    1.902740] mmcblk1boot0: error -84 transferring data, sector 2, nr
6, cmd response 0x900, card status 0x0
[    1.911604] mmcblk1boot0: error -84 transferring data, sector 3, nr
5, cmd response 0x900, card status 0x0
[    1.920287] mmcblk1boot0: error -84 transferring data, sector 4, nr
4, cmd response 0x900, card status 0x0
[    1.928900] mmcblk1boot0: error -84 transferring data, sector 5, nr
3, cmd response 0x900, card status 0x0
[    1.939773] mmcblk1boot0: error -84 transferring data, sector 6, nr
2, cmd response 0x900, card status 0x0
[    1.948437] mmcblk1boot0: error -84 transferring data, sector 7, nr
1, cmd response 0x900, card status 0x0
[    1.956917] Buffer I/O error on device mmcblk1boot0, logical block 0
[    1.962548] mmcblk1boot0: error -84 transferring data, sector 0, nr
8, cmd response 0x900, card status 0xb00
[    1.971325] mmcblk1boot0: retrying using single block read
[    1.975828] mmcblk1boot0: error -84 transferring data, sector 0, nr
8, cmd response 0x900, card status 0x0
[    1.984565] mmcblk1boot0: error -84 transferring data, sector 1, nr
7, cmd response 0x900, card status 0x0
[    1.993267] mmcblk1boot0: error -84 transferring data, sector 2, nr
6, cmd response 0x900, card status 0x0
[    2.001976] mmcblk1boot0: error -84 transferring data, sector 3, nr
5, cmd response 0x900, card status 0x0
[    2.010703] mmcblk1boot0: error -84 transferring data, sector 4, nr
4, cmd response 0x900, card status 0x0
[    2.019406] mmcblk1boot0: error -84 transferring data, sector 5, nr
3, cmd response 0x900, card status 0x0
[    2.028127] mmcblk1boot0: error -84 transferring data, sector 6, nr
2, cmd response 0x900, card status 0x0
[    2.036844] mmcblk1boot0: error -84 transferring data, sector 7, nr
1, cmd response 0x900, card status 0x0
[    2.045304] Buffer I/O error on device mmcblk1boot0, logical block 0
[    2.050460]  mmcblk1boot0: unable to read partition table


Thanks,
JM
