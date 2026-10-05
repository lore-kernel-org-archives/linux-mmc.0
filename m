Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211CF2F39B5
	for <linux-mmc@vger.kernel.org>; Mon,  5 Oct 2026 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791217896; cv=none; b=Q6E7xOsTv9LRx9j/XzVQQCcIchB1JzxPlOkao7FBQCUbltiIkCISyOhXuIcNcMbtBJEMEQH3Tilh7X627hs1yl8C8nEHLXz1nUtWsCcLYwvlf7BUN8Y6D7ZCYzcxe5R/a6py2ZM31iSJJOAQ7acYD90ISQHEUA0nupJ/KbrJzpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791217896; c=relaxed/simple;
	bh=Pf1pvvigvjF5GBy/dGWlxkrPoFtBnbtZOeHRHY5GT9k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gIQZfUwYRmsnZ7Iowwunbgc8ZcHXs4p/1Cfm9Nq2QQv6oKM/CjLrwM8mhkXMu5qokBcdY0ohGAaw04A+0DfApjQLMCohsG7SlDjuA4wVYVUX+0FitbLWRgQdprkQ4CpJQRHGIeC4cuclpABNijKJ+h8If4fzS/UTnBaVRNimI/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4b37620eb73so3106876b6e.1
        for <linux-mmc@vger.kernel.org>; Mon, 05 Oct 2026 09:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791217893; x=1791822693;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aIOSKYPrXX8if8EnWYoObqCaQyRR/W4O8yh2p31TQsw=;
        b=hHWkCQ7VvLd7FILdstENHzDB9gr2H9243SQHqVyhOu3s5bYP16qkynsEIEQEUhKfLh
         4h6Ji+dSLgFrJPi+5ZKvrTjWq/huQUH3WIihb5zKH1VVw9dCNZvMmiZAnJL9nvWYRzTp
         ICpB2MZ6ixpYquCXfb8TdOwHF1w+IPgIa4uT/xKh5cZ/SmsqW0lbs0kZyB9DTjKl9ruy
         toSi+r71UGqwpdNM5V5EAl09/Dz47VkysPJ1gHGlUpIbC4WphNEQOQ5tfbUgAwEMiCL5
         6TIUPrMwLEZ1CqnMy4eBZ0S0QJa1n+SxJqp68DTFbeFEWvzQfR/DSOgTnU7CfH0OfB+Q
         0lrQ==
X-Forwarded-Encrypted: i=1; AKwUvBzVBbG0Vnt3ojOGU6v1mm/oOm3eKqTb84NImsjDvlX0eJM5oVQpAFrYQtv3DL8ukY9+Hhsbc1vcLdk=@vger.kernel.org
X-Gm-Message-State: AFuF++nf92oJyzPrqM8BjW74mG/uBAVWvpGbwRDtaDeXvR9lo/TaUvny
	2QNo2dGF82yda0O7H25gpfBvyFTic2ss3ixqjI3ulVahTTC8aEOT3Eo8ofVp1cMYlFhVu/CGgQD
	GdbSIihSM0kisMVnyV3VoTdLu6Duo5Z+4/tOazKBZ6MVVp9Y5LHDdDUO0WQ4=
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1b22:b0:4f5:1866:91ce with SMTP id
 5614622812f47-4f5267496a9mr9453983b6e.2.1791217892851; Mon, 05 Oct 2026
 09:31:32 -0700 (PDT)
Date: Mon, 05 Oct 2026 09:31:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ac3d0e4.ae2c267a.265a6c.0002.GAE@google.com>
Subject: [syzbot] [mmc?] INFO: task hung in mmc_app_cmd
From: syzbot <syzbot+c6d8091b47243f2023b8@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, ulf.hansson@linaro.org, ulfh@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    940de590b839 Merge tag 'hardening-v7.3-rc2' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17e6f0f9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5c3949d762a91f
dashboard link: https://syzkaller.appspot.com/bug?extid=c6d8091b47243f2023b8
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/75055d1d5648/disk-940de590.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/419590aed71c/vmlinux-940de590.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c51c5e853b44/bzImage-940de590.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c6d8091b47243f2023b8@syzkaller.appspotmail.com

