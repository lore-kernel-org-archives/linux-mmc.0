From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: omap_hsmmc noisy/broken for suspend resume
Date: Fri, 4 Nov 2011 17:29:27 +0530
Message-ID: <CANrkHUapXcWiUaqwKpNWKC7V-u1dxniyaRuT4pMtBA=BdkpiCA@mail.gmail.com>
References: <878vnwhpbr.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:33266 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754921Ab1KDL72 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 4 Nov 2011 07:59:28 -0400
In-Reply-To: <878vnwhpbr.fsf@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Shubhrajyoti Datta <shubhrajyoti@ti.com>
Cc: svenkatr@ti.com, linux-omap <linux-omap@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, cjb@laptop.org, linux-mmc@vger.kernel.org

On Fri, Nov 4, 2011 at 2:54 AM, Kevin Hilman <khilman@ti.com> wrote:
>
> Hello,
>
> Using Linus' master branch, I was testing PM functionality on OMAP3/4
> and noticed that the MMC driver is now rather noisy during suspend on
> OMAP3[1], but seems to work.
>
> On OMAP4, MMC seems to prevent suspend/resume all together. =A0I have=
n't
> found the root cause, but know that by not buidling the MMC driver, I
> have working suspend/resume again on OMAP4.
>
> Venkat, can you investigate this?
>
> For OMAP4, please use my for_3.2/omap4-pm branch which has the OMAP4
> MPUSS retention support from Santosh.
>
With 4430SDP I observed abort on accessing I2C registers
probably i2c clock is not turned ON?

echo mem > /sys/power/state
[   41.971649] PM: Preparing system for mem sleep
[   41.976440] Freezing user space processes ... (elapsed 0.02 seconds)=
 done.
[   42.002838] Freezing remaining freezable tasks ... (elapsed 0.02
seconds) done.
[   42.033172] PM: Entering mem sleep
[   42.043212] omap_hsmmc omap_hsmmc.4: context was not lost
[   42.043212] omap_hsmmc omap_hsmmc.4: enabled
[   42.043212] mmc2: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0=
 timing 0
[   42.060852] omap_hsmmc omap_hsmmc.4: Set clock to 0Hz
[   42.066192] omap_device: omap_hsmmc.0: new worst case activate
latency 0: 5310058
[   42.074035] omap_hsmmc omap_hsmmc.0: context was not lost
[   42.074035] omap_hsmmc omap_hsmmc.0: enabled
[   42.074035] mmc1: starting CMD7 arg 00000000 flags 00000000
[   42.090026] omap_hsmmc omap_hsmmc.0: mmc1: CMD7, argument 0x00000000
[   42.096679] omap_hsmmc omap_hsmmc.0: IRQ Status is 1
[   42.096710] mmc1: req done (CMD7): 0: 00000000 00000000 00000000 000=
00000
[   42.109008] mmc1: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0=
 timing 0
[   42.116668] omap_hsmmc omap_hsmmc.0: Set clock to 0Hz
[   42.122009] omap_hsmmc omap_hsmmc.1: context was not lost
[   42.127655] omap_hsmmc omap_hsmmc.1: enabled
[   42.132171] mmc0: starting CMD7 arg 00000000 flags 00000000
[   42.138000] omap_hsmmc omap_hsmmc.1: mmc0: CMD7, argument 0x00000000
[   42.144653] omap_hsmmc omap_hsmmc.1: IRQ Status is 1
[   42.144653] mmc0: req done (CMD7): 0: 00000000 00000000 00000000 000=
00000
[   42.159301] mmc0: starting CMD5 arg 00018000 flags 0000001d
[   42.165130] omap_hsmmc omap_hsmmc.1: mmc0: CMD5, argument 0x00018000
[   42.171783] omap_hsmmc omap_hsmmc.1: IRQ Status is 1
[   42.176971] omap_hsmmc omap_hsmmc.1: IRQ Status is 2
[   42.176971] mmc0: req done (CMD5): 0: 00000600 00000000 00000000 000=
00000
[   42.189270] mmc0: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0=
 timing 0
