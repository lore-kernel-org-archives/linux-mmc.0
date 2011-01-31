From: =?ISO-8859-1?Q?Marc=2DAndr=E9_H=E9bert?=
	<hebert.marcandre@gmail.com>
Subject: Question about read only flag
Date: Mon, 31 Jan 2011 09:01:02 -0500
Message-ID: <AANLkTi=odLjJtR19fMAyDNB9f+FV_Y-e48Li7fkZTKrv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41477 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177Ab1AaOBD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 31 Jan 2011 09:01:03 -0500
Received: by ywe10 with SMTP id 10so1970333ywe.19
        for <linux-mmc@vger.kernel.org>; Mon, 31 Jan 2011 06:01:02 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello,

I have on an OMAPL138 board running 2.6.33-rc4 (I would liked to try a
more recent kernel but I do not have any boards which supports a more
recent version). I noticed that I was unable to detect from sysfs if
the inserted card was set to read only. The block device's
/sys/class/block/mmcblk0/ro entry always reported 0. The read only
gpio is correctly setup as opening the device for writing fails as
expected.

If I compare the behavior with a USB card reader (which of course
doesn't initialize the block device in the same way), the
/sys/class/block/xxx/ro entry is correct.

I am unsure if this is the desired behavior (if so I would really like
to understand why) but here's what I did to correct it.

Regards
Marc

--- a/drivers/mmc/card/block.c     2011-01-31 08:54:56.908952200 -0500
+++ b/drivers/mmc/card/block.c    2011-01-31 08:56:44.175950200 -0500
@@ -621,6 +621,7 @@
        md->disk->private_data = md;
        md->disk->queue = md->queue.queue;
        md->disk->driverfs_dev = &card->dev;
+       set_disk_ro(md->disk, md->read_only);

        /*
         * As discussed on lkml, GENHD_FL_REMOVABLE should:
