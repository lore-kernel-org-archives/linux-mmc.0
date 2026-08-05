Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84399438488
	for <linux-mmc@vger.kernel.org>; Wed,  5 Aug 2026 22:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785969928; cv=none; b=jO7g/hQNXE73KZD0XpVrLPtO4O2h52at6+JznQ1Jr+5SlNfq+q6TDpU+BSQset3egSFcy5jhzrSNRjRJr9l7Xh3BSFEvtrGqcvjwZCF4Sa+kll9c56H8ppBwZE2j5LOXrnoPXc3aWZOiyOo+m+1Mu+A+NzBFVoFbmbQWqErSzps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785969928; c=relaxed/simple;
	bh=YrHDcDo8GXHxFLeubyhj8d2f9Sut8EYgN6+gpAr5O+E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Niqd9+Ql6vSziaPLa63alW7cW4bW4g64w9itJY4VSSRQRla5i71MrIMYEFuOOogItPCp9AUdcnEaG1JxR+rhDGY+nu68ZH/q4DXbuJyReLdyUsdaspEl5jMRR8BpkYF9za+Y/fi71ZfQyCfMstlXhR6zZI89M3N3RLkgrP47sCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-7e6b59d85dcso2113013a34.3
        for <linux-mmc@vger.kernel.org>; Wed, 05 Aug 2026 15:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785969925; x=1786574725;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DFpyOldZEHF9Yg/Zc3gaa8k23ww7akWYZmJqKRrl9dk=;
        b=K2CZosqE2A6haPmPNbppFHNm9/faRzHzNAxSC/CS98dkvG8JY4EG0u4eCW6XpPlg79
         pxCMmj7kAxnHZtvo5Sxk9LYXqQ32/y2tHuzS7iyOoz9gQgfrP0RPVupn85HdSbV1EChb
         aUd3zdLmOq3YErG5uwMTuUdI8fyNqG/xN98VJFAJaDgmVjKg8uaO92SWp2WYfcCHhj1a
         jB0mUQ9KEebfbpyH5nWozEeLGL9Zaz8Ak7DUi9lAFgzhiAym9H3rS7USveHwzEgG/TH/
         WcxOz4MQpldTeP7iXTxAqX/p0Bzqtd2TKEH8fj9JMKZYsZ3vBtktm061ONTijwUZ/Zy2
         2dZA==
X-Forwarded-Encrypted: i=1; AHgh+RrWF6P7N3Edd+xMBCdjeLmYHK7hv2ty7KpHahcPiN+kfy5s1HCPVQvNAJcC69P4wXnef8SapzBUmUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn/hSTQVILNx/HUyV+w6QRcilMcF/MRFLdPRiHOAjQArOrE/Wu
	JAH/epJ7+KUDFL5howtNSHmulbSiZkKROzrGzwo1G9frqojvXeeno1wwnfrGhW3JooylgfWuEsz
	TYlMblXj6qSvwqxRPN/St18/6bGX8l17T8w2oc/JWCRyV0kjouWXawqx4MFc=
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:ee0a:0:b0:6aa:f810:f579 with SMTP id
 006d021491bc7-6ae96c10190mr5678278eaf.4.1785969925419; Wed, 05 Aug 2026
 15:45:25 -0700 (PDT)
Date: Wed, 05 Aug 2026 15:45:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a73bd05.5aeeccc9.207e63.0004.GAE@google.com>
Subject: [syzbot] [mmc?] [mm?] BUG: sleeping function called from invalid
 context in mmc_free_host
