Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAC9480320
	for <linux-mmc@vger.kernel.org>; Fri, 14 Aug 2026 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786720293; cv=none; b=CvgZv7WmE2jB3yGk7xUiZ/ILsp5D8ydl1v861QutNR8hHyX9eqo2XgiNsF2FfVt4XEpoQomlluxSfH0mm824tlyr6wXZqQdNaSFVyqLM2UK0ucj0vH+tp2wD+wRyO/y0eodo401riwsasRcmdfbJSpXACVQSPuZywvFCKVaOZJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786720293; c=relaxed/simple;
	bh=/ZrmtC2pVKkk+Fgrao8x+BBCzcnQ5vlH+XOL5czNtDc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HtHcNJD87xBVY3W6j6SiMxgXPbqldj+oN6qhd8rCLIXmktWKnpqToKcQmfUM4a05XIvQRYuteUoFTSUzO9s0ChXYOraLbCqQalVSotacHlY6jwLMus1D7GRjvbdAoMM18R1JCl1PqMU2pPnPQtQDoxnRQhhUB1cSyQOniLepehU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7eb89852728so800870a34.3
        for <linux-mmc@vger.kernel.org>; Fri, 14 Aug 2026 08:11:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786720289; x=1787325089;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ckS03SzjPkKNDuc+6LezxBOebF0DwUwc/THgl/tiQUA=;
        b=FVWWRzTuC2dJr4hAwF0AanZl8qz3hT/BnkswVPuZwDOM8p6RuoNk37KOWwN+UWYICM
         ATiK8Ye0FfJnuRkNVGXmixVbDyi4yMZBOAcGzSy9uouUJR9FFS9VUlhK4v/CZaSqMtDs
         nezM+N3+uV5KAS6nZmFq4cU6qAic97vfyVoLVMqnGJGANJdC5xPv+2A4F4NSmdFv8pOF
         cAqAycA+6UJFHbWiq0QuuTAKMVHezjV26Kb459RxPl3LFb8sOaRTGZy8c6dA6Qp5ll9a
         v8A2dJlCtntDroYrMkSabKMdXT7wpLmuswSgDcdvJE2IwoNAaMyvuYDSJS3o+wjjs4vG
         VgyA==
X-Forwarded-Encrypted: i=1; AHgh+RqkORYh69yPlQjdtikpc/wyD/nkMWoTchuFNnFVa/bUGrizSTz9zwOVkGeBr+Ojb8OvNFFrWzqJZlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJnDlWGWSkiiENui76BErmNwCqjXyL8k7Tb+ttMuupvO8dCNbx
	bh0Cjwynf2HosCeQ6nEIEPu8lUnAUbmlxalyYG/aobxg34En2ocsahxBwljDun2AaOqXZiX6qfU
	n+/dcTWGpOXxAt4/nl6dHjWXcWj53cUzqnSPWfJ7fgQbFS5uoUI78EWebXts=
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:201b:b0:6b0:589e:42f4 with SMTP id
 006d021491bc7-6b0d6245e3bmr5390234eaf.20.1786720288815; Fri, 14 Aug 2026
 08:11:28 -0700 (PDT)