INFO: task kworker/1:2:984 blocked for more than 143 seconds.
      Tainted: G             L      syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:2     state:D stack:23584 pid:984   tgid:984   ppid:2      task_flags:0x4208060 flags:0x00080000
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
 mmc_app_cmd+0x170/0x340 drivers/mmc/core/sd_ops.c:64
 mmc_wait_for_app_cmd+0xbf/0x3a0 drivers/mmc/core/sd_ops.c:87
 sd_app_op_cond_cb+0xb9/0x220 drivers/mmc/core/sd_ops.c:152
 __mmc_poll_for_busy+0x109/0x230 drivers/mmc/core/mmc_ops.c:529
 mmc_send_app_op_cond+0x15a/0x270 drivers/mmc/core/sd_ops.c:189
 mmc_attach_sd+0xb8/0x3d0 drivers/mmc/core/sd.c:1854
 mmc_rescan_try_freq drivers/mmc/core/core.c:2138 [inline]
 mmc_rescan+0xcd5/0x11c0 drivers/mmc/core/core.c:2316
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
 process_scheduled_works kernel/workqueue.c:3479 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task kworker/0:5:5709 blocked for more than 143 seconds.
      Tainted: G             L      syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:5     state:D stack:20536 pid:5709  tgid:5709  ppid:2      task_flags:0x4288060 flags:0x00080000
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
locks held by kthreadd/2: 1, last CPU#0:
 #0: ffffffff8edec060 (rcu_read_lock){....}-{1:3}, at: raw_spin_rq_lock_nested kernel/sched/core.c:685 [inline]
 #0: ffffffff8edec060 (rcu_read_lock){....}-{1:3}, at: raw_spin_rq_lock_nested+0x88/0x140 kernel/sched/core.c:669
locks held by kworker/u8:0/12: 3, last CPU#0:
 #0: ffff8880358f4140 ((wq_completion)bat_events){+.+.}-{0:0}, at: process_one_work+0x1466/0x1b10 kernel/workqueue.c:3371
 #1: ffffc90000117d08 ((work_completion)(&(&bat_priv->mcast.work)->work)){+.+.}-{0:0}, at: process_one_work+0xa2c/0x1b10 kernel/workqueue.c:3372
 #2: ffffffff8edec060 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #2: ffffffff8edec060 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #2: ffffffff8edec060 (rcu_read_lock){....}-{1:3}, at: batadv_mcast_mla_meshif_get_ipv6 net/batman-adv/multicast.c:447 [inline]
 #2: ffffffff8edec060 (rcu_read_lock){....}-{1:3}, at: batadv_mcast_mla_meshif_get net/batman-adv/multicast.c:535 [inline]
 #2: ffffffff8edec060 (rcu_read_lock){....}-{1:3}, at: __batadv_mcast_mla_update net/batman-adv/multicast.c:912 [inline]
 #2: ffffffff8edec060 (rcu_read_lock){....}-{1:3}, at: batadv_mcast_mla_update+0x88a/0x3200 net/batman-adv/multicast.c:949
locks held by pr/ttyS0/16: 1, last CPU#0:
 #0: ffffffff8edd8338 (console_srcu){....}-{0:0}, at: rcu_try_lock_acquire include/linux/rcupdate.h:314 [inline]
 #0: ffffffff8edd8338 (console_srcu){....}-{0:0}, at: srcu_read_lock_nmisafe include/linux/srcu.h:439 [inline]
 #0: ffffffff8edd8338 (console_srcu){....}-{0:0}, at: console_srcu_read_lock+0x49/0x60 kernel/printk/printk.c:291
locks held by khungtaskd/32: 1, last CPU#0:
 #0: ffffffff8edec060 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffffffff8edec060 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8edec060 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x3d/0x184 kernel/locking/lockdep.c:6837
locks held by kworker/1:2/984: 2, on CPU#1:
 #0: ffff88801c056140 ((wq_completion)events_freezable){+.+.}-{0:0}, at: process_one_work+0x1466/0x1b10 kernel/workqueue.c:3371
 #1: ffffc90004b9fd08 ((work_completion)(&(&host->detect)->work)){+.+.}-{0:0}, at: process_one_work+0xa2c/0x1b10 kernel/workqueue.c:3372
locks held by syslogd/4955: 1, last CPU#0:
 #0: ffff88801f3f16f0 (&u->iolock){+.+.}-{4:4}, at: __unix_dgram_recvmsg+0x255/0xc30 net/unix/af_unix.c:2587
locks held by getty/5361: 2, on CPU#0:
 #0: ffff8880391650a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000321e2e8 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x419/0x14e0 drivers/tty/n_tty.c:2211
