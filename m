From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 02/15] mmc: host: omap_hsmmc: return on fatal errors
 from omap_hsmmc_reg_get
Date: Mon, 31 Aug 2015 13:58:29 -0700
Message-ID: <20150831205829.GB4215@atomide.com>
References: <1440666847-12594-1-git-send-email-kishon@ti.com>
 <1440666847-12594-3-git-send-email-kishon@ti.com>
 <CAOesGMjW=3qqBfqdxGwEqk1uVj_08rnvP095V-9+O=rsmjLOxQ@mail.gmail.com>
 <20150828190354.GZ4215@atomide.com>
 <55E3E9B1.8070908@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55E3E9B1.8070908@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Olof Johansson <olof@lixom.net>, Ulf Hansson <ulf.hansson@linaro.org>, afenkart@gmail.com, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, Neil Brown <neilb@suse.de>
List-Id: linux-mmc@vger.kernel.org

* Kishon Vijay Abraham I <kishon@ti.com> [150830 22:47]:
> Hi,
> 
> On Saturday 29 August 2015 12:33 AM, Tony Lindgren wrote:
> > * Olof Johansson <olof@lixom.net> [150828 11:11]:
> >> Hi,
> >>
> >> On Thu, Aug 27, 2015 at 2:13 AM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> >>> Now return error only if the return value of
> >>> devm_regulator_get_optional() is not the same as -ENODEV, since with
> >>> -EPROBE_DEFER, the regulator can be obtained later and all other
> >>> errors are fatal.
> >>>
> >>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >>> Tested-by: Tony Lindgren <tony@atomide.com>
> >>
> >> I bisected boot failures on Panda ES with multi_v7_defconfig down to
> >> this commit on last night's -next build:
> >>
> >> http://arm-soc.lixom.net/bootlogs/next/next-20150828/pandaes-arm-multi_v7_defconfig.html
> > 
> > MMC is working for me at least on Duovero. Interesting that you also
> > have all kind of errors there, I guess this is some older revision
> > of the board.
> > 
> > Anyways, Kishon, care to look into what might be causing this?
> 
> I think this might be because my pbias fix [1] patch wasn't merged yet.
> I'll try to get that resolved asap.

Kishon, as there seems to be an ongoing discussion with the regulator regmap
stuff for pbias, I suggest you provide a fix for the hsmmc driver instead for
now or revert some patches to remove the dependency and get things working.

And I must have tested next-20150827 instead of next-20150828. Or
else it does not happen on every boot. In any case, I'm now getting
the following on next-20150831 most of the time:

[    9.493133] omap_hsmmc 4809c000.mmc: using lookup tables for GPIO lookup
[    9.500274] omap_hsmmc 4809c000.mmc: lookup for GPIO wp failed
[    9.506378] ------------[ cut here ]------------
[    9.508941] WARNING: CPU: 0 PID: 6 at drivers/bus/omap_l3_noc.c:147 l3_interrupt_handler+0x224/0x350()
[    9.520568] 44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4PER2 (Read): Data Access in User mode during Functional access
[    9.524810] Modules linked in: rtc_twl twl4030_wdt
[    9.534820] CPU: 0 PID: 6 Comm: kworker/u4:0 Not tainted 4.2.0-next-20150831-00002-gf55bad8 #1113
[    9.544830] Hardware name: Generic OMAP4 (Flattened Device Tree)
[    9.544830] Workqueue: deferwq deferred_probe_work_func
[    9.554809] [<c001770c>] (unwind_backtrace) from [<c0013a58>] (show_stack+0x10/0x14)
[    9.564819] [<c0013a58>] (show_stack) from [<c034efb4>] (dump_stack+0x84/0x9c)
[    9.574829] [<c034efb4>] (dump_stack) from [<c003e994>] (warn_slowpath_common+0x78/0xb4)
[    9.574951] [<c003e994>] (warn_slowpath_common) from [<c003ea00>] (warn_slowpath_fmt+0x30/0x40)
[    9.584686] [<c003ea00>] (warn_slowpath_fmt) from [<c037cc7c>] (l3_interrupt_handler+0x224/0x350)
[    9.594818] [<c037cc7c>] (l3_interrupt_handler) from [<c009e7b4>] (handle_irq_event_percpu+0x44/0x1f0)
[    9.604827] [<c009e7b4>] (handle_irq_event_percpu) from [<c009e9a0>] (handle_irq_event+0x40/0x64)
[    9.614807] [<c009e9a0>] (handle_irq_event) from [<c00a1a4c>] (handle_fasteoi_irq+0xcc/0x1c4)
[    9.625396] [<c00a1a4c>] (handle_fasteoi_irq) from [<c009de58>] (generic_handle_irq+0x28/0x3c)
[    9.638732] [<c009de58>] (generic_handle_irq) from [<c009e140>] (__handle_domain_irq+0x64/0xe0)
[    9.647827] [<c009e140>] (__handle_domain_irq) from [<c0009514>] (gic_handle_irq+0x40/0x8c)
[    9.654693] [<c0009514>] (gic_handle_irq) from [<c064ccb8>] (__irq_svc+0x58/0x78)
[    9.664367] Exception stack(0xee0cfd80 to 0xee0cfdc8)
[    9.665130] fd80: ee1ec010 c082f174 000000d0 00000000 ee6b0800 ee6ae850 ee1ec000 ee1ec010
[    9.674835] fda0: 00000000 ee6b0cc0 000000ee fa09c000 00000003 ee0cfdd0 c04cd748 c04df4e0
[    9.684814] fdc0: 20000113 ffffffff
[    9.684814] [<c064ccb8>] (__irq_svc) from [<c04df4e0>] (devm_clk_get+0x8/0x70)
[    9.694824] [<c04df4e0>] (devm_clk_get) from [<c04cd748>] (omap_hsmmc_probe+0x2e8/0x9f0)
[    9.704833] [<c04cd748>] (omap_hsmmc_probe) from [<c03e97f4>] (platform_drv_probe+0x44/0xac)
[    9.714691] [<c03e97f4>] (platform_drv_probe) from [<c03e7ea8>] (driver_probe_device+0x1f4/0x2f0)
[    9.724548] [<c03e7ea8>] (driver_probe_device) from [<c03e63b4>] (bus_for_each_drv+0x64/0x98)
[    9.733459] [<c03e63b4>] (bus_for_each_drv) from [<c03e7c28>] (__device_attach+0xb0/0x118)
[    9.734832] [<c03e7c28>] (__device_attach) from [<c03e71d0>] (bus_probe_device+0x88/0x90)
[    9.744812] [<c03e71d0>] (bus_probe_device) from [<c03e75f8>] (deferred_probe_work_func+0x60/0x90)
[    9.760040] [<c03e75f8>] (deferred_probe_work_func) from [<c00589f8>] (process_one_work+0x1a4/0x558)
[    9.769470] [<c00589f8>] (process_one_work) from [<c0058de8>] (worker_thread+0x3c/0x514)
[    9.774688] [<c0058de8>] (worker_thread) from [<c005eb88>] (kthread+0xd4/0xf0)
[    9.785614] [<c005eb88>] (kthread) from [<c000f710>] (ret_from_fork+0x14/0x24)
[    9.785614] ---[ end trace 402743bd8cfdde2f ]---
 