Date: Fri, 14 Aug 2026 08:11:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7f3020.5ca1970b.32aa76.0004.GAE@google.com>
Subject: [syzbot] [mmc?] WARNING: suspicious RCU usage in cancel_delayed_work_sync
From: syzbot <syzbot+9c1988bc953fca2086a3@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	ulf.hansson@linaro.org, ulfh@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    05abeffcc27e Merge tag 'usb-serial-7.3-rc1' of ssh://gitol..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=172cfac6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8bdeea7ee6735f91
dashboard link: https://syzkaller.appspot.com/bug?extid=9c1988bc953fca2086a3
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f63099341558/disk-05abeffc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2f8181068028/vmlinux-05abeffc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7d35739c76eb/bzImage-05abeffc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9c1988bc953fca2086a3@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
syzkaller #0 Not tainted
-----------------------------
kernel/sched/core.c:9159 Illegal context switch in RCU-sched read-side critical section!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
9 locks held by syz-executor/2973:
 #0: ffffffff89823d10 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mm kernel/fork.c:1542 [inline]
 #0: ffffffff89823d10 (dup_mmap_sem){.+.+}-{0:0}, at: copy_mm kernel/fork.c:1595 [inline]
 #0: ffffffff89823d10 (dup_mmap_sem){.+.+}-{0:0}, at: copy_process+0x498b/0x7dd0 kernel/fork.c:2289
 #1: ffff888123fdceb8 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock_killable include/linux/mmap_lock.h:554 [inline]
 #1: ffff888123fdceb8 (&mm->mmap_lock){++++}-{4:4}, at: dup_mmap+0x11f/0x1f60 mm/mmap.c:1739
 #2: ffff888118e9e7b8 (&mm->mmap_lock/1){+.+.}-{4:4}, at: mmap_write_lock_nested include/linux/mmap_lock.h:544 [inline]
 #2: ffff888118e9e7b8 (&mm->mmap_lock/1){+.+.}-{4:4}, at: dup_mmap+0x1ba/0x1f60 mm/mmap.c:1746
 #3: ffffffff896e2bc0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #3: ffffffff896e2bc0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #3: ffffffff896e2bc0 (rcu_read_lock){....}-{1:3}, at: __pte_offset_map+0x2f/0x300 mm/pgtable-generic.c:290
 #4: ffff88810cf5e8b8 (ptlock_ptr(ptdesc)#2){+.+.}-{3:3}, at: spin_lock include/linux/spinlock.h:342 [inline]
 #4: ffff88810cf5e8b8 (ptlock_ptr(ptdesc)#2){+.+.}-{3:3}, at: pte_offset_map_lock+0x10f/0x320 mm/pgtable-generic.c:404
 #5: ffffffff896e2bc0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #5: ffffffff896e2bc0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #5: ffffffff896e2bc0 (rcu_read_lock){....}-{1:3}, at: __pte_offset_map+0x2f/0x300 mm/pgtable-generic.c:290
 #6: ffff888123d09f18 (ptlock_ptr(ptdesc)#2/1){+.+.}-{3:3}, at: copy_pte_range mm/memory.c:1272 [inline]
 #6: ffff888123d09f18 (ptlock_ptr(ptdesc)#2/1){+.+.}-{3:3}, at: copy_pmd_range mm/memory.c:1408 [inline]
 #6: ffff888123d09f18 (ptlock_ptr(ptdesc)#2/1){+.+.}-{3:3}, at: copy_pud_range mm/memory.c:1445 [inline]
 #6: ffff888123d09f18 (ptlock_ptr(ptdesc)#2/1){+.+.}-{3:3}, at: copy_p4d_range mm/memory.c:1469 [inline]
 #6: ffff888123d09f18 (ptlock_ptr(ptdesc)#2/1){+.+.}-{3:3}, at: copy_page_range+0xcc2/0x56a0 mm/memory.c:1555
 #7: ffffffff896e2b00 (rcu_read_lock_sched){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #7: ffffffff896e2b00 (rcu_read_lock_sched){....}-{1:2}, at: rcu_read_lock_sched include/linux/rcupdate.h:938 [inline]
 #7: ffffffff896e2b00 (rcu_read_lock_sched){....}-{1:2}, at: pfn_valid+0xbc/0x4a0 include/linux/mmzone.h:2270
 #8: ffffc90000007ca0 ((&vub300->inactivity_timer)){+.-.}-{0:0}, at: call_timer_fn+0x11f/0x610 kernel/time/timer.c:1745

stack backtrace:
CPU: 0 UID: 0 PID: 2973 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(lazy) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 lockdep_rcu_suspicious.cold+0x4f/0xb1 kernel/locking/lockdep.c:6876
 __might_resched+0x2e0/0x330 kernel/sched/core.c:9159
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
 sysvec_apic_timer_interrupt+0x8f/0xb0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:check_preemption_disabled+0x26/0xe0 lib/smp_processor_id.c:54
