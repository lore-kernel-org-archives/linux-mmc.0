Received: from mail-oo2-f11.google.com (mail-oo2-f11.google.com [74.125.231.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FD92512C8
	for <linux-mmc@vger.kernel.org>; Sun,  6 Sep 2026 00:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788654278; cv=none; b=pOyIE+C5PzD0v+geyxYfud8mKQqf8q1IW3mqNnxsv42OleFmQTGG0XBiBzi+BiQfN9TDXguhP+Jf5CrgVawgPMoKnY3JX7EmUbiJRyxHMkFINIdcAI1rGQlTSl8eiBqa19TiBHf7Od25jB9HiDwUA0hPJMRHc3uzK2bib+5u/J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788654278; c=relaxed/simple;
	bh=8yBfIaVCKkFtBGdNziL6Ub3E/07/sjtEFZcY5kv2NU8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aaVssQluOY/8n5O4CUNzpIJUp502nzKa5Ytwjd5EkLgbzFqz42traWNgW7WDTR8dLIHpF4pIjkj6c7xuikTTUuEzRJ9dAxepqLRWHOvaR8qXQWc07jbj9cEE9CU2RzwsVL/sHEeSwFRW9GzxH8cR7ngc+d9LQQagtY3Af/geEsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo2-f11.google.com with SMTP id 006d021491bc7-6aaf6076546so1200229eaf.1
        for <linux-mmc@vger.kernel.org>; Sat, 05 Sep 2026 17:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788654275; x=1789259075;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XMcV92eNZSSR8R0sqktgYFUedPdRG6GXkBf/Ho7XOj0=;
        b=nLAaDmkKfB6OPw7Y4ZLLgBZVphovdB8yu1LHc1GBwR2YCI7O+OBoxoEEShX1oWExE/
         Z04HOm5Anzezzmy1wE73sq6CPY9iYT5FWw/wI0hCIEbzJmS9KTJ81t6WFj4ZEg1PBouH
         dUmd9np2M39Zm3WskpXdh/CHZvQZJ+anIaP28E4ATsWS8xiQM9m5i9df0mYuPNNHs6eR
         iDRwnOEjdmJoCqyzzXPNqs9LRDPbO4hNBZjKJ1tHW0x/1rvpJoiAz7GdRL6/GpQrTfPV
         3h85e16odBHIc8hEYgbvfc8T3mOBsTIMqHn8CVrAp/9TvtqyeNulkBXFrM1WPthCEx7v
         Ms2g==
X-Forwarded-Encrypted: i=1; AKwUvBxofd8MiEXxgKyHI5/FJqUKe9wy5pBqdmKQLjot2YkkGwNgOwD9ztuWBfOIplW3uvN4cD9QI/jMLyw=@vger.kernel.org
X-Gm-Message-State: AFuF++kc4ceoR0vVt+SCkXt0YfFOQDTvaoYGpUwIv90gXIoEs6XslA5k
	H7ot5AAinN8lYNBQd1YodTme5xeqXW4b1/EOLa1Kr09bOkzA79iKnr0hftcZqCi24S5q08urg9w
	8HdmH2v7klQH8pHOoc0JdTQXnWrtsKmB5fJD+mUOK0HA7mY3jIpbN/16Kyh0=
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1894:b0:6ae:8fc0:dbaf with SMTP id
 006d021491bc7-6b6f98d0006mr10468151eaf.1.1788654275245; Sat, 05 Sep 2026
 17:24:35 -0700 (PDT)
Date: Sat, 05 Sep 2026 17:24:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a9cb2c3.a5e650b3.26d8a.0013.GAE@google.com>
Subject: [syzbot] [mmc?] KASAN: slab-use-after-free Read in mmc_host_classdev_release
From: syzbot <syzbot+f312381a95cc080992fd@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	ulf.hansson@linaro.org, ulfh@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5704a4065c2c usb: typec: mux: gpio-sbu: enable when only u..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=128ed779580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c451f9f64434b622
dashboard link: https://syzkaller.appspot.com/bug?extid=f312381a95cc080992fd
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0b09fe5d8020/disk-5704a406.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/53db10338c28/vmlinux-5704a406.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b978629971dd/bzImage-5704a406.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f312381a95cc080992fd@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in mmc_host_classdev_release+0xfb/0x120 drivers/mmc/core/host.c:70
Read of size 8 at addr ffff88813b57a4c0 by task kworker/u8:1/8349

CPU: 0 UID: 0 PID: 8349 Comm: kworker/u8:1 Not tainted syzkaller #0 PREEMPT(lazy) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Workqueue: kvub300d vub300_deadwork_thread
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 mmc_host_classdev_release+0xfb/0x120 drivers/mmc/core/host.c:70
 device_release+0xd2/0x270 drivers/base/core.c:2640
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1f7/0x640 lib/kobject.c:737
 put_device+0x1f/0x30 drivers/base/core.c:3884
 vub300_delete drivers/mmc/host/vub300.c:379 [inline]
 kref_put include/linux/kref.h:65 [inline]
 vub300_deadwork_thread+0x22c/0x550 drivers/mmc/host/vub300.c:739
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3387
 process_scheduled_works kernel/workqueue.c:3470 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3551
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x69f/0xc90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 5304:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x8f/0xa0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x2d8/0x680 mm/slub.c:5563
 _kmalloc_noprof include/linux/slab.h:991 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 usb_alloc_dev+0x55/0x1090 drivers/usb/core/usb.c:651
 hub_port_connect drivers/usb/core/hub.c:5483 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5720 [inline]
 port_event drivers/usb/core/hub.c:5884 [inline]
 hub_event+0x2c5d/0x4510 drivers/usb/core/hub.c:5966
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3387
 process_scheduled_works kernel/workqueue.c:3470 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3551
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x69f/0xc90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 8349:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x43/0x70 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2748 [inline]
 slab_free mm/slub.c:6499 [inline]
 kfree+0x20c/0x650 mm/slub.c:6792
 device_release+0xd2/0x270 drivers/base/core.c:2640
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1f7/0x640 lib/kobject.c:737
 put_device+0x1f/0x30 drivers/base/core.c:3884
 usb_put_dev+0x23/0x30 drivers/usb/core/usb.c:790
 vub300_delete drivers/mmc/host/vub300.c:378 [inline]
 kref_put include/linux/kref.h:65 [inline]
 vub300_deadwork_thread+0x224/0x550 drivers/mmc/host/vub300.c:739
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3387
 process_scheduled_works kernel/workqueue.c:3470 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3551
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x69f/0xc90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff88813b57a000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1216 bytes inside of
 freed 2048-byte region [ffff88813b57a000, ffff88813b57a800)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x13b578
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
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2000(__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 24, tgid 24 (kworker/1:0), ts 125638469489
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
 usb_set_configuration+0x10cb/0x1c60 drivers/usb/core/message.c:2096
 usb_generic_driver_probe+0xa1/0xe0 drivers/usb/core/generic.c:250
 usb_probe_device+0xef/0x400 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x210/0x460 drivers/base/dd.c:868
 driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
 __device_attach_driver+0x1df/0x320 drivers/base/dd.c:1026
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
 __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1098
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88813b57a380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88813b57a400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88813b57a480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                           ^
 ffff88813b57a500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88813b57a580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