> [1] -> http://lkml.iu.edu/hypermail/linux/kernel/1507.3/01594.html

With patch 1/2 of the above applied, I'm getting this instead:

[    2.930938] ------------[ cut here ]------------
[    2.935852] WARNING: CPU: 0 PID: 6 at drivers/regulator/core.c:2105 _regulator_disable+0x13c/0x1d4()
[    2.945465] unbalanced disables for pbias_mmc_omap4
[    2.945465] Modules linked in:
[    2.950592] CPU: 0 PID: 6 Comm: kworker/u4:0 Not tainted 4.2.0-next-20150831-00003-gc5112ac-dirty #1114
[    2.963684] Hardware name: Generic OMAP4 (Flattened Device Tree)
[    2.970031] Workqueue: deferwq deferred_probe_work_func
[    2.975585] [<c001770c>] (unwind_backtrace) from [<c0013a58>] (show_stack+0x10/0x14)
[    2.983764] [<c0013a58>] (show_stack) from [<c034efb4>] (dump_stack+0x84/0x9c)
[    2.983764] [<c034efb4>] (dump_stack) from [<c003e994>] (warn_slowpath_common+0x78/0xb4)
[    2.999877] [<c003e994>] (warn_slowpath_common) from [<c003ea00>] (warn_slowpath_fmt+0x30/0x40)
[    3.009063] [<c003ea00>] (warn_slowpath_fmt) from [<c03ad830>] (_regulator_disable+0x13c/0x1d4)
[    3.018218] [<c03ad830>] (_regulator_disable) from [<c03ad8f8>] (regulator_disable+0x30/0x6c)
[    3.027221] [<c03ad8f8>] (regulator_disable) from [<c04cdfe8>] (omap_hsmmc_set_power+0x158/0x1e8)
[    3.027252] [<c04cdfe8>] (omap_hsmmc_set_power) from [<c04ce210>] (omap_hsmmc_set_ios+0x198/0x318)
[    3.046020] [<c04ce210>] (omap_hsmmc_set_ios) from [<c04b7da4>] (mmc_power_up.part.10+0x30/0xf8)
[    3.055267] [<c04b7da4>] (mmc_power_up.part.10) from [<c04b8cb0>] (mmc_start_host+0x40/0x7c)
[    3.064178] [<c04b8cb0>] (mmc_start_host) from [<c04b9dc4>] (mmc_add_host+0x5c/0x84)
[    3.072326] [<c04b9dc4>] (mmc_add_host) from [<c04cda50>] (omap_hsmmc_probe+0x5b0/0x9f0)
[    3.080871] [<c04cda50>] (omap_hsmmc_probe) from [<c03e9834>] (platform_drv_probe+0x44/0xac)
[    3.089752] [<c03e9834>] (platform_drv_probe) from [<c03e7ee8>] (driver_probe_device+0x1f4/0x2f0)
[    3.099090] [<c03e7ee8>] (driver_probe_device) from [<c03e63f4>] (bus_for_each_drv+0x64/0x98)
[    3.108093] [<c03e63f4>] (bus_for_each_drv) from [<c03e7c68>] (__device_attach+0xb0/0x118)
[    3.116790] [<c03e7c68>] (__device_attach) from [<c03e7210>] (bus_probe_device+0x88/0x90)
[    3.125427] [<c03e7210>] (bus_probe_device) from [<c03e7638>] (deferred_probe_work_func+0x60/0x90)
[    3.125427] [<c03e7638>] (deferred_probe_work_func) from [<c00589f8>] (process_one_work+0x1a4/0x558)
[    3.144470] [<c00589f8>] (process_one_work) from [<c0058de8>] (worker_thread+0x3c/0x514)
[    3.152984] [<c0058de8>] (worker_thread) from [<c005eb88>] (kthread+0xd4/0xf0)
[    3.160614] [<c005eb88>] (kthread) from [<c000f710>] (ret_from_fork+0x14/0x24)
[    3.160644] ---[ end trace 2869621ad5ef511c ]---

Regards,

Tony
