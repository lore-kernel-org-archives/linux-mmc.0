From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v3 02/15] mmc: host: omap_hsmmc: return on fatal errors
 from omap_hsmmc_reg_get
Date: Tue, 1 Sep 2015 17:54:09 +0300
Message-ID: <55E5BC11.8090002@ti.com>
References: <1440666847-12594-1-git-send-email-kishon@ti.com>
 <1440666847-12594-3-git-send-email-kishon@ti.com>
 <CAOesGMjW=3qqBfqdxGwEqk1uVj_08rnvP095V-9+O=rsmjLOxQ@mail.gmail.com>
 <20150828190354.GZ4215@atomide.com> <55E3E9B1.8070908@ti.com>
 <20150831205829.GB4215@atomide.com> <20150831211450.GC4215@atomide.com>
 <55E5B730.9020409@ti.com> <20150901145002.GE4215@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150901145002.GE4215@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Olof Johansson <olof@lixom.net>, Ulf Hansson <ulf.hansson@linaro.org>, afenkart@gmail.com, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, Neil Brown <neilb@suse.de>
List-Id: linux-mmc@vger.kernel.org

On 09/01/2015 05:50 PM, Tony Lindgren wrote:
> * Grygorii Strashko <grygorii.strashko@ti.com> [150901 07:36]:
>> On 09/01/2015 12:14 AM, Tony Lindgren wrote:
>>> * Tony Lindgren <tony@atomide.com> [150831 14:02]:
>>>>
>>>> And I must have tested next-20150827 instead of next-20150828. Or
>>>> else it does not happen on every boot. In any case, I'm now getting
>>>> the following on next-20150831 most of the time:
>>>>
>>>> [    9.493133] omap_hsmmc 4809c000.mmc: using lookup tables for GPIO lookup
>>>> [    9.500274] omap_hsmmc 4809c000.mmc: lookup for GPIO wp failed
>>>> [    9.506378] ------------[ cut here ]------------
>>>> [    9.508941] WARNING: CPU: 0 PID: 6 at drivers/bus/omap_l3_noc.c:147 l3_interrupt_handler+0x224/0x350()
>>>> [    9.520568] 44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4PER2 (Read): Data Access in User mode during Functional access
>>>> [    9.524810] Modules linked in: rtc_twl twl4030_wdt
>>>> [    9.534820] CPU: 0 PID: 6 Comm: kworker/u4:0 Not tainted 4.2.0-next-20150831-00002-gf55bad8 #1113
>>>> [    9.544830] Hardware name: Generic OMAP4 (Flattened Device Tree)
>>>> [    9.544830] Workqueue: deferwq deferred_probe_work_func
>>>> [    9.554809] [<c001770c>] (unwind_backtrace) from [<c0013a58>] (show_stack+0x10/0x14)
>>>> [    9.564819] [<c0013a58>] (show_stack) from [<c034efb4>] (dump_stack+0x84/0x9c)
>>>> [    9.574829] [<c034efb4>] (dump_stack) from [<c003e994>] (warn_slowpath_common+0x78/0xb4)
>>>> [    9.574951] [<c003e994>] (warn_slowpath_common) from [<c003ea00>] (warn_slowpath_fmt+0x30/0x40)
>>>> [    9.584686] [<c003ea00>] (warn_slowpath_fmt) from [<c037cc7c>] (l3_interrupt_handler+0x224/0x350)
>>>> [    9.594818] [<c037cc7c>] (l3_interrupt_handler) from [<c009e7b4>] (handle_irq_event_percpu+0x44/0x1f0)
>>>> [    9.604827] [<c009e7b4>] (handle_irq_event_percpu) from [<c009e9a0>] (handle_irq_event+0x40/0x64)
>>>> [    9.614807] [<c009e9a0>] (handle_irq_event) from [<c00a1a4c>] (handle_fasteoi_irq+0xcc/0x1c4)
>>>> [    9.625396] [<c00a1a4c>] (handle_fasteoi_irq) from [<c009de58>] (generic_handle_irq+0x28/0x3c)
>>>> [    9.638732] [<c009de58>] (generic_handle_irq) from [<c009e140>] (__handle_domain_irq+0x64/0xe0)
>>>> [    9.647827] [<c009e140>] (__handle_domain_irq) from [<c0009514>] (gic_handle_irq+0x40/0x8c)
>>>> [    9.654693] [<c0009514>] (gic_handle_irq) from [<c064ccb8>] (__irq_svc+0x58/0x78)
>>>> [    9.664367] Exception stack(0xee0cfd80 to 0xee0cfdc8)
>>>> [    9.665130] fd80: ee1ec010 c082f174 000000d0 00000000 ee6b0800 ee6ae850 ee1ec000 ee1ec010
>>>> [    9.674835] fda0: 00000000 ee6b0cc0 000000ee fa09c000 00000003 ee0cfdd0 c04cd748 c04df4e0
>>>> [    9.684814] fdc0: 20000113 ffffffff
>>>> [    9.684814] [<c064ccb8>] (__irq_svc) from [<c04df4e0>] (devm_clk_get+0x8/0x70)
>>>> [    9.694824] [<c04df4e0>] (devm_clk_get) from [<c04cd748>] (omap_hsmmc_probe+0x2e8/0x9f0)
>>>> [    9.704833] [<c04cd748>] (omap_hsmmc_probe) from [<c03e97f4>] (platform_drv_probe+0x44/0xac)
>>>> [    9.714691] [<c03e97f4>] (platform_drv_probe) from [<c03e7ea8>] (driver_probe_device+0x1f4/0x2f0)
>>>> [    9.724548] [<c03e7ea8>] (driver_probe_device) from [<c03e63b4>] (bus_for_each_drv+0x64/0x98)
>>>> [    9.733459] [<c03e63b4>] (bus_for_each_drv) from [<c03e7c28>] (__device_attach+0xb0/0x118)
>>>> [    9.734832] [<c03e7c28>] (__device_attach) from [<c03e71d0>] (bus_probe_device+0x88/0x90)
>>>> [    9.744812] [<c03e71d0>] (bus_probe_device) from [<c03e75f8>] (deferred_probe_work_func+0x60/0x90)
>>>> [    9.760040] [<c03e75f8>] (deferred_probe_work_func) from [<c00589f8>] (process_one_work+0x1a4/0x558)
>>>> [    9.769470] [<c00589f8>] (process_one_work) from [<c0058de8>] (worker_thread+0x3c/0x514)
>>>> [    9.774688] [<c0058de8>] (worker_thread) from [<c005eb88>] (kthread+0xd4/0xf0)
>>>> [    9.785614] [<c005eb88>] (kthread) from [<c000f710>] (ret_from_fork+0x14/0x24)
>>>> [    9.785614] ---[ end trace 402743bd8cfdde2f ]---
>>>
>>> And with the (currently almost useless) l3 interrupt stuff taken out by
>>> removing the ti,omap4-l3-noc compatible from omap4.dtsi, we get a real
>>> trace that might be of some help to you:
>>>
>>> [    8.440917] omap_hsmmc 4809c000.mmc: lookup for GPIO wp failed
>>> [    8.447418] Unhandled fault: imprecise external abort (0x1406) at 0xbeafaa10
>>> [    8.454925] pgd = c0004000
>>> [    8.454986] [beafaa10] *pgd=00000000/root/init: line 14: /sys/devices/68000000.ocp/4
>>> 8098000.spi/spi_master/spi1/spi1[    8.461334] Internal error: : 1406 [#1] SMP ARM
>>> .2/backlight/acx565akm/brightness: No such file [    8.473175] Modules linked in:or directory
>>>    rtc_twl twl4030_wdt
>>> [    8.483520] CPU: 1 PID: 66 Comm: kworker/u4:1 Not tainted 4.2.0-next-20150831-00002-gf55bad8-dirty #1115
>>> [    8.493652] Hardware name: Generic OMAP4 (Flattened Device Tree)
>>> [    8.498352] Workqueue: deferwq deferred_probe_work_func
>>> [    8.505493] task: ee5f4f40 ti: ee5f6000 task.ti: ee5f6000
>>> [    8.510803] PC is at devm_clk_get+0x8/0x70
>>> [    8.514801] LR is at omap_hsmmc_probe+0x2e8/0x9f0
>>> [    8.520385] pc : [<c04df4e0>]    lr : [<c04cd748>]    psr: 20010013
>>> [    8.520385] sp : ee5f7dd0  ip : 00000003  fp : fa09c000
>>> [    8.532470] r10: 000000ee  r9 : ee6904c0  r8 : 00000000
>>> [    8.537963] r7 : ee1ec010  r6 : ee1ec000  r5 : ee6e7dd0  r4 : ee690000
>>> [    8.544769] r3 : 00000000  r2 : 000000d0  r1 : c082f184  r0 : ee1ec010
>>> [    8.551666] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
>>> [    8.559143] Control: 10c5387d  Table: ae73804a  DAC: 00000051
>>> [    8.564727] Process kworker/u4:1 (pid: 66, stack limit = 0xee5f6218)
>>> [    8.571441] Stack: (0xee5f7dd0 to 0xee5f8000)
>>> [    8.576263] 7dc0:                                     ee690000 ee6e7dd0 ee1ec000 c04cd748
>>> [    8.584930] 7de0: 00000000 c09cf8f8 ee1ed270 ee5de150 00000000 ee090248 c11cb0d4 c09ae55c
>>> [    8.593597] 7e00: 00000000 ee1ec010 ee1ec010 c09ae55c fffffdfb 0000001d c09cf8f8 00000000
>>> [    8.601837] 7e20: c09cf8f8 c03e97f4 ee1ec010 c11cb118 c09ae55c 00000000 0000001d c03e7ea8
>>> [    8.610107] 7e40: 00000000 ee5f7e70 c03e803c 00000001 ee5f7ec8 c03e63b4 ee0f2ed4 ee5d6594
>>> [    8.619323] 7e60: ee1ec010 ee1ec010 ee1ec044 c03e7c28 ee1ec010 00000001 c099b110 ee1ec010
>>> [    8.627777] 7e80: ee1ec010 c099a708 ee61cf00 c03e71d0 ee1ec010 c099a3fc c099a3b8 c03e75f8
>>> [    8.636535] 7ea0: c099a434 ee371940 ee08a400 c00589f8 00000001 00000000 c0058968 ee08a400
>>> [    8.644805] 7ec0: c0058e5c 00000001 c099a434 c0b2a770 00000000 c0811a00 ee08a400 ee08a400
>>> [    8.653503] 7ee0: ee371958 ee08a430 ee5f6000 00000088 c09cf04c ee371940 ee08a400 c0058de8
>>> [    8.662261] 7f00: ee08a5d0 00000000 c0058dac 00000000 ee56af40 ee371940 c0058dac 00000000
>>> [    8.670532] 7f20: 00000000 00000000 00000000 c005eb88 1c4eefdf 00000000 00000000 ee371940
>>> [    8.679290] 7f40: 00000000 00000000 dead4ead ffffffff ffffffff c09d6da0 00000000 00000000
>>> [    8.679290] 7f60: c07d16a0 ee5f7f64 ee5f7f64 00000000 00000000 dead4ead ffffffff ffffffff
>>> [    8.696411] 7f80: c09d6da0 00000000 00000000 c07d16a0 ee5f7f90 ee5f7f90 ee5f7fac ee56af40
>>> [    8.705047] 7fa0: c005eab4 00000000 00000000 c000f710 00000000 00000000 00000000 00000000
>>> [    8.713562] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>>> [    8.721435] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000 2eade3dd cf5fffcd
>>> [    8.730743] [<c04df4e0>] (devm_clk_get) from [<c04cd748>] (omap_hsmmc_probe+0x2e8/0x9f0)
>>> [    8.738952] [<c04cd748>] (omap_hsmmc_probe) from [<c03e97f4>] (platform_drv_probe+0x44/0xac)
>>> [    8.748077] [<c03e97f4>] (platform_drv_probe) from [<c03e7ea8>] (driver_probe_device+0x1f4/0x2f0)
>>> [    8.757385] [<c03e7ea8>] (driver_probe_device) from [<c03e63b4>] (bus_for_each_drv+0x64/0x98)
>>> [    8.766326] [<c03e63b4>] (bus_for_each_drv) from [<c03e7c28>] (__device_attach+0xb0/0x118)
>>> [    8.774993] [<c03e7c28>] (__device_attach) from [<c03e71d0>] (bus_probe_device+0x88/0x90)
>>> [    8.783538] [<c03e71d0>] (bus_probe_device) from [<c03e75f8>] (deferred_probe_work_func+0x60/0x90)
>>> [    8.792907] [<c03e75f8>] (deferred_probe_work_func) from [<c00589f8>] (process_one_work+0x1a4/0x558)
>>> [    8.802490] [<c00589f8>] (process_one_work) from [<c0058de8>] (worker_thread+0x3c/0x514)
>>> [    8.810943] [<c0058de8>] (worker_thread) from [<c005eb88>] (kthread+0xd4/0xf0)
>>> [    8.818511] [<c005eb88>] (kthread) from [<c000f710>] (ret_from_fork+0x14/0x24)
>>> [    8.824737] Code: e5910000 ea000091 e92d4070 e3a020d0 (e1a06000)
>>> [    8.826141] ---[ end trace a89146bc4a70cc4d ]---
>>>
>>
>> On -next, Above crash signature could be related to race
>> "ARM: OMAP2+: omap-device: fix race deferred probe of omap_hsmmc vs omap_device_late_init"
>> http://www.spinics.net/lists/linux-omap/msg121622.html
>
> Good point thanks, yes that's the case. MMC probing fails and then we hit this
> separate issue while MMC is trying to probe. Applying your fix makes the
> abort disappear, but naturally does not get MMC working again.

you may need CONFIG_GPIO_PCF857X=y for dra7-evm

-- 
regards,
-grygorii
