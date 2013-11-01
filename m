From: Axel Lin <axel.lin@ingics.com>
Subject: How to determinate max_req_size and max_blk_count settings
Date: Fri, 01 Nov 2013 17:25:51 +0800
Message-ID: <1383297951.29202.6.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:63566 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755614Ab3KAJZ6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Nov 2013 05:25:58 -0400
Received: by mail-pa0-f41.google.com with SMTP id rd3so3845523pab.28
        for <linux-mmc@vger.kernel.org>; Fri, 01 Nov 2013 02:25:57 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>

Hi,
I'm working on a sd/mmc driver.
The controller has a BLKLEN setting, however here is no register to set
block_count setting.
The datasheet says for Multi-Block Read/Write:
host needs to stop controller manually by setting STPCMD to 1 when all data is
received/transmitted. Host also needs to start CMD12 on the bus to stop the card.
The datasheet does not mention the limitation on block_count.

So my question is how to determinate max_req_size and max_blk_count settings in
driver since the controller only has a BLKLEN setting in register.

Yet another question is:
I got some messages while copying file to sd card:
[   35.602813] mmcblk0: error -5 transferring data, sector 11008, nr 64, cmd response 0x900, card status 0xc00
[   35.639143] end_request: I/O error, dev mmcblk0, sector 11008
[   35.645170] end_request: I/O error, dev mmcblk0, sector 11016
[   35.651690] end_request: I/O error, dev mmcblk0, sector 11024
[   35.658095] end_request: I/O error, dev mmcblk0, sector 11032
[   35.664090] end_request: I/O error, dev mmcblk0, sector 11040
[   35.670570] end_request: I/O error, dev mmcblk0, sector 11048
[   35.676541] end_request: I/O error, dev mmcblk0, sector 11056
[   35.682997] end_request: I/O error, dev mmcblk0, sector 11064

The copy looks success.
(Destination file size looks ok.
And if I copy an executable file, I can execute it.
So I think the copy is success.)

But I'm still have no idea how to debug such I/O error now.
Any comments/hits to debug such issue?

Thanks,
Axel


