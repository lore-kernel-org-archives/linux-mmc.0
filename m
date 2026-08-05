Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387BF472F85
	for <linux-mmc@vger.kernel.org>; Wed,  5 Aug 2026 22:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785969929; cv=none; b=m0eJxcWO+2t16h7yhhZURAKjiYiUXmJkOlN9JHYSnb5vEq4ZY0Kxq2oRH7F5Sf6lNkuCkCi5/qcNaDrI5Z0JD4lV2u5pkDhZdnTfvc/GFIGhZiHLWlS+sOJ/ZdeFbERb2a8VKoyDGdix1SnToVKK2u0U5EGN9a2mabOYyYMmhFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785969929; c=relaxed/simple;
	bh=HZRU2ZXDWYvTGj6FPddSa0j4xqL46MTlqpKgVL7FGRE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hoVOAP6jlC782AYC6NKzuedCUzPAzWpwO0RHOlR4jJo27Qmk0704hnweyLuND2GQ1vnSrSa0iKp3/9ACtqAMtIPTabqMZfLPgDNqEcxItnv3je/8hnh7bYtO8JclXzKxaHlJ16c9+m1GhFrzakPcn6D8Ee1OCkn0F5z59EqpFpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-456b5122c7cso408794fac.1
        for <linux-mmc@vger.kernel.org>; Wed, 05 Aug 2026 15:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785969926; x=1786574726;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y/qeFsKJEk6EKelj90ymJzacqOB6y4VN3qxT1UM1R8Q=;
        b=TGhJnRBqJ7TOPPQY+a3zQMsAvcUrLAqX93lt0QcNnIwI9ngvllN/ZuUrEJcwY0qs+U
         z9p7yahprJRY8CIqfmFgRryeJnYnt90G+AQxgycboa8xWPjEshTZ8De5K5YASB2LM8l9
         Osmn7cmvim/kb67rr77e3WvqDS2ygIJcULrmDO3yLNrNeU8TgeZQKZTIpTNpcjjyq46o
         bbeEm8JmA7BN3pAxfHA+8NeZmILfQpoVAXVo4blZEHLanpMQPqU0sbH/9Ek+j4hQbCx8
         xG0GR9bMOhE96kM22aljv1Fv4sRPAhiugmxt0DPLOvPYp4kZA339L/HewpI+0315LvwG
         BJ1A==
X-Forwarded-Encrypted: i=1; AHgh+RqIjBJWLF6jJgTNwdVnquyJ9sNRScO1660TMi+cZ/lO/d9AbJoB14wh2IrxTR/Gewf723E1f9gSMH0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+mRGuAK/ooIH1BaM/g6ERNOL7GruYjjLH/EdUQdgVty/jOlAf
	rzyOuUF3iIgoeOAunrh2cJtesRV1DAqIB2XVlyYd6oiXvRRMx4Wdu3WRNpPOKMeVj+iHwZYplWG
	1VzO6ksjOs8Yf3idQh7LtYOORa9X0q9VOlcjg/wc7YAUVDJGrWToLIUbSqSc=
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:290b:b0:6aa:e367:a3e2 with SMTP id
 006d021491bc7-6aeb24fa433mr1568849eaf.19.1785969926036; Wed, 05 Aug 2026
 15:45:26 -0700 (PDT)
