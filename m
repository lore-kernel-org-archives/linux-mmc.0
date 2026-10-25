Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792960370;
	b=bVa8Szl1XGOfG/j6Q+CbDpqoaE8Ss5yxm9MHYEPk+jba38ggYB1u/sLOKPGKb8m7Xw23
	 wKCdk5DsUlrufrmXZgqn2Yt++02pqyQ7MkJBHJL/08OmlF7OoexgK9nWb4aRlRY++LbVt
	 xTKu+L135gM7ifKHWAHD5mHPpBFkqL6xVwHF91BAXZlVVG8OXdIxnA3snzhJGaOtizfLC
	 r3hn2oMkLJ43ErWIj/rQrZoHe2ys0IdqSqCBHJLpCw0lHQdTkbD3R6SXK2IaUnCS4Z+kH
	 m6hieH6ud0Ygw/ZolUvMNkmCEWAMNdVjNGv6aCCI5jSNxwwvuwgXZwXPc9b7qr1aEeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792960370;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=m06jpghAmTAg4J5trRpXBGFbKvdwbzdWo7mkvNAM83I=;
	b=JvMaESdgx/qm2AZwKssx5w7KNyHr+ZswGHTraCfJXQDlKnOnSzjM8OKlmUBtqREg9ANX
	 eEhs6oXoydlS8NMQ+GODYfc8iuFJ1jG9uaGqpAzs/b5INs4aJt3cJyqyDJVkESLDScVNv
	 liSyPNQ7w59HXzWfv3VUergHvHYZzUascBHLW/dSGS/XKPK3cmx0G9vNsO/15V4Obhhkz
	 s2k9PhbN7T7o3ZIUgT6a/kC7VW6f6c2KVYVrt6FHGXuD2ubNcAbziby3IqrUUucFHtuXq
	 145A77vhhLrwLgHB5xCKT1LEYPg7EBNwMeLRVZoSm19t6RhrHFH/kY4MrU4/MtKR/cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D716606A31B
	for <linux-mmc@vger.kernel.org>; Sun, 25 Oct 2026 20:32:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D716606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4cc89e86e4dso3885870b6e.2
        for <linux-mmc@vger.kernel.org>; Sun, 25 Oct 2026 13:32:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792960369; x=1793565169;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m06jpghAmTAg4J5trRpXBGFbKvdwbzdWo7mkvNAM83I=;
        b=Pmi/W7Mk9zSEspZVQfxp9nZx8fdbZNGFN4duZAIGjn28ZTomz1S/ItfK6WwsKTcoll
         sazLKrWEV38J3wYJ34yPTlm2c+KLSfK9JsNno8sw4U20jybBwHiZxW9ccBD5Vyd+eRrn
         bbxdvw52TliZJ5Jhzvm5m8YvQpfkH3ZFqxmCE1xokPtYoDttPYwua+xgzOtbH3lIjrgF
         eKDPuFlT9VVItAghlG9uxiK8ABfcEEsdVs4HrFVSgnF1nLhYk7yYue880skDB0domtJ/
         9gFjAwclzuPKMntfbDds0sB4YCi3KYhBtnNhVvS5/VgT0Jq6KWRvLF5iu/RqicWOxUXG
         5D7Q==
X-Forwarded-Encrypted: i=1; AKwUvBwtDLOfRgdCsnPS26Wr8iNtxeGyV6ouAFH1mn4DhtS+dlNVI8VdiV2lwFdkRsF6UjltOcokTLY1ABE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKMtdlCUnXT8KvzJvMArGe2FCqSuJCB97pmyvk66XFntpHk3DhR
	hVukqTjEXRhnljbtjztdvmvjo11GFqOwMv1ab90+V7mk+oxY3lR6D9CM/RyBzE+vlQt7BthONwt
	DU6N52dcMl3fe7IEdOpb99tKOFkyUw2dalejuPIm+jW7U4oZZZ8qwfqqQLVI=
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:bc9:b0:4f5:77f:5 with SMTP id 5614622812f47-55c00242278mr3205733b6e.41.1792960369094;
 Sun, 25 Oct 2026 13:32:49 -0700 (PDT)
Date: Sun, 25 Oct 2026 13:32:49 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ade6771.4ce6c07b.2dfc0c.000b.GAE@google.com>
Subject: [syzbot] [mmc?] INFO: task hung in __mmc_send_op_cond_cb
From: syzbot <syzbot+b5a34078de484f06145c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	ulf.hansson@linaro.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    bdf12cde3083 usb: gadget: dummy_hcd: prevent unbind via sy..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=1599fb3e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5b0f112b6a5be5fa
dashboard link: https://syzkaller.appspot.com/bug?extid=b5a34078de484f06145c
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/72018a922be9/disk-bdf12cde.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/536c72282fba/vmlinux-bdf12cde.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5b4965094e0b/bzImage-bdf12cde.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b5a34078de484f06145c@syzkaller.appspotmail.com

