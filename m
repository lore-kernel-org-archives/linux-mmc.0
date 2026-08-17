Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7D2190462
	for <linux-mmc@vger.kernel.org>; Mon, 17 Aug 2026 20:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786999654; cv=none; b=ELo08mqsM7urt03EVCmCrwtB93ifVcdG3C1c35W9TuPLNRPcGaNgknTcDpmY+DbeT2UHG2v1Lcwv+SPEznFwClNPdfyt5/3W+yM493J3K+qcFRV2CDOJjBNP4k61792dO4YzQTpXUmj6Al4J9ymnyAFdAfaLyC2v8HTlbvUADzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786999654; c=relaxed/simple;
	bh=BGn2ujUovuTMukX4L67NrQfZG56K9yXJFYzNbXYpcm8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=H/MdeP7kAOpdOvcfC8xeydygSa0NoNpF7Mn18qJWc0l1uqOPFU1ONP5gjUqNpxnzJ9YDlO0yD4BKT7fBED3Abc3xmx7j4W2KV2Glet7tmVKvf05whe+u5NswBLPCFJLqO5CpiiaHEjHEltZQe3lzbTeIZr60Paj0LUNbYM87KvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-4a49f09233fso208317b6e.0
        for <linux-mmc@vger.kernel.org>; Mon, 17 Aug 2026 13:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786999652; x=1787604452;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u/Y2/CHiFCGoad8cy6uG4fSQ+ehLIX5B5GfrClKUFXc=;
        b=K8idux8W9Nt9q8y62U2vnX4awLioJuZzMfUM9KHowI4TTdWBs9kV+iAzMyIu59WcV6
         1XoXLdGKi+b4Pg+zYtToV4lRTGRq32H6Jfm1so+qpVftbe9aFr3ZKGTm+CYQHFKErx35
         FLzcUUhGHsy5CSCOucyGOEXfNCkbUYBwJoFKCrf1GrtZyrARL4HCVl47AUL1rPwxFZIE
         0ptavkbY2i+4TypZ+OXfjkmmyCiIPHkgua75xnd6UtjzpOTyvc0kLT2Dkkz4tJiewJyx
         iLpuughlAipd9DKg1OUcYJWfQR+7b0pcGv1E59kNij2p7y4vHXYACL+qMspKxaK8+Td3
         cjzw==
X-Forwarded-Encrypted: i=1; AHgh+RpTqZo+2EPqqqj22Bcwjz5CRrEiqPIBKMuLvP6l7gvhvLFW//8/cynMQlZ+TGYKK+zGDlA/BAy0XC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSrlZu0YGDtlmQR7u33rXQScG4KBQ7FA9pBfwEm+KHDrhHgB+s
	uO+6X4eNkZhDOK2STKQR4pRZwlzT7z9OgZiQuFZy25z4sc7HZutgPV4zr+J380OG42J+OID+ex4
	IvGb3isOqYb2bgsgayMyS73S/TbQxkM66frF9ycACCUSyWq0lgzLmz5HDkrw=
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:170b:b0:4b2:8dbf:ffd with SMTP id
 5614622812f47-4b29b1e7f2bmr1232455b6e.1.1786999652193; Mon, 17 Aug 2026
 13:47:32 -0700 (PDT)
Date: Mon, 17 Aug 2026 13:47:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a837364.dbb3a75c.20434b.0076.GAE@google.com>
Subject: [syzbot] [mmc?] WARNING in cancel_delayed_work_sync (2)
From: syzbot <syzbot+c40b1b2a25a7801239d2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, ulf.hansson@linaro.org, ulfh@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3eb40771c00a Merge tag 'soc-fixes-7.2-3' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14749949580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d67342c314f228d
dashboard link: https://syzkaller.appspot.com/bug?extid=c40b1b2a25a7801239d2
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/21569197c3cb/disk-3eb40771.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/09af5299a851/vmlinux-3eb40771.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c657b46695b7/bzImage-3eb40771.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c40b1b2a25a7801239d2@syzkaller.appspotmail.com

