Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB5435A393
	for <linux-mmc@vger.kernel.org>; Wed, 23 Sep 2026 03:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790134349; cv=none; b=j5SgdMDE8NhFh2ZtQmxqDXB1rcTI2EZZpKFzNsjOteD+yh6K1D8Kx57ZACJdLCdcrsI6yE9H18CEU3iGonPnKQ3jBHjvYPGvJzSPUSo8u18tmwwALq0wzUzGa2wwxySxPZjFB9ktKWbNgHk31+W1+9PcYm3v5nbPRovE2YaiXtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790134349; c=relaxed/simple;
	bh=LwPxSn6z8UiIL2XR/B/XxiBO7rUlTs9y3VQGDUoqfaE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YN4tFrxispFSHnwttmEnNjFpy2w52LeBPedGVRqOanQjlc/dCC7JXHAHe/9QjQBd83rbFMP/XgX3vLAl2tkb9hkEeVXNBQWUGXuVYMvPQEFmASQBcoOYiNsLKYSbj+4wYUOiD1fzG6OHXV00lOlWE3k+VxGCPdEgowklkhsE6aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4b1bc2e44e0so1026207b6e.0
        for <linux-mmc@vger.kernel.org>; Tue, 22 Sep 2026 20:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790134347; x=1790739147;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ecdzmKoPOIWDjnigL6sfHg7MhoBwWGqxm5KzrWcgv4g=;
        b=COc2UInuoUaNvzwrh0pcT6in14HJPI70lh/RQVc7Wc2L+SOzzUom5mxCkD8rqI/mQC
         qcdAR1pnXINv9GiBSeHmW54QuhnKYVvYEi5pI2zepx5nMEpeBkjQANnZ5G1RbbejcXef
         2U2YKHvUJuU69Y/EoqVqOCkid+RDRjWmRG2Y0T5vkpbcXA/5s16taKP07xkSvmPR+DfO
         xyVNLgPozTyiPVwIafZ1cWmhxUIQWz97E1EVPDB928ley97tX1JT84YS3PU0qpixnj0y
         nONHXWC8kqbEm7e+CwITGh0x3pDAq5N0axhteccPrQonWNNmXBglVIQbIDbhdfPi4Pv/
         tJmA==
X-Forwarded-Encrypted: i=1; AKwUvBwO0jI/Udnde+PfHZxiq4JuVyXMPlM47V2XRQmnQHE73si67GcwuIEKfmEGL6HxAWMCa+aYJta6Nds=@vger.kernel.org
X-Gm-Message-State: AFuF++kHnuHvooT7EaiokIh/6VQZjvkVeFDt3QHJwNd0udp6na0UVCh6
	MJPuxUgx8kxgnApHYI+iq7msFiUbcmiHUn1XGsyQq25sYKp33m0Agm+AFlsjTU3SOEpZCAn+Zfe
	vhgj2V1+j5QG2yDcmw23VkndUVw+LXddMapPV70MtGw62dgl51ffMTK2ojB8=
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:168b:b0:6b1:6f3d:2068 with SMTP id
 006d021491bc7-6d2cf849f68mr1292080eaf.12.1790134346778; Tue, 22 Sep 2026
 20:32:26 -0700 (PDT)
Date: Tue, 22 Sep 2026 20:32:26 -0700
In-Reply-To: <6aac8d73.87c06881.1db2b3.001e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ab3484a.71f81b7d.15fa6d.0046.GAE@google.com>
Subject: Re: [syzbot] [mmc?] [usb?] KASAN: slab-use-after-free Read in rtsx_usb_ms_handle_req
From: syzbot <syzbot+3ee5da0319ca17ef1f4e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-usb@vger.kernel.org, maximlevitsky@gmail.com, oakad@yahoo.com, 
	syzkaller-bugs@googlegroups.com, ulf.hansson@linaro.org, ulfh@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    c4e9f74da438 Merge tag 'v7.3-p5' of git://git.kernel.org/p..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=160ea515580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d012d9c67977ee4
dashboard link: https://syzkaller.appspot.com/bug?extid=3ee5da0319ca17ef1f4e
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15670d25580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3ee5da0319ca17ef1f4e@syzkaller.appspotmail.com

usb 5-1: New USB device found, idVendor=0bda, idProduct=0129, bcdDevice= 1.00
usb 5-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
==================================================================
BUG: KASAN: slab-use-after-free in rtsx_usb_ms_handle_req+0x173b/0x1a00 drivers/memstick/host/rtsx_usb_ms.c:528
Write of size 4 at addr ffff88802dba2074 by task kworker/2:4/5905