Code: 90 90 90 90 41 54 55 53 48 83 ec 08 65 8b 1d 65 1f 82 05 65 f7 05 56 1f 82 05 ff ff ff 7f 74 0f 48 83 c4 08 89 d8 5b 5d 41 5c <c3> cc cc cc cc 9c 58 f6 c4 02 74 ea 65 4c 8b 25 1e 1f 82 05 48 89
RSP: 0018:ffffc90001457430 EFLAGS: 00000286
RAX: 0000000000000000 RBX: 0000000000125cae RCX: ffffffff82216929
RDX: ffff8881236b0000 RSI: ffffffff87b15680 RDI: ffffffff87b156c0
RBP: ffff88823ff5d480 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000001
R13: ffff88823ff5e000 R14: dffffc0000000000 R15: 0000000000000000
 rcu_is_watching_curr_cpu include/linux/context_tracking.h:128 [inline]
 rcu_is_watching+0x12/0xc0 kernel/rcu/tree.c:752
 rcu_read_lock_sched include/linux/rcupdate.h:939 [inline]
 pfn_valid+0x2d0/0x4a0 include/linux/mmzone.h:2270
 page_table_check_set+0x25/0x580 mm/page_table_check.c:105
 __page_table_check_ptes_set+0x217/0x270 mm/page_table_check.c:223
 page_table_check_ptes_set include/linux/page_table_check.h:83 [inline]
 set_ptes include/linux/pgtable.h:447 [inline]
 __copy_present_ptes mm/memory.c:1118 [inline]
 copy_present_ptes mm/memory.c:1197 [inline]
 copy_pte_range mm/memory.c:1320 [inline]
 copy_pmd_range mm/memory.c:1408 [inline]
 copy_pud_range mm/memory.c:1445 [inline]
 copy_p4d_range mm/memory.c:1469 [inline]
 copy_page_range+0x1c87/0x56a0 mm/memory.c:1555
 dup_mmap+0xcd8/0x1f60 mm/mmap.c:1840
 dup_mm kernel/fork.c:1543 [inline]
 copy_mm kernel/fork.c:1595 [inline]
 copy_process+0x4996/0x7dd0 kernel/fork.c:2289
 kernel_clone+0x176/0x9d0 kernel/fork.c:2748
 __do_sys_clone+0xd9/0x120 kernel/fork.c:2889
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x10b/0x7f0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2fd1056b52
Code: 89 e7 e8 71 8b f7 ff 45 31 c0 31 d2 31 f6 64 48 8b 04 25 10 00 00 00 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 66 89 c5 85 c0 75 3b 64 48 8b 04 25 10 00 00
RSP: 002b:00007ffc26622180 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007ffc26622180 RCX: 00007f2fd1056b52
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 00007ffc2662230c R08: 0000000000000000 R09: 0000000000000001
R10: 000055558a3997d0 R11: 0000000000000246 R12: 0000000000000000
R13: 00000000000927c0 R14: 000000000001c243 R15: 00007ffc26622360
 </TASK>
BUG: sleeping function called from invalid context at kernel/workqueue.c:4487
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 2973, name: syz-executor
preempt_count: 104, expected: 0
RCU nest depth: 2, expected: 0
9 locks held by syz-executor/2973:
 #0: ffffffff89823d10 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mm kernel/fork.c:1542 [inline]
 #0: ffffffff89823d10 (dup_mmap_sem){.+.+}-{0:0}, at: copy_mm kernel/fork.c:1595 [inline]
 #0: ffffffff89823d10 (dup_mmap_sem){.+.+}-{0:0}, at: copy_process+0x498b/0x7dd0 kernel/fork.c:2289
 #1: ffff888123fdceb8 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock_killable include/linux/mmap_lock.h:554 [inline]
 #1: ffff888123fdceb8 (&mm->mmap_lock){++++}-{4:4}, at: dup_mmap+0x11f/0x1f60 mm/mmap.c:1739
 #2: ffff888118e9e7b8 (&mm->mmap_lock/1){+.+.}-{4:4}, at: mmap_write_lock_nested include/linux/mmap_lock.h:544 [inline]
 #2: ffff888118e9e7b8 (&mm->mmap_lock/1){+.+.}-{4:4}, at: dup_mmap+0x1ba/0x1f60 mm/mmap.c:1746
 #3: ffffffff896e2bc0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #3: ffffffff896e2bc0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #3: ffffffff896e2bc0 (rcu_read_lock){....}-{1:3}, at: __pte_offset_map+0x2f/0x300 mm/pgtable-generic.c:290
 #4: ffff88810cf5e8b8 (ptlock_ptr(ptdesc)#2){+.+.}-{3:3}, at: spin_lock include/linux/spinlock.h:342 [inline]
 #4: ffff88810cf5e8b8 (ptlock_ptr(ptdesc)#2){+.+.}-{3:3}, at: pte_offset_map_lock+0x10f/0x320 mm/pgtable-generic.c:404
 #5: ffffffff896e2bc0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #5: ffffffff896e2bc0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #5: ffffffff896e2bc0 (rcu_read_lock){....}-{1:3}, at: __pte_offset_map+0x2f/0x300 mm/pgtable-generic.c:290
 #6: ffff888123d09f18 (ptlock_ptr(ptdesc)#2/1){+.+.}-{3:3}, at: copy_pte_range mm/memory.c:1272 [inline]
 #6: ffff888123d09f18 (ptlock_ptr(ptdesc)#2/1){+.+.}-{3:3}, at: copy_pmd_range mm/memory.c:1408 [inline]
 #6: ffff888123d09f18 (ptlock_ptr(ptdesc)#2/1){+.+.}-{3:3}, at: copy_pud_range mm/memory.c:1445 [inline]
 #6: ffff888123d09f18 (ptlock_ptr(ptdesc)#2/1){+.+.}-{3:3}, at: copy_p4d_range mm/memory.c:1469 [inline]
 #6: ffff888123d09f18 (ptlock_ptr(ptdesc)#2/1){+.+.}-{3:3}, at: copy_page_range+0xcc2/0x56a0 mm/memory.c:1555
 #7: ffffffff896e2b00 (rcu_read_lock_sched){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #7: ffffffff896e2b00 (rcu_read_lock_sched){....}-{1:2}, at: rcu_read_lock_sched include/linux/rcupdate.h:938 [inline]
 #7: ffffffff896e2b00 (rcu_read_lock_sched){....}-{1:2}, at: pfn_valid+0xbc/0x4a0 include/linux/mmzone.h:2270
 #8: ffffc90000007ca0 ((&vub300->inactivity_timer)){+.-.}-{0:0}, at: call_timer_fn+0x11f/0x610 kernel/time/timer.c:1745
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 UID: 0 PID: 2973 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(lazy) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <IRQ>
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
 sysvec_apic_timer_interrupt+0x8f/0xb0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:check_preemption_disabled+0x26/0xe0 lib/smp_processor_id.c:54
