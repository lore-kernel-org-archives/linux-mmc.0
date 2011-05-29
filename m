From: Daniel Drake <dsd@laptop.org>
Subject: SDIO single IRQ optimization breaks libertas
Date: Sun, 29 May 2011 15:26:03 +0100
Message-ID: <BANLkTi=xWwWh2z2r3THvf5DzvhUCX_ZB7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64603 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754170Ab1E2O0E (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 29 May 2011 10:26:04 -0400
Received: by pwi15 with SMTP id 15so1339319pwi.19
        for <linux-mmc@vger.kernel.org>; Sun, 29 May 2011 07:26:03 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, stefan.xk.nilsson@stericsson.com
Cc: libertas-dev@lists.infradead.org

Hi,

The following commit in 2.6.39 causes instant death for libertas_sdio
when it receives its first interrupt during initialization:

commit 06e8935febe687e2a561707d4c7ca4245d261dbe
Author: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
Date:   Wed May 11 17:48:05 2011 +0200

    mmc: sdio: optimized SDIO IRQ handling for single irq



[   59.595601] libertas_sdio: Libertas SDIO driver
[   59.600581] libertas_sdio: Copyright Pierre Ossman
[   59.616424] BUG: unable to handle kernel NULL pointer dereference at   (null)
[   59.621371] IP: [<ed010e31>] if_sdio_interrupt+0x34/0x2cf [libertas_sdio]
[   59.621371] *pde = 00000000
[   59.621371] Oops: 0000 [#1] PREEMPT
[   59.621371] Modules linked in: libertas_sdio(+)
[   59.621371]
[   59.621371] Pid: 2102, comm: ksdioirqd/mmc1 Not tainted 2.6.39+ #28
OLPC XO/XO
[   59.621371] EIP: 0060:[<ed010e31>] EFLAGS: 00010246 CPU: 0
[   59.621371] EIP is at if_sdio_interrupt+0x34/0x2cf [libertas_sdio]
[   59.621371] EAX: 0000003a EBX: ea69ff64 ECX: ea69ff64 EDX: 00000005
[   59.621371] ESI: 00000000 EDI: e9afdc00 EBP: ea69ff78 ESP: ea69ff4c
[   59.621371]  DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068
[   59.621371] Process ksdioirqd/mmc1 (pid: 2102, ti=ea69e000
task=ea6c3240 task.ti=ea69e000)
[   59.621371] Stack:
[   59.621371]  ed011489 e9ad7600 00000000 00000000 ea6c3240 00000000
00100100 00200200
[   59.621371]  00000001 e9ad4800 e9afdc00 ea69ffac b0626bca ea6c3240
ea6c3240 00000001
[   59.621371]  ea699dac ea69ffac 7fffffff 00000001 00000000 ea699d98
e9ad4800 b0626b48
[   59.621371] Call Trace:
[   59.621371]  [<b0626bca>] sdio_irq_thread+0x82/0x1ed
[   59.621371]  [<b0626b48>] ? sdio_f0_writeb+0x5a/0x5a
[   59.621371]  [<b0436c40>] kthread+0x66/0x6b
[   59.621371]  [<b0436bda>] ? __init_kthread_worker+0x2d/0x2d
[   59.621371]  [<b06bac76>] kernel_thread_helper+0x6/0x10
[   59.621371] Code: 3e 8d 74 26 00 89 c3 8d 40 04 e8 83 27 5b c3 50
53 68 89 14 01 ed 8d 5d ec 89 45 e8 e8 16 46 6a c3 8b 75 e8 89 d9 ba
05 00 00 00 <8
[   59.621371] EIP: [<ed010e31>] if_sdio_interrupt+0x34/0x2cf
[libertas_sdio] SS:ESP 0068:ea69ff4c
[   59.621371] CR2: 0000000000000000
[   59.777660] ---[ end trace f1b099151b342535 ]---

Any thoughts?

Thanks,
Daniel
