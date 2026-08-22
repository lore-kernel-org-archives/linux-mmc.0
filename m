Received: from mail-oa2-f11.google.com (mail-oa2-f11.google.com [74.125.231.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC2A2DCC1F
	for <linux-mmc@vger.kernel.org>; Sat, 22 Aug 2026 06:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787378683; cv=none; b=rog/P66MGXH8kiyEEYgdilMVLm1UNy6xs5jGGWr66W2A6db2E86XVwPODaHrtiF316+OBmeAbwaqc2kEY97FmX2HPlo0JPzX6XiIv9QjtUM4tp4DIbjvudUCeyjsWOZSmVl/FNP7FaYyX95Gr75TNxuHD2zvdEyCIbbGwAC/ub0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787378683; c=relaxed/simple;
	bh=L5tUpChp4xkmws8cX/XEvdaMqOvNhSvpj4d7fNc4cC4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=h7x0qwO8V+H413cF602MbdwJKutY1flBvkgmHQw7RV4cO4wNE2GxZZr5RlXQdp0fCcuc1la+IWod925pWQx1PcL859+fSRVV8R0w6Y5Dugk5LGUATmIlCSd76xCvOPSsI4EBYDdmPLLjWTSS2u4znPtmMW9ayVyOKSgGz38WW2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa2-f11.google.com with SMTP id 586e51a60fabf-45958a0c7c4so510714fac.0
        for <linux-mmc@vger.kernel.org>; Fri, 21 Aug 2026 23:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787378680; x=1787983480;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KMlhJp84l6vM8LZ3im86n4LcwzQFg13FVjR7jy0nN/M=;
        b=Cly1Wzhh6EWiT1f5jMBYOFX1OumK3H5QDvOAg9kZYj5JlrvnjGtU0gxPXn6KUXfXM8
         6XvurCsp2kaI10wJKXfnVcjxKfCNy5xsb5Ft5b7neDWehTesrK8uy6q9fmAoOJYgIrvp
         H88qbBZJFUB+yYEExXghq1dMXP/+EbdSRFES8OWWpK6D4mEOylp7I4likrJ9AQp7Gb0N
         mfYoG8EOr3zgIQmGmuVOTsDqann0fnJHcZYKB8DnSH1dxHXrApj2WsXGg+XIMdQYtman
         9lSDmZGZSysXZtEHn+CZ62vGt8kad8PVGEauf9HMwqN5Xok3FFFNoh7hA43nh65oi9kp
         jVLw==
X-Forwarded-Encrypted: i=1; AHgh+Rqmt/45UxZszakvOC9o7LIX07PCrJMzW1KLDqPX/Ku9ZxzyBmRRrrP0xzXJEb4geJC8fHVsd9pAAMY=@vger.kernel.org
X-Gm-Message-State: AFuF++n9i2d9zEkVIiik1yzgY3Qfx9tZrkuhc6cbUyQgeW860eIAyqU3
	E/G0WVsdgxoHlY3a70lgpUmN8gid12vKRJui/5NidjPypYTvXAJNMIsQyHL8kylE2Ef17g24jsh
	zp1h+C4ESMouFe/MI90Vuch03qXsE3STD2Zod8EE81eNSCayduxC09ObfvEk=
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4f64:b0:490:b586:1459 with SMTP id
 5614622812f47-4b3099899c6mr5871028b6e.2.1787378679855; Fri, 21 Aug 2026
 23:04:39 -0700 (PDT)
Date: Fri, 21 Aug 2026 23:04:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a893bf7.dbb3a75c.13dd47.002d.GAE@google.com>
Subject: [syzbot] [mmc?] WARNING: suspicious RCU usage in mmc_free_host
From: syzbot <syzbot+0d22039ef0915696ad4b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, ulf.hansson@linaro.org, ulfh@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    818bebeb63dd drm/xe: Don't hand out the flat CCS storage a..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1109e549580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=59b38fbc070dad5e
dashboard link: https://syzkaller.appspot.com/bug?extid=0d22039ef0915696ad4b
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/51af0608b198/disk-818bebeb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ecaa10d3a300/vmlinux-818bebeb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6ce61fdcbede/bzImage-818bebeb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0d22039ef0915696ad4b@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
syzkaller #0 Tainted: G             L     
-----------------------------
kernel/sched/core.c:9196 Illegal context switch in RCU-sched read-side critical section!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
locks held by syz-executor/5632: 9, last CPU#1:
 #0: ffffffff8ec332d0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mm kernel/fork.c:1548 [inline]
 #0: ffffffff8ec332d0 (dup_mmap_sem){.+.+}-{0:0}, at: copy_mm+0x10f/0x480 kernel/fork.c:1601
 #1: ffff8880297203b8 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock_killable include/linux/mmap_lock.h:562 [inline]
 #1: ffff8880297203b8 (&mm->mmap_lock){++++}-{4:4}, at: dup_mmap+0x195/0x1dc0 mm/mmap.c:1716
 #2: ffff888022fb03b8 (&mm->mmap_lock/1){+.+.}-{4:4}, at: mmap_write_lock_nested include/linux/mmap_lock.h:552 [inline]
 #2: ffff888022fb03b8 (&mm->mmap_lock/1){+.+.}-{4:4}, at: dup_mmap+0x221/0x1dc0 mm/mmap.c:1723
 #3: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #3: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #3: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: __pte_offset_map+0x29/0x240 mm/pgtable-generic.c:290
 #4: ffff88801b0621f8 (ptlock_ptr(ptdesc)#2){+.+.}-{3:3}, at: spin_lock include/linux/spinlock.h:347 [inline]
 #4: ffff88801b0621f8 (ptlock_ptr(ptdesc)#2){+.+.}-{3:3}, at: pte_offset_map_lock+0x13d/0x210 mm/pgtable-generic.c:404
 #5: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #5: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #5: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: __pte_offset_map+0x29/0x240 mm/pgtable-generic.c:290
 #6: ffff88805b9e76d8 (ptlock_ptr(ptdesc)#2/1){+.+.}-{3:3}, at: copy_pte_range mm/memory.c:1292 [inline]
 #6: ffff88805b9e76d8 (ptlock_ptr(ptdesc)#2/1){+.+.}-{3:3}, at: copy_pmd_range+0x70f/0x5c50 mm/memory.c:1428
 #7: ffffffff8eb5a420 (rcu_read_lock_sched){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #7: ffffffff8eb5a420 (rcu_read_lock_sched){....}-{1:2}, at: rcu_read_lock_sched include/linux/rcupdate.h:938 [inline]
 #7: ffffffff8eb5a420 (rcu_read_lock_sched){....}-{1:2}, at: pfn_valid+0xba/0x490 include/linux/mmzone.h:2266
 #8: ffffc90000a08cc0 ((&vub300->inactivity_timer)){+.-.}-{0:0}, at: call_timer_fn+0xd5/0x5f0 kernel/time/timer.c:1745

stack backtrace:
CPU: 1 UID: 0 PID: 5632 Comm: syz-executor Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <IRQ>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 lockdep_rcu_suspicious+0x140/0x1d0 kernel/locking/lockdep.c:6894
 __might_resched+0xbb/0x4c0 kernel/sched/core.c:9196
 __cancel_work_sync+0x6d/0x110 kernel/workqueue.c:4552
 mmc_free_host+0x19/0x30 drivers/mmc/core/host.c:700
 call_timer_fn+0x18d/0x5f0 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers kernel/time/timer.c:2374 [inline]
 __run_timer_base+0x652/0x8b0 kernel/time/timer.c:2386
 run_timer_base kernel/time/timer.c:2395 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2405
 handle_softirqs+0x226/0x860 kernel/softirq.c:645
 __do_softirq kernel/softirq.c:679 [inline]
 invoke_softirq kernel/softirq.c:519 [inline]
 __irq_exit_rcu+0xcb/0x220 kernel/softirq.c:767
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:784
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:lock_acquire+0x222/0x350 kernel/locking/lockdep.c:5890
Code: ff ff ff e8 a0 20 39 0a f7 44 24 08 00 02 00 00 0f 84 39 ff ff ff 65 48 8b 05 f2 0b ce 11 48 3b 44 24 58 75 33 fb 48 83 c4 60 <5b> 41 5c 41 5d 41 5e 41 5f 5d e9 cf 27 3c 0a cc 48 8d 3d a7 64 b9
RSP: 0018:ffffc90004307210 EFLAGS: 00000282
RAX: 2ab30850d67e6b00 RBX: 0000000000000000 RCX: 8000000000000003
RDX: 00000000dc7298f8 RSI: ffffffff8e4e132a RDI: ffffffff8c4cf580
RBP: ffffffff8242ba4a R08: ffffffff8242ba4a R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff8eb5a420 R12: 0000000000000002
R13: ffffffff8eb5a420 R14: 0000000000000000 R15: 0000000000000246
 rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 rcu_read_lock_sched include/linux/rcupdate.h:938 [inline]
 pfn_valid+0xd6/0x490 include/linux/mmzone.h:2266
 page_table_check_set+0x25/0x530 mm/page_table_check.c:105
 page_table_check_ptes_set include/linux/page_table_check.h:83 [inline]
 set_ptes include/linux/pgtable.h:447 [inline]
 __copy_present_ptes mm/memory.c:1138 [inline]
 copy_present_ptes mm/memory.c:1217 [inline]
 copy_pte_range mm/memory.c:1340 [inline]
 copy_pmd_range+0x4b46/0x5c50 mm/memory.c:1428
 copy_pud_range mm/memory.c:1465 [inline]
 copy_p4d_range mm/memory.c:1489 [inline]
 copy_page_range+0xc25/0x1230 mm/memory.c:1575
 dup_mmap+0xf17/0x1dc0 mm/mmap.c:1819
 dup_mm kernel/fork.c:1549 [inline]
 copy_mm+0x11a/0x480 kernel/fork.c:1601
 copy_process+0x1e75/0x43e0 kernel/fork.c:2313
 kernel_clone+0x2d7/0x940 kernel/fork.c:2772
 __do_sys_clone kernel/fork.c:2914 [inline]
 __se_sys_clone kernel/fork.c:2898 [inline]
 __x64_sys_clone+0x1b6/0x230 kernel/fork.c:2898
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5322fc6b52
Code: 89 e7 e8 71 8b f7 ff 45 31 c0 31 d2 31 f6 64 48 8b 04 25 10 00 00 00 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 66 89 c5 85 c0 75 3b 64 48 8b 04 25 10 00 00
RSP: 002b:00007f532334fc60 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007f532334fc60 RCX: 00007f5322fc6b52
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 00007f532334fdec R08: 0000000000000000 R09: 0000000000000001
R10: 0000555576c227d0 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000000927c0 R14: 0000000000039654 R15: 00007f532334fe40
 </TASK>
BUG: sleeping function called from invalid context at kernel/workqueue.c:4552
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5632, name: syz-executor
preempt_count: 103, expected: 0
RCU nest depth: 2, expected: 0
locks held by syz-executor/5632: 9, last CPU#1:
 #0: ffffffff8ec332d0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mm kernel/fork.c:1548 [inline]
 #0: ffffffff8ec332d0 (dup_mmap_sem){.+.+}-{0:0}, at: copy_mm+0x10f/0x480 kernel/fork.c:1601
 #1: ffff8880297203b8 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock_killable include/linux/mmap_lock.h:562 [inline]
 #1: ffff8880297203b8 (&mm->mmap_lock){++++}-{4:4}, at: dup_mmap+0x195/0x1dc0 mm/mmap.c:1716
 #2: ffff888022fb03b8 (&mm->mmap_lock/1){+.+.}-{4:4}, at: mmap_write_lock_nested include/linux/mmap_lock.h:552 [inline]
 #2: ffff888022fb03b8 (&mm->mmap_lock/1){+.+.}-{4:4}, at: dup_mmap+0x221/0x1dc0 mm/mmap.c:1723
 #3: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #3: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #3: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: __pte_offset_map+0x29/0x240 mm/pgtable-generic.c:290
 #4: ffff88801b0621f8 (ptlock_ptr(ptdesc)#2){+.+.}-{3:3}, at: spin_lock include/linux/spinlock.h:347 [inline]
 #4: ffff88801b0621f8 (ptlock_ptr(ptdesc)#2){+.+.}-{3:3}, at: pte_offset_map_lock+0x13d/0x210 mm/pgtable-generic.c:404
 #5: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #5: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #5: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: __pte_offset_map+0x29/0x240 mm/pgtable-generic.c:290
 #6: ffff88805b9e76d8 (ptlock_ptr(ptdesc)#2/1){+.+.}-{3:3}, at: copy_pte_range mm/memory.c:1292 [inline]
 #6: ffff88805b9e76d8 (ptlock_ptr(ptdesc)#2/1){+.+.}-{3:3}, at: copy_pmd_range+0x70f/0x5c50 mm/memory.c:1428
 #7: ffffffff8eb5a420 (rcu_read_lock_sched){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #7: ffffffff8eb5a420 (rcu_read_lock_sched){....}-{1:2}, at: rcu_read_lock_sched include/linux/rcupdate.h:938 [inline]
 #7: ffffffff8eb5a420 (rcu_read_lock_sched){....}-{1:2}, at: pfn_valid+0xba/0x490 include/linux/mmzone.h:2266
 #8: ffffc90000a08cc0 ((&vub300->inactivity_timer)){+.-.}-{0:0}, at: call_timer_fn+0xd5/0x5f0 kernel/time/timer.c:1745
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 UID: 0 PID: 5632 Comm: syz-executor Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <IRQ>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 __might_resched+0x36a/0x4c0 kernel/sched/core.c:9234
 __cancel_work_sync+0x6d/0x110 kernel/workqueue.c:4552
 mmc_free_host+0x19/0x30 drivers/mmc/core/host.c:700
 call_timer_fn+0x18d/0x5f0 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers kernel/time/timer.c:2374 [inline]
 __run_timer_base+0x652/0x8b0 kernel/time/timer.c:2386
 run_timer_base kernel/time/timer.c:2395 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2405
 handle_softirqs+0x226/0x860 kernel/softirq.c:645
 __do_softirq kernel/softirq.c:679 [inline]
 invoke_softirq kernel/softirq.c:519 [inline]
 __irq_exit_rcu+0xcb/0x220 kernel/softirq.c:767
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:784
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:lock_acquire+0x222/0x350 kernel/locking/lockdep.c:5890
Code: ff ff ff e8 a0 20 39 0a f7 44 24 08 00 02 00 00 0f 84 39 ff ff ff 65 48 8b 05 f2 0b ce 11 48 3b 44 24 58 75 33 fb 48 83 c4 60 <5b> 41 5c 41 5d 41 5e 41 5f 5d e9 cf 27 3c 0a cc 48 8d 3d a7 64 b9
RSP: 0018:ffffc90004307210 EFLAGS: 00000282
RAX: 2ab30850d67e6b00 RBX: 0000000000000000 RCX: 8000000000000003
RDX: 00000000dc7298f8 RSI: ffffffff8e4e132a RDI: ffffffff8c4cf580
RBP: ffffffff8242ba4a R08: ffffffff8242ba4a R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff8eb5a420 R12: 0000000000000002
R13: ffffffff8eb5a420 R14: 0000000000000000 R15: 0000000000000246
 rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 rcu_read_lock_sched include/linux/rcupdate.h:938 [inline]
 pfn_valid+0xd6/0x490 include/linux/mmzone.h:2266
 page_table_check_set+0x25/0x530 mm/page_table_check.c:105
 page_table_check_ptes_set include/linux/page_table_check.h:83 [inline]
 set_ptes include/linux/pgtable.h:447 [inline]
 __copy_present_ptes mm/memory.c:1138 [inline]
 copy_present_ptes mm/memory.c:1217 [inline]
 copy_pte_range mm/memory.c:1340 [inline]
 copy_pmd_range+0x4b46/0x5c50 mm/memory.c:1428
 copy_pud_range mm/memory.c:1465 [inline]
 copy_p4d_range mm/memory.c:1489 [inline]
 copy_page_range+0xc25/0x1230 mm/memory.c:1575
 dup_mmap+0xf17/0x1dc0 mm/mmap.c:1819
 dup_mm kernel/fork.c:1549 [inline]
 copy_mm+0x11a/0x480 kernel/fork.c:1601
 copy_process+0x1e75/0x43e0 kernel/fork.c:2313
 kernel_clone+0x2d7/0x940 kernel/fork.c:2772
 __do_sys_clone kernel/fork.c:2914 [inline]
 __se_sys_clone kernel/fork.c:2898 [inline]
 __x64_sys_clone+0x1b6/0x230 kernel/fork.c:2898
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5322fc6b52
Code: 89 e7 e8 71 8b f7 ff 45 31 c0 31 d2 31 f6 64 48 8b 04 25 10 00 00 00 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 66 89 c5 85 c0 75 3b 64 48 8b 04 25 10 00 00
RSP: 002b:00007f532334fc60 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007f532334fc60 RCX: 00007f5322fc6b52
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 00007f532334fdec R08: 0000000000000000 R09: 0000000000000001
R10: 0000555576c227d0 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000000927c0 R14: 0000000000039654 R15: 00007f532334fe40
 </TASK>

=============================
WARNING: suspicious RCU usage
syzkaller #0 Tainted: G        W    L     
-----------------------------
kernel/rcu/srcutree.c:1487 Illegal synchronize_srcu() in same-type SRCU (or in RCU) read-side critical section!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
locks held by syz-executor/5632: 9, last CPU#1:
 #0: ffffffff8ec332d0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mm kernel/fork.c:1548 [inline]
 #0: ffffffff8ec332d0 (dup_mmap_sem){.+.+}-{0:0}, at: copy_mm+0x10f/0x480 kernel/fork.c:1601
 #1: ffff8880297203b8 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock_killable include/linux/mmap_lock.h:562 [inline]
 #1: ffff8880297203b8 (&mm->mmap_lock){++++}-{4:4}, at: dup_mmap+0x195/0x1dc0 mm/mmap.c:1716
 #2: ffff888022fb03b8 (&mm->mmap_lock/1){+.+.}-{4:4}, at: mmap_write_lock_nested include/linux/mmap_lock.h:552 [inline]
 #2: ffff888022fb03b8 (&mm->mmap_lock/1){+.+.}-{4:4}, at: dup_mmap+0x221/0x1dc0 mm/mmap.c:1723
 #3: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #3: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #3: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: __pte_offset_map+0x29/0x240 mm/pgtable-generic.c:290
 #4: ffff88801b0621f8 (ptlock_ptr(ptdesc)#2){+.+.}-{3:3}, at: spin_lock include/linux/spinlock.h:347 [inline]
 #4: ffff88801b0621f8 (ptlock_ptr(ptdesc)#2){+.+.}-{3:3}, at: pte_offset_map_lock+0x13d/0x210 mm/pgtable-generic.c:404
 #5: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #5: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #5: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: __pte_offset_map+0x29/0x240 mm/pgtable-generic.c:290
 #6: ffff88805b9e76d8 (ptlock_ptr(ptdesc)#2/1){+.+.}-{3:3}, at: copy_pte_range mm/memory.c:1292 [inline]
 #6: ffff88805b9e76d8 (ptlock_ptr(ptdesc)#2/1){+.+.}-{3:3}, at: copy_pmd_range+0x70f/0x5c50 mm/memory.c:1428
 #7: ffffffff8eb5a420 (rcu_read_lock_sched){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #7: ffffffff8eb5a420 (rcu_read_lock_sched){....}-{1:2}, at: rcu_read_lock_sched include/linux/rcupdate.h:938 [inline]
 #7: ffffffff8eb5a420 (rcu_read_lock_sched){....}-{1:2}, at: pfn_valid+0xba/0x490 include/linux/mmzone.h:2266
 #8: ffffc90000a08cc0 ((&vub300->inactivity_timer)){+.-.}-{0:0}, at: call_timer_fn+0xd5/0x5f0 kernel/time/timer.c:1745

stack backtrace:
CPU: 1 UID: 0 PID: 5632 Comm: syz-executor Tainted: G        W    L      syzkaller #0 PREEMPT(full) 
Tainted: [W]=WARN, [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <IRQ>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 lockdep_rcu_suspicious+0x140/0x1d0 kernel/locking/lockdep.c:6894
 __synchronize_srcu+0x157/0x2f0 kernel/rcu/srcutree.c:1483
 wakeup_source_remove drivers/base/power/wakeup.c:201 [inline]
 wakeup_source_unregister+0x129/0x3f0 drivers/base/power/wakeup.c:237
 mmc_host_classdev_release+0x47/0x100 drivers/mmc/core/host.c:69
 device_release+0xc4/0x1f0 drivers/base/core.c:-1
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x222/0x550 lib/kobject.c:737
 call_timer_fn+0x18d/0x5f0 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers kernel/time/timer.c:2374 [inline]
 __run_timer_base+0x652/0x8b0 kernel/time/timer.c:2386
 run_timer_base kernel/time/timer.c:2395 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2405
 handle_softirqs+0x226/0x860 kernel/softirq.c:645
 __do_softirq kernel/softirq.c:679 [inline]
 invoke_softirq kernel/softirq.c:519 [inline]
 __irq_exit_rcu+0xcb/0x220 kernel/softirq.c:767
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:784
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:lock_acquire+0x222/0x350 kernel/locking/lockdep.c:5890
Code: ff ff ff e8 a0 20 39 0a f7 44 24 08 00 02 00 00 0f 84 39 ff ff ff 65 48 8b 05 f2 0b ce 11 48 3b 44 24 58 75 33 fb 48 83 c4 60 <5b> 41 5c 41 5d 41 5e 41 5f 5d e9 cf 27 3c 0a cc 48 8d 3d a7 64 b9
RSP: 0018:ffffc90004307210 EFLAGS: 00000282
RAX: 2ab30850d67e6b00 RBX: 0000000000000000 RCX: 8000000000000003
RDX: 00000000dc7298f8 RSI: ffffffff8e4e132a RDI: ffffffff8c4cf580
RBP: ffffffff8242ba4a R08: ffffffff8242ba4a R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff8eb5a420 R12: 0000000000000002
R13: ffffffff8eb5a420 R14: 0000000000000000 R15: 0000000000000246
 rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 rcu_read_lock_sched include/linux/rcupdate.h:938 [inline]
 pfn_valid+0xd6/0x490 include/linux/mmzone.h:2266
 page_table_check_set+0x25/0x530 mm/page_table_check.c:105
 page_table_check_ptes_set include/linux/page_table_check.h:83 [inline]
 set_ptes include/linux/pgtable.h:447 [inline]
 __copy_present_ptes mm/memory.c:1138 [inline]
 copy_present_ptes mm/memory.c:1217 [inline]
 copy_pte_range mm/memory.c:1340 [inline]
 copy_pmd_range+0x4b46/0x5c50 mm/memory.c:1428
 copy_pud_range mm/memory.c:1465 [inline]
 copy_p4d_range mm/memory.c:1489 [inline]
 copy_page_range+0xc25/0x1230 mm/memory.c:1575
 dup_mmap+0xf17/0x1dc0 mm/mmap.c:1819
 dup_mm kernel/fork.c:1549 [inline]
 copy_mm+0x11a/0x480 kernel/fork.c:1601
 copy_process+0x1e75/0x43e0 kernel/fork.c:2313
 kernel_clone+0x2d7/0x940 kernel/fork.c:2772
 __do_sys_clone kernel/fork.c:2914 [inline]
 __se_sys_clone kernel/fork.c:2898 [inline]
 __x64_sys_clone+0x1b6/0x230 kernel/fork.c:2898
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5322fc6b52
Code: 89 e7 e8 71 8b f7 ff 45 31 c0 31 d2 31 f6 64 48 8b 04 25 10 00 00 00 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 66 89 c5 85 c0 75 3b 64 48 8b 04 25 10 00 00
RSP: 002b:00007f532334fc60 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007f532334fc60 RCX: 00007f5322fc6b52
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 00007f532334fdec R08: 0000000000000000 R09: 0000000000000001
R10: 0000555576c227d0 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000000927c0 R14: 0000000000039654 R15: 00007f532334fe40
 </TASK>
BUG: sleeping function called from invalid context at kernel/rcu/srcutree.c:1491
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5632, name: syz-executor
preempt_count: 103, expected: 0
RCU nest depth: 2, expected: 0
locks held by syz-executor/5632: 9, last CPU#1:
 #0: ffffffff8ec332d0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mm kernel/fork.c:1548 [inline]
 #0: ffffffff8ec332d0 (dup_mmap_sem){.+.+}-{0:0}, at: copy_mm+0x10f/0x480 kernel/fork.c:1601
 #1: ffff8880297203b8 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock_killable include/linux/mmap_lock.h:562 [inline]
 #1: ffff8880297203b8 (&mm->mmap_lock){++++}-{4:4}, at: dup_mmap+0x195/0x1dc0 mm/mmap.c:1716
 #2: ffff888022fb03b8 (&mm->mmap_lock/1){+.+.}-{4:4}, at: mmap_write_lock_nested include/linux/mmap_lock.h:552 [inline]
 #2: ffff888022fb03b8 (&mm->mmap_lock/1){+.+.}-{4:4}, at: dup_mmap+0x221/0x1dc0 mm/mmap.c:1723
 #3: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #3: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #3: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: __pte_offset_map+0x29/0x240 mm/pgtable-generic.c:290
 #4: ffff88801b0621f8 (ptlock_ptr(ptdesc)#2){+.+.}-{3:3}, at: spin_lock include/linux/spinlock.h:347 [inline]
 #4: ffff88801b0621f8 (ptlock_ptr(ptdesc)#2){+.+.}-{3:3}, at: pte_offset_map_lock+0x13d/0x210 mm/pgtable-generic.c:404
 #5: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #5: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #5: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: __pte_offset_map+0x29/0x240 mm/pgtable-generic.c:290
 #6: ffff88805b9e76d8 (ptlock_ptr(ptdesc)#2/1){+.+.}-{3:3}, at: copy_pte_range mm/memory.c:1292 [inline]
 #6: ffff88805b9e76d8 (ptlock_ptr(ptdesc)#2/1){+.+.}-{3:3}, at: copy_pmd_range+0x70f/0x5c50 mm/memory.c:1428
 #7: ffffffff8eb5a420 (rcu_read_lock_sched){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #7: ffffffff8eb5a420 (rcu_read_lock_sched){....}-{1:2}, at: rcu_read_lock_sched include/linux/rcupdate.h:938 [inline]
 #7: ffffffff8eb5a420 (rcu_read_lock_sched){....}-{1:2}, at: pfn_valid+0xba/0x490 include/linux/mmzone.h:2266
 #8: ffffc90000a08cc0 ((&vub300->inactivity_timer)){+.-.}-{0:0}, at: call_timer_fn+0xd5/0x5f0 kernel/time/timer.c:1745
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 UID: 0 PID: 5632 Comm: syz-executor Tainted: G        W    L      syzkaller #0 PREEMPT(full) 
Tainted: [W]=WARN, [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <IRQ>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 __might_resched+0x36a/0x4c0 kernel/sched/core.c:9234
 __synchronize_srcu+0x1a1/0x2f0 kernel/rcu/srcutree.c:1491
 wakeup_source_remove drivers/base/power/wakeup.c:201 [inline]
 wakeup_source_unregister+0x129/0x3f0 drivers/base/power/wakeup.c:237
 mmc_host_classdev_release+0x47/0x100 drivers/mmc/core/host.c:69
 device_release+0xc4/0x1f0 drivers/base/core.c:-1
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x222/0x550 lib/kobject.c:737
 call_timer_fn+0x18d/0x5f0 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers kernel/time/timer.c:2374 [inline]
 __run_timer_base+0x652/0x8b0 kernel/time/timer.c:2386
 run_timer_base kernel/time/timer.c:2395 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2405
 handle_softirqs+0x226/0x860 kernel/softirq.c:645
 __do_softirq kernel/softirq.c:679 [inline]
 invoke_softirq kernel/softirq.c:519 [inline]
 __irq_exit_rcu+0xcb/0x220 kernel/softirq.c:767
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:784
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:lock_acquire+0x222/0x350 kernel/locking/lockdep.c:5890
Code: ff ff ff e8 a0 20 39 0a f7 44 24 08 00 02 00 00 0f 84 39 ff ff ff 65 48 8b 05 f2 0b ce 11 48 3b 44 24 58 75 33 fb 48 83 c4 60 <5b> 41 5c 41 5d 41 5e 41 5f 5d e9 cf 27 3c 0a cc 48 8d 3d a7 64 b9
RSP: 0018:ffffc90004307210 EFLAGS: 00000282
RAX: 2ab30850d67e6b00 RBX: 0000000000000000 RCX: 8000000000000003
RDX: 00000000dc7298f8 RSI: ffffffff8e4e132a RDI: ffffffff8c4cf580
RBP: ffffffff8242ba4a R08: ffffffff8242ba4a R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff8eb5a420 R12: 0000000000000002
R13: ffffffff8eb5a420 R14: 0000000000000000 R15: 0000000000000246
 rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 rcu_read_lock_sched include/linux/rcupdate.h:938 [inline]
 pfn_valid+0xd6/0x490 include/linux/mmzone.h:2266
 page_table_check_set+0x25/0x530 mm/page_table_check.c:105
 page_table_check_ptes_set include/linux/page_table_check.h:83 [inline]
 set_ptes include/linux/pgtable.h:447 [inline]
 __copy_present_ptes mm/memory.c:1138 [inline]
 copy_present_ptes mm/memory.c:1217 [inline]
 copy_pte_range mm/memory.c:1340 [inline]
 copy_pmd_range+0x4b46/0x5c50 mm/memory.c:1428
 copy_pud_range mm/memory.c:1465 [inline]
 copy_p4d_range mm/memory.c:1489 [inline]
 copy_page_range+0xc25/0x1230 mm/memory.c:1575
 dup_mmap+0xf17/0x1dc0 mm/mmap.c:1819
 dup_mm kernel/fork.c:1549 [inline]
 copy_mm+0x11a/0x480 kernel/fork.c:1601
 copy_process+0x1e75/0x43e0 kernel/fork.c:2313
 kernel_clone+0x2d7/0x940 kernel/fork.c:2772
 __do_sys_clone kernel/fork.c:2914 [inline]
 __se_sys_clone kernel/fork.c:2898 [inline]
 __x64_sys_clone+0x1b6/0x230 kernel/fork.c:2898
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5322fc6b52
Code: 89 e7 e8 71 8b f7 ff 45 31 c0 31 d2 31 f6 64 48 8b 04 25 10 00 00 00 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 66 89 c5 85 c0 75 3b 64 48 8b 04 25 10 00 00
RSP: 002b:00007f532334fc60 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007f532334fc60 RCX: 00007f5322fc6b52
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 00007f532334fdec R08: 0000000000000000 R09: 0000000000000001
R10: 0000555576c227d0 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000000927c0 R14: 0000000000039654 R15: 00007f532334fe40
 </TASK>
ODEBUG: object ffffc90000a08a80 is NOT on stack ffffc90004300000, but annotated.

======================================================
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	ff                   	ljmp   (bad)
   1:	e8 a0 20 39 0a       	call   0xa3920a6
   6:	f7 44 24 08 00 02 00 	testl  $0x200,0x8(%rsp)
   d:	00
   e:	0f 84 39 ff ff ff    	je     0xffffff4d
  14:	65 48 8b 05 f2 0b ce 	mov    %gs:0x11ce0bf2(%rip),%rax        # 0x11ce0c0e
  1b:	11
  1c:	48 3b 44 24 58       	cmp    0x58(%rsp),%rax
  21:	75 33                	jne    0x56
  23:	fb                   	sti
  24:	48 83 c4 60          	add    $0x60,%rsp
* 28:	5b                   	pop    %rbx <-- trapping instruction
  29:	41 5c                	pop    %r12
  2b:	41 5d                	pop    %r13
  2d:	41 5e                	pop    %r14
  2f:	41 5f                	pop    %r15
  31:	5d                   	pop    %rbp
  32:	e9 cf 27 3c 0a       	jmp    0xa3c2806
  37:	cc                   	int3
  38:	48                   	rex.W
  39:	8d                   	.byte 0x8d
  3a:	3d                   	.byte 0x3d
  3b:	a7                   	cmpsl  %es:(%rdi),%ds:(%rsi)
  3c:	64                   	fs
  3d:	b9                   	.byte 0xb9


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
