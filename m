Received: from mail-oi2-f11.google.com (mail-oi2-f11.google.com [74.125.231.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811BE370AF3
	for <linux-mmc@vger.kernel.org>; Sun, 20 Sep 2026 03:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789874442; cv=none; b=PDG0Bb/eG1h3Pw+xAthAJ/nFfpXyBhg5jaH90LF4RiW/r6PcWxR7VvW/Iiz669jKz78BR8gmeseGAvOlBZsmdpsVbVpEWi8bK+qTVrglZDx/VEeIGOVL3xlLdiS6RwVgsp3iNIiGbNQTF9TIgFGKO6p3286gDtCH4sdvajdeQWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789874442; c=relaxed/simple;
	bh=C915j3Iu+JufUXBkqezxsxaQnnUecz65DBiXkbcgACo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Iwxy9ZHF5VcNk6DuWWaAvoAK4vmGY3krli6RahLTe+foUrxh2n5DPaCaPThbIqnPB2jg2nqpC85qBfNRgPT7LdZRDWmy9LAXVQwHSq3uFOrYbM7Bb7kWc/ADe1xS1UPTgXvxUO56AWIPjYE/TAQkAiOzSVUVv5CM524mFoUqmJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f11.google.com with SMTP id 5614622812f47-4c6545d0f93so1096114b6e.0
        for <linux-mmc@vger.kernel.org>; Sat, 19 Sep 2026 20:20:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789874439; x=1790479239;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cHMDZzTqVUC/XZjm5NrFYzE/EntiQCbVDWH/2tKCVWg=;
        b=LRMqJRGTG1HXr5QWxIM/z1CvdyPmiCCz1gMx2h8vlxTINJ9pLh6BlDdU0vfSa6CBDE
         JdCTj9G+QtQNtDZqjqaUqcqlMocRdjfBX40TwyDrnyr0JRnuHdf9N/YdgCP5ARR2dEMG
         IXVWXAfxUGCiNu74CUhf1DnP7H3Y5Dxwei6Ayt6GRRafHkL0fOEYOB8eyzyo1rbeuDm4
         Fki2YdIDaxXb0AlJe0cRFV/99WPBEyHina052FXLz0GP/9dkIyQ4N1tWhA9F6BkL4Etx
         ClJdG0gDBw8op+9w0Ou2YAU7vU6RF25jZUw4yyQhd4QzZgPB5i2/MHG2DmRFfS5jIcR2
         F/vg==
X-Forwarded-Encrypted: i=1; AKwUvBzTz8vwfVk/BxNlhHg2V2AOcExM7O7VhZAtafALluriQbIRJ+Fq7G+Iz263qv/GPYtRflyoCz0iru8=@vger.kernel.org
X-Gm-Message-State: AFuF++mVmvXCUviMa37yDEC4K2Mv5INT6Ku2Ppgahclheka/0marjp7U
	AVhCTOSqacre78JHqcWwFdqt29WDFVRg5ifk1j06Bnwv5SDpZPsPLqwZfwsc5yh53/5RMfQ6P2F
	lvR6swuceiEaxRVrviTWHg0KeZ4Yv/iT+O9DAMpCEH8LohFnKq9MJhxLuLxE=
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:17a0:b0:4c4:aaaf:fdfa with SMTP id
 5614622812f47-4ccf6e7682cmr8965378b6e.18.1789874439442; Sat, 19 Sep 2026
 20:20:39 -0700 (PDT)
Date: Sat, 19 Sep 2026 20:20:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aaf5107.a6af0033.177e91.000a.GAE@google.com>
Subject: [syzbot] [mmc?] INFO: task hung in mmc_send_io_op_cond
From: syzbot <syzbot+15adedb55f72fa957b00@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, ulf.hansson@linaro.org, ulfh@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    28924df2a08f Merge tag 'perf-tools-fixes-for-v7.3-2026-09-..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16991af9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e4e3a0e188a497e
dashboard link: https://syzkaller.appspot.com/bug?extid=15adedb55f72fa957b00
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dbb658780e3f/disk-28924df2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ed954d86e83d/vmlinux-28924df2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/56cc5fdb5ce4/bzImage-28924df2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+15adedb55f72fa957b00@syzkaller.appspotmail.com

INFO: task kworker/0:1:10 blocked for more than 143 seconds.
      Tainted: G             L      syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:1     state:D stack:20768 pid:10    tgid:10    ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: events_freezable mmc_rescan
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5526 [inline]
 __schedule+0x17db/0x58f0 kernel/sched/core.c:7276
 __schedule_loop kernel/sched/core.c:7353 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7368
 schedule_timeout+0xc0/0x2c0 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:100 [inline]
 __wait_for_common kernel/sched/completion.c:121 [inline]
 wait_for_common kernel/sched/completion.c:132 [inline]
 wait_for_completion+0x2ca/0x5e0 kernel/sched/completion.c:153
 mmc_wait_for_req_done+0x37/0x490 drivers/mmc/core/core.c:408
 mmc_wait_for_cmd+0x183/0x2a0 drivers/mmc/core/core.c:645
 mmc_send_io_op_cond+0xfd/0x300 drivers/mmc/core/sdio_ops.c:28
 mmc_attach_sdio+0xdb/0xc10 drivers/mmc/core/sdio.c:1220
 mmc_rescan_try_freq drivers/mmc/core/core.c:2134 [inline]
 mmc_rescan+0x7e9/0x1040 drivers/mmc/core/core.c:2316
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3479
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3560
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task kworker/1:7:5689 blocked for more than 143 seconds.
      Tainted: G             L      syzkaller #0
"echo 0 >
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:7     state:D stack:23400 pid:5689  tgid:5689  ppid:2      task_flags:0x4288060 flags:0x00080000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5526 [inline]
 __schedule+0x17db/0x58f0 kernel/sched/core.c:7276
 __schedule_loop kernel/sched/core.c:7353 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7368
 schedule_timeout+0xc0/0x2c0 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:100 [inline]
 __wait_for_common kernel/sched/completion.c:121 [inline]
 wait_for_common kernel/sched/completion.c:132 [inline]
 wait_for_completion+0x2ca/0x5e0 kernel/sched/completion.c:153
 __flush_work+0xa63/0xca0 kernel/workqueue.c:4448
 __cancel_work_sync+0xbf/0x110 kernel/workqueue.c:4568
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
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3479
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3560
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Showing all locks held in the system:
locks held by kworker/0:1/10: 2, on CPU#0:
 #0: ffff88801b06a140 ((wq_completion)events_freezable){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff88801b06a140 ((wq_completion)events_freezable){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff88801b06a140 ((wq_completion)events_freezable){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff88801b06a140 ((wq_completion)events_freezable){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc900000f7c40 ((work_completion)(&(&host->detect)->work)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc900000f7c40 ((work_completion)(&(&host->detect)->work)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc900000f7c40 ((work_completion)(&(&host->detect)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #1: ffffc900000f7c40 ((work_completion)(&(&host->detect)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
locks held by pr/ttyS0/16: 2, last CPU#0:
 #0: ffffffff8ec36338 (console_srcu){....}-{0:0}, at: rcu_try_lock_acquire include/linux/rcupdate.h:314 [inline]
 #0: ffffffff8ec36338 (console_srcu){....}-{0:0}, at: srcu_read_lock_nmisafe include/linux/srcu.h:439 [inline]
 #0: ffffffff8ec36338 (console_srcu){....}-{0:0}, at: console_srcu_read_lock+0x30/0x60 kernel/printk/printk.c:291
 #1: ffffffff9ad35098 (&port_lock_key){-.-.}-{3:3}, at: __uart_port_lock_irqsave include/linux/serial_core.h:613 [inline]
 #1: ffffffff9ad35098 (&port_lock_key){-.-.}-{3:3}, at: univ8250_console_device_lock+0x67/0xc0 drivers/tty/serial/8250/8250_core.c:413
locks held by khungtaskd/33: 1, last CPU#1:
 #0: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6871
locks held by udevd/4984: 1, on CPU#1:
 #0: ffff88801c2d4a10 (&root->kernfs_iattr_rwsem){++++}-{4:4}, at: kernfs_iop_getattr+0x9e/0x450 fs/kernfs/inode.c:190
locks held by getty/5375: 2, on CPU#1:
 #0: ffff888035f540a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900032332e8 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x45a/0x1360 drivers/tty/n_tty.c:2211
locks held by udevd/5638: 4, on CPU#1:
 #0: ffff8880358ac878 (&p->lock){+.+.}-{4:4}, at: seq_read_iter+0xa4/0xca0 fs/seq_file.c:183
 #1: ffff88805688cc80 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_seq_start+0x5d/0x420 fs/kernfs/file.c:165
 #2: ffff888074ae7a58 (kn->active#30){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:73 [inline]
 #2: ffff888074ae7a58 (kn->active#30){.+.+}-{0:0}, at: kernfs_seq_start+0xb2/0x420 fs/kernfs/file.c:166
 #3: ffff8880778371d8 (&dev->mutex){....}-{4:4}, at: device_lock_interruptible include/linux/device.h:1109 [inline]
 #3: ffff8880778371d8 (&dev->mutex){....}-{4:4}, at: product_show+0x26/0xa0 drivers/usb/core/sysfs.c:141
locks held by kworker/1:7/5689: 5, on CPU#1:
 #0: ffff8880222ea140 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff8880222ea140 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff8880222ea140 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff8880222ea140 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc9000430fc40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc9000430fc40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc9000430fc40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #1: ffffc9000430fc40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #2: ffff88802a05c1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #2: ffff88802a05c1d8 (&dev->mutex){....}-{4:4}, at: hub_event+0x184/0x4d30 drivers/usb/core/hub.c:5912
 #3: ffff8880490101d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #3: ffff8880490101d8 (&dev->mutex){....}-{4:4}, at: usb_disconnect+0xfc/0x9a0 drivers/usb/core/hub.c:2341
 #4: ffff888032ed51a0 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #4: ffff888032ed51a0 (&dev->mutex){....}-{4:4}, at: __device_driver_lock drivers/base/dd.c:1171 [inline]
 #4: ffff888032ed51a0 (&dev->mutex){....}-{4:4}, at: device_release_driver_internal+0xb9/0x880 drivers/base/dd.c:1369
locks held by kworker/u8:19/5772: 5, last CPU#1:
 #0: ffff88801b0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff88801b0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff88801b0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff88801b0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc90004d27c40 ((work_completion)(&(&kfence_timer)->work)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc90004d27c40 ((work_completion)(&(&kfence_timer)->work)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc90004d27c40 ((work_completion)(&(&kfence_timer)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #1: ffffc90004d27c40 ((work_completion)(&(&kfence_timer)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #2: ffffffff8ebe98f0 (cpu_hotplug_lock){++++}-{0:0}, at: static_key_enable+0x12/0x20 kernel/jump_label.c:222
 #3: ffffffff8ee386e0 (jump_label_mutex){+.+.}-{4:4}, at: jump_label_lock kernel/jump_label.c:27 [inline]
 #3: ffffffff8ee386e0 (jump_label_mutex){+.+.}-{4:4}, at: static_key_enable_cpuslocked+0xcb/0x240 kernel/jump_label.c:207
 #4: ffffffff8ebff620 (text_mutex){+.+.}-{4:4}, at: arch_jump_label_transform_apply+0x17/0x30 arch/x86/kernel/jump_label.c:145
locks held by kworker/1:8/7614: 4, last CPU#1:
 #0: ffff8880222ea140 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff8880222ea140 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff8880222ea140 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff8880222ea140 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc900041dfc40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc900041dfc40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc900041dfc40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #1: ffffc900041dfc40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #2: ffff88823be989d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #2: ffff88823be989d8 (&dev->mutex){....}-{4:4}, at: hub_event+0x184/0x4d30 drivers/usb/core/hub.c:5912
 #3: ffff8880778371d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #3: ffff8880778371d8 (&dev->mutex){....}-{4:4}, at: usb_disconnect+0xfc/0x9a0 drivers/usb/core/hub.c:2341
locks held by kworker/1:9/7615: 4, last CPU#1:
 #0: ffff88801b06b140 ((wq_completion)events){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff88801b06b140 ((wq_completion)events){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff88801b06b140 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff88801b06b140 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc9000647fc40 (reg_work){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc9000647fc40 (reg_work){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc9000647fc40 (reg_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #1: ffffc9000647fc40 (reg_work){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #2: ffffffff90251500 (rtnl_mutex){+.+.}-{4:4}, at: reg_todo+0x1c/0xa40 net/wireless/reg.c:3205
 #3: ffff888056be07a0 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: class_wiphy_constructor include/net/cfg80211.h:6906 [inline]
 #3: ffff888056be07a0 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: reg_process_self_managed_hints+0x8d/0x160 net/wireless/reg.c:3195
locks held by syz.1.1008/9019: 2, last CPU#1:
 #0: ffff888035541078 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock_killable include/linux/mmap_lock.h:562 [inline]
 #0: ffff888035541078 (&mm->mmap_lock){++++}-{4:4}, at: vm_mmap_pgoff+0x1dd/0x4e0 mm/util.c:579
 #1: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: __pte_offset_map+0x29/0x240 mm/pgtable-generic.c:290
locks held by syz.4.1020/9051: 2, last CPU#1:
 #0: ffff88807904e9b8 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock include/linux/mmap_lock.h:600 [inline]
 #0: ffff88807904e9b8 (&mm->mmap_lock){++++}-{4:4}, at: exit_mmap+0x1a4/0x9f0 mm/mmap.c:1299
 #1: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: __pte_offset_map+0x29/0x240 mm/pgtable-generic.c:290
locks held by syz.0.1023/9063: 3, last CPU#1:
 #0: ffff888048842928 (&vcpu->mutex){+.+.}-{4:4}, at: kvm_vcpu_ioctl+0x27f/0xfd0 virt/kvm/kvm_main.c:4457
 #1: ffff88802992e310 (&kvm->srcu){.+.+}-{0:0}, at: srcu_lock_release include/linux/srcu.h:204 [inline]
 #1: ffff88802992e310 (&kvm->srcu){.+.+}-{0:0}, at: srcu_read_unlock include/linux/srcu.h:497 [inline]
 #1: ffff88802992e310 (&kvm->srcu){.+.+}-{0:0}, at: kvm_vcpu_srcu_read_unlock include/linux/kvm_host.h:969 [inline]
 #1: ffff88802992e310 (&kvm->srcu){.+.+}-{0:0}, at: vcpu_enter_guest arch/x86/kvm/x86.c:8270 [inline]
 #1: ffff88802992e310 (&kvm->srcu){.+.+}-{0:0}, at: vcpu_run+0x28fd/0x79b0 arch/x86/kvm/x86.c:8646
 #2: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #2: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #2: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: xa_load+0x60/0x210 lib/xarray.c:1620

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 33 Comm: khungtaskd Tainted: G             L      syzkaller #0 PREEMPT(full) 
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
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 4946 Comm: jbd2/sda1-8 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:memcmp lib/string.c:676 [inline]
RIP: 0010:bcmp+0x18e/0x230 lib/string.c:697
Code: 48 89 ef 48 8b 34 24 4c 89 ea e9 0d ff ff ff 48 85 d2 0f 84 95 00 00 00 31 db 48 8d 04 1f 48 89 c1 48 c1 e9 03 42 0f b6 0c 39 <84> c9 75 2b 0f b6 04 1f 48 8d 0c 1e 49 89 c8 49 c1 e8 03 47 0f b6
RSP: 0018:ffffc900000079c0 EFLAGS: 00000a02
RAX: ffff888025f70040 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000006 RSI: ffff88801df1b79a RDI: ffff888025f70040
RBP: 1ffff1100ac14315 R08: 0000000000000100 R09: 000000000000000c
R10: 000000000000000c R11: 8000000000000100 R12: ffff888025f70030
R13: 0000000000000030 R14: 1ffff1100ac14315 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888124cd6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000021f32000 CR4: 00000000003526f0
DR0: 0000000000000008 DR1: 0000000000000002 DR2: 0000000000000404
DR3: ffffffffefffff14 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 memcmp include/linux/fortify-string.h:677 [inline]
 rhashtable_compare include/linux/rhashtable.h:607 [inline]
 __rhashtable_lookup include/linux/rhashtable.h:635 [inline]
 rhltable_lookup include/linux/rhashtable.h:735 [inline]
 sta_info_hash_lookup+0x26e/0x610 net/mac80211/sta_info.c:199
 sta_info_get_bss+0xf9/0x390 net/mac80211/sta_info.c:236
 ieee80211_rx_for_interface+0x1ad/0x770 net/mac80211/rx.c:5338
 __ieee80211_rx_handle_packet net/mac80211/rx.c:5547 [inline]
 ieee80211_rx_list+0x2e84/0x3b00 net/mac80211/rx.c:5720
 ieee80211_rx_napi+0x1ad/0x3d0 net/mac80211/rx.c:5743
 ieee80211_rx include/net/mac80211.h:5449 [inline]
 ieee80211_handle_queued_frames+0xe4/0x1d0 net/mac80211/main.c:452
 tasklet_action_common+0x2d7/0x490 kernel/softirq.c:961
 handle_softirqs+0x226/0x860 kernel/softirq.c:645
 __do_softirq kernel/softirq.c:679 [inline]
 invoke_softirq kernel/softirq.c:519 [inline]
 __irq_exit_rcu+0xcb/0x220 kernel/softirq.c:758
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:775
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:lock_acquire+0x232/0x350 kernel/locking/lockdep.c:5947
Code: ff ff ff e8 70 7e 41 0a f7 44 24 10 00 02 00 00 0f 84 38 ff ff ff 65 48 8b 05 c2 79 f1 11 48 3b 44 24 50 75 33 fb 48 83 c4 58 <5b> 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc 48 8d 3d 87 31 da
RSP: 0018:ffffc9000f9af2c0 EFLAGS: 00000296
RAX: 0d6c4687d2d69600 RBX: 0000000000000000 RCX: 0000000000000046
RDX: 00000000105209fd RSI: ffffffff8e6fd6d4 RDI: ffffffff8c6d9480
RBP: ffff888036333e80 R08: ffffffff8177f1df R09: 0000000000000000
R10: ffffc9000f9af3f8 R11: ffffffff81b28090 R12: ffffffff8ed5c760
R13: 0000000000000002 R14: 0000000000000000 R15: 0000000000000246
 rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 rcu_read_lock include/linux/rcupdate.h:849 [inline]
 class_rcu_constructor include/linux/rcupdate.h:1216 [inline]
 unwind_next_frame+0xac/0x2550 arch/x86/kernel/unwind_orc.c:495
 arch_stack_walk+0x11b/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0xa9/0x100 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4683 [inline]
 slab_alloc_node mm/slub.c:4996 [inline]
 kmem_cache_alloc_noprof+0x2b9/0x600 mm/slub.c:5010
 alloc_buffer_head+0x2a/0x280 fs/buffer.c:2872
 jbd2_journal_write_metadata_buffer+0xbe/0xd60 fs/jbd2/journal.c:347
 jbd2_journal_commit_transaction+0x155a/0x5b70 fs/jbd2/commit.c:689
 kjournald2+0x3bc/0x750 fs/jbd2/journal.c:200
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
