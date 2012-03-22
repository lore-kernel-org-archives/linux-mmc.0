From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: Occasional crashes in suspend-resume with MMC transactions
Date: Thu, 22 Mar 2012 04:23:23 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D12143317FDFBB@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55626 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751253Ab2CVEXb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Mar 2012 00:23:31 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi,

I am trying to do suspend-resume test with a file copy on MMC/SD going on
in the background. The test involves simply copying a 450MB file on an ext3
partition to the same partition under a different name.

This is on an AM335x board which uses the omap_hsmmc driver. 
The kernel is v3.2 and I have also applied the following patch 

commit 6b9dc6b5f2a1b7953e46e897eb3e91e885322ed0
Author: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date:   Wed Jan 4 15:28:45 2012 +0100

    mmc: fix a deadlock between system suspend and MMC block IO

    Performing MMC block IO with simultaneous STR can lead to a deadlock: the
    mmc_pm_notify() function claims the host and then calls bus .remove()
    method, which lands in mmc_blk_remove(), which calls mmc_blk_remove_req()
    then it goes to -> mmc_cleanup_queue() -> kthread_stop(), which waits for
    the mmc-block thread to stop. If the mmc-block thread at that time is
    processing block requests, it will also try to claim the host in
    mmc_blk_issue_rq() and block there. This patch fixes the problem by
    calling .remove() before claiming the host.

    Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
    Acked-by: Arindam Nath <arindam.nath@amd.com>
    Signed-off-by: Chris Ball <cjb@laptop.org>


In some iterations the resume part gets into issues with the following dump

...
[  229.716033] PM: Syncing filesystems ... done.
[  281.389129] Freezing user space processes ... (elapsed 0.95 seconds) done.
[  282.357757] Freezing remaining freezable tasks ... (elapsed 4.36 seconds) done.
[  286.764099] PM: suspend of devices complete after 29.815 msecs
[  286.765777] PM: late suspend of devices complete after 1.647 msecs