CPU: 2 UID: 0 PID: 5905 Comm: kworker/2:4 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: events rtsx_usb_ms_handle_req
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 rtsx_usb_ms_handle_req+0x173b/0x1a00 drivers/memstick/host/rtsx_usb_ms.c:528
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
 process_scheduled_works kernel/workqueue.c:3479 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 38:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x2f8/0x6d0 mm/slub.c:5563
 _kmalloc_noprof include/linux/slab.h:991 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 memstick_alloc_card drivers/memstick/core/memstick.c:383 [inline]
 memstick_check+0x2c1/0x10d0 drivers/memstick/core/memstick.c:452
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
 process_scheduled_works kernel/workqueue.c:3479 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 38:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2748 [inline]
 slab_free mm/slub.c:6508 [inline]
 kfree+0x22b/0x6d0 mm/slub.c:6801
 memstick_alloc_card drivers/memstick/core/memstick.c:420 [inline]
 memstick_check+0x72b/0x10d0 drivers/memstick/core/memstick.c:452
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
 process_scheduled_works kernel/workqueue.c:3479 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff88802dba2000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 116 bytes inside of
 freed 2048-byte region [ffff88802dba2000, ffff88802dba2800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88802dba5000 pfn:0x2dba0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000240 ffff88801c042f00 ffffea0000dda410 ffffea000074f410
raw: ffff88802dba5000 0000000000080006 00000000f5000000 0000000000000000
head: 00fff00000000240 ffff88801c042f00 ffffea0000dda410 ffffea000074f410
head: ffff88802dba5000 0000000000080006 00000000f5000000 0000000000000000
head: 00fff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5751, tgid 5751 (syz-executor), ts 52051381762
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1871
 prep_new_page mm/page_alloc.c:1879 [inline]
 get_page_from_freelist+0x110d/0x35d0 mm/page_alloc.c:3943
 __alloc_frozen_pages_noprof+0x2eb/0x3300 mm/page_alloc.c:5436
 alloc_slab_page mm/slub.c:3347 [inline]
 allocate_slab mm/slub.c:3462 [inline]
 new_slab+0xa9/0x6e0 mm/slub.c:3513
 refill_objects+0xe3/0x410 mm/slub.c:7417
 refill_sheaf mm/slub.c:2885 [inline]
 __pcs_replace_empty_main+0x35e/0x650 mm/slub.c:4774
 alloc_from_pcs mm/slub.c:4850 [inline]
 slab_alloc_node mm/slub.c:4984 [inline]
 __do_kmalloc_node mm/slub.c:5413 [inline]
 __kmalloc_noprof+0x67c/0x840 mm/slub.c:5439
 _kmalloc_noprof include/linux/slab.h:995 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 cache_create_net+0xa2/0x1f0 net/sunrpc/cache.c:1739
 unix_gid_cache_create+0x60/0x130 net/sunrpc/svcauth_unix.c:875
 sunrpc_init_net+0x71/0x1b0 net/sunrpc/sunrpc_syms.c:49
 ops_init+0x1e2/0x5f0 net/core/net_namespace.c:137
 setup_net+0x118/0x3a0 net/core/net_namespace.c:443
 copy_net_ns+0x345/0x7a0 net/core/net_namespace.c:582
 create_new_namespaces+0x3ea/0xac0 kernel/nsproxy.c:132
 unshare_nsproxy_namespaces+0xf2/0x220 kernel/nsproxy.c:234
 ksys_unshare+0x4a2/0xa70 kernel/fork.c:3295
page last free pid 5718 tgid 5718 ts 42990443667 stack trace:
 reset_page_owner include/linux/page_owner.h:26 [inline]
 __free_pages_prepare mm/page_alloc.c:1418 [inline]
 __free_frozen_pages+0x79f/0x10f0 mm/page_alloc.c:2962
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x47/0xf0 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x1a0/0x1f0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4683 [inline]
 slab_alloc_node mm/slub.c:4996 [inline]
 kmem_cache_alloc_noprof+0x269/0x6a0 mm/slub.c:5010
 alloc_filename fs/namei.c:147 [inline]
 do_getname+0x35/0x390 fs/namei.c:187
 class_filename_flags_constructor include/linux/fs.h:2586 [inline]
 do_sys_openat2+0xc7/0x1e0 fs/open.c:1416
 do_sys_open fs/open.c:1423 [inline]
 __do_sys_openat fs/open.c:1439 [inline]
 __se_sys_openat fs/open.c:1434 [inline]
 __x64_sys_openat+0x12d/0x210 fs/open.c:1434
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88802dba1f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802dba1f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88802dba2000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                             ^
 ffff88802dba2080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802dba2100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