Code: 90 90 90 90 41 54 55 53 48 83 ec 08 65 8b 1d 65 1f 82 05 65 f7 05 56 1f 82 05 ff ff ff 7f 74 0f 48 83 c4 08 89 d8 5b 5d 41 5c <c3> cc cc cc cc 9c 58 f6 c4 02 74 ea 65 4c 8b 25 1e 1f 82 05 48 89
RSP: 0018:ffffc90001457430 EFLAGS: 00000286
RAX: 0000000000000000 RBX: 0000000000125cae RCX: ffffffff82216929
RDX: ffff8881236b0000 RSI: ffffffff87b15680 RDI: ffffffff87b156c0
RBP: ffff88823ff5d480 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000001
R13: ffff88823ff5e000 R14: dffffc0000000000 R15: 0000000000000000
 rcu_is_watching_curr_cpu include/linux/context_tracking.h:128 [inline]
 rcu_is_watching+0x12/0xc0 kernel/rcu/tree.c:752
 rcu_read_lock_sched include/linux/rcupdate.h:939 [inline]
 pfn_valid+0x2d0/0x4a0 include/linux/mmzone.h:2270
 page_table_check_set+0x25/0x580 mm/page_table_check.c:105
 __page_table_check_ptes_set+0x217/0x270 mm/page_table_check.c:223
 page_table_check_ptes_set include/linux/page_table_check.h:83 [inline]
 set_ptes include/linux/pgtable.h:447 [inline]
 __copy_present_ptes mm/memory.c:1118 [inline]
 copy_present_ptes mm/memory.c:1197 [inline]
 copy_pte_range mm/memory.c:1320 [inline]
 copy_pmd_range mm/memory.c:1408 [inline]
 copy_pud_range mm/memory.c:1445 [inline]
 copy_p4d_range mm/memory.c:1469 [inline]
 copy_page_range+0x1c87/0x56a0 mm/memory.c:1555
 dup_mmap+0xcd8/0x1f60 mm/mmap.c:1840
 dup_mm kernel/fork.c:1543 [inline]
 copy_mm kernel/fork.c:1595 [inline]
 copy_process+0x4996/0x7dd0 kernel/fork.c:2289
 kernel_clone+0x176/0x9d0 kernel/fork.c:2748
 __do_sys_clone+0xd9/0x120 kernel/fork.c:2889
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x10b/0x7f0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2fd1056b52
Code: 89 e7 e8 71 8b f7 ff 45 31 c0 31 d2 31 f6 64 48 8b 04 25 10 00 00 00 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 66 89 c5 85 c0 75 3b 64 48 8b 04 25 10 00 00
RSP: 002b:00007ffc26622180 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007ffc26622180 RCX: 00007f2fd1056b52
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 00007ffc2662230c R08: 0000000000000000 R09: 0000000000000001
R10: 000055558a3997d0 R11: 0000000000000246 R12: 0000000000000000
R13: 00000000000927c0 R14: 000000000001c243 R15: 00007ffc26622360
 </TASK>

