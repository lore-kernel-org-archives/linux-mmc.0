Received: from mail-oi2-f11.google.com (mail-oi2-f11.google.com [74.125.231.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C399530B53F
	for <linux-mmc@vger.kernel.org>; Tue, 25 Aug 2026 01:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787621867; cv=none; b=UI1fJBek4XJvFjEwzXdj+InKV8YR9BYGih+VpI+5C+AlBju8iNz48G0v7h0+Wl8jHjtqanqHx0IQbnktHzXRRp1mjSi4f/4zFxlTzh37ZqJK+PDm69falCAFCTvhH3FMUNYw+TF0H/s0Q5YwcCU31+3iPmPeUNSvx/FTAZQppoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787621867; c=relaxed/simple;
	bh=9Dw5zUP4FEQbfZad9C6UYP7+xUYXOAdRDpnna5GLKac=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rh98UnLpd56/my/lNdGmRfjyobHSMT0F4erUUuq8xF6ukF7vHQBQdh1mAKcjS+twKMZbeiE9E97C/C7B3tMpZSJ86UQfTOVkcaTSh4RFvBmBo4XR5FF53OZsqe/Go7tkO6ieCO3hLUmK2B+LITrMEFYmK4T9QEqhFtNJjMotm+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f11.google.com with SMTP id 5614622812f47-4af7193adb7so1370847b6e.0
        for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2026 18:37:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787621864; x=1788226664;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ycCjzGwowX5X5Ud8FvH0v8aZ95u8DKe9u08t1TKKXbk=;
        b=Fm9g8+00BZG3f18l5FbXz9T8g5vlAXU8JXkgo3jGAEBPoUkbJxPLRwoTwmUq72NKix
         7g0x0HSH3fNwhKKhQnmkNNg5Jybsz6ruougz5w9lKiEgbRlJAs91C5JaeV5u7PLSVjNW
         pyoyRrf8AzoDgkBg3Lf1KTL4CtwcQyJth8fGJTAyHOR1FRR9coXNpIqi/BU/Fx4LITPk
         bgnsvwzKggPmrqKwhT0ggVOu7qpw4jgSyIz1QZVXLD9JUycOHZn+Fb9OwAKiAdFGWWiU
         2WCYB1TNU0S7QF4KvDf8qdJIHo2kVXuGF51YMzVMrvz1SAIpBToiB5+fsr7T1yovYDFs
         VAFA==
X-Forwarded-Encrypted: i=1; AHgh+RrrI92/lnyosrNQ7h3A1E2ipcaxXGiD7XOkBe/9/3Jn4OsSyhh2l+5xlvn0q+9HhudSPdJFDu3HUB0=@vger.kernel.org
X-Gm-Message-State: AFuF++mvicQ7LuxXve89PXJbNhaVKvsMEb/sPBVWJIvLu1HRRa0u+A1n
	nzRtZ4HB9WN4gh6I/bPWkrb8DMvLHMWNN8zfVzpYG4xyX3DWhhygmTnlu07L3ipiSBIP/Dp7HJY
	D8efvZku2wYq3N2/M3FPA/RxHn4fsp8/IRDO2cDM0n05fobUon3NO7uaisek=
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2293:b0:4b2:98a3:a567 with SMTP id
 5614622812f47-4b2ef1bea44mr31947539b6e.4.1787621864696; Mon, 24 Aug 2026
 18:37:44 -0700 (PDT)
Date: Mon, 24 Aug 2026 18:37:44 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8cf1e8.dbb3a75c.7844.001a.GAE@google.com>
Subject: [syzbot] [kernel?] WARNING: ODEBUG bug in vub300_disconnect
From: syzbot <syzbot+f4a0159ce6802a0a4774@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, ulfh@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0a0d1d55dad5 Merge tag 'scftorture.2026.08.18a' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=126be415580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=335632b21d0ce540
dashboard link: https://syzkaller.appspot.com/bug?extid=f4a0159ce6802a0a4774
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b00b3ccadcaf/disk-0a0d1d55.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0e672b557a64/vmlinux-0a0d1d55.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b5c1ac823fac/bzImage-0a0d1d55.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f4a0159ce6802a0a4774@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: free active (active state 0) object: ffff888077279270 object type: timer_list hint: vub300_inactivity_timer_expired+0x0/0x3f0 include/linux/refcount.h:-1
WARNING: lib/debugobjects.c:632 at debug_print_object+0xec/0x230 lib/debugobjects.c:629, CPU#0: kworker/0:1/10
Modules linked in:
CPU: 0 UID: 0 PID: 10 Comm: kworker/0:1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Workqueue: usb_hub_wq hub_event
RIP: 0010:debug_print_object+0x18a/0x230 lib/debugobjects.c:629
Code: f8 48 c1 e8 03 80 3c 18 00 74 08 4c 89 ff e8 5d 6f 4f fd 4d 8b 0f 4c 89 ef 48 8b 74 24 08 48 89 ea 44 89 e1 4d 89 f0 ff 34 24 <67> 48 0f b9 3a 48 83 c4 08 ff 05 53 75 92 0b 48 83 c4 10 5b 41 5c
RSP: 0018:ffffc900000f7218 EFLAGS: 00010246
RAX: 1ffffffff181ede4 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: ffffffff8c6d6340 RSI: ffffffff8c6d5dc0 RDI: ffffffff9084da30
RBP: ffffffff8c6d6340 R08: ffff888077279270 R09: ffffffff8c0f8280
R10: dffffc0000000000 R11: ffffffff81b32b80 R12: 0000000000000000
R13: ffffffff9084da30 R14: ffff888077279270 R15: ffffffff8c0f6f20
FS:  0000000000000000(0000) GS:ffff888124cf3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5b6cbceff8 CR3: 000000000eb46000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 __debug_check_no_obj_freed lib/debugobjects.c:1171 [inline]
 debug_check_no_obj_freed+0x2e3/0x450 lib/debugobjects.c:1201
 slab_free_hook mm/slub.c:2609 [inline]
 slab_free mm/slub.c:6372 [inline]
 kfree+0x13e/0x640 mm/slub.c:6687
 device_release+0xc4/0x1f0 drivers/base/core.c:-1
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x222/0x550 lib/kobject.c:737
 vub300_delete drivers/mmc/host/vub300.c:379 [inline]
 kref_put include/linux/kref.h:65 [inline]
 vub300_disconnect+0x280/0x2f0 drivers/mmc/host/vub300.c:2388
 usb_unbind_interface+0x295/0x9f0 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:618 [inline]
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x4f5/0x880 drivers/base/dd.c:1372
 bus_remove_device+0x444/0x560 drivers/base/bus.c:664
 device_del+0x524/0x8f0 drivers/base/core.c:3965
 usb_disable_device+0x3d4/0x8d0 drivers/usb/core/message.c:1478
 usb_disconnect+0x346/0x9a0 drivers/usb/core/hub.c:2345
 hub_port_connect drivers/usb/core/hub.c:5415 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5715 [inline]
 port_event drivers/usb/core/hub.c:5879 [inline]
 hub_event+0x1bbb/0x4d30 drivers/usb/core/hub.c:5961
 process_one_work kernel/workqueue.c:3387 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3470
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3551
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
----------------
Code disassembly (best guess):
   0:	f8                   	clc
   1:	48 c1 e8 03          	shr    $0x3,%rax
   5:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1)
   9:	74 08                	je     0x13
   b:	4c 89 ff             	mov    %r15,%rdi
   e:	e8 5d 6f 4f fd       	call   0xfd4f6f70
  13:	4d 8b 0f             	mov    (%r15),%r9
  16:	4c 89 ef             	mov    %r13,%rdi
  19:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
  1e:	48 89 ea             	mov    %rbp,%rdx
  21:	44 89 e1             	mov    %r12d,%ecx
  24:	4d 89 f0             	mov    %r14,%r8
  27:	ff 34 24             	push   (%rsp)
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	48 83 c4 08          	add    $0x8,%rsp
  33:	ff 05 53 75 92 0b    	incl   0xb927553(%rip)        # 0xb92758c
  39:	48 83 c4 10          	add    $0x10,%rsp
  3d:	5b                   	pop    %rbx
  3e:	41 5c                	pop    %r12


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
