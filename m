From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: 4.13 on thinkpad x220: oops when writing to SD card
Date: Wed, 6 Sep 2017 10:44:35 +0800
Message-ID: <8f0f7310-ea4d-a200-75fd-23509947fb38@rock-chips.com>
References: <20170905194739.GA31241@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170905194739.GA31241@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, linux-mmc@vger.kernel.org
Cc: kernel list <linux-kernel@vger.kernel.org>, adrian.hunter@intel.com, shawn.lin@rock-chips.com, Seraphime Kirkovski <kirkseraph@gmail.com>
List-Id: linux-mmc@vger.kernel.org

+ Seraphime

On 2017/9/6 3:47, Pavel Machek wrote:
> Hi!
> 
> I tried to write to the MMC card; process hung and I got this in the
> dmesg.


A similar report for 4.13 cycle was here:

https://lkml.org/lkml/2017/8/10/824

Seems 4.13-rc4 was already broken for that but unfortuantely I didn't
reproduce that. So maybe Seraphime can do git-bisect as he said "I get
it everytime" for which I assume it could be easy for him to find out
the problematic commit?

> 
> [15909.353822] usb 2-1.2: Product: Ethernet Gadget
> [15909.353826] usb 2-1.2: Manufacturer: Linux
> 4.12.0-03002-gec979a4-dirty with musb-hdrc
> [15909.362182] cdc_ether 2-1.2:1.0 usb0: register 'cdc_ether' at
> usb-0000:00:1d.0-1.2, CDC Ethernet Device, e2:f7:c0:44:db:77
> [16109.316302] perf: interrupt took too long (2544 > 2500), lowering
> kernel.perf_event_max_sample_rate to 78500
> [18273.845406] mmc0: error -123 whilst initialising SD card
> [18275.327982] mmc0: new high speed SDHC card at address 0003
> [18275.328962] mmcblk0: mmc0:0003 SB08G 7.21 GiB
> [18275.333698]  mmcblk0: p1 p2 p3
> [18275.955293] EXT4-fs (mmcblk0p3): mounting ext3 file system using
> the ext4 subsystem
> [18276.013021] EXT4-fs (mmcblk0p3): recovery complete
> [18276.016185] EXT4-fs (mmcblk0p3): mounted filesystem with ordered
> data mode. Opts: (null)
> [18306.524676]  mmcblk0: p1 p2 p3
> [18439.780298] perf: interrupt took too long (3258 > 3180), lowering
> kernel.perf_event_max_sample_rate to 61250
> [19137.696497] perf: interrupt took too long (4082 > 4072), lowering
> kernel.perf_event_max_sample_rate to 49000
> [19925.945831] general protection fault: 0000 [#1] SMP
> [19925.945909] Modules linked in:
> [19925.945940] CPU: 2 PID: 30540 Comm: mmcqd/0 Not tainted 4.13.0 #123
> [19925.946010] Hardware name: LENOVO 42872WU/42872WU, BIOS 8DET73WW
> (1.43 ) 10/12/2016
> [19925.946168] task: ffff88001de9e800 task.stack: ffffc900087d4000
> [19925.946293] RIP: 0010:blk_rq_map_sg+0x21a/0x4a3
> [19925.946376] RSP: 0000:ffffc900087d7d10 EFLAGS: 00010202
> [19925.946479] RAX: 6b6b6b6b6b6b6b68 RBX: 0000000000002000 RCX:
> 0000000000002000
> [19925.946622] RDX: 6b6b6b6b6b6b6b6b RSI: 000000006eed2000 RDI:
> ffff88009e32b9e0
> [19925.946767] RBP: ffffc900087d7d68 R08: 0000000000000000 R09:
> 0000000063188000
> [19925.946919] R10: 0000160000000000 R11: 6db6db6db6db6db7 R12:
> 0000000000000000
> [19925.947059] R13: 0000000000001000 R14: 0000000000000002 R15:
> ffffea00015ad5c0
> [19925.947197] FS:  0000000000000000(0000) GS:ffff88019e280000(0000)
> knlGS:0000000000000000
> [19925.947347] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [19925.947454] CR2: 000000004482a000 CR3: 000000000521d000 CR4:
> 00000000000406a0
> [19925.947586] Call Trace:
> [19925.947634]  mmc_queue_map_sg+0x2f/0xa3
> [19925.947703]  mmc_blk_rw_rq_prep+0x1fa/0x3d8
> [19925.947777]  mmc_blk_issue_rw_rq+0xe8/0x419
> [19925.947852]  mmc_blk_issue_rq+0x589/0x6e7
> [19925.947924]  mmc_queue_thread+0xe1/0x175
> [19925.947996]  kthread+0x13d/0x145
> [19925.948050]  ? mmc_blk_issue_rq+0x6e7/0x6e7
> [19925.948125]  ? kthread_bind+0x2c/0x2c
> [19925.948191]  ? do_int80_syscall_32+0x5c/0xb4
> [19925.948269]  ? SyS_exit_group+0xf/0xf
> [19925.948337]  ret_from_fork+0x22/0x30
> [19925.948394] Code: 89 e8 4a 8d 74 06 ff 48 09 f7 48 39 fa 75 05 89
> 48 0c eb 39 48 85 c0 74 0e 48 83 20 fd 48 89 c7 e8 83 02 02 00 eb 04
> 48 8b 45 b0 <48> 8b 10 83 e2 03 41 f6 c7 03 74 02 0f 0b 4c 09 fa 48 89
> 10 8b
> [19925.948980] RIP: blk_rq_map_sg+0x21a/0x4a3 RSP: ffffc900087d7d10
> [19925.958464] ---[ end trace 3ddfa379837fe00b ]---
> pavel@duo:~$ uname -a
> Linux duo 4.13.0 #123 SMP Mon Sep 4 10:42:23 CEST 2017 x86_64
> GNU/Linux
> pavel@duo:~$
> 
> Similar crash happened yesterday, but that time I got panic (blinking
> capslock) and stripes on screen. I did not use MMC before.
> 
> Any ideas?
> 
> Thanks,
> 									Pavel
> 