( resume using a uart keystroke)
[  290.121765] GFX domain entered low power stat
[  290.123748] Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa06022c
[  290.123809] Internal error: : 1028 [#1]
[  290.123840] Modules linked in:
[  290.123870] CPU: 0    Not tainted  (3.2.0-12280-g6b9dc6b-dirty #12)
[  290.123931] PC is at omap_hsmmc_request+0xcc/0x4d8
[  290.123962] LR is at mmc_start_request+0x110/0x20c
[  290.123992] pc : [<c030baec>]    lr : [<c02fbff8>]    psr: a0000113
[  290.124023] sp : cf373e58  ip : cf373ea0  fp : cf373e9c
[  290.124053] r10: 00000000  r9 : ce55e218  r8 : cfa6202c
[  290.124053] r7 : cfa620dc  r6 : cf3b6000  r5 : cfa6202c  r4 : cf3b6280
[  290.124084] r3 : fa060100  r2 : fa060100  r1 : 00000080  r0 : cf3b6000
[  290.124145] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[  290.124176] Control: 10c5387d  Table: 8edf4019  DAC: 00000015
[  290.124206] Process mmcqd/0 (pid: 666, stack limit = 0xcf3722f0)
[  290.124237] Stack: (0xcf373e58 to 0xcf374000)
[  290.124237] 3e40:                                                       cf373e9c cf373e68
[  290.124298] 3e60: c001991c c01c7898 cf362c40 00000001 00002000 cfa6202c cf3b6000 c0616550
[  290.124359] 3e80: cfa620dc cfa6202c ce55e218 00000000 cf373ed4 cf373ea0 c02fbff8 c030ba2c
[  290.124389] 3ea0: 00000001 00000000 cfa6202c 00000000 cf373ed4 cf3b6000 cfa6211c 00000000
[  290.124420] 3ec0: cf373f14 cfa6202c cf373efc cf373ed8 c02fce8c c02fbef4 00000000 cfa62400
[  290.124481] 3ee0: cfa62004 cf372000 cfa62400 cfa62000 cf373f44 cf373f00 c03089fc c02fcd88
[  290.124542] 3f00: cf373f54 00000000 cfa6223c c312e8d8 00100100 00200200 c02fc47c cfa62400
[  290.124572] 3f20: cfa62004 cf372000 cfa62000 c312e8d8 ce55e218 cfa62000 cf373f8c cf373f48
[  290.124633] 3f40: c0308e5c c0308998 00000000 c312e8d8 cf373f74 cf373f60 c01ab760 c01af878
[  290.124664] 3f60: c312e8d8 cfa62004 00000000 cf372000 00000001 cf3a8ae8 ce55e218 cfa6200c
[  290.124725] 3f80: cf373fbc cf373f90 c03095f8 c0308cd0 00000000 cf835cb0 cfa62004 c030959c
[  290.124755] 3fa0: 00000013 00000000 00000000 00000000 cf373ff4 cf373fc0 c0055a30 c03095a8
[  290.124786] 3fc0: cf835cb0 00000000 cfa62004 00000000 cf373fd0 cf373fd0 00000000 cf835cb0
[  290.124847] 3fe0: c00559a0 c004018c 00000000 cf373ff8 c004018c c00559ac f52322cc f291067e
[  290.124877] Backtrace:
[  290.124938] [<c030ba20>] (omap_hsmmc_request+0x0/0x4d8) from [<c02fbff8>] (mmc_start_request+0x110/0x20c)
[  290.125000] [<c02fbee8>] (mmc_start_request+0x0/0x20c) from [<c02fce8c>] (mmc_start_req+0x110/0x160)
[  290.125030]  r8:cfa6202c r7:cf373f14 r6:00000000 r5:cfa6211c r4:cf3b6000
[  290.125091] [<c02fcd7c>] (mmc_start_req+0x0/0x160) from [<c03089fc>] (mmc_blk_issue_rw_rq+0x70/0x338)
[  290.125122]  r8:cfa62000 r7:cfa62400 r6:cf372000 r5:cfa62004 r4:cfa62400
[  290.125183] r3:00000000
[  290.125213] [<c030898c>] (mmc_blk_issue_rw_rq+0x0/0x338) from [<c0308e5c>] (mmc_blk_issue_rq+0x198/0x460)
[  290.125274] [<c0308cc4>] (mmc_blk_issue_rq+0x0/0x460) from [<c03095f8>] (mmc_queue_thread+0x5c/0xf0)
[  290.125335] [<c030959c>] (mmc_queue_thread+0x0/0xf0) from [<c0055a30>] (kthread+0x90/0x94)
[  290.125396] [<c00559a0>] (kthread+0x0/0x94) from [<c004018c>] (do_exit+0x0/0x67c)
[  290.125427]  r6:c004018c r5:c00559a0 r4:cf835cb0
[  290.125457] Code: e5933008 e1833801 e5823104 e5943034 (e593212c)
[  290.125488] ---[ end trace 82f48b7910402960 ]---
[  290.329986] PM: early resume of devices complete after 207.732 msecs
[  290.465484] CPSW phy found : id is : 0x4dd074
[  290.467193] PHY 0:01 not found
[  290.469512] PM: resume of devices complete after 139.156 msecs
[  290.921264] Successfully transitioned all domains to low power state
[  290.928375] PM: Finishing wakeup.
[  290.932250] Restarting tasks ... 
[  290.960052] done.
[  293.461608] PHY: 0:00 - Link is Up - 100/Full

Whenever this happens, the file copy doesn't continue after resume.

A snapshot of the blocked tasks gives the following info

root@arago-armv7:/media/mmcblk0p3# echo w > /proc/sysrq-trigger
[  364.364807] SysRq : Show Blocked State
[  364.368743]   task                PC stack   pid father
[  364.374206] kworker/u:0     D c0411548     0     5      2 0x00000000
[  364.380859] Backtrace:
[  364.383422] [<c0411388>] (__schedule+0x0/0x394) from [<c0411810>] (schedule+0x50/0x68)
[  364.391693] [<c04117c0>] (schedule+0x0/0x68) from [<c02fc604>] (__mmc_claim_host+0x138/0x144)
[  364.400604] [<c02fc4cc>] (__mmc_claim_host+0x0/0x144) from [<c030184c>] (mmc_sd_detect+0x28/0x80)
[  364.409881] [<c0301824>] (mmc_sd_detect+0x0/0x80) from [<c02fdff0>] (mmc_rescan+0x120/0x250)
[  364.418670]  r5:cf8d2e00 r4:cf3b6000
[  364.422424] [<c02fded0>] (mmc_rescan+0x0/0x250) from [<c004fba0>] (process_one_work+0x124/0x384)
[  364.431579]  r6:cf834000 r5:cf8d2e00 r4:cf817f00 r3:60000013
[  364.437500] [<c004fa7c>] (process_one_work+0x0/0x384) from [<c0051a18>] (worker_thread+0x15c/0x330)
[  364.446960] [<c00518bc>] (worker_thread+0x0/0x330) from [<c0055a30>] (kthread+0x90/0x94)
[  364.455413] [<c00559a0>] (kthread+0x0/0x94) from [<c004018c>] (do_exit+0x0/0x67c)
[  364.463226]  r6:c004018c r5:c00559a0 r4:cf81dee0
[  364.468078] kjournald       D c0411548     0  1747      2 0x00000000
[  364.474700] Backtrace:
[  364.477264] [<c0411388>] (__schedule+0x0/0x394) from [<c0411810>] (schedule+0x50/0x68)
[  364.485534] [<c04117c0>] (schedule+0x0/0x68) from [<c0411890>] (io_schedule+0x68/0x90)
[  364.493804] [<c0411828>] (io_schedule+0x0/0x90) from [<c01aabc4>] (get_request_wait+0xcc/0x170)
[  364.502868]  r6:cf3a8ae8 r5:cfb53d9c r4:cfb53da8 r3:cede3c00
[  364.508789] [<c01aaaf8>] (get_request_wait+0x0/0x170) from [<c01abde8>] (blk_queue_bio+0x4c/0x298)
[  364.518157] [<c01abd9c>] (blk_queue_bio+0x0/0x298) from [<c01a9c64>] (generic_make_request+0xb4/0xd4)
[  364.527770] [<c01a9bb0>] (generic_make_request+0x0/0xd4) from [<c01a9d08>] (submit_bio+0x84/0xf8)
[  364.537017]  r6:00000211 r5:00000008 r4:c3538240
[  364.541870] [<c01a9c84>] (submit_bio+0x0/0xf8) from [<c00cd198>] (submit_bh+0x13c/0x16c)
[  364.550323] [<c00cd05c>] (submit_bh+0x0/0x16c) from [<c011ecb0>] (journal_do_submit_data.clone.23+0x3c/0x48)
[  364.560577]  r7:00000200 r6:c00d0c68 r5:cee2ee80 r4:000001a0
[  364.566497] [<c011ec74>] (journal_do_submit_data.clone.23+0x0/0x48) from [<c011fab0>] (journal_commit_transaction+0xdf4/0xf1c)
[  364.578369]  r7:c600cec0 r6:00000200 r5:c600ce88 r4:cec053c0
[  364.584289] [<c011ecbc>] (journal_commit_transaction+0x0/0xf1c) from [<c0121e54>] (kjournald+0xc4/0x1d8)
[  364.594207] [<c0121d90>] (kjournald+0x0/0x1d8) from [<c0055a30>] (kthread+0x90/0x94)
[  364.602264] [<c00559a0>] (kthread+0x0/0x94) from [<c004018c>] (do_exit+0x0/0x67c)
[  364.610076]  r6:c004018c r5:c00559a0 r4:cedfbcd8
[  364.614929] cp              D c0411548     0  1915   1877 0x00000000
[  364.621551] Backtrace:
[  364.624114] [<c0411388>] (__schedule+0x0/0x394) from [<c0411810>] (schedule+0x50/0x68)
[  364.632354] [<c04117c0>] (schedule+0x0/0x68) from [<c0411890>] (io_schedule+0x68/0x90)
[  364.640625] [<c0411828>] (io_schedule+0x0/0x90) from [<c01aabc4>] (get_request_wait+0xcc/0x170)
[  364.649719]  r6:cf3a8ae8 r5:c17aba84 r4:c17aba90 r3:cede2600
[  364.655639] [<c01aaaf8>] (get_request_wait+0x0/0x170) from [<c01abde8>] (blk_queue_bio+0x4c/0x298)
[  364.664978] [<c01abd9c>] (blk_queue_bio+0x0/0x298) from [<c01a9c64>] (generic_make_request+0xb4/0xd4)
[  364.674591] [<c01a9bb0>] (generic_make_request+0x0/0xd4) from [<c01a9d08>] (submit_bio+0x84/0xf8)
[  364.683868]  r6:00000001 r5:00000080 r4:cfac3a40
[  364.688690] [<c01a9c84>] (submit_bio+0x0/0xf8) from [<c00d9870>] (do_mpage_readpage+0x468/0x774)
[  364.697845] [<c00d9408>] (do_mpage_readpage+0x0/0x774) from [<c00d9cec>] (mpage_readpages+0xec/0x148)
[  364.707489] [<c00d9c00>] (mpage_readpages+0x0/0x148) from [<c01060a0>] (ext3_readpages+0x24/0x28)
[  364.716766] [<c010607c>] (ext3_readpages+0x0/0x28) from [<c0083448>] (__do_page_cache_readahead+0x198/0x27c)
[  364.727020] [<c00832b0>] (__do_page_cache_readahead+0x0/0x27c) from [<c00837f8>] (ra_submit+0x28/0x30)
[  364.736724] [<c00837d0>] (ra_submit+0x0/0x30) from [<c0083908>] (ondemand_readahead+0x108/0x1e8)
[  364.745910] [<c0083800>] (ondemand_readahead+0x0/0x1e8) from [<c0083ae0>] (page_cache_sync_readahead+0x4c/0x68)
[  364.756439] [<c0083a94>] (page_cache_sync_readahead+0x0/0x68) from [<c007be18>] (generic_file_aio_read+0x42c/0x770)
[  364.767333]  r5:cf576888 r4:00000000
[  364.771057] [<c007b9ec>] (generic_file_aio_read+0x0/0x770) from [<c00a7694>] (do_sync_read+0xac/0xec)
[  364.780700] [<c00a75e8>] (do_sync_read+0x0/0xec) from [<c00a7e20>] (vfs_read+0xb8/0x14c)
[  364.789123]  r8:00001000 r7:c17abf70 r6:bea1da58 r5:00001000 r4:ced3a740
[  364.796142] [<c00a7d68>] (vfs_read+0x0/0x14c) from [<c00a7ef8>] (sys_read+0x44/0x74)
[  364.804229]  r8:00001000 r7:bea1da58 r6:ced3a740 r5:00000000 r4:09adc000
[  364.811248] [<c00a7eb4>] (sys_read+0x0/0x74) from [<c0014200>] (ret_fast_syscall+0x0/0x30)
[  364.819854]  r8:c00143a8 r7:00000003 r6:bea1da58 r5:00000003 r4:00001000

Debugging a bit further I found that runtime resume of hsmmc does not take place in the
failed iterations. Since this doesn't happen in every iteration I would hazard a guess
that there's some sort of race condition between the MMC core resuming and the 
pm_runtime_get_sync() call.

Any pointers on what could be going wrong here and how to debug this further.

Regards,
Vaibhav