From: syzbot <syzbot+0e06aa1bdc6495bac24b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-mmc@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	ulf.hansson@linaro.org, ulfh@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    848acc8ffe1b Merge tag 'fsverity-for-linus' of git://git.k..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=152c6cc6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e38b15c29e6a1d9
dashboard link: https://syzkaller.appspot.com/bug?extid=0e06aa1bdc6495bac24b
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=132c6cc6580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11137649580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4949138dcfef/disk-848acc8f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/31cc6fbe5b8a/vmlinux-848acc8f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/433919ca6520/bzImage-848acc8f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0e06aa1bdc6495bac24b@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at kernel/workqueue.c:4487
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/1
preempt_count: 101, expected: 0
RCU nest depth: 0, expected: 0
1 lock held by swapper/1/0:
 #0: ffffc90000a08cc0 ((&vub300->inactivity_timer)){+.-.}-{0:0}, at: call_timer_fn+0xd4/0x5e0 kernel/time/timer.c:1745
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <IRQ>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 __might_resched+0x378/0x4d0 kernel/sched/core.c:9197
 __cancel_work_sync+0x6d/0x110 kernel/workqueue.c:4487
 mmc_free_host+0x19/0x30 drivers/mmc/core/host.c:700
 call_timer_fn+0x192/0x5e0 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers kernel/time/timer.c:2374 [inline]
 __run_timer_base+0x652/0x8b0 kernel/time/timer.c:2386
 run_timer_base kernel/time/timer.c:2395 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2405
 handle_softirqs+0x225/0x840 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0xca/0x220 kernel/softirq.c:735
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:752
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:64
Code: ac 7e 02 e9 93 06 03 00 cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d d3 3e 18 00 fb f4 <c3> cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90
RSP: 0018:ffffc90000197e40 EFLAGS: 00000246
RAX: 000000000005e681 RBX: ffffffff819b5450 RCX: 0000000080000001
RDX: 0000000000000001 RSI: ffffffff8e22f174 RDI: ffffffff8c4bdd80
RBP: ffffc90000197f10 R08: ffff8880b87338db R09: 1ffff110170e671b
R10: dffffc0000000000 R11: ffffed10170e671c R12: 0000000000000000
R13: 1ffff11003c56000 R14: 1ffff92000032fd0 R15: dffffc0000000000
 arch_safe_halt arch/x86/kernel/process.c:767 [inline]
 default_idle+0x9/0x20 arch/x86/kernel/process.c:768
 default_idle_call+0x72/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:199 [inline]
 do_idle+0x2e0/0x540 kernel/sched/idle.c:355
 cpu_startup_entry+0x43/0x60 kernel/sched/idle.c:454
 start_secondary+0x101/0x110 arch/x86/kernel/smpboot.c:312
 common_startup_64+0x13e/0x157
 </TASK>
ODEBUG: object ffffc90000a08a80 is NOT on stack ffffc90000190000, but annotated.

======================================================
----------------
Code disassembly (best guess):
   0:	ac                   	lods   %ds:(%rsi),%al
   1:	7e 02                	jle    0x5
   3:	e9 93 06 03 00       	jmp    0x3069b
   8:	cc                   	int3
   9:	cc                   	int3
   a:	cc                   	int3
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
  16:	90                   	nop
  17:	90                   	nop
  18:	90                   	nop
  19:	90                   	nop
  1a:	90                   	nop
  1b:	f3 0f 1e fa          	endbr64
  1f:	66 90                	xchg   %ax,%ax
  21:	0f 00 2d d3 3e 18 00 	verw   0x183ed3(%rip)        # 0x183efb
  28:	fb                   	sti
  29:	f4                   	hlt
* 2a:	c3                   	ret <-- trapping instruction
  2b:	cc                   	int3
  2c:	cc                   	int3
  2d:	cc                   	int3
  2e:	cc                   	int3
  2f:	cc                   	int3
  30:	cc                   	int3
  31:	cc                   	int3
  32:	cc                   	int3
  33:	cc                   	int3
  34:	cc                   	int3
  35:	cc                   	int3
  36:	cc                   	int3
  37:	cc                   	int3
  38:	cc                   	int3
  39:	cc                   	int3
  3a:	cc                   	int3
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop


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
