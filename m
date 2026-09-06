Received: from mail-oo2-f8.google.com (mail-oo2-f8.google.com [74.125.231.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5470D2F6577
	for <linux-mmc@vger.kernel.org>; Sun,  6 Sep 2026 18:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788717817; cv=none; b=qhm7Ec3iRcfeOBFb1o+8CUWE3t3Qxifzbdcnd0srb2WQ3+aXkHWlDJZ8CaFjIpxlvj9ncNsavuAfl01WU3nX8QIVz5NtBEy4VIDh5U0/NX7dM+IXd3UqCGR+UH8IhPqCR8IaPDVYB3zYg9DAEPlVDL+RGtRsEAvJ9lPGEJuCT6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788717817; c=relaxed/simple;
	bh=4gqD9sv07dzm/6lWtMgltcBYGDg/Yt9/3GApfAIFmpQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MYidvPpj4dIMGaDsjUAqXCCXPppdUGHbIWtE2ht5ZYcgFvIKAhq2qXZkl9Emkh5ksZjGSJLAqhIzi5AwEI7PFzGUmxeKpFIqtbGWj3+NxnFUhWAOlGfnaxP9E4sravw6YIxSQxOYGIFp4qJ+3RLbaDWrN+9dJkJVd06Lu64N0x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo2-f8.google.com with SMTP id 006d021491bc7-6b1bf394d3bso424275eaf.0
        for <linux-mmc@vger.kernel.org>; Sun, 06 Sep 2026 11:03:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788717814; x=1789322614;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dp95l++1UdRwAR4kmpEP87mlCfFuiW6dCRayJfOYNVQ=;
        b=qQYVKdyEB21b5d54AvT4amXPKumo2DTsh4VZ+xryKS+Xg47LUMeYwdTewR1A7g0jfr
         tEIxNZUptRaRVZmqJSJQhmc9Es2CQTdxt+cDOLfA6L8tFXtZ2GkuRvsTRlsJkHeVfauT
         esuTr5qc/JgkylPnqepCrfMCISgmn2pPInn0Pc9qpTbT+4LfGWMeo5oUyCFokPftIdg1
         1rFxnn8asVoAq5Opl1ZoAZEGSzveqMWYBDF2g9aS1kVupWSF+6kk9H4Bv6Mfy0135Y8J
         LPQ43UzfxApozTjqsGxOr0rEJwPs1Mt/kURRo8Is/dIxGsldW/NeDQq7KwxgdPxlDuGJ
         j0IA==
X-Forwarded-Encrypted: i=1; AKwUvByB+Mh1y8RN0RhAY5KZ0MDep91kt9q8jhi56D5vEhN4BguQnJfke6mzv7BVnqeBN/8JI8vsRoOpP/o=@vger.kernel.org
X-Gm-Message-State: AFuF++nr0Nkq1y9rSa+eWaTbA8puJwPrzCSkjWR5uPlSN9Fm7u2LemEr
	oFAGOslXH5gaL9d763wI7YH3denZgOP5XYJ1og0Y1w0G2Els/iho9eKS/FEYeMBUht/HtiwbFmo
	lJmMAJm2NmywXntn0QXaCsHPxQErcJEFlUp5DXGd1epH8FfV64kYIwBbIRLs=
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4dcd:b0:6b1:6636:e919 with SMTP id
 006d021491bc7-6b6fb6d206cmr20280543eaf.11.1788717814180; Sun, 06 Sep 2026
 11:03:34 -0700 (PDT)
Date: Sun, 06 Sep 2026 11:03:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a9daaf6.a5e650b3.26d8a.001f.GAE@google.com>
Subject: [syzbot] [mmc?] INFO: task hung in mmc_io_rw_direct_host
From: syzbot <syzbot+fd993974345f022e97f2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, ulf.hansson@linaro.org, ulfh@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0d9ff90a5422 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16126cf9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5c3949d762a91f
dashboard link: https://syzkaller.appspot.com/bug?extid=fd993974345f022e97f2
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d40c962715ec/disk-0d9ff90a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e76513f6d7e7/vmlinux-0d9ff90a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/40a69dadb7ab/bzImage-0d9ff90a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fd993974345f022e97f2@syzkaller.appspotmail.com

INFO: task kworker/0:1:10 blocked for mor
INFO: task kworker/0:1:10 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:1     state:D stack:23304 pid:10    tgid:10    ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: events_freezable mmc_rescan
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5520 [inline]
 __schedule+0x1259/0x6920 kernel/sched/core.c:7270
 __schedule_loop kernel/sched/core.c:7347 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7362
 schedule_timeout+0x1b2/0x280 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:100 [inline]
 __wait_for_common+0x2e7/0x4c0 kernel/sched/completion.c:121
 mmc_wait_for_req_done+0xcd/0x3d0 drivers/mmc/core/core.c:408
 mmc_wait_for_req+0x207/0x2c0 drivers/mmc/core/core.c:619
 mmc_wait_for_cmd+0x154/0x200 drivers/mmc/core/core.c:645
 mmc_io_rw_direct_host+0x126/0x330 drivers/mmc/core/sdio_ops.c:83
 sdio_reset+0x92/0x240 drivers/mmc/core/sdio_ops.c:209
 mmc_rescan_try_freq drivers/mmc/core/core.c:2121 [inline]
 mmc_rescan+0xba9/0x11c0 drivers/mmc/core/core.c:2316
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
 process_scheduled_works kernel/workqueue.c:3479 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task kworker/0:5:5708 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:5     state:D stack:20216 pid:5708  tgid:5708  ppid:2      task_flags:0x4288060 flags:0x00080000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5520 [inline]
 __schedule+0x1259/0x6920 kernel/sched/core.c:7270
 __schedule_loop kernel/sched/core.c:7347 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7362
 schedule_timeout+0x1b2/0x280 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:100 [inline]
 __wait_for_common+0x2e7/0x4c0 kernel/sched/completion.c:121
 __flush_work+0x7c7/0xcb0 kernel/workqueue.c:4448
 __cancel_work_sync kernel/workqueue.c:4568 [inline]
 cancel_delayed_work_sync+0xd1/0xf0 kernel/workqueue.c:4642
 __mmc_stop_host drivers/mmc/core/core.c:2368 [inline]
 __mmc_stop_host drivers/mmc/core/core.c:2357 [inline]
 mmc_stop_host+0xe9/0x400 drivers/mmc/core/core.c:2373
 mmc_remove_host+0x15/0x60 drivers/mmc/core/host.c:681
 vub300_disconnect+0x12d/0x170 drivers/mmc/host/vub300.c:2387
 usb_unbind_interface+0x1dd/0x9e0 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:618 [inline]
 device_remove+0x12a/0x180 drivers/base/dd.c:610
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x44e/0x620 drivers/base/dd.c:1372
 bus_remove_device+0x2bc/0x560 drivers/base/bus.c:664
 device_del+0x376/0x9b0 drivers/base/core.c:3965
 usb_disable_device+0x367/0x810 drivers/usb/core/message.c:1478
 usb_disconnect+0x2e2/0x9a0 drivers/usb/core/hub.c:2350
 hub_port_connect drivers/usb/core/hub.c:5420 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5720 [inline]
 port_event drivers/usb/core/hub.c:5884 [inline]
 hub_event+0x1bb1/0x4420 drivers/usb/core/hub.c:5966
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
 process_scheduled_works kernel/workqueue.c:3479 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Showing all locks held in the system:
locks held by kworker/0:1/10: 2, on CPU#0:
 #0: ffff88801c05a140 ((wq_completion)events_freezable){+.+.}-{0:0}, at: process_one_work+0x1466/0x1b10 kernel/workqueue.c:3371
 #1: ffffc900000f7d08 ((work_completion)(&(&host->detect)->work)){+.+.}-{0:0}, at: process_one_work+0xa2c/0x1b10 kernel/workqueue.c:3372
locks held by pr/ttyS0/16: 2, last CPU#0:
 #0: ffffffff8edd8338 (console_srcu){....}-{0:0}, at: rcu_try_lock_acquire include/linux/rcupdate.h:314 [inline]
 #0: ffffffff8edd8338 (console_srcu){....}-{0:0}, at: srcu_read_lock_nmisafe include/linux/srcu.h:439 [inline]
 #0: ffffffff8edd8338 (console_srcu){....}-{0:0}, at: console_srcu_read_lock+0x49/0x60 kernel/printk/printk.c:291
 #1: ffffffff9bc65c78 (&port_lock_key){-.-.}-{3:3}, at: __uart_port_lock_irqsave include/linux/serial_core.h:613 [inline]
 #1: ffffffff9bc65c78 (&port_lock_key){-.-.}-{3:3}, at: univ8250_console_device_lock+0x64/0xc0 drivers/tty/serial/8250/8250_core.c:413
locks held by khungtaskd/31: 1, last CPU#1:
 #0: ffffffff8edec060 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffffffff8edec060 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8edec060 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x3d/0x184 kernel/locking/lockdep.c:6837
locks held by getty/5358: 2, on CPU#0:
 #0: ffff8880363a40a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000321e2e8 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x419/0x14e0 drivers/tty/n_tty.c:2211
locks held by syz-executor/5599: 4, last CPU#0:
 #0: ffffffff8ef3cc30 (dup_mmap_sem){++++}-{0:0}, at: dup_mm kernel/fork.c:1542 [inline]
 #0: ffffffff8ef3cc30 (dup_mmap_sem){++++}-{0:0}, at: copy_mm kernel/fork.c:1595 [inline]
 #0: ffffffff8ef3cc30 (dup_mmap_sem){++++}-{0:0}, at: copy_process+0x4806/0x8370 kernel/fork.c:2307
 #1: ffff888032f2c378 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock_killable include/linux/mmap_lock.h:562 [inline]
 #1: ffff888032f2c378 (&mm->mmap_lock){++++}-{4:4}, at: dup_mmap+0x127/0x2370 mm/mmap.c:1716
 #2: ffff88802a209078 (&mm->mmap_lock/1){+.+.}-{4:4}, at: mmap_write_lock_nested include/linux/mmap_lock.h:552 [inline]
 #2: ffff88802a209078 (&mm->mmap_lock/1){+.+.}-{4:4}, at: dup_mmap+0x1c9/0x2370 mm/mmap.c:1723
 #3: ffffffff8edec060 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #3: ffffffff8edec060 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #3: ffffffff8edec060 (rcu_read_lock){....}-{1:3}, at: __pte_offset_map+0x2f/0x310 mm/pgtable-generic.c:290
locks held by syz-executor/5600: 4, last CPU#0:
 #0: ffffffff8ef3cc30 (dup_mmap_sem){++++}-{0:0}, at: dup_mm kernel/fork.c:1542 [inline]
 #0: ffffffff8ef3cc30 (dup_mmap_sem){++++}-{0:0}, at: copy_mm kernel/fork.c:1595 [inline]
 #0: ffffffff8ef3cc30 (dup_mmap_sem){++++}-{0:0}, at: copy_process+0x4806/0x8370 kernel/fork.c:2307
 #1: ffff88802a6669b8 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock_killable include/linux/mmap_lock.h:562 [inline]
 #1: ffff88802a6669b8 (&mm->mmap_lock){++++}-{4:4}, at: dup_mmap+0x127/0x2370 mm/mmap.c:1716
 #2: ffff88801c087678 (&mm->mmap_lock/1){+.+.}-{4:4}, at: mmap_write_lock_nested include/linux/mmap_lock.h:552 [inline]
 #2: ffff88801c087678 (&mm->mmap_lock/1){+.+.}-{4:4}, at: dup_mmap+0x1c9/0x2370 mm/mmap.c:1723
 #3: ffffffff8edec060 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #3: ffffffff8edec060 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #3: ffffffff8edec060 (rcu_read_lock){....}-{1:3}, at: __pte_offset_map+0x2f/0x310 mm/pgtable-generic.c:290
locks held by syz-executor/5602: 1, last CPU#1:
 #0: ffff88807b45c460 (sb_writers#6){.+.+}-{0:0}, at: filename_unlinkat+0x1ad/0x730 fs/namei.c:5696
locks held by kworker/0:5/5708: 5, on CPU#0:
 #0: ffff888023ab7d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x1466/0x1b10 kernel/workqueue.c:3371
 #1: ffffc90002e17d08 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0xa2c/0x1b10 kernel/workqueue.c:3372
 #2: ffff88802a8a41d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #2: ffff88802a8a41d8 (&dev->mutex){....}-{4:4}, at: hub_event+0x1bb/0x4420 drivers/usb/core/hub.c:5912
 #3: ffff88804cae71d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #3: ffff88804cae71d8 (&dev->mutex){....}-{4:4}, at: usb_disconnect+0x10a/0x9a0 drivers/usb/core/hub.c:2341
 #4: ffff888035c291a0 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #4: ffff888035c291a0 (&dev->mutex){....}-{4:4}, at: __device_driver_lock drivers/base/dd.c:1171 [inline]
 #4: ffff888035c291a0 (&dev->mutex){....}-{4:4}, at: device_release_driver_internal+0xb2/0x620 drivers/base/dd.c:1369
locks held by syz.4.1228/9913: 1, last CPU#1:
 #0: ffff88802a5ea460 (sb_writers#6){.+.+}-{0:0}, at: get_signal+0x1f2a/0x21e0 kernel/signal.c:3024
locks held by syz-executor/9984: 5, last CPU#0:
 #0: ffff8880374aa460 (sb_writers#6){.+.+}-{0:0}, at: filename_create+0x10d/0x400 fs/namei.c:5085
 #1: ffff888055acb8d0 (&type->i_mutex_dir_key#5/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1069 [inline]
 #1: ffff888055acb8d0 (&type->i_mutex_dir_key#5/1){+.+.}-{4:4}, at: __start_dirop fs/namei.c:2918 [inline]
 #1: ffff888055acb8d0 (&type->i_mutex_dir_key#5/1){+.+.}-{4:4}, at: start_dirop fs/namei.c:2942 [inline]
 #1: ffff888055acb8d0 (&type->i_mutex_dir_key#5/1){+.+.}-{4:4}, at: filename_create+0x1c0/0x400 fs/namei.c:5092
 #2: ffffffff8edec060 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #2: ffffffff8edec060 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #2: ffffffff8edec060 (rcu_read_lock){....}-{1:3}, at: security_sid_to_context_core+0x21f/0x700 security/selinux/ss/services.c:1402
 #3: ffffffff8edec060 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #3: ffffffff8edec060 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #3: ffffffff8edec060 (rcu_read_lock){....}-{1:3}, at: sidtab_sid2str_get+0x84/0x670 security/selinux/ss/sidtab.c:617
 #4: ffffffff8edec060 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #4: ffffffff8edec060 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #4: ffffffff8edec060 (rcu_read_lock){....}-{1:3}, at: class_rcu_constructor include/linux/rcupdate.h:1216 [inline]
 #4: ffffffff8edec060 (rcu_read_lock){....}-{1:3}, at: unwind_next_frame+0xbd/0x2090 arch/x86/kernel/unwind_orc.c:495

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 31 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 nmi_cpu_backtrace.cold+0x12d/0x151 lib/nmi_backtrace.c:123
 nmi_trigger_cpumask_backtrace+0x21f/0x2a0 lib/nmi_backtrace.c:66
 trigger_all_cpu_backtrace include/linux/nmi.h:164 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x141/0x190 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:353 [inline]
 watchdog+0xcb1/0x1030 kernel/hung_task.c:561
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 16 Comm: pr/ttyS0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
RIP: 0010:delay_tsc+0x32/0xc0 arch/x86/lib/delay.c:77
Code: fd bf 01 00 00 00 41 54 55 53 e8 d9 59 08 f6 e8 04 7e 01 00 41 89 c4 0f 01 f9 66 90 48 c1 e2 20 48 09 c2 48 89 d5 eb 16 f3 90 <bf> 01 00 00 00 e8 b4 59 08 f6 e8 df 7d 01 00 44 39 e0 75 36 0f 01
RSP: 0018:ffffc90000157950 EFLAGS: 00000082
RAX: 8000000000000002 RBX: 000000cbca961e49 RCX: 0000000000000000
RDX: 0000000000000004 RSI: ffffffff8c620f00 RDI: 0000000000000001
RBP: 000000cbca961bc5 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000814 R11: 205d313354202020 R12: 0000000000000000
R13: 0000000000000af1 R14: fffffbfff378cbe9 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888123b5f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f73f732d380 CR3: 000000005ca75000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 udelay include/asm-generic/delay.h:62 [inline]
 wait_for_lsr+0xf3/0x210 drivers/tty/serial/8250/8250_port.c:2019
 serial8250_fifo_wait_for_lsr_thre+0x5f/0xd0 drivers/tty/serial/8250/8250_port.c:3270
 __serial8250_console_fifo_write+0xa5/0x290 drivers/tty/serial/8250/8250_port.c:3345
 serial8250_console_fifo_write drivers/tty/serial/8250/8250_port.c:3378 [inline]
 __serial8250_console_write drivers/tty/serial/8250/8250_port.c:3429 [inline]
 serial8250_console_write+0xf46/0x1330 drivers/tty/serial/8250/8250_port.c:3493
 nbcon_emit_next_record+0x8f7/0xa70 kernel/printk/nbcon.c:1070
 nbcon_emit_one+0x1a8/0x2b0 kernel/printk/nbcon.c:1157
 nbcon_kthread_func+0x613/0x7d0 kernel/printk/nbcon.c:1271
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
