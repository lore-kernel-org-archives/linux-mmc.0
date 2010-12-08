From: Sahitya Tummala <stummala@codeaurora.org>
Subject: Re: [PATCH 1/5] mmc: msm_sdcc: Fix possible circular locking
 dependency warning
Date: Wed, 08 Dec 2010 11:34:44 +0530
Message-ID: <1291788284.21924.32.camel@stummala-linux.in.qualcomm.com>
References: <1291719316-23948-1-git-send-email-stummala@codeaurora.org>
	 <1291745753.8000.3.camel@c-dwalke-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:42688 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687Ab0LHGEy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Dec 2010 01:04:54 -0500
In-Reply-To: <1291745753.8000.3.camel@c-dwalke-linux.qualcomm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Walker <dwalker@codeaurora.org>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, san@google.com, linux-arm-msm@vger.kernel.org

Hi Daniel,

On Tue, 2010-12-07 at 10:15 -0800, Daniel Walker wrote:

> Can you provide and example of the warning ? Not in the commit, but in
> this thread.

This patch fixes the following warning - 

=======================================================
[ INFO: possible circular locking dependency detected ]
2.6.37-rc2-g7559620 #58
-------------------------------------------------------
init/1 is trying to acquire lock:
 (&(&host->lock)->rlock){-.....}, at: [<c019efe8>]
msmsdcc_dma_complete_func+0x20/0x26c

but task is already holding lock:
 (msm_dmov_lock){-.....}, at: [<c002a2b4>] msm_datamover_irq_handler
+0x14/0x594

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (msm_dmov_lock){-.....}:
       [<c0061618>] lock_acquire+0x88/0x9c
       [<c02189cc>] _raw_spin_lock_irqsave+0x48/0x5c
       [<c002a884>] msm_dmov_enqueue_cmd+0x14/0x1ac
       [<c019ee94>] msmsdcc_start_data+0x3a4/0x4d8
       [<c019f584>] msmsdcc_request+0x15c/0x20c
       [<c01960f0>] mmc_wait_for_req+0x148/0x164
       [<c01994b0>] mmc_app_sd_status+0xec/0x10c
       [<c01987c8>] mmc_sd_setup_card+0xc4/0x304
       [<c0198f30>] mmc_sd_init_card+0x130/0x1d4
       [<c01990e4>] mmc_attach_sd+0x110/0x198
       [<c0195f2c>] mmc_rescan+0x298/0x314
       [<c0049c18>] process_one_work+0x254/0x408
       [<c004a1fc>] worker_thread+0x1b8/0x2d8
       [<c004ef0c>] kthread+0x84/0x8c
       [<c0022910>] kernel_thread_exit+0x0/0x8

-> #0 (&(&host->lock)->rlock){-.....}:
       [<c0060e70>] __lock_acquire+0x1118/0x1838
       [<c0061618>] lock_acquire+0x88/0x9c
       [<c02189cc>] _raw_spin_lock_irqsave+0x48/0x5c
       [<c019efe8>] msmsdcc_dma_complete_func+0x20/0x26c
       [<c002a47c>] msm_datamover_irq_handler+0x1dc/0x594
       [<c006b3c8>] handle_IRQ_event+0x24/0xe8
       [<c006d50c>] handle_level_irq+0xc0/0x140
       [<c0021074>] asm_do_IRQ+0x74/0x98
       [<c0021af0>] __irq_svc+0x50/0x98
       [<c0061624>] lock_acquire+0x94/0x9c
       [<c0217ee0>] down_read+0x48/0x5c
       [<c00473e0>] sys_newuname+0x10/0x78
       [<c0021f00>] ret_fast_syscall+0x0/0x3c

other info that might help us debug this:

2 locks held by init/1:
 #0:  (uts_sem){.+.+..}, at: [<c00473e0>] sys_newuname+0x10/0x78
 #1:  (msm_dmov_lock){-.....}, at: [<c002a2b4>]
msm_datamover_irq_handler+0x14/0x594

stack backtrace:
[<c002638c>] (unwind_backtrace+0x0/0xec) from [<c005f834>]
(print_circular_bug+0xc8/0xe0)
[<c005f834>] (print_circular_bug+0xc8/0xe0) from [<c0060e70>]
(__lock_acquire+0x1118/0x1838)
[<c0060e70>] (__lock_acquire+0x1118/0x1838) from [<c0061618>]
(lock_acquire+0x88/0x9c)
[<c0061618>] (lock_acquire+0x88/0x9c) from [<c02189cc>]
(_raw_spin_lock_irqsave+0x48/0x5c)
[<c02189cc>] (_raw_spin_lock_irqsave+0x48/0x5c) from [<c019efe8>]
(msmsdcc_dma_complete_func+0x20/0x26c)
[<c019efe8>] (msmsdcc_dma_complete_func+0x20/0x26c) from [<c002a47c>]
(msm_datamover_irq_handler+0x1dc/0x594)
[<c002a47c>] (msm_datamover_irq_handler+0x1dc/0x594) from [<c006b3c8>]
(handle_IRQ_event+0x24/0xe8)
[<c006b3c8>] (handle_IRQ_event+0x24/0xe8) from [<c006d50c>]
(handle_level_irq+0xc0/0x140)
[<c006d50c>] (handle_level_irq+0xc0/0x140) from [<c0021074>] (asm_do_IRQ
+0x74/0x98)
[<c0021074>] (asm_do_IRQ+0x74/0x98) from [<c0021af0>] (__irq_svc
+0x50/0x98)
Exception stack(0xc7823ef8 to 0xc7823f40)
3ee0:                                                       00000001
000000db
3f00: c08158e0 c7821240 00000000 60000013 c7822000 00000000 00000000
00000001
3f20: 00000000 c02e7360 c7821658 c7823f40 c006157c c0061624 80000013
ffffffff
[<c0021af0>] (__irq_svc+0x50/0x98) from [<c0061624>] (lock_acquire
+0x94/0x9c)
[<c0061624>] (lock_acquire+0x94/0x9c) from [<c0217ee0>] (down_read
+0x48/0x5c)
[<c0217ee0>] (down_read+0x48/0x5c) from [<c00473e0>] (sys_newuname
+0x10/0x78)
[<c00473e0>] (sys_newuname+0x10/0x78) from [<c0021f00>]
(ret_fast_syscall+0x0/0x3c)
mmc0: host does not support reading read-only switch. assuming
write-enable.
mmc0: new high speed SDHC card at address 0007
mmcblk0: mmc0:0007 SD8GB 7.63 GiB
 mmcblk0: p1

Thanks,
Sahitya.
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum.