[   42.196929] TWL6030 IRQ 0x0 0x8 0x0
[   42.203765] omap_hsmmc omap_hsmmc.1: Set clock to 0Hz
[   42.203765] PM: suspend of devices complete after 166.717 msecs
[   42.216003] omap_hsmmc omap_hsmmc.4: disabled
[   42.221801] omap_hsmmc omap_hsmmc.0: disabled
[   42.226379] omap_hsmmc omap_hsmmc.1: disabled
[   42.230926] PM: late suspend of devices complete after 14.923 msecs
[   42.237609] Disabling non-boot CPUs ...
[   42.241790] Unhandled fault: imprecise external abort (0x1406) at 0x=
4005a000
[   42.241851] Internal error: : 1406 [#1] SMP
[   42.253509] Modules linked in:
[   42.256713] CPU: 0    Not tainted  (3.1.0-00165-g97d4c96-dirty #12)
[   42.256713] PC is at omap_i2c_wait_for_bb+0x88/0xa8
[   42.268341] LR is at omap_i2c_wait_for_bb+0x10/0xa8
[   42.273437] pc : [<c0351d84>]    lr : [<c0351d0c>]    psr: 40000013
[   42.273437] sp : ef9dfee8  ip : ffff7e58  fp : ef8f2c00
[   42.273437] r10: ffff7e58  r9 : c035249c  r8 : 00000001
[   42.285430] r7 : c0c0c43c  r6 : c063e080  r5 : c063e080  r4 : ef8f2c=
00
[   42.285430] r3 : 00000000  r2 : 00000028  r1 : 00000028  r0 : 000000=
80
[   42.304504] Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
Segment kernel
[   42.304504] Control: 10c53c7d  Table: af10404a  DAC: 00000017
[   42.304504] Process twl6030-irq (pid: 251, stack limit =3D 0xef9de2f=
8)
[   42.304504] Stack: (0xef9dfee8 to 0xef9e0000)
[   42.329284] fee0:                   ef8f2ca8 00000000 c063e080
c03524c8 ef9dfef8 00000001
[   42.337829] ff00: ef997460 ef8f2c70 c02b7ce4 ef8f2c60 00000000
c063e080 c0c0c43c 00000001
[   42.337829] ff20: c035249c ffff7e58 00000004 c0350188 ef9dff84
00000000 c0c0c454 00000068
[   42.354888] ff40: c0c0c3cc c0c0c3c4 c0c0c434 c02b7d2c 00000000
00000008 00000000 c0c0c640
[   42.363433] ff60: ef9dff84 c0c0c640 c047cba4 00000027 00000030
00000000 00000000 c02b8fc8
[   42.363433] ff80: 60000013 000000d0 ef833d18 00000002 00000027
c02b8e88 00000000 00000000
[   42.380493] ffa0: 00000000 c0073628 00000001 00000000 00000027
00000000 00000000 dead4ead
[   42.380493] ffc0: ffffffff ffffffff c06d4a74 00000000 00000000
c05628f4 ef9dffd8 ef9dffd8
[   42.380493] ffe0: ef833d18 ef833d18 c00735a0 c0015358 00000013
c0015358 64946642 61340b38
[   42.380493] [<c0351d84>] (omap_i2c_wait_for_bb+0x88/0xa8) from
[<c03524c8>] (omap_i2c_xfer+0x2c/0x388)
[   42.415832] [<c03524c8>] (omap_i2c_xfer+0x2c/0x388) from
[<c0350188>] (i2c_transfer+0xa8/0x118)
[   42.415832] [<c0350188>] (i2c_transfer+0xa8/0x118) from
[<c02b7d2c>] (twl_i2c_write+0xa8/0x124)
[   42.433990] [<c02b7d2c>] (twl_i2c_write+0xa8/0x124) from
[<c02b8fc8>] (twl6030_irq_thread+0x140/0x1a4)
[   42.443725] [<c02b8fc8>] (twl6030_irq_thread+0x140/0x1a4) from
[<c0073628>] (kthread+0x88/0x90)
[   42.443725] [<c0073628>] (kthread+0x88/0x90) from [<c0015358>]
(kernel_thread_exit+0x0/0x8)
[   42.461517] Code: e1a00312 e19010bc e3110a01 1afffff1 (e3a00000)
[   42.467895] ---[ end trace bfbd839e645b5cd8 ]---
[   42.473388] CPU1: shutdown
