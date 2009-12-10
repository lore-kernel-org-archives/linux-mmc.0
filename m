From: "Aric D. Blumer" <aric@sdgsystems.com>
Subject: MMC Suspend Hang in kernel 2.6.32
Date: Thu, 10 Dec 2009 11:33:45 -0500
Message-ID: <4B2122E9.1080109@sdgsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:45297 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760801AbZLJQdl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Dec 2009 11:33:41 -0500
Received: by yxe17 with SMTP id 17so7071817yxe.33
        for <linux-mmc@vger.kernel.org>; Thu, 10 Dec 2009 08:33:48 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi.  I believe I'm running into the same problem that is reported here:

http://thread.gmane.org/gmane.linux.kernel/884017

It looks like the patch that helped the original poster got into 2.6.32,
but I still get the hang on suspend.  I've tracked it down to the
bdi_wait_on_work_clear() function in fs/fs-writeback.c.  I put a
backtrace dump in that function, and it's included below.  This is on a
PXA320 device, but as far as I can tell, it's not caused by pxamci.c.

[<c00c1d58>] (sync_inodes_sb+0x0/0x1c8) from [<c00c62c0>]
(__sync_filesystem+0xb4/0xe8)
 r7:00000002 r6:c7fadce0 r5:00000001 r4:c7e14e00
[<c00c620c>] (__sync_filesystem+0x0/0xe8) from [<c00c64d8>]
(sync_filesystem+0x5c/0x74)
 r5:c7408340 r4:c7e14e00
[<c00c647c>] (sync_filesystem+0x0/0x74) from [<c00cf600>]
(fsync_bdev+0x38/0x8c)
 r4:c7e14e00
[<c00cf5c8>] (fsync_bdev+0x0/0x8c) from [<c017a650>]
(invalidate_partition+0x38/0x8c)
 r5:c7408340 r4:c7408340
[<c017a618>] (invalidate_partition+0x0/0x8c) from [<c00ecb34>]
(del_gendisk+0x4c/0x1a8)
 r5:c7b2de00 r4:c7b2d800
[<c00ecae8>] (del_gendisk+0x0/0x1a8) from [<c025d7b4>]
(mmc_blk_remove+0x44/0x9c)
 r6:c7b2d608 r5:c7b2ede0 r4:c7b2ede4
[<c025d770>] (mmc_blk_remove+0x0/0x9c) from [<c02574cc>]
(mmc_bus_remove+0x2c/0x44)
 r6:c7aada08 r5:c04523b0 r4:c7b2d608
[<c02574a0>] (mmc_bus_remove+0x0/0x44) from [<c01c3ed0>]
(__device_release_driver+0x9c/0x170)
 r5:c04523b0 r4:c7b2d608
[<c01c3e34>] (__device_release_driver+0x0/0x170) from [<c01c4074>]
(device_release_driver+0x24/0x30)
 r5:c7b2d63c r4:c7b2d608
[<c01c4050>] (device_release_driver+0x0/0x30) from [<c01c3154>]
(bus_remove_device+0xb4/0x10c)
 r5:c7b2d610 r4:c7b2d608
[<c01c30a0>] (bus_remove_device+0x0/0x10c) from [<c01c11a8>]
(device_del+0x190/0x2b8)
 r5:c7b2d608 r4:c7b2d600
[<c01c1018>] (device_del+0x0/0x2b8) from [<c02578e0>]
(mmc_remove_card+0x54/0xb0)
 r6:00000000 r5:c7b2d608 r4:c7b2d600
[<c025788c>] (mmc_remove_card+0x0/0xb0) from [<c02593a0>]
(mmc_sd_remove+0x38/0x80)
 r5:c042eb48 r4:c7aada00
[<c0259368>] (mmc_sd_remove+0x0/0x80) from [<c02573cc>]
(mmc_suspend_host+0x158/0x17c)
 r4:c7aada00
[<c0257274>] (mmc_suspend_host+0x0/0x17c) from [<c025eb04>]
(pxamci_suspend+0x20/0x2c)
 r6:00000000 r5:c042eb48 r4:c03556f8
[<c025eae4>] (pxamci_suspend+0x0/0x2c) from [<c01c5498>]
(platform_pm_suspend+0x38/0x68)
[<c01c5460>] (platform_pm_suspend+0x0/0x68) from [<c01c79d8>]
(pm_op+0x3c/0x94)
[<c01c799c>] (pm_op+0x0/0x94) from [<c01c7e64>]
(dpm_suspend_start+0x2c4/0x594)
 r5:c042eb48 r4:c042eba0
[<c01c7ba0>] (dpm_suspend_start+0x0/0x594) from [<c0071954>]
(suspend_devices_and_enter+0x64/0x200)
[<c00718f0>] (suspend_devices_and_enter+0x0/0x200) from [<c0071bf8>]
(enter_state+0x108/0x130)
 r6:c03ca8e0 r5:00000003 r4:00000000
[<c0071af0>] (enter_state+0x0/0x130) from [<c0071c40>]
(pm_suspend+0x20/0x2c)
 r6:00004102 r5:c6c71740 r4:00000003
[<c0071c20>] (pm_suspend+0x0/0x2c) from [<c01ba2c4>] (apm_ioctl+0x84/0x1c8)
[<c01ba240>] (apm_ioctl+0x0/0x1c8) from [<c00b2700>] (vfs_ioctl+0x74/0x78)
 r6:00004102 r5:c01ba240 r4:c7f0d500
[<c00b268c>] (vfs_ioctl+0x0/0x78) from [<c00b29b4>]
(do_vfs_ioctl+0x98/0x594)
 r5:00000000 r4:00000003
[<c00b291c>] (do_vfs_ioctl+0x0/0x594) from [<c00b2ef0>]
(sys_ioctl+0x40/0x68)
 r9:c7fac000 r8:c0027108 r7:00000036 r6:00004102 r5:fffffff7
r4:c7f0d500
[<c00b2eb0>] (sys_ioctl+0x0/0x68) from [<c0026f60>]
(ret_fast_syscall+0x0/0x28)
 r6:00000000 r5:00000003 r4:00000003

