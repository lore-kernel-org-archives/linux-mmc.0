Received: from mail-oi2-f8.google.com (mail-oi2-f8.google.com [74.125.231.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3633242D9
	for <linux-mmc@vger.kernel.org>; Thu, 27 Aug 2026 05:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787810384; cv=none; b=HapkQOTqL7IOhIhbbFUIhOoiaE5+SDLBvFftyx0S3WOcEWZZsetMHR1mMYUVuiywPstAe00uNmFFIqxaok0ncUfvLEaXyIuh32EvYp4LNpIGDGw7nQ7sVYfeEjXrdWV25rtgNVcJGSetzvHE+TKSeQ3Fuf8hu3ovGsjLDk5tS1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787810384; c=relaxed/simple;
	bh=sE0jyLL8f7iiiSCXU8T46j9ChZ3NolmazXfuTjsIOo4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YWa/9cJl+A1lePJBpKjfqKeIHfRYYwa03d2FyGj6YLdYKQ933XFm2lzxLi5SdGXGclvXBDQwUQA7vZXv/ptDbwV2NQAKrgTkOeAgfaT/YonrzNGag6UlwTuMys3M26TKd5283fh7+1nwiJQGpJf1WmyTpV6I5/t/LH1Jdd9fXE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f8.google.com with SMTP id 46e09a7af769-7f0355eb4b3so630377a34.0
        for <linux-mmc@vger.kernel.org>; Wed, 26 Aug 2026 22:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787810380; x=1788415180;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ca059/CJy7VrIyAYpHOE3VQf+Ph2ySr0tflRr19HY6M=;
        b=E2eAbKNnFveMDZ3Vnkni1LCVBSB5TIYLfzA/VzUQtcHdprQfKSOegGutV5VRw+UHRc
         BqXxem/iCYQ5pPI3JFDLr0MPr0bkLx9J7nGLoKlCrgADJ1Rw7461o8luEzg3MySvIJgy
         p4MvZVLBajc7K86N8d7m2JgUjsHxQma5jnGwPGsUuTvvBtq+mRqd58Z00v3M9/R+VzO9
         7rUYIpLSv8vEjBfIfSEiGj8Lek66YCkpbXvyEvAmwSnwOJvvlo6bVW4yxxDqnBT0OdP0
         dDWKojf9Sb+nckf3sXbPkJsUrcKFzSGsAC+G72IYR/2JILacDsI64WrWaQLYLTkH3Dll
         qaCQ==
X-Forwarded-Encrypted: i=1; AHgh+RoTIB9iufl/HeWieN54Rq7/3Au94/W53dcKY38+2W7MLOL0D0XICoYvdv4rk12dgMjo7SsDVmAd4Yw=@vger.kernel.org
X-Gm-Message-State: AFuF++k+Ngqmju7cxcVBLMjH/NSsnmUldYWF2cTZndp2SX6TOjfV/41t
	TU12vGx6u9G8BjEWKEppgz76wnhbiuTlNqA875Dj3FHuP4BIZN1FAV4mYTSqCjwmHoY5XoHRqcR
	CEUH+TN4SNY3U3aJY+LvM7OC60+muaB/9Wf173MZg94SpvVqS0Ga3dytczvk=
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:16a2:b0:6b1:7f02:a9b6 with SMTP id
 006d021491bc7-6b1a035971fmr11312086eaf.5.1787810379979; Wed, 26 Aug 2026
 22:59:39 -0700 (PDT)
Date: Wed, 26 Aug 2026 22:59:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8fd24b.50659fcc.60cd.000d.GAE@google.com>
Subject: [syzbot] [kernel?] INFO: task hung in sdio_reset
From: syzbot <syzbot+e8678cd3d8b65d1f2c74@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, ulfh@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    502d45774af0 Merge tag 'clk-for-linus' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17cde979580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dfd8ec781284be4e
dashboard link: https://syzkaller.appspot.com/bug?extid=e8678cd3d8b65d1f2c74
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fb0ebb231418/disk-502d4577.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/82fe4e8c3ba9/vmlinux-502d4577.xz
kernel image: https://storage.googleapis.com/syzbot-assets/40eb9f92a77c/bzImage-502d4577.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e8678cd3d8b65d1f2c74@syzkaller.appspotmail.com

INFO: task kworker/0:0:9 blocked for more than 143 seconds.
      Tainted: G             L      syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:0     state:D stack:23560 pid:9     tgid:9     ppid:2      task_flags:0x4208060 flags:0x00080000
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
 mmc_io_rw_direct_host drivers/mmc/core/sdio_ops.c:83 [inline]
 sdio_reset+0xf4/0x3a0 drivers/mmc/core/sdio_ops.c:209
 mmc_rescan_try_freq drivers/mmc/core/core.c:2121 [inline]
 mmc_rescan+0x6eb/0x1040 drivers/mmc/core/core.c:2316
 process_one_work kernel/workqueue.c:3387 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3470
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3551
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task kworker/0:5:5737 blocked for more than 143 seconds.
      Tainted: G             L      syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:5     state:D stack:20688 pid:5737  tgid:5737  ppid:2      task_flags:0x4288060 flags:0x00080000
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
locks held by kworker/0:0/9: 2, on CPU#0:
 #0: ffff88801b06a140 ((wq_completion)events_freezable){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff88801b06a140 ((wq_completion)events_freezable){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff88801b06a140 ((wq_completion)events_freezable){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3352 [inline]
 #0: ffff88801b06a140 ((wq_completion)events_freezable){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3470
 #1: ffffc900000e7c40 ((work_completion)(&(&host->detect)->work)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc900000e7c40 ((work_completion)(&(&host->detect)->work)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc900000e7c40 ((work_completion)(&(&host->detect)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3352 [inline]
 #1: ffffc900000e7c40 ((work_completion)(&(&host->detect)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3470
locks held by kworker/0:1/10: 4, last CPU#0:
 #0: ffff888022280d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff888022280d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff888022280d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3352 [inline]
 #0: ffff888022280d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3470
 #1: ffffc900000f7c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc900000f7c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc900000f7c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3352 [inline]
 #1: ffffc900000f7c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3470
 #2: ffff88802912d1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #2: ffff88802912d1d8 (&dev->mutex){....}-{4:4}, at: hub_event+0x184/0x4d30 drivers/usb/core/hub.c:5912
 #3: ffff88801ff411d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #3: ffff88801ff411d8 (&dev->mutex){....}-{4:4}, at: __device_attach+0x88/0x450 drivers/base/dd.c:1073
locks held by pr/ttyS0/16: 2, last CPU#1:
 #0: ffffffff8ec36278 (console_srcu){....}-{0:0}, at: rcu_try_lock_acquire include/linux/rcupdate.h:314 [inline]
 #0: ffffffff8ec36278 (console_srcu){....}-{0:0}, at: srcu_read_lock_nmisafe include/linux/srcu.h:439 [inline]
 #0: ffffffff8ec36278 (console_srcu){....}-{0:0}, at: console_srcu_read_lock+0x30/0x60 kernel/printk/printk.c:291
 #1: ffffffff9ad28018 (&port_lock_key){-.-.}-{3:3}, at: __uart_port_lock_irqsave include/linux/serial_core.h:613 [inline]
 #1: ffffffff9ad28018 (&port_lock_key){-.-.}-{3:3}, at: univ8250_console_device_lock+0x67/0xc0 drivers/tty/serial/8250/8250_core.c:413
locks held by khungtaskd/32: 1, last CPU#0:
 #0: ffffffff8ed5c6a0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffffffff8ed5c6a0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8ed5c6a0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6793
locks held by klogd/4964: 1, last CPU#0:
 #0: ffffffff8ed4e8c0 (syslog_lock){+.+.}-{4:4}, at: syslog_print+0x4ad/0x610 kernel/printk/printk.c:1663
locks held by udevd/4975: 1, last CPU#0:
 #0: ffffffff8f4ec0b8 (tomoyo_ss){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:198 [inline]
 #0: ffffffff8f4ec0b8 (tomoyo_ss){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:305 [inline]
 #0: ffffffff8f4ec0b8 (tomoyo_ss){.+.+}-{0:0}, at: tomoyo_read_lock security/tomoyo/common.h:1112 [inline]
 #0: ffffffff8f4ec0b8 (tomoyo_ss){.+.+}-{0:0}, at: tomoyo_check_open_permission+0x1d3/0x470 security/tomoyo/file.c:772
locks held by getty/5366: 2, on CPU#0:
 #0: ffff888033e7b0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000322b2e8 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x45a/0x1360 drivers/tty/n_tty.c:2211
locks held by kworker/0:5/5737: 5, on CPU#0:
 #0: ffff888022280d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff888022280d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff888022280d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3352 [inline]
 #0: ffff888022280d40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3470
 #1: ffffc90003e27c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc90003e27c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc90003e27c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3352 [inline]
 #1: ffffc90003e27c40 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3470
 #2: ffff888028c601d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #2: ffff888028c601d8 (&dev->mutex){....}-{4:4}, at: hub_event+0x184/0x4d30 drivers/usb/core/hub.c:5912
 #3: ffff888077d641d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #3: ffff888077d641d8 (&dev->mutex){....}-{4:4}, at: usb_disconnect+0xfc/0x9a0 drivers/usb/core/hub.c:2341
 #4: ffff8880318b41a0 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #4: ffff8880318b41a0 (&dev->mutex){....}-{4:4}, at: __device_driver_lock drivers/base/dd.c:1171 [inline]
 #4: ffff8880318b41a0 (&dev->mutex){....}-{4:4}, at: device_release_driver_internal+0xb9/0x880 drivers/base/dd.c:1369
locks held by syz-executor/7993: 4, last CPU#0:
 #0: ffffffff8ee35b50 (dup_mmap_sem){++++}-{0:0}, at: dup_mm kernel/fork.c:1542 [inline]
 #0: ffffffff8ee35b50 (dup_mmap_sem){++++}-{0:0}, at: copy_mm+0x10f/0x480 kernel/fork.c:1595
 #1: ffff88807b4b7678 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock_killable include/linux/mmap_lock.h:562 [inline]
 #1: ffff88807b4b7678 (&mm->mmap_lock){++++}-{4:4}, at: dup_mmap+0x195/0x1dc0 mm/mmap.c:1716
 #2: ffff888032bf5038 (&mm->mmap_lock/1){+.+.}-{4:4}, at: mmap_write_lock_nested include/linux/mmap_lock.h:552 [inline]
 #2: ffff888032bf5038 (&mm->mmap_lock/1){+.+.}-{4:4}, at: dup_mmap+0x221/0x1dc0 mm/mmap.c:1723
 #3: ffffffff8ed5c6a0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #3: ffffffff8ed5c6a0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #3: ffffffff8ed5c6a0 (rcu_read_lock){....}-{1:3}, at: __pte_offset_map+0x29/0x240 mm/pgtable-generic.c:290
locks held by syz-executor/8232: 4, last CPU#0:
 #0: ffffffff8ee35b50 (dup_mmap_sem){++++}-{0:0}, at: dup_mm kernel/fork.c:1542 [inline]
 #0: ffffffff8ee35b50 (dup_mmap_sem){++++}-{0:0}, at: copy_mm+0x10f/0x480 kernel/fork.c:1595
 #1: ffff888027f7c378 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock_killable include/linux/mmap_lock.h:562 [inline]
 #1: ffff888027f7c378 (&mm->mmap_lock){++++}-{4:4}, at: dup_mmap+0x195/0x1dc0 mm/mmap.c:1716
 #2: ffff888032bf4378 (&mm->mmap_lock/1){+.+.}-{4:4}, at: mmap_write_lock_nested include/linux/mmap_lock.h:552 [inline]
 #2: ffff888032bf4378 (&mm->mmap_lock/1){+.+.}-{4:4}, at: dup_mmap+0x221/0x1dc0 mm/mmap.c:1723
 #3: ffffffff8ed5c6a0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #3: ffffffff8ed5c6a0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #3: ffffffff8ed5c6a0 (rcu_read_lock){....}-{1:3}, at: __pte_offset_map+0x29/0x240 mm/pgtable-generic.c:290
locks held by syz.6.3137/15081: 2, last CPU#1:
 #0: ffff88801c2f2460 (sb_writers#5){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2754 [inline]
 #0: ffff88801c2f2460 (sb_writers#5){.+.+}-{0:0}, at: vfs_write+0x22b/0xba0 fs/read_write.c:683
 #1: ffff888027f0acc0 (&sb->s_type->i_mutex_key#15){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:1025 [inline]
 #1: ffff888027f0acc0 (&sb->s_type->i_mutex_key#15){+.+.}-{4:4}, at: shmem_file_write_iter+0x7f/0x120 mm/shmem.c:3419
locks held by syz.2.3141/15090: 4, last CPU#0:
 #0: ffff8880766110b0 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x246/0x320 fs/file.c:1259
 #1: ffff88807c202480 (&sb->s_type->i_mutex_key#43){.+.+}-{4:4}, at: iterate_dir+0x209/0x4d0 fs/readdir.c:103
 #2: ffffffff8ee8f5e0 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:316 [inline]
 #2: ffffffff8ee8f5e0 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slub.c:4636 [inline]
 #2: ffffffff8ee8f5e0 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:4974 [inline]
 #2: ffffffff8ee8f5e0 (fs_reclaim){+.+.}-{0:0}, at: __kmalloc_cache_noprof+0x61/0x600 mm/slub.c:5559
 #3: ffffffff8eea4d40 (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at: fs_reclaim_acquire+0x7c/0x100 mm/page_alloc.c:4392
locks held by syz.0.3142/15091: 2, last CPU#0:
 #0: ffff88807dc19078 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock include/linux/mmap_lock.h:600 [inline]
 #0: ffff88807dc19078 (&mm->mmap_lock){++++}-{4:4}, at: exit_mmap+0x1a4/0x9f0 mm/mmap.c:1299
 #1: ffffffff8ed5c6a0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffffff8ed5c6a0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffffff8ed5c6a0 (rcu_read_lock){....}-{1:3}, at: __pte_offset_map+0x29/0x240 mm/pgtable-generic.c:290

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 32 Comm: khungtaskd Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
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
CPU: 1 UID: 0 PID: 5610 Comm: syz-executor Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
RIP: 0010:__hlist_del include/linux/list.h:1043 [inline]
RIP: 0010:hlist_del include/linux/list.h:1059 [inline]
RIP: 0010:debug_object_free+0x1f4/0x340 lib/debugobjects.c:1037
Code: ff ff ff 05 ae 95 91 0b e9 51 fe ff ff 4c 89 f8 48 c1 e8 03 48 89 04 24 42 80 3c 30 00 74 08 4c 89 ff e8 ef b7 4e fd 4d 8b 2f <49> 8d 6f 08 49 89 ec 49 c1 ec 03 43 80 3c 34 00 74 08 48 89 ef e8
RSP: 0018:ffffc900036d7c88 EFLAGS: 00000046
RAX: 1ffff1100ff3875e RBX: ffffffff9ac13938 RCX: 0000000000000001
RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffffc900036d7be0
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff520006daf7c R12: ffffc900036d7d40
R13: ffff88802a5f9bd0 R14: dffffc0000000000 R15: ffff88807f9c3af0
FS:  0000555562070500(0000) GS:ffff888124de3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5e4a3ff000 CR3: 0000000058ce7000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 destroy_hrtimer_on_stack kernel/time/hrtimer.c:501 [inline]
 hrtimer_nanosleep+0x2cc/0x3a0 kernel/time/hrtimer.c:2490
 __do_sys_clock_nanosleep kernel/time/posix-timers.c:1406 [inline]
 __se_sys_clock_nanosleep+0x35b/0x3b0 kernel/time/posix-timers.c:1383
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff61fd5e90e
Code: 08 0f 85 a5 a8 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 80 00 00 00 00 48 83 ec 08
RSP: 002b:00007ffc9ba67d28 EFLAGS: 00000246 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: 0000555562070500 RCX: 00007ff61fd5e90e
RDX: 00007ffc9ba67d80 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007ffc9ba67dec R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000001388
R13: 00000000000927c0 R14: 0000000000076ac4 R15: 00007ffc9ba67e40
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