locks held by syz-executor/5621: 1, last CPU#0:
 #0: ffff8880351562e0 (&xt[i].mutex){+.+.}-{4:4}, at: xt_find_table_lock+0x5a/0x520 net/netfilter/x_tables.c:1336
locks held by syz-executor/5622: 4, last CPU#0:
 #0: ffffffff8ef3cc30 (dup_mmap_sem){++++}-{0:0}, at: dup_mm kernel/fork.c:1542 [inline]
 #0: ffffffff8ef3cc30 (dup_mmap_sem){++++}-{0:0}, at: copy_mm kernel/fork.c:1595 [inline]
 #0: ffffffff8ef3cc30 (dup_mmap_sem){++++}-{0:0}, at: copy_process+0x4806/0x8370 kernel/fork.c:2307
 #1: ffff88802e6bf678 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock_killable include/linux/mmap_lock.h:562 [inline]
 #1: ffff88802e6bf678 (&mm->mmap_lock){++++}-{4:4}, at: dup_mmap+0x127/0x2370 mm/mmap.c:1716
 #2: ffff8880202d5038 (&mm->mmap_lock/1){+.+.}-{4:4}, at: mmap_write_lock_nested include/linux/mmap_lock.h:552 [inline]
 #2: ffff8880202d5038 (&mm->mmap_lock/1){+.+.}-{4:4}, at: dup_mmap+0x1c9/0x2370 mm/mmap.c:1723
 #3: ffffffff8edec060 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #3: ffffffff8edec060 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #3: ffffffff8edec060 (rcu_read_lock){....}-{1:3}, at: __pte_offset_map+0x2f/0x310 mm/pgtable-generic.c:290
locks held by kworker/0:5/5709: 5, on CPU#0:
 #0: ffff8880236ef940 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x1466/0x1b10 kernel/workqueue.c:3371
 #1: ffffc900040a7d08 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0xa2c/0x1b10 kernel/workqueue.c:3372
 #2: ffff88802bb661d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #2: ffff88802bb661d8 (&dev->mutex){....}-{4:4}, at: hub_event+0x1bb/0x4420 drivers/usb/core/hub.c:5912
 #3: ffff88802aa041d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #3: ffff88802aa041d8 (&dev->mutex){....}-{4:4}, at: usb_disconnect+0x10a/0x9a0 drivers/usb/core/hub.c:2341
 #4: ffff88802aa011a0 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #4: ffff88802aa011a0 (&dev->mutex){....}-{4:4}, at: __device_driver_lock drivers/base/dd.c:1171 [inline]
 #4: ffff88802aa011a0 (&dev->mutex){....}-{4:4}, at: device_release_driver_internal+0xb2/0x620 drivers/base/dd.c:1369
locks held by kworker/1:7/5799: 5, on CPU#1:
 #0: ffff8880236ef940 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x1466/0x1b10 kernel/workqueue.c:3371
 #1: ffffc900048c7d08 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0xa2c/0x1b10 kernel/workqueue.c:3372
 #2: ffff88802b89c1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #2: ffff88802b89c1d8 (&dev->mutex){....}-{4:4}, at: hub_event+0x1bb/0x4420 drivers/usb/core/hub.c:5912
 #3: ffff88802b3d0568 (&port_dev->status_lock){+.+.}-{4:4}, at: usb_lock_port drivers/usb/core/hub.c:3265 [inline]
 #3: ffff88802b3d0568 (&port_dev->status_lock){+.+.}-{4:4}, at: hub_port_connect drivers/usb/core/hub.c:5477 [inline]
 #3: ffff88802b3d0568 (&port_dev->status_lock){+.+.}-{4:4}, at: hub_port_connect_change drivers/usb/core/hub.c:5720 [inline]
 #3: ffff88802b3d0568 (&port_dev->status_lock){+.+.}-{4:4}, at: port_event drivers/usb/core/hub.c:5884 [inline]
 #3: ffff88802b3d0568 (&port_dev->status_lock){+.+.}-{4:4}, at: hub_event+0x2b3e/0x4420 drivers/usb/core/hub.c:5966
 #4: ffff88802bc8a860 (hcd->address0_mutex){+.+.}-{4:4}, at: hub_port_connect drivers/usb/core/hub.c:5478 [inline]
 #4: ffff88802bc8a860 (hcd->address0_mutex){+.+.}-{4:4}, at: hub_port_connect_change drivers/usb/core/hub.c:5720 [inline]
 #4: ffff88802bc8a860 (hcd->address0_mutex){+.+.}-{4:4}, at: port_event drivers/usb/core/hub.c:5884 [inline]
 #4: ffff88802bc8a860 (hcd->address0_mutex){+.+.}-{4:4}, at: hub_event+0x2b67/0x4420 drivers/usb/core/hub.c:5966
