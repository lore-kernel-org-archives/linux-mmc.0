From: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>
Subject: Boot from eMMC and removing SDcard after boot results in Warning
Date: Thu, 4 Sep 2014 17:31:22 +0200
Message-ID: <CAL8zT=hbYPgUBeF33vf8H3AFGiFHhGrKMKPE2Xqqeen10O6NbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:58969 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753992AbaIDPbh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Sep 2014 11:31:37 -0400
Received: by mail-oa0-f49.google.com with SMTP id jd19so7364394oac.22
        for <linux-mmc@vger.kernel.org>; Thu, 04 Sep 2014 08:31:37 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi,

I have now a kernel which boots from eMMC card on mmc1 and mounts
partitions from mmc0 which is a SDcard. When I remove the SDcard, I
get the following warning :

[  109.182663] mmc0: card 0002 removed
[  109.448516] ------------[ cut here ]------------
[  109.453205] WARNING: CPU: 1 PID: 855 at fs/fs-writeback.c:1200
__mark_inode_dirty+0x1bc/0x1d0()
[  109.461956] bdi-block not registered
[  109.465564] Modules linked in: snd_soc_sgtl5000 snd_soc_imx_sgtl5000
[  109.472017] CPU: 1 PID: 855 Comm: umount Tainted: G        W
3.17.0-rc2+yocto+g49cd5a7d #40
[  109.480860] Backtrace:
[  109.483373] [<80012ff0>] (dump_backtrace) from [<800132d4>]
(show_stack+0x18/0x1c)
[  109.490988]  r6:80aa5ef4 r5:80aa5ef4 r4:00000000 r3:00000000
[  109.496774] [<800132bc>] (show_stack) from [<806db4ec>]
(dump_stack+0x8c/0xa4)
[  109.504026] [<806db460>] (dump_stack) from [<8002b8b8>]
(warn_slowpath_common+0x70/0x94)
[  109.512145]  r6:801135d0 r5:00000009 r4:bd043de8 r3:bd066b40
[  109.517915] [<8002b848>] (warn_slowpath_common) from [<8002b914>]
(warn_slowpath_fmt+0x38/0x40)
[  109.526640]  r8:00000000 r7:a00b0013 r6:bd898970 r5:bdc53b70 r4:bd898768
[  109.533460] [<8002b8e0>] (warn_slowpath_fmt) from [<801135d0>]
(__mark_inode_dirty+0x1bc/0x1d0)
[  109.542189]  r3:8095be98 r2:80951c5c
[  109.545840] [<80113414>] (__mark_inode_dirty) from [<80119d1c>]
(__set_page_dirty+0x90/0xc8)
[  109.554316]  r7:a00b0013 r6:bdc53cac r5:bdc53c9c r4:bef816e0
[  109.560095] [<80119c8c>] (__set_page_dirty) from [<8011ad84>]
(mark_buffer_dirty+0x84/0xbc)
[  109.568470]  r8:bc51d800 r7:80a82380 r6:bc51d800 r5:00000000
r4:bef816e0 r3:bdc53c9c
[  109.576328] [<8011ad00>] (mark_buffer_dirty) from [<801633b4>]
(ext3_put_super+0x1fc/0x23c)
[  109.584699]  r5:bdabcc00 r4:bc8b7400
[  109.588328] [<801631b8>] (ext3_put_super) from [<800ee73c>]
(generic_shutdown_super+0x78/0xe0)
[  109.596958]  r7:80a82380 r6:806ed0a8 r5:bc51d890 r4:bc51d800
[  109.602694] [<800ee6c4>] (generic_shutdown_super) from [<800eea50>]
(kill_block_super+0x20/0x74)
[  109.611497]  r6:8010c5fc r5:00000083 r4:bdc53a80 r3:800eea30
[  109.617248] [<800eea30>] (kill_block_super) from [<800eee68>]
(deactivate_locked_super+0x68/0x7c)
[  109.626138]  r6:8010c5fc r5:80aa0228 r4:bc51d800 r3:800eea30
[  109.631877] [<800eee00>] (deactivate_locked_super) from
[<800efaec>] (deactivate_super+0x68/0x6c)
[  109.640766]  r5:00000001 r4:bc51d800
[  109.644399] [<800efa84>] (deactivate_super) from [<8010aff0>]
(mntput_no_expire+0x18c/0x27c)
[  109.652841]  r5:00000001 r4:bd388780
[  109.656476] [<8010ae64>] (mntput_no_expire) from [<8010c5fc>]
(SyS_umount+0xa0/0x4a8)
[  109.664326]  r7:8000f680 r6:bd388780 r5:00000000 r4:bd3887a8
[  109.670068] [<8010c55c>] (SyS_umount) from [<8000f680>]
(ret_fast_syscall+0x0/0x48)
[  109.677747]  r10:00000000 r9:bd042000 r8:8000f844 r7:00000034
r6:00cec7e0 r5:76f3e8c8
[  109.685684]  r4:00ceb038
[  109.688239] ---[ end trace 2709c6b2b9cdead5 ]---
[  109.693718] EXT3-fs (mmcblk0p2): I/O error while writing superblock

I am having a look into it, but if anyone already solved this ;-).
Thanks,
JM
