From: Joel Fernandes <joelf@ti.com>
Subject: Re: ARM: AM335x: Kernel oops when using EDMA and MMC
Date: Wed, 17 Jul 2013 11:38:35 -0500
Message-ID: <51E6C88B.8090608@ti.com>
References: <51E6BE84.6080905@newflow.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <51E6BE84.6080905@newflow.co.uk>
Sender: linux-omap-owner@vger.kernel.org
To: Mark Jackson <mpfj-list@newflow.co.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Balaji TK <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

On 07/17/2013 10:55 AM, Mark Jackson wrote:
> I'm trying to get the MMC port working on our custom AM3352 CPU board.
> 
> I have added MMC entries to out dts file (similar to [1]), and I've
> enabled CONFIG_TI_EDMA.
> 
> Our board boots fine without an SD card inserted ...
> 
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 3.11.0-rc1-00025-g95b9b72 (mpfj@mpfj-nanobone) (gcc version 4.6.3 (Buildroot 2013.02-dirty) ) #309 Wed Jul 17 16:37:28 BST 2013
> ...
> [    2.789028] VFS: Mounted root (ubifs filesystem) on device 0:12.
> [    2.797268] devtmpfs: mounted
> [    2.801032] Freeing unused kernel memory: 200K (c0551000 - c0583000)
> ...
> Welcome to Buildroot
> nanobone login:
> 
> But when I boot with a card already inserted, I get the following oops ...
> 
> ...
> [    1.827343] Unable to handle kernel NULL pointer dereference at virtual address 0000000c
> [    1.835868] pgd = c0004000
> [    1.838774] [0000000c] *pgd=00000000
> [    1.842556] Internal error: Oops: 5 [#1] ARM
> [    1.847063] CPU: 0 PID: 6 Comm: kworker/u2:0 Not tainted 3.11.0-rc1-00025-g95b9b72 #309
> [    1.855511] Workqueue: kmmcd mmc_rescan
> [    1.859556] task: cf06a080 ti: cf072000 task.ti: cf072000
> [    1.865257] PC is at omap_hsmmc_start_command+0x74/0xf4
> [    1.870761] LR is at omap_hsmmc_request+0xec/0x4dc
> [    1.875806] pc : [<c0305b70>]    lr : [<c0306c64>]    psr: 60000113
> [    1.875806] sp : cf073ca0  ip : 00000000  fp : 00000008
> [    1.887885] r10: cf073de8  r9 : 00000001  r8 : cf11d918
> [    1.893382] r7 : 00000003  r6 : cf33cc80  r5 : 00000001  r4 : 00000033
> [    1.900250] r3 : 00020000  r2 : cf073db8  r1 : cf073d84  r0 : cf33cc80
> [    1.907122] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> [    1.914813] Control: 10c5387d  Table: 80004019  DAC: 00000015
> [    1.920859] Process kworker/u2:0 (pid: 6, stack limit = 0xcf072238)
> [    1.927454] Stack: (0xcf073ca0 to 0xcf074000)
> [    1.932048] 3ca0: cf33c800 cf073d40 00000003 00000000 c0076a8c cf073d40 48060220 48060220
> [    1.940659] 3cc0: 00000004 00000004 00000002 00000002 cf073ec8 c0421a9c c051835c cf073d40
> [    1.949271] 3ce0: cf33c800 00000001 00000008 00000008 00000002 cf073db8 cf073ec8 c02f0f28
> [    1.957882] 3d00: 00000200 00000064 00000000 cf073db8 cf073ec8 cf073d40 cf073d50 00000000
> [    1.966493] 3d20: cf33c800 c02f18a4 cf369800 cf369a80 00000000 cf360880 00000008 c02f9964
> [    1.975104] 3d40: 00000000 cf073d84 cf073db8 00000000 00000001 00000001 dead4ead ffffffff
> [    1.983717] 3d60: ffffffff c0af722c c06aa3e4 00000000 c04ddadc cf073d74 cf073d74 c02f0dc4
> [    1.992327] 3d80: 00000000 00000033 00000000 00000000 00000000 00000000 00000000 000000b5
> [    2.000938] 3da0: 00000000 00000000 00000000 00000000 cf073db8 cf073d40 05f5e100 00000000
> [    2.009548] 3dc0: 00000008 00000001 00000000 00000200 00000000 00000000 cf073d40 00000001
> [    2.018159] 3de0: cf073de8 00000000 c0cf1c02 00000880 00000008 8f360880 00000000 cf369800
> [    2.026771] 3e00: cf33c800 00000000 cf369800 cf073e4c cf072000 c02f8740 00000000 00000015
> [    2.035382] 3e20: 00000003 cf33c800 00000000 00000000 cf369800 cf073e4c cf072000 c02f8b20
> [    2.043994] 3e40: 00000002 c02f25cc 00000002 02544d53 41303447 1026c914 2600bbbd c0ff8000
> [    2.052605] 3e60: c0455884 cf33c800 00000000 c0455884 c0455890 00000000 cf072000 c02f92bc
> [    2.061217] 3e80: c0455890 00ff8000 00000002 cf33cb14 cf33c800 c02f3a28 cf041ac0 cf33cb14
> [    2.069829] 3ea0: cf050c00 cf051c00 00000000 c00507ec 00000002 00000000 c0050778 c0050f10
> [    2.078441] 3ec0: 00000000 00000000 c0af7268 c06aa1c4 00000000 c0518cd0 cf06a080 cf041ac0
> [    2.087054] 3ee0: cf050c00 cf072000 cf050c30 cf041ad8 00000089 c05d7b5c cf050c00 c0050e4c
> [    2.095665] 3f00: 00000000 cf072000 60000113 cf04dda8 00000000 cf041ac0 c0050d08 00000000
> [    2.104276] 3f20: 00000000 00000000 00000000 c0056c94 c0429a18 00000000 00000001 cf041ac0
> [    2.112888] 3f40: 00000000 00000001 dead4ead ffffffff ffffffff c05ec0a0 00000000 00000000
> [    2.121499] 3f60: c04ddadc cf073f64 cf073f64 00000000 00000001 dead4ead ffffffff ffffffff
> [    2.130112] 3f80: c05ec0a0 00000000 00000000 c04ddadc cf073f90 cf073f90 cf073fac cf04dda8
> [    2.138724] 3fa0: c0056bf0 00000000 00000000 c0013588 00000000 00000000 00000000 00000000
> [    2.147334] 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    2.155946] 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000 57e0c5db 5ffb7d3c
> [    2.164565] [<c0305b70>] (omap_hsmmc_start_command+0x74/0xf4) from [<00000003>] (0x3)
> [    2.172814] Code: 13a03801 0a00001b e590c008 e5914000 (e59cc00c)
> [    2.179314] ---[ end trace 6ec9899a56aef6aa ]---
> 
> I have also noticed that when the kernel boots okay (without a card inserted), if
> I then insert a card, nothing happens (even with CONFIG_MMC_DEBUG=y) ... including
> no kernel oops.
> 
> Can anyone shed light on what's wrong ?

I see this issue too on -rc1. The mmc host pointer is mangled but this could be
due to something totally unrelated.

Can you first please try rebasing on 3.10 instead of 3.11-rc1?

Thanks,

-Joel