locks held by udevd/5912: 1, last CPU#0:
 #0: ffffffff8edec060 (rcu_read_lock){....}-{1:3}
, at: raw_spin_rq_lock_nested+0x2c/0x140 kernel/sched/core.c:677
locks held by udevd/5916: 1, last CPU#1:
 #0: ffffffff8f906338 (tomoyo_ss){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:198 [inline]
 #0: ffffffff8f906338 (tomoyo_ss){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:305 [inline]
 #0: ffffffff8f906338 (tomoyo_ss){.+.+}-{0:0}, at: tomoyo_read_lock security/tomoyo/common.h:1112 [inline]
 #0: ffffffff8f906338 (tomoyo_ss){.+.+}-{0:0}, at: tomoyo_check_open_permission+0x169/0x3c0 security/tomoyo/file.c:772
locks held by kworker/0:12/6851: 4, last CPU#0:
 #0: ffff88801c057140 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x1466/0x1b10 kernel/workqueue.c:3371
 #1: ffffc90004d47d08 ((work_completion)(&rfkill->sync_work)){+.+.}-{0:0}, at: process_one_work+0xa2c/0x1b10 kernel/workqueue.c:3372
 #2: ffffffff911a5be0 (rfkill_global_mutex){+.+.}-{4:4}, at: rfkill_sync_work+0x1b/0x40 net/rfkill/core.c:1071
 #3: ffffffff91272200 (uevent_sock_mutex){+.+.}-{4:4}, at: uevent_net_broadcast_untagged lib/kobject_uevent.c:317 [inline]
 #3: ffffffff91272200 (uevent_sock_mutex){+.+.}-{4:4}, at: kobject_uevent_net_broadcast lib/kobject_uevent.c:410 [inline]
 #3: ffffffff91272200 (uevent_sock_mutex){+.+.}-{4:4}, at: kobject_uevent_env+0xba8/0x18b0 lib/kobject_uevent.c:611
locks held by syz.0.1283/10674: 1, last CPU#0:
 #0: ffff8880202d5038 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock_killable include/linux/mmap_lock.h:562 [inline]
 #0: ffff8880202d5038 (&mm->mmap_lock){++++}-{4:4}, at: vm_mmap_pgoff+0x1f5/0x470 mm/util.c:579
locks held by syz.4.1285/10677: 3, last CPU#1:
 #0: ffff8880390b57b0 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x2aa/0x380 fs/file.c:1259
 #1: ffff88804fff7998 (&p->lock){+.+.}-{4:4}, at: seq_read_iter+0xe1/0x1270 fs/seq_file.c:183
 #2: ffffffff8f058668 (namespace_sem){++++}-{4:4}, at: m_start+0x4e/0x210 fs/namespace.c:1541

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 32 Comm: khungtaskd Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/05/2026
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
CPU: 0 UID: 0 PID: 16 Comm: pr/ttyS0 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/05/2026
RIP: 0010:io_serial_in+0x87/0xb0 drivers/tty/serial/8250/8250_port.c:410
Code: 07 5c fc 48 8d 7d 40 44 89 e1 48 b8 00 00 00 00 00 fc ff df 48 89 fa d3 e3 48 c1 ea 03 80 3c 02 00 75 1a 66 03 5d 40 89 da ec <5b> 0f b6 c0 5d 41 5c c3 cc cc cc cc e8 48 1a cf fc eb a2 e8 d1 1a
RSP: 0018:ffffc90000157958 EFLAGS: 00000002
RAX: dffffc0000000000 RBX: 00000000000003fd RCX: 0000000000000000
RDX: 00000000000003fd RSI: ffffffff85afe8d0 RDI: ffffffff9bc63ca0
RBP: ffffffff9bc63c60 R08: 0000000000000001 R09: 000000000000001f
R10: 0000000000000000 R11: 205d323354202020 R12: 0000000000000000
R13: 0000000000000020 R14: fffffbfff378c7e9 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888123b61000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f38821556c8 CR3: 000000005afdf000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 serial_in drivers/tty/serial/8250/8250.h:128 [inline]
 serial_lsr_in drivers/tty/serial/8250/8250.h:150 [inline]
 wait_for_lsr+0x13a/0x210 drivers/tty/serial/8250/8250_port.c:2013
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
