Received: from mail-oo2-f9.google.com (mail-oo2-f9.google.com [74.125.231.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3601E22D7A9
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 01:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789090591; cv=none; b=qq3+3q/J8eB6YX2xh2BNdL+g9EoJRI8jG4r+NZGxnOTmCyoO5hUfrWe6nkzkCIYLxEjs+Nae6FSCbOiM0+FidIjXGpAr32c9lC6P1rZX5b5KN5X2BTp0kq5qUSXU2mIP3uoiyAmZG06suiHkD7CBmADmOeNtxnr+rA7kfftfFqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789090591; c=relaxed/simple;
	bh=BB7Gl15MXHCcPsnX4WqgCaOztB/VT6j6MK2ZPrqYqVc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cTNM0dLRKBGEoGLXK/bl6n0hJ1AOge+IewL0wO5baNPh3HIty3AnyZ0z3nMkRjo4qAA7ae0X7v1ua1YkrztP/kw1oliyO9y1LD5NbODabWzuAEdqIkmws9ZEJKuWGs0mq+McvYZMwpafz/2pM1UGieiFwPFDXLWmkOIhiVnDZqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo2-f9.google.com with SMTP id 006d021491bc7-6b136fad4b3so158180eaf.0
        for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 18:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789090589; x=1789695389;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OmIJxuqhMc+KW+/bAmiatf3OfQ3XnThy/KVMRH75/F0=;
        b=H3SJIhTc1QaZrYWGrVVRP5wRehbYLzcXgfXdNxtZw3qIhthS8jAwrWM3NgkRf61BS0
         HvFIxthggbzpQC6QDLwtW56Q9HG1ruV2Z5gvWjIA/maSPC0cbw3eLWSlPCxA3eIBT8wZ
         gVgBr5cy+DPSOiO8PpkSs5zW98XwMcGZ91UoimuLCxlxfMtc2v9WQ64UCuIj+ZQdb7s6
         AyF5o5mRdF5g55LFU0v0g48lrYIZU2KVdl+H0ghQRFFkRyrJlfmOxJHHrcxQV6qcvh7o
         /HCSOMwrupsY1+CIVtoTpZMkAE7jQUtDfs8lCHWZVh7x67o1cbUjhCk94h50jn22hbPF
         JJXA==
X-Forwarded-Encrypted: i=1; AKwUvBxrS8INsSlaBoE+mtQzOJmTkC4lWI6Lnpe1jd95G8XadxDOuhGk6Mu/HZA6P521j3HS7ruuGcB+c20=@vger.kernel.org
X-Gm-Message-State: AFuF++nj6csd/YpKwQctgenx1gv1pNcOwjKJTpEHUuZ2VjFgfBRcLjnD
	xwTQPDKmTql2i+DZtEXwyvneyvV99OmPYMPCchTbEmlE91oA4c5FZmHZIGy06lT/rtOJFXzb0o4
	Dgrrq5T+OiAuBNJlHq2cNixpRtROfQk3O6R3VxJAIDVwJrHbmGpzwWOktGZE=
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:7084:20b0:6be:7782:5a51 with SMTP id
 006d021491bc7-6c0ba8280afmr1637387eaf.10.1789090589215; Thu, 10 Sep 2026
 18:36:29 -0700 (PDT)
Date: Thu, 10 Sep 2026 18:36:29 -0700
In-Reply-To: <6a8cf1e8.dbb3a75c.7844.001a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aa35b1d.6e6c5f9e.28f11f.003c.GAE@google.com>
Subject: Re: [syzbot] [mmc?] WARNING: ODEBUG bug in vub300_disconnect
From: syzbot <syzbot+f4a0159ce6802a0a4774@syzkaller.appspotmail.com>
To: cjb@laptop.org, dakr@kernel.org, driver-core@lists.linux.dev, 
	gregkh@linuxfoundation.org, johan@kernel.org, lgs201920130244@gmail.com, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, rafael@kernel.org, 
	runyu.xiao@seu.edu.cn, syzkaller-bugs@googlegroups.com, 
	tony.olech@elandigitalsystems.com, ulf.hansson@linaro.org, ulfh@kernel.org, 
	yogeshgaur.83@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    50d05c7c76c9 Merge tag 'landlock-7.3-rc3' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=142f5615580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85bc5cc2fc7394d9
dashboard link: https://syzkaller.appspot.com/bug?extid=f4a0159ce6802a0a4774
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122f5615580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-50d05c7c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/303a0ade8f9e/vmlinux-50d05c7c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/70b8ca71442b/bzImage-50d05c7c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f4a0159ce6802a0a4774@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: free active (active state 0) object: ffff888014529270 object type: timer_list hint: vub300_inactivity_timer_expired+0x0/0x550 drivers/mmc/host/vub300.c:1447
WARNING: lib/debugobjects.c:629 at debug_print_object+0x198/0x2b0 lib/debugobjects.c:629, CPU#1: kworker/1:4/6022
Modules linked in:
CPU: 1 UID: 0 PID: 6022 Comm: kworker/1:4 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: usb_hub_wq hub_event
RIP: 0010:debug_print_object+0x1a5/0x2b0 lib/debugobjects.c:629
Code: b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 4f 48 8d 3d 88 ce 1d 0c 41 56 48 8b 14 ed 40 3e 62 8c 4c 89 e6 <67> 48 0f b9 3a 58 83 05 e2 00 13 0c 01 48 83 c4 18 5b 5d 41 5c 41
RSP: 0000:ffffc900039d73c8 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffffc900039d74b0 RCX: 0000000000000000
RDX: ffffffff8c623d80 RSI: ffffffff8c623920 RDI: ffffffff91505580
RBP: 0000000000000003 R08: ffff888014529270 R09: ffffffff8bf31160
R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff8c623920
R13: ffffffff8bf311a0 R14: ffffffff88c79960 R15: ffffc900039d74c8
FS:  0000000000000000(0000) GS:ffff888096a60000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000361bf60 CR3: 000000004fa35000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 __debug_check_no_obj_freed lib/debugobjects.c:1171 [inline]
 debug_check_no_obj_freed+0x4da/0x630 lib/debugobjects.c:1201
 slab_free_hook mm/slub.c:2679 [inline]
 slab_free mm/slub.c:6499 [inline]
 kfree+0x3d6/0x6d0 mm/slub.c:6792
 device_release+0xd2/0x270 drivers/base/core.c:2640
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1f7/0x640 lib/kobject.c:737
 put_device+0x1f/0x30 drivers/base/core.c:3884
 vub300_delete drivers/mmc/host/vub300.c:379 [inline]
 kref_put.constprop.0.isra.0+0x159/0x1d0 include/linux/kref.h:65
 vub300_disconnect+0x136/0x170 drivers/mmc/host/vub300.c:2388
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
----------------
Code disassembly (best guess):
   0:	b8 00 00 00 00       	mov    $0x0,%eax
   5:	00 fc                	add    %bh,%ah
   7:	ff                   	lcall  (bad)
   8:	df 48 89             	fisttps -0x77(%rax)
   b:	fa                   	cli
   c:	48 c1 ea 03          	shr    $0x3,%rdx
  10:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
  14:	75 4f                	jne    0x65
  16:	48 8d 3d 88 ce 1d 0c 	lea    0xc1dce88(%rip),%rdi        # 0xc1dcea5
  1d:	41 56                	push   %r14
  1f:	48 8b 14 ed 40 3e 62 	mov    -0x739dc1c0(,%rbp,8),%rdx
  26:	8c
  27:	4c 89 e6             	mov    %r12,%rsi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	58                   	pop    %rax
  30:	83 05 e2 00 13 0c 01 	addl   $0x1,0xc1300e2(%rip)        # 0xc130119
  37:	48 83 c4 18          	add    $0x18,%rsp
  3b:	5b                   	pop    %rbx
  3c:	5d                   	pop    %rbp
  3d:	41 5c                	pop    %r12
  3f:	41                   	rex.B


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