INFO: task kworker/1:0:24 blocked for more than 143 seconds.
      Not tainted syzkall
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:0     state:D stack:21160 pid:24    tgid:24    ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: events_freezable mmc_rescan
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5533 [inline]
 __schedule+0x1325/0x47e0 kernel/sched/core.c:7284
 __schedule_loop kernel/sched/core.c:7361 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7376
 schedule_timeout+0x1b2/0x280 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:100 [inline]
 __wait_for_common+0x2e7/0x4c0 kernel/sched/completion.c:121
 mmc_wait_for_req_done+0xcd/0x3d0 drivers/mmc/core/core.c:408
 mmc_wait_for_req+0x207/0x2c0 drivers/mmc/core/core.c:619
 mmc_wait_for_cmd+0x154/0x200 drivers/mmc/core/core.c:645
 __mmc_send_op_cond_cb+0x94/0x2b0 drivers/mmc/core/mmc_ops.c:200
 __mmc_poll_for_busy+0x109/0x230 drivers/mmc/core/mmc_ops.c:529
 mmc_send_op_cond+0x13d/0x260 drivers/mmc/core/mmc_ops.c:245
 mmc_attach_mmc+0x107/0x420 drivers/mmc/core/mmc.c:2411
 mmc_rescan_try_freq drivers/mmc/core/core.c:2142 [inline]
 mmc_rescan+0x914/0x11c0 drivers/mmc/core/core.c:2316
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
 process_scheduled_works kernel/workqueue.c:3479 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x69f/0xc90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task kworker/1:5:5304 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:5     state:D stack:20288 pid:5304  tgid:5304  ppid:2      task_flags:0x4288060 flags:0x00080000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5533 [inline]
 __schedule+0x1325/0x47e0 kernel/sched/core.c:7284
 __schedule_loop kernel/sched/core.c:7361 [inline]
 schedule+0xdd/0x2c0 kernel/sched/core.c:7376
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
 usb_unbind_interface+0x1dd/0x9b0 drivers/usb/core/driver.c:460
 device_remove drivers/base/dd.c:618 [inline]
 device_remove+0x12a/0x180 drivers/base/dd.c:610
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x44e/0x620 drivers/base/dd.c:1372
 bus_remove_device+0x2bc/0x560 drivers/base/bus.c:664
 device_del+0x376/0x9b0 drivers/base/core.c:3965
 usb_disable_device+0x367/0x810 drivers/usb/core/message.c:1484
 usb_disconnect+0x2e2/0x9a0 drivers/usb/core/hub.c:2355
 hub_port_connect drivers/usb/core/hub.c:5425 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5725 [inline]
 port_event drivers/usb/core/hub.c:5889 [inline]
 hub_event+0x1d46/0x4510 drivers/usb/core/hub.c:5971
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
 process_scheduled_works kernel/workqueue.c:3479 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x69f/0xc90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Showing all locks held in the system:
locks held by pr/ttyS0/15: 2, last CPU#0:
 #0: ffffffff898d3238 (console_srcu){....}-{0:0}, at: rcu_try_lock_acquire include/linux/rcupdate.h:314 [inline]
 #0: ffffffff898d3238 (console_srcu){....}-{0:0}, at: srcu_read_lock_nmisafe include/linux/srcu.h:439 [inline]
 #0: ffffffff898d3238 (console_srcu){....}-{0:0}, at: console_srcu_read_lock+0x49/0x60 kernel/printk/printk.c:291
 #1: ffffffff944998f8 (&port_lock_key){-.-.}-{3:3}, at: __uart_port_lock_irqsave include/linux/serial_core.h:613 [inline]
 #1: ffffffff944998f8 (&port_lock_key){-.-.}-{3:3}, at: univ8250_console_device_lock+0x64/0xc0 drivers/tty/serial/8250/8250_core.c:413
locks held by kworker/1:0/24: 2, on CPU#1:
 #0: ffff88810006a140 ((wq_completion)events_freezable){+.+.}-{0:0}, at: process_one_work+0x1466/0x1b10 kernel/workqueue.c:3371
 #1: ffffc9000019fd18 ((work_completion)(&(&host->detect)->work)){+.+.}-{0:0}, at: process_one_work+0xa2c/0x1b10 kernel/workqueue.c:3372
locks held by khungtaskd/31: 1, last CPU#1:
 #0: ffffffff898e6f20 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffffffff898e6f20 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff898e6f20 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x3d/0x184 kernel/locking/lockdep.c:6871
locks held by getty/2930: 2, on CPU#0:
 #0: ffff8881125cd0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900000452e8 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x419/0x14e0 drivers/tty/n_tty.c:2211
