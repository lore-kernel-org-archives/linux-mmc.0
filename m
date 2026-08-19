Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ADA225788
	for <linux-mmc@vger.kernel.org>; Wed, 19 Aug 2026 18:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787163205; cv=none; b=WpDQsau78X2Sfhyzo+TAqi/15F6Hthn6+2rXVkj2rPaijtf+KJibRJgkm0tS/W6XqswLISqlfnFQ71v6KXqPyJyHonlVjbuG/3IphvXGsyBKtr7uHs63WvdSLb8/fJD19Go32TCdO2vhA9WRNmSWQcLZClswKPpFZ/AZaFcVUqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787163205; c=relaxed/simple;
	bh=Ji5H397BwBGkRAkfa8lTlH/IWCiJMDfKdIMIxNzLkU0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=j9sTtv/M306koHwaap6h6yQOu7InmQILgx1cAKYr8B60HJLiIvu4jt78c+a9OIU/0FU0AL2p4oRnsGQzwvbb1k5Js8/51VwTKfuaL+FxD3R6Bc6GOH3jcaeiUK2W5O1lzGOkHb/LO2MzaD3+doWNBBxTTgHyU6+5RSoVsCF8Iyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-6b12d84686eso1361677eaf.3
        for <linux-mmc@vger.kernel.org>; Wed, 19 Aug 2026 11:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787163203; x=1787768003;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K+f1tCSMRaXnCgmZu2zRG6KoqZkzFU6BmX21iDBy/BU=;
        b=bNPjPZkTwex0lw62y9fZ+VscvKLGdQr3VQ3GpxB7kVA2DGb9aaVhiQnwS9jbGFJVax
         rqjC9l3R27g8JzHGHmH3KTA1NtU79Skuv8e1YcBNQSdICk1GK2pRqLTq1DvRdb5gLxvT
         RhrmZ8fItnRHeLGJhP74VdeUBg0DcvYHCfreYqXLVTNvKefBJi7LMcW8nEZPphRO3HFk
         p7AsbNtt+1xaFbTNLe3wdnP84t1Hx/xwsyhnZGMhhoLCBgDKE4XddpXQfrVivWlnGoee
         OFtMiXl5HuxsllaLcJYASoHoT+Z05qWix+4JvwPIPwMLu2kNf0xiuJnLbpfkSZRGvrrD
         F7gw==
X-Forwarded-Encrypted: i=1; AHgh+Rpi2qsMGxviXAV9t9Xim1D754iz28p1HMhBiwwYuFlK+x+ghoUFi4mpJFHabLF9FAW2fJ+TBN4sS+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbLXO00+a3iHe2rFB+eN3Y8ra7q2/LI/RPZVY8zT7VoHxrO8eR
	UzIIKN66k5N7E+62ahShR8wBKUycM5R3aPSfGYCbixwV87rUk/tYX6J6qtYmmhgzAaahM/53oo5
	hBNkSnQGQJrjpNXdFGF+Ykv6TT5HzEi/a6l9yUbuGFP9v+SrE86JQeFwPrkk=
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:7097:10b0:6b1:3da8:da1a with SMTP id
 006d021491bc7-6b13da8f107mr4662848eaf.17.1787163202968; Wed, 19 Aug 2026
 11:13:22 -0700 (PDT)
Date: Wed, 19 Aug 2026 11:13:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a85f242.c8649fcc.3bb87.0014.GAE@google.com>
Subject: [syzbot] [mmc?] WARNING in mmc_free_host
From: syzbot <syzbot+82a0a7de6d84867d030e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, ulf.hansson@linaro.org, ulfh@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8d3ae59288f1 Linux 7.2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1797d6c6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ca5f2f2c4197664
dashboard link: https://syzkaller.appspot.com/bug?extid=82a0a7de6d84867d030e
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4dc2f356959b/disk-8d3ae592.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1a5c72c8e23c/vmlinux-8d3ae592.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bc814d980581/bzImage-8d3ae592.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+82a0a7de6d84867d030e@syzkaller.appspotmail.com