=============================
WARNING: suspicious RCU usage
syzkaller #0 Tainted: G        W          
-----------------------------
kernel/rcu/srcutree.c:1483 Illegal synchronize_srcu() in same-type SRCU (or in RCU) read-side critical section!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
9 locks held by syz-executor/2973:
 #0: ffffffff89823d10 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mm kernel/fork.c:1542 [inline]
 #0: ffffffff89823d10 (dup_mmap_sem){.+.+}-{0:0}, at: copy_mm kernel/fork.c:1595 [inline]
 #0: ffffffff89823d10 (dup_mmap_sem){.+.+}-{0:0}, at: copy_process+0x498b/0x7dd0 kernel/fork.c:2289
 #1: ffff888123fdceb8 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock_killable include/linux/mmap_lock.h:554 [inline]
 #1: ffff888123fdceb8 (&mm->mmap_lock){++++}-{4:4}, at: dup_mmap+0x11f/0x1f60 mm/mmap.c:1739
 #2: ffff888118e9e7b8 (&mm->mmap_lock/1){+.+.}-{4:4}, at: mmap_write_lock_nested include/linux/mmap_lock.h:544 [inline]
 #2: ffff888118e9e7b8 (&mm->mmap_lock/1){+.+.}-{4:4}, at: dup_mmap+0x1ba/0x1f60 mm/mmap.c:1746
 #3: ffffffff896e2bc0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #3: ffffffff896e2bc0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #3: ffffffff896e2bc0 (rcu_read_lock){....}-{1:3}, at: __pte_offset_map+0x2f/0x300 mm/pgtable-generic.c:290
 #4: ffff88810cf5e8b8 (ptlock_ptr(ptdesc)#2){+.+.}-{3:3}, at: spin_lock include/linux/spinlock.h:342 [inline]
 #4: ffff88810cf5e8b8 (ptlock_ptr(ptdesc)#2){+.+.}-{3:3}, at: pte_offset_map_lock+0x10f/0x320 mm/pgtable-generic.c:404
 #5: ffffffff896e2bc0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #5: ffffffff896e2bc0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #5: ffffffff896e2bc0 (rcu_read_lock){....}-{1:3}, at: __pte_offset_map+0x2f/0x300 mm/pgtable-generic.c:290
 #6: ffff888123d09f18 (ptlock_ptr(ptdesc)#2/1){+.+.}-{3:3}, at: copy_pte_range mm/memory.c:1272 [inline]
 #6: ffff888123d09f18 (ptlock_ptr(ptdesc)#2/1){+.+.}-{3:3}, at: copy_pmd_range mm/memory.c:1408 [inline]
 #6: ffff888123d09f18 (ptlock_ptr(ptdesc)#2/1){+.+.}-{3:3}, at: copy_pud_range mm/memory.c:1445 [inline]
 #6: ffff888123d09f18 (ptlock_ptr(ptdesc)#2/1){+.+.}-{3:3}, at: copy_p4d_range mm/memory.c:1469 [inline]
 #6: ffff888123d09f18 (ptlock_ptr(ptdesc)#2/1){+.+.}-{3:3}, at: copy_page_range+0xcc2/0x56a0 mm/memory.c:1555
 #7: ffffffff896e2b00 (rcu_read_lock_sched){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #7: ffffffff896e2b00 (rcu_read_lock_sched){....}-{1:2}, at: rcu_read_lock_sched include/linux/rcupdate.h:938 [inline]
 #7: ffffffff896e2b00 (rcu_read_lock_sched){....}-{1:2}, at: pfn_valid+0xbc/0x4a0 include/linux/mmzone.h:2270
 #8: ffffc90000007ca0 ((&vub300->inactivity_timer)){+.-.}-{0:0}, at: call_timer_fn+0x11f/0x610 kernel/time/timer.c:1745

