From: Yoshii Takashi <takashi.yoshii.zj@renesas.com>
Subject: shdma: (or tmio_mmc?) inconsistent lock state detected on ag5evm
Date: Mon, 25 Jul 2011 18:28:19 +0900
Message-ID: <4E2D3733.6080607@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: g.liakhovetski@gmx.de, linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hello, Guennadi.
This was started as an evaluation of your patch
 [PATCH v2] mmc: tmio: fix recursive spinlock, don't schedule with interrupts disabled
But now I don't know where exactly the issue is. So, let me begin new thread.

On ag5evm(the board under arch/arm/mach-shmobile, that is SMP), both
 tag v3.0 + patch above, and
 tag v3.0 + cjb/mmc-next
with CONFIG_PROVE_LOCKING=y, inconsistent lock state is detected as text attached at
 the bottom.
Function itself(mount/read/write/umount) seems working without problem, so far.

As it happens on the spinlock at sh_dmae_interrupt(), it seems to have been there since
2dc66667 dmaengine: shdma: fix locking
which introduced the lock there.

I found deleting the spin_lock/unlock there makes it quiet. But that lock must be the
important part of the patch. Actually, deleting it brings another locking issue on
tmio_mmc, and it confuses me. I wonder what is the correct solution. I'm afraid I can't
tell what is the critical object to be protected in shdma and tmio_mmc source code...

Any suggestions are appreciated.
/yoshii

=================================
[ INFO: inconsistent lock state ]
3.0.0-00100-g82258ef-dirty #3643
---------------------------------
inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
swapper/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
 (&(&new_sh_chan->desc_lock)->rlock){?.-...}, at: [<c0795fc4>] sh_dmae_interrupt+0x14/0x78
{HARDIRQ-ON-W} state was registered at:
  [<c0689b30>] __lock_acquire+0x5c4/0xbb4
  [<c068a6f8>] lock_acquire+0x60/0x74
  [<c088da7c>] _raw_spin_lock_bh+0x3c/0x4c
  [<c0796edc>] sh_dmae_alloc_chan_resources+0x1b0/0x298
  [<c0794ca8>] dma_chan_get+0xd8/0x17c
  [<c0795560>] __dma_request_channel+0x140/0x1e4
  [<c07e5850>] tmio_mmc_request_dma+0x74/0x10c
  [<c0886b84>] tmio_mmc_host_probe+0x208/0x284
  [<c0886d68>] sh_mobile_sdhi_probe+0x168/0x28c
  [<c07bca4c>] platform_drv_probe+0x18/0x1c
  [<c07bb5b8>] driver_probe_device+0x7c/0x178
  [<c07bb748>] __driver_attach+0x94/0x98
  [<c07badbc>] bus_for_each_dev+0x60/0x8c
  [<c07ba5a4>] bus_add_driver+0xa8/0x2a4
  [<c07bbd24>] driver_register+0x78/0x18c
  [<c0633530>] do_one_initcall+0x34/0x184
  [<c00083d8>] kernel_init+0xa8/0x134
  [<c063a5a8>] kernel_thread_exit+0x0/0x8
irq event stamp: 17556
hardirqs last  enabled at (17553): [<c063a64c>] default_idle+0x24/0x2c
hardirqs last disabled at (17554): [<c0639674>] __irq_svc+0x34/0xa0
softirqs last  enabled at (17556): [<c065c878>] irq_enter+0x78/0x7c
softirqs last disabled at (17555): [<c065c86c>] irq_enter+0x6c/0x7c

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&(&new_sh_chan->desc_lock)->rlock);
  <Interrupt>
    lock(&(&new_sh_chan->desc_lock)->rlock);

 *** DEADLOCK ***

no locks held by swapper/0.

stack backtrace:
[<c063f730>] (unwind_backtrace+0x0/0xfc) from [<c0686358>] (print_usage_bug+0x21c/0x2bc)
[<c0686358>] (print_usage_bug+0x21c/0x2bc) from [<c0686908>] (mark_lock+0x510/0x740)
[<c0686908>] (mark_lock+0x510/0x740) from [<c0689ba4>] (__lock_acquire+0x638/0xbb4)
[<c0689ba4>] (__lock_acquire+0x638/0xbb4) from [<c068a6f8>] (lock_acquire+0x60/0x74)
[<c068a6f8>] (lock_acquire+0x60/0x74) from [<c088d868>] (_raw_spin_lock+0x34/0x44)
[<c088d868>] (_raw_spin_lock+0x34/0x44) from [<c0795fc4>] (sh_dmae_interrupt+0x14/0x78)
[<c0795fc4>] (sh_dmae_interrupt+0x14/0x78) from [<c0698f50>] (handle_irq_event_percpu+0x54/0x184)
[<c0698f50>] (handle_irq_event_percpu+0x54/0x184) from [<c06990bc>] (handle_irq_event+0x3c/0x5c)
[<c06990bc>] (handle_irq_event+0x3c/0x5c) from [<c069b6e8>] (handle_fasteoi_irq+0x9c/0x104)
[<c069b6e8>] (handle_fasteoi_irq+0x9c/0x104) from [<c0698eec>] (generic_handle_irq+0x28/0x30)
[<c0698eec>] (generic_handle_irq+0x28/0x30) from [<c0633058>] (asm_do_IRQ+0x58/0xb8)
[<c0633058>] (asm_do_IRQ+0x58/0xb8) from [<c0644acc>] (shmobile_handle_irq_gic+0xc/0x80)
Exception stack(0xc0951f70 to 0xc0951fb8)
1f60:                                     00000001 00004491 00000000 c0951fa8
1f80: c0950000 c0977604 c088f9c4 c0955b40 4000406a 412fc098 00000000 00000000
1fa0: 00000001 c0951fb8 00004490 c063a650 20000013 ffffffff
[<c0644acc>] (shmobile_handle_irq_gic+0xc/0x80) from [<00004491>] (0x4491)
mmc0: new high speed SD card at address b368
mmcblk0: mmc0:b368 SDC   489 MiB 
 mmcblk0: p1
