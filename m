Received: from mail-oa2-f0.google.com (mail-oa2-f0.google.com [74.125.231.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7D347DD56
	for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2026 10:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789467996; cv=none; b=u8OnlN9GK0zJ/B/tgNp9yrFGRS/9BGVMc71m4YGYDqxOpDUAvypxXFG8NCGMEhhN2mhBbRjSsWERr8X5UhOVXRMRVOMnDFOtKyjmPrxfuojmCczQJRdTJwMeJosa2AQnF3ZFWWaNoUsTeubhh0OGKeQhm/DX2EFcR/LPD7/uIDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789467996; c=relaxed/simple;
	bh=B1V7amIq3fdBGo4Bqe/pVUVthjf/0iUzRhMVved/W3k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lWQ3IBippvQXBK6jOb8mO7R8ezcqRLvOIHLk4WMEbhT2QeL18PFV6l4YD81qyeMXYJf9zrgAgFN56WgfKvJB6ihoPBzIXlv3pX98vbYp0c68fazDWaMSZxEtR2Z6n7MzUvztqoEqiRuFFSU2h42vNFf7aJ34bxxOtn1cQtkuihc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa2-f0.google.com with SMTP id 586e51a60fabf-451e8472960so3645671fac.1
        for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2026 03:26:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789467992; x=1790072792;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3A/2L7amDbVjDYc0CYY39cc1oaqo1ICWDIJFTkwVo/s=;
        b=wQTWVvEme0EVdk6iZW7EgwusupIcW+1Hvh9yeazdtYuhxLAXz9h+YQ4kCgt6jAmufI
         XrQlWjc6aPf+o1gmAmkzORPkIPj0ZNLHBsoDZh/vvu22zmgB+HsYWNxTG6yOJQ2K/XMI
         DHWzAZplPmXhj1boowyLaKJ16rptsCNHsb8BsH+Ottz14+X0wONSWx6At3u+7+qA+/Up
         /BUC9xJ3HqA7MrVQNk04/9lX6Su5aWUhaXCa7KsCAhJ3qRVoaqP5fGiHq+vQQBJ7nPW3
         EEZSD6zCROca5nOh3NZWI7UIKEWg1LJDYIpqfkO/XOw1WjyHCQtvUmbzMiUXxihcal2s
         c6vA==
X-Forwarded-Encrypted: i=1; AKwUvByeNP7iifE1V/bB7eGyc33ezcZfynfPzgUwwBlwVuzzFXmUShL6pcc1PrefuGc59rRzA4h6CjUjT8Y=@vger.kernel.org
X-Gm-Message-State: AFuF++mQeh8G0XaQT2tuZsQQ6SyFfXfDzpbSFA8r4lI8+X5fXGIQGh3r
	5K8jSAwZ/+pjJGQEhqBNNnMIglV+LCSJaUMsfRynZr10KD7YksKXWrfveMOX0uF9nJ5SEFfMtnF
	7JODxnqhqIXiuGvMzAitgYWv/+8uOzRsXq7XC9UPOMF5nLBNFKAnrZz+V5L0=
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:290e:b0:6c3:42eb:ec22 with SMTP id
 006d021491bc7-6c53fe7e165mr3590339eaf.23.1789467992608; Tue, 15 Sep 2026
 03:26:32 -0700 (PDT)
Date: Tue, 15 Sep 2026 03:26:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aa91d58.4c28b7d0.c1bba.0035.GAE@google.com>
Subject: [syzbot] [kernel?] INFO: task hung in mmc_send_if_cond_pcie
From: syzbot <syzbot+30341f17551668478919@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, ulfh@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c297ed90fbba Merge tag 'configfs-7.3-rc3' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17cbca15580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e4e3a0e188a497e
dashboard link: https://syzkaller.appspot.com/bug?extid=30341f17551668478919
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b8fd57a0421e/disk-c297ed90.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f17a4a824476/vmlinux-c297ed90.xz
kernel image: https://storage.googleapis.com/syzbot-assets/66695b314836/bzImage-c297ed90.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+30341f17551668478919@syzkaller.appspotmail.com

INFO: task kworker/1:6:5712 blocked for more than 143 seconds.
      Tainted: G             L      syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:6     state:D stack:20608 pid:5712  tgid:5712  ppid:2      task_flags:0x4208060 flags:0x00080000
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
 __mmc_send_if_cond drivers/mmc/core/sd_ops.c:232 [inline]
 mmc_send_if_cond_pcie+0x160/0x3a0 drivers/mmc/core/sd_ops.c:269
 mmc_rescan_try_freq drivers/mmc/core/core.c:2126 [inline]
 mmc_rescan+0x751/0x1040 drivers/mmc/core/core.c:2316
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3479
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3560
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task kworker/0:7:5750 blocked for more than 143 seconds.
      Tainted: G             L      syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:7     stat
task:kworker/0:7     state:D stack:20704 pid:5750  tgid:5750  ppid:2      task_flags:0x4288060 flags:0x00080000
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
locks held by kworker/0:0/9: 5, on CPU#0:
 #0: ffff88801fe9c940 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff88801fe9c940 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff88801fe9c940 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff88801fe9c940 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc900000e7c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc900000e7c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc900000e7c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #1: ffffc900000e7c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #2: ffff88802a1661d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #2: ffff88802a1661d8 (&dev->mutex){....}-{4:4}, at: hub_event+0x184/0x4d30 drivers/usb/core/hub.c:5912
 #3: ffff88807bd8d1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #3: ffff88807bd8d1d8 (&dev->mutex){....}-{4:4}, at: __device_attach+0x88/0x450 drivers/base/dd.c:1073
 #4: ffff88807a62e1a0 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #4: ffff88807a62e1a0 (&dev->mutex){....}-{4:4}, at: __device_attach+0x88/0x450 drivers/base/dd.c:1073
locks held by pr/ttyS0/16: 2, last CPU#0:
 #0: ffffffff8ec36338 (console_srcu){....}-{0:0}, at: rcu_try_lock_acquire include/linux/rcupdate.h:314 [inline]
 #0: ffffffff8ec36338 (console_srcu){....}-{0:0}, at: srcu_read_lock_nmisafe include/linux/srcu.h:439 [inline]
 #0: ffffffff8ec36338 (console_srcu){....}-{0:0}, at: console_srcu_read_lock+0x30/0x60 kernel/printk/printk.c:291
 #1: ffffc90000007cc0 (&(&br->gc_work)->timer){..-.}-{0:0}, at: call_timer_fn+0xd5/0x5f0 kernel/time/timer.c:1745
locks held by kworker/1:0/25: 5, on CPU#1:
 #0: ffff88801fe9c940 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff88801fe9c940 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff88801fe9c940 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff88801fe9c940 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc900001f7c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc900001f7c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc900001f7c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #1: ffffc900001f7c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #2: ffff88802b5b21d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #2: ffff88802b5b21d8 (&dev->mutex){....}-{4:4}, at: hub_event+0x184/0x4d30 drivers/usb/core/hub.c:5912
 #3: ffff88802b5b6568 (&port_dev->status_lock){+.+.}-{4:4}, at: usb_lock_port drivers/usb/core/hub.c:3265 [inline]
 #3: ffff88802b5b6568 (&port_dev->status_lock){+.+.}-{4:4}, at: hub_port_connect drivers/usb/core/hub.c:5477 [inline]
 #3: ffff88802b5b6568 (&port_dev->status_lock){+.+.}-{4:4}, at: hub_port_connect_change drivers/usb/core/hub.c:5720 [inline]
 #3: ffff88802b5b6568 (&port_dev->status_lock){+.+.}-{4:4}, at: port_event drivers/usb/core/hub.c:5884 [inline]
 #3: ffff88802b5b6568 (&port_dev->status_lock){+.+.}-{4:4}, at: hub_event+0x20a1/0x4d30 drivers/usb/core/hub.c:5966
 #4: ffff88802b49dc60 (hcd->address0_mutex){+.+.}-{4:4}, at: hub_port_connect drivers/usb/core/hub.c:5478 [inline]
 #4: ffff88802b49dc60 (hcd->address0_mutex){+.+.}-{4:4}, at: hub_port_connect_change drivers/usb/core/hub.c:5720 [inline]
 #4: ffff88802b49dc60 (hcd->address0_mutex){+.+.}-{4:4}, at: port_event drivers/usb/core/hub.c:5884 [inline]
 #4: ffff88802b49dc60 (hcd->address0_mutex){+.+.}-{4:4}, at: hub_event+0x20c9/0x4d30 drivers/usb/core/hub.c:5966
locks held by khungtaskd/32: 1, last CPU#1:
 #0: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6871
locks held by klogd/4972: 1, last CPU#1:
 #0: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: class_rcu_constructor include/linux/rcupdate.h:1216 [inline]
 #0: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: unwind_next_frame+0x8f/0x2550 arch/x86/kernel/unwind_orc.c:495
locks held by udevd/4983: 1, last CPU#1:
 #0: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: class_rcu_constructor include/linux/rcupdate.h:1216 [inline]
 #0: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: unwind_next_frame+0x8f/0x2550 arch/x86/kernel/unwind_orc.c:495
locks held by getty/5372: 2, on CPU#1:
 #0: ffff888035e9d0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900032332e8 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x45a/0x1360 drivers/tty/n_tty.c:2211
locks held by syz-executor/5603: 2, last CPU#1:
 #0: ffff888034e869b8 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock include/linux/mmap_lock.h:600 [inline]
 #0: ffff888034e869b8 (&mm->mmap_lock){++++}-{4:4}, at: exit_mmap+0x1a4/0x9f0 mm/mmap.c:1299
 #1: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: class_rcu_constructor include/linux/rcupdate.h:1216 [inline]
 #1: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: unwind_next_frame+0x8f/0x2550 arch/x86/kernel/unwind_orc.c:495
locks held by udevd/5626: 4, on CPU#0:
 #0: ffff88807ff4c638 (&p->lock){+.+.}-{4:4}, at: seq_read_iter+0xa4/0xca0 fs/seq_file.c:183
 #1: ffff88805782ec80 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_seq_start+0x5d/0x420 fs/kernfs/file.c:165
 #2: ffff888030bdce18 (kn->active#25){++++}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:73 [inline]
 #2: ffff888030bdce18 (kn->active#25){++++}-{0:0}, at: kernfs_seq_start+0xb2/0x420 fs/kernfs/file.c:166
 #3: ffff88807bd8d1d8 (&dev->mutex){....}-{4:4}, at: device_lock_interruptible include/linux/device.h:1109 [inline]
 #3: ffff88807bd8d1d8 (&dev->mutex){....}-{4:4}, at: manufacturer_show+0x26/0xa0 drivers/usb/core/sysfs.c:142
locks held by syz-executor/5627: 4, last CPU#1:
 #0: ffffffff8ee36170 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mm kernel/fork.c:1542 [inline]
 #0: ffffffff8ee36170 (dup_mmap_sem){.+.+}-{0:0}, at: copy_mm+0x10f/0x480 kernel/fork.c:1595
 #1: ffff888034e829f8 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock_killable include/linux/mmap_lock.h:562 [inline]
 #1: ffff888034e829f8 (&mm->mmap_lock){++++}-{4:4}, at: dup_mmap+0x195/0x1dc0 mm/mmap.c:1716
 #2: ffff88807f9069b8 (&mm->mmap_lock/1){+.+.}-{4:4}, at: mmap_write_lock_nested include/linux/mmap_lock.h:552 [inline]
 #2: ffff88807f9069b8 (&mm->mmap_lock/1){+.+.}-{4:4}, at: dup_mmap+0x221/0x1dc0 mm/mmap.c:1723
 #3: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #3: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #3: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: __pte_offset_map+0x29/0x240 mm/pgtable-generic.c:290
locks held by kworker/1:6/5712: 2, on CPU#1:
 #0: ffff88801b06a140 ((wq_completion)events_freezable){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff88801b06a140 ((wq_completion)events_freezable){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff88801b06a140 ((wq_completion)events_freezable){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff88801b06a140 ((wq_completion)events_freezable){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc90004de7c40 ((work_completion)(&(&host->detect)->work)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc90004de7c40 ((work_completion)(&(&host->detect)->work)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc90004de7c40 ((work_completion)(&(&host->detect)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #1: ffffc90004de7c40 ((work_completion)(&(&host->detect)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
locks held by kworker/0:7/5750: 5, on CPU#0:
 #0: ffff88801fe9c940 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff88801fe9c940 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff88801fe9c940 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff88801fe9c940 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc90005077c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc90005077c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc90005077c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #1: ffffc90005077c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #2: ffff8880287a51d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #2: ffff8880287a51d8 (&dev->mutex){....}-{4:4}, at: hub_event+0x184/0x4d30 drivers/usb/core/hub.c:5912
 #3: ffff88807a0061d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #3: ffff88807a0061d8 (&dev->mutex){....}-{4:4}, at: usb_disconnect+0xfc/0x9a0 drivers/usb/core/hub.c:2341
 #4: ffff88807a0031a0 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #4: ffff88807a0031a0 (&dev->mutex){....}-{4:4}, at: __device_driver_lock drivers/base/dd.c:1171 [inline]
 #4: ffff88807a0031a0 (&dev->mutex){....}-{4:4}, at: device_release_driver_internal+0xb9/0x880 drivers/base/dd.c:1369
locks held by kworker/u8:14/5783: 3, last CPU#1:
 #0: ffff88801b0ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: raw_spin_rq_lock_nested+0xb2/0x160 kernel/sched/core.c:685
 #1: ffff8880b8724408 (psi_seq){-.-.}-{0:0}, at: psi_task_switch+0x57/0x7d0 kernel/sched/psi.c:933
 #2: ffff8880b8726118 (&base->lock){-.-.}-{2:2}, at: lock_timer_base kernel/time/timer.c:1004 [inline]
 #2: ffff8880b8726118 (&base->lock){-.-.}-{2:2}, at: __mod_timer+0x1a9/0xed0 kernel/time/timer.c:1085
locks held by syz.1.929/9659: 2, last CPU#1:
 #0: ffff88807cec9078 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock include/linux/mmap_lock.h:544 [inline]
 #0: ffff88807cec9078 (&mm->mmap_lock){++++}-{4:4}, at: exit_mmap+0x2d8/0x9f0 mm/mmap.c:1323
 #1: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: class_rcu_constructor include/linux/rcupdate.h:1216 [inline]
 #1: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: unwind_next_frame+0x8f/0x2550 arch/x86/kernel/unwind_orc.c:495
locks held by syz.0.981/9840: 1, on CPU#1:
 #0: ffff88807f904378 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock_killable include/linux/mmap_lock.h:562 [inline]
 #0: ffff88807f904378 (&mm->mmap_lock){++++}-{4:4}, at: vm_mmap_pgoff+0x1dd/0x4e0 mm/util.c:579
locks held by syz.0.981/9841: 2, last CPU#1:
 #0: ffffffff90242ca8 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x524/0x780 net/core/net_namespace.c:578
 #1: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: class_rcu_constructor include/linux/rcupdate.h:1216 [inline]
 #1: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: unwind_next_frame+0x8f/0x2550 arch/x86/kernel/unwind_orc.c:495
locks held by syz.0.981/9842: 2, last CPU#1:
 #0: ffffffff90242ca8 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x524/0x780 net/core/net_namespace.c:578
 #1: ffffffff8ee8ff20 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:316 [inline]
 #1: ffffffff8ee8ff20 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slub.c:4636 [inline]
 #1: ffffffff8ee8ff20 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:4974 [inline]
 #1: ffffffff8ee8ff20 (fs_reclaim){+.+.}-{0:0}, at: __do_kmalloc_node mm/slub.c:5413 [inline]
 #1: ffffffff8ee8ff20 (fs_reclaim){+.+.}-{0:0}, at: __kmalloc_noprof+0xbc/0x720 mm/slub.c:5439
locks held by syz.0.981/9844: 3, last CPU#1:
 #0: ffff88807f904378 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock include/linux/mmap_lock.h:600 [inline]
 #0: ffff88807f904378 (&mm->mmap_lock){++++}-{4:4}, at: __mm_populate+0x182/0x390 mm/gup.c:1942
 #1: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: do_fault_around mm/memory.c:5957 [inline]
 #1: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: do_read_fault mm/memory.c:5991 [inline]
 #1: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: do_fault mm/memory.c:6134 [inline]
 #1: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: do_pte_missing+0x140c/0x34b0 mm/memory.c:4700
 #2: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #2: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #2: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: filemap_map_pages+0x1d1/0x2170 mm/filemap.c:3921
locks held by syz-executor/9843: 2, last CPU#1:
 #0: ffff888057777540 (&sb->s_type->i_mutex_key#13){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:1024 [inline]
 #0: ffff888057777540 (&sb->s_type->i_mutex_key#13){+.+.}-{4:4}, at: __sock_release+0x7a/0x1f0 net/socket.c:734
 #1: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: class_rcu_constructor include/linux/rcupdate.h:1216 [inline]
 #1: ffffffff8ed5c760 (rcu_read_lock){....}-{1:3}, at: unwind_next_frame+0x8f/0x2550 arch/x86/kernel/unwind_orc.c:495

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 32 Comm: khungtaskd Tainted: G             L      syzkaller #0 PREEMPT(full) 
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
CPU: 0 UID: 0 PID: 16 Comm: pr/ttyS0 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:io_serial_out+0x7c/0xc0 drivers/tty/serial/8250/8250_port.c:416
Code: 67 55 fc 44 89 f9 d3 e5 49 83 c6 40 4c 89 f0 48 c1 e8 03 42 80 3c 20 00 74 08 4c 89 f7 e8 0c 67 c5 fc 41 03 2e 89 d8 89 ea ee <5b> 41 5c 41 5e 41 5f 5d c3 cc cc cc cc cc 44 89 f9 80 e1 07 38 c1
RSP: 0018:ffffc90000157900 EFLAGS: 00000002
RAX: 0000000000000020 RBX: 0000000000000020 RCX: 0000000000000000
RDX: 00000000000003f8 RSI: 0000000000000000 RDI: 0000000000000020
RBP: 00000000000003f8 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: ffffffff85725de0 R12: dffffc0000000000
R13: 0000000000000020 R14: ffffffff9ad350c0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888124cd6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb7fe16cf80 CR3: 0000000069722000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000020
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 serial_port_out include/linux/serial_core.h:817 [inline]
 serial8250_console_putchar drivers/tty/serial/8250/8250_port.c:3287 [inline]
 __serial8250_console_fifo_write+0x1e6/0x3e0 drivers/tty/serial/8250/8250_port.c:3359
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