locks held by kworker/0:4/5254: 6, on CPU#0:
 #0: ffff888105effd40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x1466/0x1b10 kernel/workqueue.c:3371
 #1: ffffc9000265fd18 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0xa2c/0x1b10 kernel/workqueue.c:3372
 #2: ffff88810ab341d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #2: ffff88810ab341d8 (&dev->mutex){....}-{4:4}, at: hub_event+0x1bb/0x4510 drivers/usb/core/hub.c:5917
 #3: ffff88810abb9560 (&port_dev->status_lock){+.+.}-{4:4}, at: usb_lock_port drivers/usb/core/hub.c:3270 [inline]
 #3: ffff88810abb9560 (&port_dev->status_lock){+.+.}-{4:4}, at: hub_port_connect drivers/usb/core/hub.c:5482 [inline]
 #3: ffff88810abb9560 (&port_dev->status_lock){+.+.}-{4:4}, at: hub_port_connect_change drivers/usb/core/hub.c:5725 [inline]
 #3: ffff88810abb9560 (&port_dev->status_lock){+.+.}-{4:4}, at: port_event drivers/usb/core/hub.c:5889 [inline]
 #3: ffff88810abb9560 (&port_dev->status_lock){+.+.}-{4:4}, at: hub_event+0x2c08/0x4510 drivers/usb/core/hub.c:5971
 #4: ffff88810a7ca560 (hcd->address0_mutex){+.+.}-{4:4}, at: hub_port_connect drivers/usb/core/hub.c:5483 [inline]
 #4: ffff88810a7ca560 (hcd->address0_mutex){+.+.}-{4:4}, at: hub_port_connect_change drivers/usb/core/hub.c:5725 [inline]
 #4: ffff88810a7ca560 (hcd->address0_mutex){+.+.}-{4:4}, at: port_event drivers/usb/core/hub.c:5889 [inline]
 #4: ffff88810a7ca560 (hcd->address0_mutex){+.+.}-{4:4}, at: hub_event+0x2c31/0x4510 drivers/usb/core/hub.c:5971
 #5: ffffffff8a54a6c8 (ehci_cf_port_reset_rwsem){.+.+}-{4:4}, at: hub_port_reset+0x1a1/0x1d20 drivers/usb/core/hub.c:3085
locks held by kworker/1:5/5304: 5, on CPU#1:
 #0: ffff888105effd40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x1466/0x1b10 kernel/workqueue.c:3371
 #1: ffffc9000277fd18 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0xa2c/0x1b10 kernel/workqueue.c:3372
 #2: ffff88810abbc1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #2: ffff88810abbc1d8 (&dev->mutex){....}-{4:4}, at: hub_event+0x1bb/0x4510 drivers/usb/core/hub.c:5917
 #3: ffff88813bb171d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #3: ffff88813bb171d8 (&dev->mutex){....}-{4:4}, at: usb_disconnect+0x10a/0x9a0 drivers/usb/core/hub.c:2346
 #4: ffff88813523f1a0 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #4: ffff88813523f1a0 (&dev->mutex){....}-{4:4}, at: __device_driver_lock drivers/base/dd.c:1171 [inline]
 #4: ffff88813523f1a0 (&dev->mutex){....}-{4:4}, at: device_release_driver_internal+0xb2/0x620 drivers/base/dd.c:1369
locks held by kworker/1:6/5320: 5, on CPU#1:
 #0: ffff888105effd40 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x1466/0x1b10 kernel/workqueue.c:3371
 #1: ffffc900021efd18 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0xa2c/0x1b10 kernel/workqueue.c:3372
 #2: ffff88810a7ac1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #2: ffff88810a7ac1d8 (&dev->mutex){....}-{4:4}, at: hub_event+0x1bb/0x4510 drivers/usb/core/hub.c:5917
 #3: ffff88810568b1d8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #3: ffff88810568b1d8 (&dev->mutex){....}-{4:4}, at: __device_attach+0x7e/0x4d0 drivers/base/dd.c:1073
 #4: ffff8881192041a0 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #4: ffff8881192041a0 (&dev->mutex){....}-{4:4}, at: __device_attach+0x7e/0x4d0 drivers/base/dd.c:1073

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 31 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(lazy) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/07/2026
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
 ret_from_fork+0x69f/0xc90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 15 Comm: pr/ttyS0 Not tainted syzkaller #0 PREEMPT(lazy) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/07/2026
RIP: 0010:io_serial_in+0x87/0xb0 drivers/tty/serial/8250/8250_port.c:410
Code: ba 82 fe 48 8d 7d 40 44 89 e1 48 b8 00 00 00 00 00 fc ff df 48 89 fa d3 e3 48 c1 ea 03 80 3c 02 00 75 1a 66 03 5d 40 89 da ec <5b> 0f b6 c0 5d 41 5c c3 cc cc cc cc e8 b8 ec ed fe eb a2 e8 41 ed
RSP: 0018:ffffc900000ff968 EFLAGS: 00000002
RAX: dffffc0000000000 RBX: 00000000000003fd RCX: 0000000000000000
RDX: 00000000000003fd RSI: ffffffff83327400 RDI: ffffffff94499920
RBP: ffffffff944998e0 R08: 0000000000000001 R09: 000000000000001f
R10: 0000000000000000 R11: 205d313354202020 R12: 0000000000000000
R13: 0000000000000020 R14: fffffbfff2893379 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8882683d5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c38a975 CR3: 00000001365b2000 CR4: 00000000003506f0
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
 ret_from_fork+0x69f/0xc90 arch/x86/kernel/process.c:158
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
