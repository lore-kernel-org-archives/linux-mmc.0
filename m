Received: from mail-oo2-f4.google.com (mail-oo2-f4.google.com [74.125.231.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB732F7445
	for <linux-mmc@vger.kernel.org>; Wed, 23 Sep 2026 00:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790123606; cv=none; b=YH+TDL1hW3PZAzFdnkBxXAP+VLqk58SkgGqbCbeEbNI+oGB3obs+4RUKCwe5u0kvkBWIa3S6+mo0yDWSQD6PQjjGE1Xu8gxHwa0iccKsIk87pei5kvj5Tr1kmp1EY8GlFNm59uESG+sY15qyAYiF+LTpLLg/bkFlVPF5Vl8Pupg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790123606; c=relaxed/simple;
	bh=sUo0eeU9dqLm3x/b4GdwnnnVIPDwHP9vuivKkMgRwQM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DNPgG4mF3A5ipUX5JRW/hTYkTPoohIj+LmNzw4U2nyasSLfVxBdNxMNYx+mdTP7H36o6HDVtcRpics17p2rF1X3YN/RDwVvGMaxVuwB82+WpEqAlQQhzqRzBO0+ZDEkNx94ATTOsidOnnEVVq5zGbrqtAIQG6H6687J4aNNsAWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo2-f4.google.com with SMTP id 006d021491bc7-6d26562298dso135130eaf.0
        for <linux-mmc@vger.kernel.org>; Tue, 22 Sep 2026 17:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790123604; x=1790728404;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=26acOs9A2D4oBmB7TKWMEDIcWIuf7VT+CiNnxN/eHn0=;
        b=RTbGkqkaenSKqjwYgXVpaeGeeEESwqhuMOQjylvUWAeStcfLrVxKJ7SrZQU2QXegJ4
         KZtFK0BYDtJ8VXU2gVU/7sgvQjJD/puH3JGKsJ0h56Ws3pufca5i4/GCQJgjqCnx17uf
         OH55mLBHUTLwlh5vLlsY3PS97HrsljtrAy7yUM8ZXubch1ZxxprYXnu0lrdfdFuO4Hmu
         pYWsAH+uOrjkI/U2sNzR0umlgo08ZZFGyeTHuw7TN0P0dPtbMsFhZjqGnj4FeLerU+cU
         hg0eTl1pHxBWAl88HccyiZMTTvyi6em77mtaejz8LcqkY7kd0IqmVdWcTRf1AN6bjqAO
         UuIA==
X-Forwarded-Encrypted: i=1; AKwUvBy5Y4pNQ2PIogbfrrl6EYdydOuKz1y7Y1nHoFzu6P7TVWmkrjWqQzokUxmLK+tdoEIpNYcU1wsudhs=@vger.kernel.org
X-Gm-Message-State: AFuF++k7svPtdD4z9ZdzjBpgYtorVNz6nWoIanl8s0HGojC0j3CWfGHQ
	S1HpsbO+l3SSqWYesPnhsVLUy+s3FBFpkYzvfJzHa0ChQPXgPVW8cGEHfHGvt5smiSJ0TYUYVuH
	GVQ50Lj5GmSTHOL7UWTN+aYlQueINJkUVMc4gCH4Cp1aH80+vPzMKkJTsSaE=
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1524:b0:6cd:3fdb:fa65 with SMTP id
 006d021491bc7-6d2d3908806mr979955eaf.80.1790123603977; Tue, 22 Sep 2026
 17:33:23 -0700 (PDT)
Date: Tue, 22 Sep 2026 17:33:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ab31e53.3179f8cd.1e36b2.002e.GAE@google.com>
Subject: [syzbot] [mmc?] KASAN: slab-use-after-free Write in ms_read_bytes
From: syzbot <syzbot+ccffdf05833ebdaeae70@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-usb@vger.kernel.org, maximlevitsky@gmail.com, oakad@yahoo.com, 
	syzkaller-bugs@googlegroups.com, ulf.hansson@linaro.org, ulfh@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d58dffe9ee2c USB: core: amend usb_get_from_anchor() kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=112d0515580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c451f9f64434b622
dashboard link: https://syzkaller.appspot.com/bug?extid=ccffdf05833ebdaeae70
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/424c61cbb872/disk-d58dffe9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4124586dc97c/vmlinux-d58dffe9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a07e8e384dc4/bzImage-d58dffe9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ccffdf05833ebdaeae70@syzkaller.appspotmail.com

=========
==================================================================
BUG: KASAN: slab-use-after-free in ms_read_bytes+0x8fe/0x990 drivers/memstick/host/rtsx_usb_ms.c:450
Write of size 1 at addr ffff88813c188079 by task kworker/1:5/5239

CPU: 1 UID: 0 PID: 5239 Comm: kworker/1:5 Not tainted syzkaller #0 PREEMPT(lazy) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Workqueue: events rtsx_usb_ms_handle_req
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 ms_read_bytes+0x8fe/0x990 drivers/memstick/host/rtsx_usb_ms.c:450
 rtsx_usb_ms_issue_cmd drivers/memstick/host/rtsx_usb_ms.c:477 [inline]
 rtsx_usb_ms_handle_req+0x557/0x1a00 drivers/memstick/host/rtsx_usb_ms.c:531
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
 process_scheduled_works kernel/workqueue.c:3479 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x69f/0xc90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 1662:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x8f/0xa0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x2d8/0x680 mm/slub.c:5563
 _kmalloc_noprof include/linux/slab.h:991 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 memstick_alloc_card drivers/memstick/core/memstick.c:383 [inline]
 memstick_check+0x2c1/0x10d0 drivers/memstick/core/memstick.c:452
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
 process_scheduled_works kernel/workqueue.c:3479 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x69f/0xc90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 1662:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x43/0x70 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2748 [inline]
 slab_free mm/slub.c:6499 [inline]
 kfree+0x20c/0x650 mm/slub.c:6792
 memstick_alloc_card drivers/memstick/core/memstick.c:420 [inline]
 memstick_check+0x72b/0x10d0 drivers/memstick/core/memstick.c:452
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
 process_scheduled_works kernel/workqueue.c:3479 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x69f/0xc90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff88813c188000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 121 bytes inside of
 freed 2048-byte region [ffff88813c188000, ffff88813c188800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x13c188
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x200000000000040(head|node=0|zone=2)
page_type: f5(slab)
raw: 0200000000000040 ffff888100042000 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
head: 0200000000000040 ffff888100042000 dead000000000100 dead000000000122
head: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
head: 0200000000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 24, tgid 24 (kworker/1:0), ts 137296809400
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1871
 prep_new_page mm/page_alloc.c:1879 [inline]
 get_page_from_freelist+0xf4b/0x3440 mm/page_alloc.c:3943
 __alloc_frozen_pages_noprof+0x2d7/0x2f70 mm/page_alloc.c:5436
 alloc_slab_page mm/slub.c:3347 [inline]
 allocate_slab mm/slub.c:3462 [inline]
 new_slab+0xa9/0x6e0 mm/slub.c:3513
 refill_objects+0xe3/0x410 mm/slub.c:7410
 refill_sheaf mm/slub.c:2885 [inline]
 __pcs_replace_empty_main+0x35e/0x650 mm/slub.c:4774
 alloc_from_pcs mm/slub.c:4850 [inline]
 slab_alloc_node mm/slub.c:4984 [inline]
 __kmalloc_cache_noprof+0x4a1/0x680 mm/slub.c:5559
 _kmalloc_noprof include/linux/slab.h:991 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 usb_alloc_dev+0x55/0x1090 drivers/usb/core/usb.c:651
 hub_port_connect drivers/usb/core/hub.c:5483 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5720 [inline]
 port_event drivers/usb/core/hub.c:5884 [inline]
 hub_event+0x2c5d/0x4510 drivers/usb/core/hub.c:5966
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
 process_scheduled_works kernel/workqueue.c:3479 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x69f/0xc90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88813c187f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88813c187f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88813c188000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                                ^
 ffff88813c188080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88813c188100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


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