stack backtrace:
CPU: 0 UID: 0 PID: 2973 Comm: syz-executor Tainted: G        W           syzkaller #0 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 lockdep_rcu_suspicious.cold+0x4f/0xb1 kernel/locking/lockdep.c:6876
 __synchronize_srcu+0x29d/0x300 kernel/rcu/srcutree.c:1483
 wakeup_source_remove drivers/base/power/wakeup.c:201 [inline]
 wakeup_source_unregister.part.0+0x12c/0x540 drivers/base/power/wakeup.c:237
 wakeup_source_unregister+0x1f/0x30 drivers/base/power/wakeup.c:236
 mmc_host_classdev_release+0x42/0x120 drivers/mmc/core/host.c:69
 device_release+0xd2/0x270 drivers/base/core.c:2636
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1f7/0x640 lib/kobject.c:737
 put_device+0x1f/0x30 drivers/base/core.c:3880
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
 sysvec_apic_timer_interrupt+0x8f/0xb0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:check_preemption_disabled+0x26/0xe0 lib/smp_processor_id.c:54
Code: 90 90 90 90 41 54 55 53 48 83 ec 08 65 8b 1d 65 1f 82 05 65 f7 05 56 1f 82 05 ff ff ff 7f 74 0f 48 83 c4 08 89 d8 5b 5d 41 5c <c3> cc cc cc cc 9c 58 f6 c4 02 74 ea 65 4c 8b 25 1e 1f 82 05 48 89
RSP: 0018:ffffc90001457430 EFLAGS: 00000286
RAX: 0000000000000000 RBX: 0000000000125cae RCX: ffffffff82216929
RDX: ffff8881236b0000 RSI: ffffffff87b15680 RDI: ffffffff87b156c0
RBP: ffff88823ff5d480 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000001
R13: ffff88823ff5e000 R14: dffffc0000000000 R15: 0000000000000000
 rcu_is_watching_curr_cpu include/linux/context_tracking.h:128 [inline]
 rcu_is_watching+0x12/0xc0 kernel/rcu/tree.c:752
 rcu_read_lock_sched include/linux/rcupdate.h:939 [inline]
 pfn_valid+0x2d0/0x4a0 include/linux/mmzone.h:2270
 page_table_check_set+0x25/0x580 mm/page_table_check.c:105
 __page_table_check_ptes_set+0x217/0x270 mm/page_table_check.c:223
 page_table_check_ptes_set include/linux/page_table_check.h:83 [inline]
 set_ptes include/linux/pgtable.h:447 [inline]
 __copy_present_ptes mm/memory.c:1118 [inline]
 copy_present_ptes mm/memory.c:1197 [inline]
 copy_pte_range mm/memory.c:1320 [inline]
 copy_pmd_range mm/memory.c:1408 [inline]
 copy_pud_range mm/memory.c:1445 [inline]
 copy_p4d_range mm/memory.c:1469 [inline]
 copy_page_range+0x1c87/0x56a0 mm/memory.c:1555
 dup_mmap+0xcd8/0x1f60 mm/mmap.c:1840
 dup_mm kernel/fork.c:1543 [inline]
 copy_mm kernel/fork.c:1595 [inline]
 copy_process+0x4996/0x7dd0 kernel/fork.c:2289
 kernel_clone+0x176/0x9d0 kernel/fork.c:2748
 __do_sys_clone+0xd9/0x120 kernel/fork.c:2889
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x10b/0x7f0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2fd1056b52
Code: 89 e7 e8 71 8b f7 ff 45 31 c0 31 d2 31 f6 64 48 8b 04 25 10 00 00 00 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 66 89 c5 85 c0 75 3b 64 48 8b 04 25 10 00 00
RSP: 002b:00007ffc26622180 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007ffc26622180 RCX: 00007f2fd1056b52
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 00007ffc2662230c R08: 0000000000000000 R09: 0000000000000001
R10: 000055558a3997d0 R11: 0000000000000246 R12: 0000000000000000
R13: 00000000000927c0 R14: 000000000001c243 R15: 00007ffc26622360
 </TASK>
