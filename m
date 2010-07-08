From: hardik patel <hk5patel@gmail.com>
Subject: SD Driver : FAT: FAT read failed (blocknr 8) in sd card error while
	removing sd card during writing
Date: Thu, 8 Jul 2010 15:35:52 +0530
Message-ID: <AANLkTim_7C0pYl_xwPbavrz96GJHiiTngUSWEiMAzGuL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:45918 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396Ab0GHKFx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Jul 2010 06:05:53 -0400
Received: by gwj21 with SMTP id 21so263008gwj.19
        for <linux-mmc@vger.kernel.org>; Thu, 08 Jul 2010 03:05:52 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

I have sd card on board ... During recording/writing SD card, remove
SD card ... then i am getting endless error in dmesg as below :

end_request: I/O error, dev mmcblk0, sector 24
FAT: FAT read failed (blocknr 8)
mmcblk0: error -110 sending status comand<3>mmcblk0: error -110
sending read/write command, response 0x0, card status 0x0
Block mmc_blk_issue_rq function call 346
end_request: I/O error, dev mmcblk0, sector 4
FAT: FAT read failed (blocknr 4)
MMC: killing requests for dead queue
end_request: I/O error, dev mmcblk0, sector 8
FAT: FAT read failed (blocknr 8)
FAT: FAT read failed (blocknr 4)
FAT: FAT read failed (blocknr 8)
FAT: FAT read failed (blocknr 4)
FAT: FAT read failed (blocknr 8)
FAT: FAT read failed (blocknr 4)
FAT: FAT read failed (blocknr 8)

How to stop this message ... what is ideal situation when we remove
card while writing ...... can u help me what to do ?

where is the problem here? sd host controler driver problem or block
driver problem or file system problem

Note: I have formatted sd card with FAT32 file system .



With EXT3 File system :

Remove SD card while writing/recording we got error messages like
below. but this is not endless. After some time it stops.

==============================
=============
end_request: I/O error, dev mmcblk0, sector 156536
mmcblk0: error -110 sending status comand<3>mmcblk0: error -110
sending read/write command, response 0x0, card status 0x0
mmcblk0: error -110 requesting status
end_request: I/O error, dev mmcblk0, sector 4736
Aborting journal on device mmcblk0p1.
ext3_abort called.
EXT3-fs error (device mmcblk0p1): ext3_journal_start_sb: Detected
aborted journal
Remounting filesystem read-only
end_request: I/O error, dev mmcblk0, sector 4448
journal commit I/O error
===========================================
