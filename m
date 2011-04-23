From: Rabin Vincent <rabin@rab.in>
Subject: [PATCH] mmc: block: init force_ro sysfs attribute
Date: Sat, 23 Apr 2011 20:52:58 +0530
Message-ID: <1303572178-6349-1-git-send-email-rabin@rab.in>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:43669 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754708Ab1DWPWd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 23 Apr 2011 11:22:33 -0400
Received: by pwi15 with SMTP id 15so681167pwi.19
        for <linux-mmc@vger.kernel.org>; Sat, 23 Apr 2011 08:22:33 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: andreiw@motorola.com, linux-mmc@vger.kernel.org, Rabin Vincent <rabin@rab.in>

To avoid lockdep warnings:

BUG: key dc90a520 not in .data!
------------[ cut here ]------------
WARNING: at /home/rabin/kernel/arm/kernel/lockdep.c:2701 sysfs_add_file_mode+0x4c/0xb0()
Modules linked in:
[<c004b5d8>] (unwind_backtrace+0x0/0xe4) from [<c0074f20>] (warn_slowpath_common+0x4c/0x64)
[<c0074f20>] (warn_slowpath_common+0x4c/0x64) from [<c0074f50>] (warn_slowpath_null+0x18/0x1c)
[<c0074f50>] (warn_slowpath_null+0x18/0x1c) from [<c0157fec>] (sysfs_add_file_mode+0x4c/0xb0)
[<c0157fec>] (sysfs_add_file_mode+0x4c/0xb0) from [<c02d61e4>] (mmc_add_disk+0x40/0x64)
[<c02d61e4>] (mmc_add_disk+0x40/0x64) from [<c02d64cc>] (mmc_blk_probe+0x188/0x1fc)
[<c02d64cc>] (mmc_blk_probe+0x188/0x1fc) from [<c02ce820>] (mmc_bus_probe+0x14/0x18)
...

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 drivers/mmc/card/block.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 9e30cf6..179a607 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -967,6 +967,7 @@ static int mmc_add_disk(struct mmc_blk_data *md)
 	add_disk(md->disk);
 	md->force_ro.show = force_ro_show;
 	md->force_ro.store = force_ro_store;
+	sysfs_attr_init(&md->force_ro.attr);
 	md->force_ro.attr.name = "force_ro";
 	md->force_ro.attr.mode = S_IRUGO | S_IWUSR;
 	ret = device_create_file(disk_to_dev(md->disk), &md->force_ro);
-- 
1.7.4.1