BUG: sleeping function called from invalid context at kernel/rcu/srcutree.c:1491
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 2973, name: syz-executor
preempt_count: 104, expected: 0
RCU nest depth: 2, expected: 0
9 locks held by syz-executor/2973:
 #0: ffffffff89823d10 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mm kernel/fork.c:1542 [inline]
 #0: ffffffff89823d10 (dup_mmap_sem){.+.+}-{0:0}, at: copy_mm kernel/fork.c:1595 [inline]
 #0: ffffffff89823d10 (dup_mmap_sem){.+.+}-{0:0}, at: copy_process+0x498b/0x7dd0 kernel/fork.c:2289
 #1: ffff888123fdceb8 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock_killable include/linux/mmap_lock.h:554 [inline]
 #1: ffff888123fdceb8 (&mm->mmap_lock){++++}-{4:4}, at: dup_mmap+0x11f/0x1f60 mm/mmap.c:1739
 #2: ffff888118e9e7b8 (&mm->mmap_lock/1){+.+.}-{4:4}, at: mmap_write_lock_nested include/linux/mmap_lock.h:544 [inline]
 #2: ffff888118e9e7b8 (&mm->mmap_lock/1){+.+.}-{4:4}, at: dup_mmap+0x1ba/0x1f60 mm/mmap.c:1746
 #3: ffffffff896e2bc0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #3: ffffffff896e2bc0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #3: ffffffff896e2bc0 (rcu_read_lock){....}-{1:3}, at: __pte_offset_map+0x2f/0x300 mm/pgtable-generic.c:290
 #4: ffff88810cf5e8b8 (ptlock_ptr(ptdesc)#2){+.+.}-{3:3}, at: spin_lock include/linux/spinlock.h:342 [inline]
 #4: ffff88810cf5e8b8 (ptlock_ptr(ptdesc)#2){+.+.}-{3:3}, at: pte_offset_map_lock+0x10f/0x320 mm/pgtable-generic.c:404
 #5: ffffffff896e2bc0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #5: ffffffff896e2bc0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #5: ffffffff896e2bc0 (rcu_read_lock){....}-{1:3}, at: __pte_offset_map+0x2f/0x300 mm/pgtable-generic.c:290
 #6: ffff888123d09f18 (ptlock_ptr(ptdesc)#2/1){+.+.}-{3:3}, at: copy_pte_range mm/memory.c:1272 [inline]
 #6: ffff888123d09f18 (ptlock_ptr(ptdesc)#2/1){+.+.}-{3:3}, at: copy_pmd_range mm/memory.c:1408 [inline]
 #6: ffff888123d09f18 (ptlock_ptr(ptdesc)#2/1){+.+.}-{3:3}, at: copy_pud_range mm/memory.c:1445 [inline]
 #6: ffff888123d09f18 (ptlock_ptr(ptdesc)#2/1){+.+.}-{3:3}, at: copy_p4d_range mm/memory.c:1469 [inline]
 #6: ffff888123d09f18 (ptlock_ptr(ptdesc)#2/1){+.+.}-{3:3}, at: copy_page_range+0xcc2/0x56a0 mm/memory.c:1555
 #7: ffffffff896e2b00 (rcu_read_lock_sched){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #7: ffffffff896e2b00 (rcu_read_lock_sched){....}-{1:2}, at: rcu_read_lock_sched include/linux/rcupdate.h:938 [inline]
 #7: ffffffff896e2b00 (rcu_read_lock_sched){....}-{1:2}, at: pfn_valid+0xbc/0x4a0 include/linux/mmzone.h:2270
 #8: ffffc90000007ca0 ((&vub300->inactivity_timer)){+.-.}-{0:0}, at: call_timer_fn+0x11f/0x610 kernel/time/timer.c:1745
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 UID: 0 PID: 2973 Comm: syz-executor Tainted: G        W           syzkaller #0 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 __might_resched.cold+0x1ec/0x232 kernel/sched/core.c:9197
 __synchronize_srcu+0x13c/0x300 kernel/rcu/srcutree.c:1491
 wakeup_source_remove drivers/base/power/wakeup.c:201 [inline]
 wakeup_source_unregister.part.0+0x12c/0x540 drivers/base/power/wakeup.c:237
 wakeup_source_unregister+0x1f/0x30 drivers/base/power/wakeup.c:236
 mmc_host_classdev_release+0x42/0x120 drivers/mmc/core/host.c:69
 device_release+0xd2/0x270 drivers/base/core.c:2636
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1f7/0x640 lib/kobject.c:737
 put_device+0x1f/0x30 drivers/base/core.c:3880
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
 sysvec_apic_timer_interrupt+0x8f/0xb0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:check_preemption_disabled+0x26/0xe0 lib/smp_processor_id.c:54
