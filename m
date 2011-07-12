From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [RFC] Kernel NULL pointer dereference for mmc
Date: Tue, 12 Jul 2011 13:23:37 +0900
Message-ID: <4E1BCC49.6050708@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:55315 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162Ab1GLEXq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jul 2011 00:23:46 -0400
Received: from epcpsbgm1.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LO700G56DJ4D6I0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 12 Jul 2011 13:23:28 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LO700HA5DJ4L6@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 12 Jul 2011 13:23:28 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@linaro.org>, Philip Rakity <prakity@marvell.com>, Kyungmin Park <kyungmin.park@samsung.com>

Hi

When I tested MMC card with IOzone, i found this message..
I tried to find what problem..but i didn't find yet..

So i want to get mailing's help..Have ever seen the below message?
(using SDHCI controller, eMMC 4.41 card, 8-bit buswidth)

I didn't applied about post_req/pre_req in sdhci.c.
(using latest kernel in mmc-tree)

Also i will try to debug for this problem.

Plz let me know what is problem.. 

[  103.605000] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[  103.605000] pgd = c0004000
[  103.605000] [00000000] *pgd=00000000
[  103.605000] Internal error: Oops: 805 [#1] PREEMPT SMP
[  103.605000] last sysfs file: /sys/devices/virtual/vc/vcsa1/dev
[  103.605000] Modules linked in:
[  103.605000] CPU: 0    Not tainted  (2.6.39-rc7-00350-g0510951 #78)
[  103.605000] PC is at wait_for_common+0x8c/0x174
[  103.605000] LR is at wait_for_common+0x64/0x174
[  103.605000] pc : [<c0290104>]    lr : [<c02900dc>]    psr: 40000093
[  103.605000] sp : ed9efee0  ip : 00000000  fp : ed9eff1c
[  103.605000] r10: ed9efef0  r9 : ed928000  r8 : 00000002
[  103.605000] r7 : ed9f9868  r6 : ed9ee000  r5 : 7fffffff  r4 : ed9f9864
[  103.605000] r3 : 00000000  r2 : 00000001  r1 : ed9f987c  r0 : ed9efef8
[  103.605000] Flags: nZcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[  103.605000] Control: 10c5387d  Table: 6dbc004a  DAC: 00000015
[  103.605000] Process mmcqd/0 (pid: 856, stack limit = 0xed9ee2f0)
[  103.605000] Stack: (0xed9efee0 to 0xed9f0000)
[  103.605000] fee0: 00000000 00000001 ed928000 c004a5d0 ed9f987c 00000000 edbb4438 ed9f8800
[  103.605000] ff00: ed9f9958 ed9f9958 ed9eff44 ed9f9800 00000000 edbb4438 edbb4438 c027b060
[  103.605000] ff20: ed9f9800 ed9f9818 ed9f9400 00000000 ed9f9800 c0283614 edb3ee68 00000000
[  103.605000] ff40: ed9f9800 ed9f9818 00000000 edbb4438 ed9f9400 ed9f9818 00000000 ed9f9800
[  103.605000] ff60: 00000000 edbb4438 00000000 c0283af8 ed9f9818 edbb4438 ed9f9818 ed9ee000
[  103.605000] ff80: ed9f9820 edb3eb20 edbb4a20 00000000 edbb4438 c0284558 00000000 ed855d8c
[  103.605000] ffa0: ed9f9818 ed9effc0 c02844b8 00000000 00000000 c006ae6c 00000000 ed9f9818
[  103.605000] ffc0: 00000000 00000000 c002eb20 dead4ead ffffffff ffffffff ed9effd8 ed9effd8
[  103.605000] ffe0: 00000000 ed855d8c c006adec c002eb20 00000013 c002eb20 fcfcfcfc fcfcfcfc
[  103.605000] [<c0290104>] (wait_for_common+0x8c/0x174) from [<c027b060>] (mmc_start_req+0x50/0xec)
[  103.605000] [<c027b060>] (mmc_start_req+0x50/0xec) from [<c0283614>] (mmc_blk_issue_rw_rq+0x68/0x288)
[  103.605000] [<c0283614>] (mmc_blk_issue_rw_rq+0x68/0x288) from [<c0283af8>] (mmc_blk_issue_rq+0x2c4/0x2e4)
[  103.605000] [<c0283af8>] (mmc_blk_issue_rq+0x2c4/0x2e4) from [<c0284558>] (mmc_queue_thread+0xa0/0x110)
[  103.605000] [<c0284558>] (mmc_queue_thread+0xa0/0x110) from [<c006ae6c>] (kthread+0x80/0x88)
[  103.605000] [<c006ae6c>] (kthread+0x80/0x88) from [<c002eb20>] (kernel_thread_exit+0x0/0x8)
[  103.605000] Code: e50b9034 e3822001 e50b2038 e584a01c (e583a000)
[  103.830000] ---[ end trace 06e246d2b7931d3a ]---
[  103.835000] note: mmcqd/0[856] exited with preempt_count 1

Regards,
Jaehoon Chung