------------[ cut here ]------------
do not call blocking ops when !TASK_RUNNING; state=1 set at [<ffffffff81880fbd>] do_wait+0x17d/0x510 kernel/exit.c:-1
WARNING: kernel/sched/core.c:9124 at __might_sleep+0x92/0xf0 kernel/sched/core.c:9120, CPU#0: syz-executor/16351
Modules linked in:
CPU: 0 UID: 0 PID: 16351 Comm: syz-executor Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:__might_sleep+0xac/0xf0 kernel/sched/core.c:9120
Code: 00 00 48 89 3c 24 41 89 f5 4c 8d 35 6e d3 c4 0e 43 80 3c 3c 00 74 08 48 89 df e8 bf 9b 9e 00 48 8b 0b 4c 89 f7 89 ee 48 89 ca <67> 48 0f b9 3a 44 89 ee 48 8b 3c 24 eb b5 44 89 f1 80 e1 07 80 c1
RSP: 0000:ffffc90000007c08 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88802fe5b770 RCX: ffffffff81880fbd
RDX: ffffffff81880fbd RSI: 0000000000000001 RDI: ffffffff905ae310
RBP: 0000000000000001 R08: ffffffff90578f37 R09: 1ffffffff20af1e6
R10: dffffc0000000000 R11: fffffbfff20af1e7 R12: 1ffff11005fcb6ee
R13: 0000000000001187 R14: ffffffff905ae310 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888124f49000(0063) knlGS:000000005776e480
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 000000003291fff8 CR3: 0000000055a7a000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
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
RIP: 0010:do_raw_read_lock+0x4/0x90 kernel/locking/spinlock_debug.c:160
Code: 91 00 e9 e5 fe ff ff 66 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 40 d6 <41> 56 53 48 89 fb 4c 8d 77 08 4c 89 f0 48 c1 e8 03 48 b9 00 00 00
RSP: 0000:ffffc900067c7b80 EFLAGS: 00000286
RAX: 2cb575fa076c2400 RBX: ffffc900067c7c80 RCX: 0000000080000001
RDX: 00000000d89f7662 RSI: ffffffff8e4b1d72 RDI: ffffffff8e80a040
RBP: ffff88802fe5b770 R08: ffffffff8187fba9 R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff8e80a058 R12: dffffc0000000000
R13: 1ffff92000cf8f90 R14: ffffc900067c7cb0 R15: 0000000000000004
 __do_wait+0xd9/0x720 kernel/exit.c:1712
 do_wait+0x1e7/0x510 kernel/exit.c:1756
 kernel_wait4+0x232/0x2b0 kernel/exit.c:1915
 __do_compat_sys_wait4 kernel/exit.c:1973 [inline]
 __se_compat_sys_wait4 kernel/exit.c:1966 [inline]
 __ia32_compat_sys_wait4+0x165/0x230 kernel/exit.c:1966
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 do_int80_emulation+0x19a/0x550 arch/x86/entry/syscall_32.c:172
 asm_int80_emulation+0x1a/0x20 arch/x86/include/asm/idtentry.h:598
RIP: 0023:0xf71074eb
Code: 57 56 53 8b 44 24 14 f6 00 08 75 23 8b 44 24 18 8b 5c 24 1c 8b 4c 24 20 8b 54 24 24 8b 74 24 28 8b 7c 24 2c 8b 6c 24 30 cd 80 <5b> 5e 5f 5d c3 5b 5e 5f 5d e9 f7 a1 ff ff 66 90 66 90 66 90 90 53
RSP: 002b:00000000f74efc6c EFLAGS: 00000246 ORIG_RAX: 0000000000000072
RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 00000000f74efe08
RDX: 0000000040000001 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	48 89 3c 24          	mov    %rdi,(%rsp)
   6:	41 89 f5             	mov    %esi,%r13d
   9:	4c 8d 35 6e d3 c4 0e 	lea    0xec4d36e(%rip),%r14        # 0xec4d37e
  10:	43 80 3c 3c 00       	cmpb   $0x0,(%r12,%r15,1)
  15:	74 08                	je     0x1f
  17:	48 89 df             	mov    %rbx,%rdi
  1a:	e8 bf 9b 9e 00       	call   0x9e9bde
  1f:	48 8b 0b             	mov    (%rbx),%rcx
  22:	4c 89 f7             	mov    %r14,%rdi
  25:	89 ee                	mov    %ebp,%esi
  27:	48 89 ca             	mov    %rcx,%rdx
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	44 89 ee             	mov    %r13d,%esi
  32:	48 8b 3c 24          	mov    (%rsp),%rdi
  36:	eb b5                	jmp    0xffffffed
  38:	44 89 f1             	mov    %r14d,%ecx
  3b:	80 e1 07             	and    $0x7,%cl
  3e:	80                   	.byte 0x80
  3f:	c1                   	.byte 0xc1


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