Code: 90 90 90 90 41 54 55 53 48 83 ec 08 65 8b 1d 65 1f 82 05 65 f7 05 56 1f 82 05 ff ff ff 7f 74 0f 48 83 c4 08 89 d8 5b 5d 41 5c <c3> cc cc cc cc 9c 58 f6 c4 02 74 ea 65 4c 8b 25 1e 1f 82 05 48 89
RSP: 0018:ffffc90001457430 EFLAGS: 00000286
RAX: 0000000000000000 RBX: 0000000000125cae RCX: ffffffff82216929
RDX: ffff8881236b0000 RSI: ffffffff87b15680 RDI: ffffffff87b156c0
RBP: ffff88823ff5d480 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000001
R13: ffff88823ff5e000 R14: dffffc0000000000 R15: 0000000000000000
 rcu_is_watching_curr_cpu include/linux/context_tracking.h:128 [inline]
 rcu_is_watching+0x12/0xc0 kernel/rcu/tree.c:752
 rcu_read_lock_sched include/linux/rcupdate.h:939 [inline]
 pfn_valid+0x2d0/0x4a0 include/linux/mmzone.h:2270
 page_table_check_set+0x25/0x580 mm/page_table_check.c:105
 __page_table_check_ptes_set+0x217/0x270 mm/page_table_check.c:223
 page_table_check_ptes_set include/linux/page_table_check.h:83 [inline]
 set_ptes include/linux/pgtable.h:447 [inline]
 __copy_present_ptes mm/memory.c:1118 [inline]
 copy_present_ptes mm/memory.c:1197 [inline]
 copy_pte_range mm/memory.c:1320 [inline]
 copy_pmd_range mm/memory.c:1408 [inline]
 copy_pud_range mm/memory.c:1445 [inline]
 copy_p4d_range mm/memory.c:1469 [inline]
 copy_page_range+0x1c87/0x56a0 mm/memory.c:1555
 dup_mmap+0xcd8/0x1f60 mm/mmap.c:1840
 dup_mm kernel/fork.c:1543 [inline]
 copy_mm kernel/fork.c:1595 [inline]
 copy_process+0x4996/0x7dd0 kernel/fork.c:2289
 kernel_clone+0x176/0x9d0 kernel/fork.c:2748
 __do_sys_clone+0xd9/0x120 kernel/fork.c:2889
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x10b/0x7f0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2fd1056b52
Code: 89 e7 e8 71 8b f7 ff 45 31 c0 31 d2 31 f6 64 48 8b 04 25 10 00 00 00 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 66 89 c5 85 c0 75 3b 64 48 8b 04 25 10 00 00
RSP: 002b:00007ffc26622180 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007ffc26622180 RCX: 00007f2fd1056b52
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 00007ffc2662230c R08: 0000000000000000 R09: 0000000000000001
R10: 000055558a3997d0 R11: 0000000000000246 R12: 0000000000000000
R13: 00000000000927c0 R14: 000000000001c243 R15: 00007ffc26622360
 </TASK>
ODEBUG: object ffffc90000007a70 is NOT on stack ffffc90001450000, but annotated.

======================================================
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	41 54                	push   %r12
   6:	55                   	push   %rbp
   7:	53                   	push   %rbx
   8:	48 83 ec 08          	sub    $0x8,%rsp
   c:	65 8b 1d 65 1f 82 05 	mov    %gs:0x5821f65(%rip),%ebx        # 0x5821f78
  13:	65 f7 05 56 1f 82 05 	testl  $0x7fffffff,%gs:0x5821f56(%rip)        # 0x5821f74
  1a:	ff ff ff 7f
  1e:	74 0f                	je     0x2f
  20:	48 83 c4 08          	add    $0x8,%rsp
  24:	89 d8                	mov    %ebx,%eax
  26:	5b                   	pop    %rbx
  27:	5d                   	pop    %rbp
  28:	41 5c                	pop    %r12
* 2a:	c3                   	ret <-- trapping instruction
  2b:	cc                   	int3
  2c:	cc                   	int3
  2d:	cc                   	int3
  2e:	cc                   	int3
  2f:	9c                   	pushf
  30:	58                   	pop    %rax
  31:	f6 c4 02             	test   $0x2,%ah
  34:	74 ea                	je     0x20
  36:	65 4c 8b 25 1e 1f 82 	mov    %gs:0x5821f1e(%rip),%r12        # 0x5821f5c
  3d:	05
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89


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
