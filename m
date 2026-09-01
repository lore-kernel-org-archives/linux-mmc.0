Received: from mail-oi2-f4.google.com (mail-oi2-f4.google.com [74.125.231.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310BD476CF5
	for <linux-mmc@vger.kernel.org>; Tue,  1 Sep 2026 09:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788253720; cv=none; b=iM9vTMja50vw577aqV4DjlH6PH6ziKNKCuTHJIZe0O4xsMCpmvpOs8gDDVF0uJTcsHTeJ9WSIWfFGZSj1klwgpYIm4qzWF2NJFG49QyTbOJrhquyPzQ1r1HrB9TXeliyMPANhnXlh3BW6kBMurdloNDKtUDtqkzem4IeFehSNdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788253720; c=relaxed/simple;
	bh=ziV6zZDIVwlemG2i9XVT7SSlBQP8GSHoNQO1U8EYE5g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=k4gIMUbnv3L7KhGupjAuJFelgIsCtupLDSDxTbjhXj0yKvE63v0Skm+YylEdK5YldpN15rHxlCgNTi4Najc4kcX2YJBdENIsBgzSrJ5R1Ah05iaNd4DWSF0veOTkeKmIKpG9aYIsf4vjCPMPqzGTWDaPtpClwpeW9q4DJGEkYQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f4.google.com with SMTP id 5614622812f47-4b388697b03so446788b6e.0
        for <linux-mmc@vger.kernel.org>; Tue, 01 Sep 2026 02:08:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788253715; x=1788858515;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UTsqTVxmZyzoBZYaOw1oAyhSxxGK3l/uI0RdubcdI+Q=;
        b=iN7S+Y20pUMcbwoLV16DsWy+0niyXjVWdzIRw8KYwoHjHlVHDqqLJlvcqrWc6CpgRL
         vH4VwlJXJwF1spKkBs7ShBY/iv4Na/WjwXHUKOpxdPPUJZk8Xy8/5jHZpNQlzfjenEZg
         OLIcb+wAEU5416ViI1Uf0yt0RO8dycc43BySqowbcp8Ey3UpR5Rpt3gaD46SGhGMgoie
         rD+LV3HVVwRkGnwnNQx0aMgg4LZcheZxys2a+yoktuKkV88CpVXpDc2PLBueFOgPYK4K
         OZkt5AQGMmqfwYTwsB01P3M5BUrVq6ycRkLxtwwZe+OkZBFoHlCWj8mbKc016zjk7NWu
         7cYw==
X-Forwarded-Encrypted: i=1; AHgh+RrKTIENNgB4A6p788vnYv4+MqKI1knr9Hc8vatNNrQ+Slrr6UiGVw3G0BsjQD2ShzLdfzlxXWhHhSg=@vger.kernel.org
X-Gm-Message-State: AFuF++n1YEAPPHhWC1y1mE5e1Qw70fEVgM8e54hUv+ukX3Uyq3Yc7hr7
	QXyL6ZxA4d0RToSPRf+7PJxp9OALKwGR3CMrpF9LLpjiuMFIGaDmbGog0R7wHKOuSrHzJq1tL1q
	EXJP/FDRf6rVGoLLVa6fMjxSwvRNUXRQpDD9L4mFN5UUww4LGVXS+hPrH2mo=
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:178e:b0:4b2:b653:87ff with SMTP id
 5614622812f47-4b39803b2ffmr38342393b6e.7.1788253715199; Tue, 01 Sep 2026
 02:08:35 -0700 (PDT)
Date: Tue, 01 Sep 2026 02:08:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a969613.a8e469d2.cbf3.5624.GAE@google.com>
Subject: [syzbot] [kernel?] INFO: task hung in mmc_go_idle
From: syzbot <syzbot+bb55e8118af00556efa2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, ulfh@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cf72cbb39da8 Merge tag 'io_uring-7.3-20260828' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1235cc15580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e4e3a0e188a497e
dashboard link: https://syzkaller.appspot.com/bug?extid=bb55e8118af00556efa2
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/76d43caf1866/disk-cf72cbb3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1821781c5c85/vmlinux-cf72cbb3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/31abf6144cf2/bzImage-cf72cbb3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bb55e8118af00556efa2@syzkaller.appspotmail.com

INFO: task kworker/1:6:5756 blocked for more than 143 seconds.
      Tainted: G             L      syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:6     state:D stack:20984 pid:5756  tgid:5756  ppid:2      task_flags:0x4208160 flags:0x00080000
Workqueue: events_freezable mmc_rescan
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5520 [inline]
 __schedule+0x17d4/0x5820 kernel/sched/core.c:7270
 __schedule_loop kernel/sched/core.c:7347 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7362
 schedule_timeout+0xc0/0x2c0 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:100 [inline]
 __wait_for_common kernel/sched/completion.c:121 [inline]
 wait_for_common kernel/sched/completion.c:132 [inline]
 wait_for_completion+0x2ca/0x5e0 kernel/sched/completion.c:153
 mmc_wait_for_req_done+0x37/0x490 drivers/mmc/core/core.c:408
 mmc_wait_for_cmd+0x183/0x2a0 drivers/mmc/core/core.c:645
 __mmc_go_idle drivers/mmc/core/mmc_ops.c:156 [inline]
 mmc_go_idle+0x12c/0x2a0 drivers/mmc/core/mmc_ops.c:180
 mmc_rescan_try_freq drivers/mmc/core/core.c:2123 [inline]
 mmc_rescan+0x6fe/0x1040 drivers/mmc/core/core.c:2316
 process_one_work kernel/workqueue.c:3387 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3470
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3551
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task kworker/1:4:14234 blocked for more than 143 seconds.
      Tainted: G             L      syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:4     state:D stack:22528 pid:14234 tgid:14234 ppid:2      task_flags:0x4288060 flags:0x00080000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5520 [inline]
 __schedule+0x17d4/0x5820 kernel/sched/core.c:7270
 __schedule_loop kernel/sched/core.c:7347 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7362
 schedule_timeout+0xc0/0x2c0 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:100 [inline]
 __wait_for_common kernel/sched/completion.c:121 [inline]
 wait_for_common kernel/sched/completion.c:132 [inline]
 wait_for_completion+0x2ca/0x5e0 kernel/sched/completion.c:153
 __flush_work+0xa63/0xca0 kernel/workqueue.c:4439
 __cancel_work_sync+0xbf/0x110 kernel/workqueue.c:4559
 __mmc_stop_host drivers/mmc/core/core.c:2368 [inline]
 mmc_stop_host+0xd9/0x460 drivers/mmc/core/core.c:2373
 mmc_remove_host+0x15/0x60 drivers/mmc/core/host.c:681
 vub300_disconnect+0x154/0x2f0 drivers/mmc/host/vub300.c:2387
 usb_unbind_interface+0x295/0x9f0 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:618 [inline]
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x4f5/0x880 drivers/base/dd.c:1372
 bus_remove_device+0x444/0x560 drivers/base/bus.c:664
 device_del+0x524/0x8f0 drivers/base/core.c:3965
 usb_disable_device+0x3d4/0x8d0 drivers/usb/core/message.c:1478
 usb_disconnect+0x346/0x9a0 drivers/usb/core/hub.c:2350
 hub_port_connect drivers/usb/core/hub.c:5420 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5720 [inline]
 port_event drivers/usb/core/hub.c:5884 [inline]
 hub_event+0x1bbb/0x4d30 drivers/usb/core/hub.c:5966
 process_one_work kernel/workqueue.c:3387 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3470
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3551
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Showing all locks held in the system:
locks held by pr/ttyS0/16: 2, last CPU#1:
 #0: ffffffff8ec362b8 (console_srcu){....}-{0:0}, at: rcu_try_lock_acquire include/linux/rcupdate.h:314 [inline]
 #0: ffffffff8ec362b8 (console_srcu){....}-{0:0}, at: srcu_read_lock_nmisafe include/linux/srcu.h:439 [inline]
 #0: ffffffff8ec362b8 (console_srcu){....}-{0:0}, at: console_srcu_read_lock+0x30/0x60 kernel/printk/printk.c:291
 #1: ffffffff9ad2f098 (&port_lock_key){-.-.}-{3:3}, at: __uart_port_lock_irqsave include/linux/serial_core.h:613 [inline]
 #1: ffffffff9ad2f098 (&port_lock_key){-.-.}-{3:3}, at: univ8250_console_device_lock+0x67/0xc0 drivers/tty/serial/8250/8250_core.c:413
locks held by khungtaskd/32: 1, last CPU#0:
 #0: ffffffff8ed5c6e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffffffff8ed5c6e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8ed5c6e0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6837
locks held by kworker/u8:6/142: 3, last CPU#1:
 #0: ffff88801b0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff88801b0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff88801b0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3352 [inline]
 #0: ffff88801b0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3470
 #1: ffffc90002de7c40 ((work_completion)(&(&nsim_dev->trap_data->trap_report_dw)->work)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc90002de7c40 ((work_completion)(&(&nsim_dev->trap_data->trap_report_dw)->work)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc90002de7c40 ((work_completion)(&(&nsim_dev->trap_data->trap_report_dw)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3352 [inline]
 #1: ffffc90002de7c40 ((work_completion)(&(&nsim_dev->trap_data->trap_report_dw)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3470
 #2: ffff888052a47258 (&devlink->lock_key#14){+.+.}-{4:4}, at: nsim_dev_trap_report_work+0x57/0xb40 drivers/net/netdevsim/dev.c:834
locks held by udevd/4986: 4, last CPU#0:
 #0: ffffffff8ee35b90 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mm kernel/fork.c:1542 [inline]
 #0: ffffffff8ee35b90 (dup_mmap_sem){.+.+}-{0:0}, at: copy_mm+0x10f/0x480 kernel/fork.c:1595
 #1: ffff8880212cb6b8 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock_killable include/linux/mmap_lock.h:562 [inline]
 #1: ffff8880212cb6b8 (&mm->mmap_lock){++++}-{4:4}, at: dup_mmap+0x195/0x1dc0 mm/mmap.c:1716
 #2: ffff888028481078 (&mm->mmap_lock/1){+.+.}-{4:4}, at: mmap_write_lock_nested include/linux/mmap_lock.h:552 [inline]
 #2: ffff888028481078 (&mm->mmap_lock/1){+.+.}-{4:4}, at: dup_mmap+0x221/0x1dc0 mm/mmap.c:1723
 #3: ffffffff8ed5c6e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #3: ffffffff8ed5c6e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #3: ffffffff8ed5c6e0 (rcu_read_lock){....}-{1:3}, at: __pte_offset_map+0x29/0x240 mm/pgtable-generic.c:290
locks held by getty/5376: 2, on CPU#1:
 #0: ffff8880339940a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000322b2e8 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x45a/0x1360 drivers/tty/n_tty.c:2211
locks held by kworker/1:6/5756: 2, on CPU#1:
 #0: ffff88801b06a140 ((wq_completion)events_freezable){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff88801b06a140 ((wq_completion)events_freezable){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff88801b06a140 ((wq_completion)events_freezable){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3352 [inline]
 #0: ffff88801b06a140 ((wq_completion)events_freezable){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3470
 #1: ffffc9000487fc40 ((work_completion)(&(&host->detect)->work)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc9000487fc40 ((work_completion)(&(&host->detect)->work)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc9000487fc40 ((work_completion)(&(&host->detect)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3352 [inline]
 #1: ffffc9000487fc40 ((work_completion)(&(&host->detect)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3470
locks held by kworker/1:4/14234: 5, on CPU#1:
 #0: ffff8880202d1540 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff8880202d1540 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff8880202d1540 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3352 [inline]
 #0: ffff8880202d1540 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3470
 #1: ffffc90003327c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc90003327c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc90003327c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3352 [inline]
 #1: ffffc90003327c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3470
 #2: ffff8880295bf1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #2: ffff8880295bf1d8 (&dev->mutex){....}-{4:4}, at: hub_event+0x184/0x4d30 drivers/usb/core/hub.c:5912
 #3: ffff8880797a71d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #3: ffff8880797a71d8 (&dev->mutex){....}-{4:4}, at: usb_disconnect+0xfc/0x9a0 drivers/usb/core/hub.c:2341
 #4: ffff88807c93d1a0 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #4: ffff88807c93d1a0 (&dev->mutex){....}-{4:4}, at: __device_driver_lock drivers/base/dd.c:1171 [inline]
 #4: ffff88807c93d1a0 (&dev->mutex){....}-{4:4}, at: device_release_driver_internal+0xb9/0x880 drivers/base/dd.c:1369
locks held by syz-executor/14286: 3, last CPU#0:
 #0: ffff888032188ce0 (&xt[i].mutex){+.+.}-{4:4}, at: xt_find_table_lock+0x55/0x400 net/netfilter/x_tables.c:1336
 #1: ffffffff8ee8f900 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:316 [inline]
 #1: ffffffff8ee8f900 (fs_reclaim){+.+.}-{0:0}, at: prepare_alloc_pages+0x149/0x600 mm/page_alloc.c:5113
 #2: ffffffff8eea5560 (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at: fs_reclaim_acquire+0x7c/0x100 mm/page_alloc.c:4392
locks held by kworker/1:18/18251: 2, on CPU#1:
 #0: ffff88801b06b140 ((wq_completion)events){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff88801b06b140 ((wq_completion)events){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff88801b06b140 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3352 [inline]
 #0: ffff88801b06b140 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3470
 #1: ffffc90003997c40 ((work_completion)(&m->mpeg_thread)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc90003997c40 ((work_completion)(&m->mpeg_thread)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc90003997c40 ((work_completion)(&m->mpeg_thread)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3352 [inline]
 #1: ffffc90003997c40 ((work_completion)(&m->mpeg_thread)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3470
locks held by syz.0.3395/20127: 2, last CPU#0:
 #0: ffff88801b091078 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock include/linux/mmap_lock.h:600 [inline]
 #0: ffff88801b091078 (&mm->mmap_lock){++++}-{4:4}, at: exit_mmap+0x1a4/0x9f0 mm/mmap.c:1299
 #1: ffffffff8ed5c6e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffffff8ed5c6e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffffff8ed5c6e0 (rcu_read_lock){....}-{1:3}, at: __pte_offset_map+0x29/0x240 mm/pgtable-generic.c:290
locks held by udevd/20130: 1, on CPU#0:
 #0: ffff88801c2d4980 (&root->kernfs_rwsem){++++}-{4:4}, at: kernfs_dop_revalidate+0x9e/0x650 fs/kernfs/dir.c:1217
locks held by syz.5.3396/20134: 1, last CPU#1:
 #0: ffff88802527a0a0 (&ctx->uring_lock){+.+.}-{4:4}, at: tctx_task_work_run+0x2d3/0xa80 io_uring/tw.c:92
locks held by syz.4.3397/20144: 2, last CPU#1:
 #0: ffff88807a4f7678 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock include/linux/mmap_lock.h:544 [inline]
 #0: ffff88807a4f7678 (&mm->mmap_lock){++++}-{4:4}, at: exit_mmap+0x2d8/0x9f0 mm/mmap.c:1323
 #1: ffffffff8ed5c6e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffffff8ed5c6e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffffff8ed5c6e0 (rcu_read_lock){....}-{1:3}, at: class_rcu_constructor include/linux/rcupdate.h:1216 [inline]
 #1: ffffffff8ed5c6e0 (rcu_read_lock){....}-{1:3}, at: unwind_next_frame+0x8f/0x2550 arch/x86/kernel/unwind_orc.c:495
locks held by syz.2.3398/20146: 2, last CPU#0:
 #0: ffffffff90250c40 (rtnl_mutex){+.+.}-{4:4}, at: __tun_chr_ioctl+0x3da/0x1e70 drivers/net/tun.c:3229
 #1: ffff88801c2d4980 (&root->kernfs_rwsem){++++}-{4:4}, at: kernfs_add_one+0x41/0x6f0 fs/kernfs/dir.c:825
locks held by udevd/20147: 1, last CPU#0:
 #0: ffffffff8ed5c6e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffffffff8ed5c6e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8ed5c6e0 (rcu_read_lock){....}-{1:3}, at: class_rcu_constructor include/linux/rcupdate.h:1216 [inline]
 #0: ffffffff8ed5c6e0 (rcu_read_lock){....}-{1:3}, at: unwind_next_frame+0x8f/0x2550 arch/x86/kernel/unwind_orc.c:495

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 32 Comm: khungtaskd Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x274/0x2d0 lib/nmi_backtrace.c:123
 nmi_trigger_cpumask_backtrace+0x17d/0x390 lib/nmi_backtrace.c:66
 trigger_all_cpu_backtrace include/linux/nmi.h:164 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x135/0x170 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:353 [inline]
 watchdog+0xfd7/0x1030 kernel/hung_task.c:561
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 16 Comm: pr/ttyS0 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:io_serial_in+0x77/0xc0 drivers/tty/serial/8250/8250_port.c:409
Code: e8 4e e8 55 fc 44 89 f9 d3 e3 49 83 c6 40 4c 89 f0 48 c1 e8 03 42 80 3c 20 00 74 08 4c 89 f7 e8 1f b0 c5 fc 41 03 1e 89 da ec <0f> b6 c0 5b 41 5c 41 5e 41 5f e9 5a cc 74 06 cc 44 89 f9 80 e1 07
RSP: 0018:ffffc900001578b8 EFLAGS: 00000002
RAX: 1ffffffff35a5e00 RBX: 00000000000003fd RCX: 0000000000000000
RDX: 00000000000003fd RSI: 0000000000000000 RDI: 0000000000000020
RBP: dffffc0000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: ffffffff8571cb00 R12: dffffc0000000000
R13: 0000000000000000 R14: ffffffff9ad2f0c0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888124ddc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2f023ffc CR3: 000000005d670000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 serial_in drivers/tty/serial/8250/8250.h:128 [inline]
 serial_lsr_in drivers/tty/serial/8250/8250.h:150 [inline]
 wait_for_lsr+0x184/0x2f0 drivers/tty/serial/8250/8250_port.c:2013
 serial8250_fifo_wait_for_lsr_thre drivers/tty/serial/8250/8250_port.c:3270 [inline]
 __serial8250_console_fifo_write+0x346/0x3e0 drivers/tty/serial/8250/8250_port.c:3372
 serial8250_console_fifo_write drivers/tty/serial/8250/8250_port.c:3378 [inline]
 __serial8250_console_write drivers/tty/serial/8250/8250_port.c:3429 [inline]
 serial8250_console_write+0xaa1/0x1200 drivers/tty/serial/8250/8250_port.c:3493
 nbcon_emit_next_record+0xef5/0x1a90 kernel/printk/nbcon.c:-1
 nbcon_emit_one kernel/printk/nbcon.c:1157 [inline]
 nbcon_kthread_func+0x679/0x880 kernel/printk/nbcon.c:1271
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
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
