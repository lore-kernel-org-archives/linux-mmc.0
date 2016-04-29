From: Tor Krill <tor@openproducts.com>
Subject: Unstable mmc operation on armada38x
Date: Fri, 29 Apr 2016 13:48:51 +0200
Message-ID: <1461930531.2784.21.camel@openproducts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from op-mail.openproducts.com ([54.93.171.173]:54468 "EHLO
	op-mail.openproducts.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753154AbcD2Lza (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Apr 2016 07:55:30 -0400
Received: from opi-build.localdomain (c-6a66e655.125-1-64736c10.cust.bredbandsbolaget.se [85.230.102.106])
	by op-mail.openproducts.com (Postfix) with ESMTPS id 88842201EB
	for <linux-mmc@vger.kernel.org>; Fri, 29 Apr 2016 11:52:42 +0000 (UTC)
Received: from tor-desktop.localdomain (c-5466e655.125-1-64736c10.cust.bredbandsbolaget.se [85.230.102.84])
	by opi-build.localdomain (Postfix) with ESMTPSA id 3CAA1F01
	for <linux-mmc@vger.kernel.org>; Fri, 29 Apr 2016 11:48:52 +0000 (UTC)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>

Hi,

I work on a custom setup using the Solid-run ClearFog Pro that uses the
Marvell 88F6828. I use this with a SOM that is equipped with on board
eMMC.

When using the provided Marvell based kernel fork operation works
nicely.

But when i however try using either stable kernel.org, i.e. 4.5.2, or
the latest mmc-next the system malfunctions on the mmc-operation
resulting in the root-filesystem remount read only and the system
becomes unusable. (I still use the Marvell/Solid-run u-boot to boot the
board)

When doing this i get:

mmcblk0: error -110 sending status command, retrying
mmcblk0: error -110 sending status command, retrying
mmcblk0: error -110 sending status command, aborting

Thus it seems like the mmc doesn't answer the status request?

I have tried debug this further by enable debug on sdhci-pxav3 and
mmc_core. When doing so i unfortunately can't reproduce the problem. I
do log on a slow serial port which might be the reason for affecting
operation since i get a lot of debug messages when doing this.

I get the impression that this _seems_ to happen during writes to the
emmc card.

My question is how to proceed investigating this matter?

I also intercepted the error condition in drivers/mmc/card/block.c end
using BUG() to trigger a backtrace, also available here

http://pastebin.com/jeRZ7zqS

[   41.866257] ------------[ cut here ]------------
[   41.870883] Kernel BUG at c04c4834 [verbose debug info unavailable]
[   41.877163] Internal error: Oops - BUG: 0 [#1] SMP ARM
[   41.882310] Modules linked in: marvell_cesa des_generic
[   41.887580] CPU: 0 PID: 1187 Comm: mmcqd/0 Not tainted 4.6.0-rc4
-00084-gb941a0e-dirty #1
[   41.895687] Hardware name: Marvell Armada 380/385 (Device Tree)
[   41.901619] task: ef20b000 ti: ef2ae000 task.ti: ef2ae000
[   41.907031] PC is at mmc_blk_err_check+0x46c/0x4f8
[   41.911831] LR is at mmc_blk_err_check+0x46c/0x4f8
[   41.916632] pc : [<c04c4834>]    lr : [<c04c4834>]    psr: 60070013
[   41.916632] sp : ef2afde0  ip : 00000007  fp : ee84e034
[   41.928135] r10: ef2afed4  r9 : ee84e260  r8 : eea10b1c
[   41.933370] r7 : 00000000  r6 : ee6e4380  r5 : ee84f000  r4 :
ee84e140
[   41.939910] r3 : 00000006  r2 : 00000007  r1 : 00000000  r0 :
0000000c
[   41.946452] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM 
 Segment none
[   41.953602] Control: 10c5387d  Table: 2ea3004a  DAC: 00000051
[   41.959359] Process mmcqd/0 (pid: 1187, stack limit = 0xef2ae220)
[   41.965464] Stack: (0xef2afde0 to 0xef2b0000)
[   41.969831] fde0: c0a00018 ef7d2200 ef20b000 c0a06300 00000000
ee4a0e00 2ee88000 00000000
[   41.978027] fe00: ef2afe4c c067269c 00000001 ee84e218 c0a07ce4
00000000 ef14d010 eea03000
[   41.986222] fe20: c0672a48 00000000 00000000 ef2ae000 ef2afe64
eea10b10 ee84e140 eea10800
[   41.994418] fe40: ee84e090 eea10b10 ee84e140 eea10b1c ee84e260
ef2afed4 ee84e034 c04b47d0
[   42.002614] fe60: ee84e008 00000000 ef20b000 c0152dfc ef2afe70
ef2afe70 ee6e4110 ee84e154
[   42.010810] fe80: ee6e4c70 ee84e008 ee84f000 ee84e000 ee84e150
00000000 ee6e4c70 c04c21f4
[   42.019006] fea0: 00000000 00000000 ee84e000 00000000 00000000
00000000 ee6e4c70 eeb48ed8
[   42.027203] fec0: eeb48ed8 ee6e4c70 ef3bd600 00000001 ee84e010
24590001 00000000 ee84e008
[   42.035399] fee0: ee84f000 ee6e4c70 00000000 ee84e000 ee84e000
24590001 24590001 c04c2e78
[   42.043594] ff00: 00002b24 eea019b0 ef3beb00 eea10800 00000000
00000001 ee84e010 24590001
[   42.051791] ff20: eea019b0 ee84e008 eea019b0 ef2ae000 00000000
00000001 ee84e010 24590001
[   42.059986] ff40: 00000000 c04c4abc 00000000 ef3bea40 ee84e008
c04c49fc 00000000 00000000
[   42.068182] ff60: 00000000 c0138570 ef3bad38 00000000 00000001
ee84e008 00000000 00000000
[   42.076378] ff80: ef2aff80 ef2aff80 00000000 00000000 ef2aff90
ef2aff90 ef2affac ef3bea40
[   42.084574] ffa0: c0138494 00000000 00000000 c0107778 00000000
00000000 00000000 00000000
[   42.092770] ffc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[   42.100965] ffe0: 00000000 00000000 00000000 00000000 00000013
00000000 ffffffff ffffffff
[   42.109168] [<c04c4834>] (mmc_blk_err_check) from [<c04b47d0>]
(mmc_start_req+0xe0/0x3d4)
[   42.117365] [<c04b47d0>] (mmc_start_req) from [<c04c21f4>]
(mmc_blk_issue_rw_rq+0xa8/0xae4)
[   42.125736] [<c04c21f4>] (mmc_blk_issue_rw_rq) from [<c04c2e78>]
(mmc_blk_issue_rq+0x248/0x4e8)
[   42.134453] [<c04c2e78>] (mmc_blk_issue_rq) from [<c04c4abc>]
(mmc_queue_thread+0xc0/0x188)
[   42.142825] [<c04c4abc>] (mmc_queue_thread) from [<c0138570>]
(kthread+0xdc/0xf4)
[   42.150327] [<c0138570>] (kthread) from [<c0107778>]
(ret_from_fork+0x14/0x3c)
[   42.157566] Code: ebf34b80 e305038c e34c0084 ebf34b7d (e7f001f2) 
[   42.163673] ---[ end trace 9d3b8f108853e09b ]---

Best Regards

/Tor


