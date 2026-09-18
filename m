Received: from mail-oi2-f4.google.com (mail-oi2-f4.google.com [74.125.231.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF10357CF3
	for <linux-mmc@vger.kernel.org>; Fri, 18 Sep 2026 01:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789693302; cv=none; b=Bw8MLgZKM/wRJlwiXlOpMuEscg8QvAdfH1G7u4G+IVCaGnmxclDog4AQND+n/BtujfJUNBduYqVFpkBY0Yj/35cJ0cQ2nUv+l+QCpeRFC0HVqT3+zK+HgAJ0rqVzw5JOu44w/iqxSQ7EJuKOlya9xMA+oj2847S1wDG3JoaL4RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789693302; c=relaxed/simple;
	bh=63t47ASy4Pqaw2rxcNVymf+q8JkG0Jgq8Egv5JlxqXs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=O621y2ZcophneuDDKoj8EVRZay7j1zJBdjSUkEzC3DQgghd57vjqNJgUNPrCTE+aKdENHSzzMHTT83i6ZzWe1ABhrN4OPMmLxBM/ubG6G5jfY7EjrRBRHYjSUDi0biYzWp4BEmbzIWKTzDBaHwSOwkd+nLelUfU5V6gbFFVjxB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f4.google.com with SMTP id 5614622812f47-4ab2d72ff13so97772b6e.0
        for <linux-mmc@vger.kernel.org>; Thu, 17 Sep 2026 18:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789693300; x=1790298100;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hnmcEZw6N9pgwLjSmO5GPULj7Drde3nmSPgE8fUPnbQ=;
        b=D8Ixkvh+/mOQfsxJ/rNr2m2Bm3nWk4Xtr0weJSkeCWiZ9MxncQhuZzWNzw1TtNFlrx
         2ZQtq5y58/T1aBnLmPDfBorKXPhop7eRpOZJ6R5rIsJNDbizMX5dn/MeUM+c5h17jPoS
         pagaWteaGZp4En1P7YhZxNYFNOaioFDvaefuZ7jDn+xYX3iGvoobo4oMfCLFNtzEIZo+
         8bfT68OWY8Y1yO09l2OWMyhZ+403bGfX8UWfqsiMYkTg0/gpXWDfwLDuIvkdIJ9Pa8w1
         LEPpxnai7AGpAViF4VloQQquykLwKcbkzTupEgS6kEvww3p8FyPUrcslXBrQf4seECJG
         sP+w==
X-Forwarded-Encrypted: i=1; AKwUvByehMDA91nI7ZQFW8N7aSqse1RlHj07hhSmsITwkLNneg7tbvkZb30Q07/NvMZN8BH0A4P04E+++BI=@vger.kernel.org
X-Gm-Message-State: AFuF++lGsIyO/6vfYlBrigMtwzTxhe4+iKPsl6O4/Aqysu7MYw7rdwDP
	+ADC0gL5B4e7u2r3axktKNmZA8L8U+hj/fVce3xtjSc5OFfMuzCSW1llChgKeUpRkrS1BZgd6xp
	QQvXOLxJSR+avB7jWC3tZGYnCKOGebTnDiGm+A/bN2xtSlOYQ0sdnuwhb0/8=
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:5392:b0:4c3:b6cb:da26 with SMTP id
 5614622812f47-4ccf840c6dcmr1110640b6e.37.1789693299770; Thu, 17 Sep 2026
 18:01:39 -0700 (PDT)
Date: Thu, 17 Sep 2026 18:01:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aac8d73.87c06881.1db2b3.001e.GAE@google.com>
Subject: [syzbot] [mmc?] [usb?] KASAN: slab-use-after-free Read in rtsx_usb_ms_handle_req
From: syzbot <syzbot+3ee5da0319ca17ef1f4e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-usb@vger.kernel.org, maximlevitsky@gmail.com, oakad@yahoo.com, 
	syzkaller-bugs@googlegroups.com, ulf.hansson@linaro.org, ulfh@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d58dffe9ee2c USB: core: amend usb_get_from_anchor() kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=101538c9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c451f9f64434b622
dashboard link: https://syzkaller.appspot.com/bug?extid=3ee5da0319ca17ef1f4e
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10a39bf9580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/424c61cbb872/disk-d58dffe9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4124586dc97c/vmlinux-d58dffe9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a07e8e384dc4/bzImage-d58dffe9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3ee5da0319ca17ef1f4e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in rtsx_usb_ms_issue_cmd drivers/memstick/host/rtsx_usb_ms.c:486 [inline]
BUG: KASAN: slab-use-after-free in rtsx_usb_ms_handle_req+0x17ff/0x1a00 drivers/memstick/host/rtsx_usb_ms.c:531
Read of size 1 at addr ffff888120c35071 by task kworker/1:0/24

CPU: 1 UID: 0 PID: 24 Comm: kworker/1:0 Not tainted syzkaller #0 PREEMPT(lazy) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Workqueue: events rtsx_usb_ms_handle_req
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 rtsx_usb_ms_issue_cmd drivers/memstick/host/rtsx_usb_ms.c:486 [inline]
 rtsx_usb_ms_handle_req+0x17ff/0x1a00 drivers/memstick/host/rtsx_usb_ms.c:531
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
 process_scheduled_works kernel/workqueue.c:3479 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x69f/0xc90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 12:
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

Freed by task 12:
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

The buggy address belongs to the object at ffff888120c35000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 113 bytes inside of
 freed 2048-byte region [ffff888120c35000, ffff888120c35800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x120c30
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
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 2865, tgid 2865 (udevd), ts 24097723903
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
 __do_kmalloc_node mm/slub.c:5413 [inline]
 __kmalloc_node_track_caller_noprof+0x634/0x820 mm/slub.c:5545
 kmalloc_reserve+0xe8/0x350 net/core/skbuff.c:637
 __alloc_skb+0x185/0x710 net/core/skbuff.c:715
 alloc_skb include/linux/skbuff.h:1384 [inline]
 netlink_alloc_large_skb+0x69/0x150 net/netlink/af_netlink.c:1185
 netlink_sendmsg+0x680/0xda0 net/netlink/af_netlink.c:1875
 sock_sendmsg_nosec net/socket.c:800 [inline]
 __sock_sendmsg net/socket.c:815 [inline]
 ____sys_sendmsg+0xa4d/0xbe0 net/socket.c:2713
 ___sys_sendmsg+0x190/0x1e0 net/socket.c:2767
 __sys_sendmsg+0x160/0x210 net/socket.c:2799
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x119/0x710 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888120c34f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888120c34f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888120c35000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                             ^
 ffff888120c35080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888120c35100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