Date: Wed, 05 Aug 2026 15:45:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a73bd06.5aeeccc9.207e63.0006.GAE@google.com>
Subject: [syzbot] [usb?] BUG: sleeping function called from invalid context in cancel_delayed_work_sync
From: syzbot <syzbot+1ee4f3b9228e35f14677@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com, ulfh@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5d5fd841c346 Merge 7.2-rc5 into usb-next
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=10b47649580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6ec4d592e55f7960
dashboard link: https://syzkaller.appspot.com/bug?extid=1ee4f3b9228e35f14677
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17e47e32580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d64bb9580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2ed536ae4daf/disk-5d5fd841.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ab40098ccbf1/vmlinux-5d5fd841.xz
kernel image: https://storage.googleapis.com/syzbot-assets/66d5c395f47c/bzImage-5d5fd841.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1ee4f3b9228e35f14677@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at kernel/workqueue.c:4487
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 2983, name: syz-execprog
preempt_count: 100, expected: 0
RCU nest depth: 0, expected: 0
1 lock held by syz-execprog/2983:
 #0: ffffc90000537be8 ((&vub300->inactivity_timer)){+.-.}-{0:0}, at: call_timer_fn+0x11f/0x610 kernel/time/timer.c:1745
Preemption disabled at:
[<ffffffff81772c20>] softirq_handle_begin kernel/softirq.c:463 [inline]
[<ffffffff81772c20>] handle_softirqs+0xf0/0x990 kernel/softirq.c:598
CPU: 0 UID: 0 PID: 2983 Comm: syz-execprog Not tainted syzkaller #0 PREEMPT(lazy) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 __might_resched.cold+0x1ec/0x232 kernel/sched/core.c:9197
 __cancel_work_sync kernel/workqueue.c:4487 [inline]
 cancel_delayed_work_sync+0xb8/0xf0 kernel/workqueue.c:4568
 mmc_free_host+0x19/0x30 drivers/mmc/core/host.c:700
 vub300_delete drivers/mmc/host/vub300.c:379 [inline]
 kref_put include/linux/kref.h:65 [inline]
 vub300_inactivity_timer_expired drivers/mmc/host/vub300.c:747 [inline]
 vub300_inactivity_timer_expired+0x42f/0x550 drivers/mmc/host/vub300.c:742
 call_timer_fn+0x19a/0x610 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers+0x757/0xb00 kernel/time/timer.c:2374
 __run_timer_base kernel/time/timer.c:2386 [inline]
 __run_timer_base kernel/time/timer.c:2378 [inline]
 run_timer_base+0x114/0x190 kernel/time/timer.c:2395
 run_timer_softirq+0x1a/0x50 kernel/time/timer.c:2405
 handle_softirqs+0x1dd/0x990 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x160/0x210 kernel/softirq.c:735
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:752
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0x42/0xb0 arch/x86/kernel/apic/apic.c:1062
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0033:0x476b32
Code: 0c 0f b6 48 09 f6 c1 01 74 20 f6 c1 04 74 1b 48 83 78 18 00 7e 14 83 e1 fb 88 48 09 48 8b 48 48 ba ff ff ff ff f0 0f c1 51 24 <0f> b6 48 09 90 f6 c1 01 75 1d 48 83 78 18 00 7e 16 80 78 0a 00 74
RSP: 002b:00003a4df9efdec8 EFLAGS: 00000257
RAX: 00003a4dfa0fc2b0 RBX: 0000000000000001 RCX: 00003a4df9ec1570
RDX: 0000000000000001 RSI: 0000000000000080 RDI: 0000000000000018
RBP: 00003a4df9efdee8 R08: 00003a4dfa0fc1c0 R09: 0000000000000000
R10: 00003a4dfe15c838 R11: 00003a4dfe15e180 R12: 00003a4dfe15e180
R13: 0000000000000001 R14: 00003a4dfa37cf00 R15: 0000000000000001
 </TASK>
BUG: scheduling while atomic: syz-execprog/2983/0x00000101
1 lock held by syz-execprog/2983:
 #0: ffffc90000537be8 ((&vub300->inactivity_timer)){+.-.}-{0:0}, at: call_timer_fn+0x11f/0x610 kernel/time/timer.c:1745
Modules linked in:
Preemption disabled at:
[<ffffffff81772c20>] softirq_handle_begin kernel/softirq.c:463 [inline]
[<ffffffff81772c20>] handle_softirqs+0xf0/0x990 kernel/softirq.c:598


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