------------[ cut here ]------------
do not call blocking ops when !TASK_RUNNING; state=1 set at [<ffffffff89524b6d>] snd_rawmidi_write+0x44d/0xc60 sound/core/rawmidi.c:1614
WARNING: kernel/sched/core.c:9120 at __might_sleep+0x94/0xc0 kernel/sched/core.c:9120, CPU#1: syz.2.462/7622
Modules linked in:
CPU: 1 UID: 0 PID: 7622 Comm: syz.2.462 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
RIP: 0010:__might_sleep+0x97/0xc0 kernel/sched/core.c:9120
Code: 8b 94 24 70 18 00 00 48 85 d2 75 14 48 83 c4 08 89 ee 48 89 df 31 d2 5b 5d 41 5c e9 33 fc ff ff 48 8d 3d 0c 81 6f 0f 48 89 d1 <67> 48 0f b9 3a eb db e8 fd 3d a5 00 eb 9f 89 74 24 04 e8 22 3e a5
RSP: 0018:ffffc90000a08be8 EFLAGS: 00010282
RAX: dffffc0000000000 RBX: ffffffff8beddf40 RCX: ffffffff89524b6d
RDX: ffffffff89524b6d RSI: 0000000000000001 RDI: ffffffff91454550
RBP: 0000000000001187 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880291d4a80
R13: 1ffff9200014118e R14: ffffffff88b89840 R15: 0000000000000001
FS:  00007faa891ce6c0(0000) GS:ffff888123cde000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000004000 CR3: 000000002dc05000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
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
 handle_softirqs+0x1ea/0x9b0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x162/0x210 kernel/softirq.c:735
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:752
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa3/0xc0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:179 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x31/0x80 kernel/locking/spinlock.c:198
Code: f5 53 48 8b 74 24 10 48 89 fb 48 83 c7 18 e8 96 90 26 f6 48 89 df e8 1e e0 26 f6 f7 c5 00 02 00 00 75 23 9c 58 f6 c4 02 75 37 <bf> 01 00 00 00 e8 c5 ed 15 f6 65 8b 05 ee a6 c4 08 85 c0 74 16 5b
RSP: 0018:ffffc9000209f8e0 EFLAGS: 00000246
RAX: 0000000000000006 RBX: ffff8880b8526280 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8e3aced0 RDI: ffffffff8c600380
RBP: 0000000000000283 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff8880b8526280
R13: 0000000000000000 R14: 00000000ffffffff R15: ffff8880b85262c8
 __mod_timer+0x409/0xca0 kernel/time/timer.c:1139
 add_timer+0x62/0x90 kernel/time/timer.c:1249
 schedule_timeout+0x122/0x280 kernel/time/sleep_timeout.c:98
 snd_rawmidi_write+0x492/0xc60 sound/core/rawmidi.c:1616
 do_loop_readv_writev fs/read_write.c:851 [inline]
 do_loop_readv_writev fs/read_write.c:836 [inline]
 vfs_writev+0x5ed/0xdd0 fs/read_write.c:1060
 do_writev+0x28a/0x340 fs/read_write.c:1104
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7faa8839e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007faa891ce028 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00007faa88625fa0 RCX: 00007faa8839e0d9
RDX: 0000000000000002 RSI: 0000200000000840 RDI: 0000000000000005
RBP: 00007faa88435024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007faa88626038 R14: 00007faa88625fa0 R15: 00007fff04c4f0a8
 </TASK>
----------------
Code disassembly (best guess):
   0:	8b 94 24 70 18 00 00 	mov    0x1870(%rsp),%edx
   7:	48 85 d2             	test   %rdx,%rdx
   a:	75 14                	jne    0x20
   c:	48 83 c4 08          	add    $0x8,%rsp
  10:	89 ee                	mov    %ebp,%esi
  12:	48 89 df             	mov    %rbx,%rdi
  15:	31 d2                	xor    %edx,%edx
  17:	5b                   	pop    %rbx
  18:	5d                   	pop    %rbp
  19:	41 5c                	pop    %r12
  1b:	e9 33 fc ff ff       	jmp    0xfffffc53
  20:	48 8d 3d 0c 81 6f 0f 	lea    0xf6f810c(%rip),%rdi        # 0xf6f8133
  27:	48 89 d1             	mov    %rdx,%rcx
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	eb db                	jmp    0xc
  31:	e8 fd 3d a5 00       	call   0xa53e33
  36:	eb 9f                	jmp    0xffffffd7
  38:	89 74 24 04          	mov    %esi,0x4(%rsp)
  3c:	e8                   	.byte 0xe8
  3d:	22 3e                	and    (%rsi),%bh
  3f:	a5                   	movsl  %ds:(%rsi),%es:(%rdi)


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
