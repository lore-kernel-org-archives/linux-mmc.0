From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/8] mmc: dw_mmc-rockchip: allow tuning using the
 clk-phase api
Date: Fri, 9 Oct 2015 10:10:54 +0200
Message-ID: <CAPDyKFr6WV-o8Td9eJVkuCgaeNjdLr2GpaC32c3026bFmOJiYQ@mail.gmail.com>
References: <1443622064-14362-1-git-send-email-heiko@sntech.de>
	<CAPDyKFqeo--AiW_zHHrSqoOdFNZ3J_FgJpz2L7Z8gZnNmQZSig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqeo--AiW_zHHrSqoOdFNZ3J_FgJpz2L7Z8gZnNmQZSig@mail.gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, Doug Anderson <dianders@chromium.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-clk@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Alexandru Stan <amstan@chromium.org>
List-Id: linux-mmc@vger.kernel.org

On 8 October 2015 at 19:36, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 30 September 2015 at 16:07, Heiko Stuebner <heiko@sntech.de> wrote:
>> This series resurrects and adapts some individual patches whose sum
>> enable the dw_mmc hosts on Rockchip socs to tune clock phases using
>> the generic phase api (rk3288 and following have this capability).
>>
>> The changes to the original mmc-phase clocks are expanded by further
>> findings resulting from devices being used in the field.
>>
>> Similarly the regulator handling changes do use the brand new
>> regulator_set_voltage_triplet call to allow specifying lower and upper
>> limits. One possible point of discussion are the two voltage ranges
>> that are tried for the 3.3V signal level. Trying to stay near vmmc
>> at first and only then opening the range to the full 2.7-3.6V.
>>
>> This mainly circumvents a shortcoming of the regulator voltage
>> setting, in that even with regulator_set_voltage_triplet the regulator
>> framework will take the lowest possible voltage when the possible
>> voltages are below the target voltage. While it may be ideal to solve
>> this on the regulator side, I'm not seeing this appearing in the short
>> term, mainly because all regulator parts (including regulator drivers)
>> are keyed to selecting the lowest voltage from the range, while on the
>> mmc side we know which voltages may work and trying this in two steps
>> does not create to much overhead, as unsupported voltages are already
>> filtered out by the regulator_is_voltage_selected calls.
>>
>> changes since v1:
>> - address comment from Jaehoon Chung and keep this local to Rockchip
>>   for the time being
>> - address comments from Ulf and Doug in making it more explicit
>>   that the two-step 3.3V voltage setting essentially works around
>>   a limitation of regulator_set_voltage_triplet
>>
>> Alexandru M Stan (3):
>>   mmc: dw_mmc-rockchip: dt-binding: Add tuning related things
>>   mmc: dw_mmc: Generic MMC tuning with the clock phase framework
>>   ARM: dts: rockchip: Add drive/sample clocks for rk3288 dw_mmc devices
>>
>> Douglas Anderson (4):
>>   clk: rockchip: Allow more precision for some mmc clock phases
>>   clk: rockchip: Make calculations use rounding
>>   mmc: core: Add mmc_regulator_set_vqmmc()
>>   mmc: dw_mmc: Use mmc_regulator_set_vqmmc in
>>     start_signal_voltage_switch
>>
>> Heiko Stuebner (1):
>>   ARM: dts: rockchip: add tuning related settings to veyron devices
>>
>>  .../devicetree/bindings/mmc/rockchip-dw-mshc.txt   |  13 ++
>>  arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi         |   7 +-
>>  arch/arm/boot/dts/rk3288-veyron.dtsi               |   6 +
>>  arch/arm/boot/dts/rk3288.dtsi                      |  20 ++-
>>  drivers/clk/rockchip/clk-mmc-phase.c               |  54 ++++---
>>  drivers/mmc/core/core.c                            |  74 ++++++++++
>>  drivers/mmc/host/dw_mmc-rockchip.c                 | 162 +++++++++++++++++++++
>>  drivers/mmc/host/dw_mmc.c                          |  17 +--
>>  include/linux/mmc/host.h                           |   7 +
>>  9 files changed, 321 insertions(+), 39 deletions(-)
>>
>> --
>> 2.5.1
>>
>
> Thanks, applied for next!
>
> Kind regards
> Uffe

Dough, Heiko,

This patchset seems to be causing a boot regression for exynos5800-peach-pi [1].

Apparently, the vmmc regulator doesn't exist for one of the controller
but vqmmc is. This leads to the following NULL pointer exception.

.....

[    5.672281] dwmmc_exynos 12210000.mmc: No vmmc regulator found
[    5.678234] dwmmc_exynos 12210000.mmc: allocated mmc-pwrseq
[    5.683890] Unable to handle kernel NULL pointer dereference at
virtual address 0000001d
[    5.691727] pgd = c0204000
[    5.694296] [0000001d] *pgd=00000000
[    5.697853] Internal error: Oops: 17 [#1] SMP ARM
[    5.702538] Modules linked in: snd_soc_max98090 exynosdrm
snd_soc_core rtc_max77802 max77802 spi_s3c64xx snd_compress
snd_pcm_dmaengine snd_pcm pwm_samsung snd_timer clk_max77802 snd
soundcore rtc_s3c exynos_adc phy_exynos_usb2 ohci_exynos
[    5.723702] CPU: 6 PID: 83 Comm: kworker/u16:1 Not tainted
4.3.0-rc4-00051-gaf00b2580295 #1
[    5.732053] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[    5.738120] Workqueue: deferwq deferred_probe_work_func
[    5.743305] task: ed7297c0 ti: ed780000 task.ti: ed780000
[    5.746177] ntc-thermistor 12d10000.adc:ncp15wb473@3: Thermistor
type: ncp15wb473 successfully probed.
[    5.746514] ntc-thermistor 12d10000.adc:ncp15wb473@4: Thermistor
type: ncp15wb473 successfully probed.
[    5.746913] ntc-thermistor 12d10000.adc:ncp15wb473@5: Thermistor
type: ncp15wb473 successfully probed.
[    5.747150] ntc-thermistor 12d10000.adc:ncp15wb473@6: Thermistor
type: ncp15wb473 successfully probed.
[    5.785853] PC is at regulator_get_voltage+0x8/0x34
[    5.790681] LR is at mmc_regulator_set_vqmmc+0x40/0xe8
[    5.795798] pc : [<c0553bcc>]    lr : [<c080b820>]    psr: 80000013
[    5.795798] sp : ed781dd0  ip : ec02e5f8  fp : 00000000
[    5.807269] r10: 00000000  r9 : ec02e700  r8 : 00000000
[    5.812450] r7 : 00000000  r6 : 00000001  r5 : 00000000  r4 : ffffffed
[    5.818958] r3 : ec02e400  r2 : 00000000  r1 : ec02e5f8  r0 : ffffffed
[    5.825466] Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[    5.832579] Control: 10c5387d  Table: 6c18006a  DAC: 00000051
[    5.838303] Process kworker/u16:1 (pid: 83, stack limit = 0xed780220)
[    5.844722] Stack: (0xed781dd0 to 0xed782000)
[    5.849061] 1dc0:                                     ec02e400
ec02e400 00000000 c080b820
[    5.857240] 1de0: ec57da10 00000000 00000001 00000000 00000000
c08330e0 c0833074 ec02e400
[    5.865395] 1e00: ec02e5f8 c080cb58 00000000 ec02e400 00000000
ec02e400 00000000 c080d83c
[    5.873550] 1e20: ec02e400 c080e8b8 00000001 ec57da10 00000000
c083460c 00000040 c0cbe7e0
[    5.881704] 1e40: ec57da10 ed223bc0 ed23d410 00000000 c0ac26a8
17d78400 edfc15b4 ec57da10
[    5.889858] 1e60: ec57da10 fffffffe ed23d410 fffffdfb c0f3a920
0000000b ed723080 00000001
[    5.898013] 1e80: 00000001 c0623668 c0623620 ed23d410 c0fbde24
00000000 c0f3a920 c0622098
[    5.906168] 1ea0: 00000000 ed781ed0 c0622344 00000001 00000000
c0620730 ed08b770 ed3836b8
[    5.914323] 1ec0: ed23d410 ed23d444 c0f1a910 c0621e2c ed23d410
00000001 00000002 ed23d410
[    5.922477] 1ee0: ed23d410 c0f1a910 ed7a3800 c06215a8 ed23d410
c0f1a8b0 c0f1a898 c0621980
[    5.930631] 1f00: ed723080 c0f1a8cc ed01b800 c025ed00 ed781f5c
ed01b800 00000001 ed01b814
[    5.938785] 1f20: 00000001 ed01b800 ed723098 00000088 ed723080
ed01b800 00000001 c025ef60
[    5.946940] 1f40: ed7297c0 ed762000 00000000 ed723080 c025ef38
00000000 00000000 00000000
[    5.955094] 1f60: 00000000 c02640a0 ed083dc0 00000000 00000000
ed723080 00000000 00000000
[    5.963249] 1f80: ed781f80 ed781f80 00000000 00000000 ed781f90
ed781f90 ed781fac ed762000
[    5.971403] 1fa0: c0263fc8 00000000 00000000 c0210b38 00000000
00000000 00000000 00000000
[    5.979557] 1fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    5.987712] 1fe0: 00000000 00000000 00000000 00000000 00000013
00000000 00000000 00000000
[    5.995883] [<c0553bcc>] (regulator_get_voltage) from [<c080b820>]
(mmc_regulator_set_vqmmc+0x40/0xe8)
[    6.005158] [<c080b820>] (mmc_regulator_set_vqmmc) from
[<c08330e0>] (dw_mci_switch_voltage+0x6c/0x84)
[    6.014438] [<c08330e0>] (dw_mci_switch_voltage) from [<c080cb58>]
(mmc_power_up+0x68/0x104)
[    6.022852] [<c080cb58>] (mmc_power_up) from [<c080d83c>]
(mmc_start_host+0x50/0x80)
[    6.030569] [<c080d83c>] (mmc_start_host) from [<c080e8b8>]
(mmc_add_host+0x58/0x7c)
[    6.038289] [<c080e8b8>] (mmc_add_host) from [<c083460c>]
(dw_mci_probe+0x5d8/0xc68)
[    6.046013] [<c083460c>] (dw_mci_probe) from [<c0623668>]
(platform_drv_probe+0x48/0xa4)
[    6.054082] [<c0623668>] (platform_drv_probe) from [<c0622098>]
(driver_probe_device+0x1e0/0x2a0)
[    6.062930] [<c0622098>] (driver_probe_device) from [<c0620730>]
(bus_for_each_drv+0x44/0x8c)
[    6.071434] [<c0620730>] (bus_for_each_drv) from [<c0621e2c>]
(__device_attach+0xa0/0x104)
[    6.079670] [<c0621e2c>] (__device_attach) from [<c06215a8>]
(bus_probe_device+0x84/0x8c)
[    6.087825] [<c06215a8>] (bus_probe_device) from [<c0621980>]
(deferred_probe_work_func+0x5c/0x88)
[    6.096763] [<c0621980>] (deferred_probe_work_func) from
[<c025ed00>] (process_one_work+0x134/0x338)
[    6.105871] [<c025ed00>] (process_one_work) from [<c025ef60>]
(worker_thread+0x28/0x4cc)
[    6.113938] [<c025ef60>] (worker_thread) from [<c02640a0>]
(kthread+0xd8/0xf4)
[    6.121139] [<c02640a0>] (kthread) from [<c0210b38>]
(ret_from_fork+0x14/0x3c)
[    6.128333] Code: e5843010 eaffffdb e92d4038 e1a04000 (e5900030)
[    6.134460] ---[ end trace ee25ca3d5cf9ee44 ]---

....

Looking into the new mmc_regulator_set_vqmmc() API, I believe it's
quite obvious where the error is, as there's a missing validation of
"mmc->supply.vmmc" before trying regulator_get_voltage() for it.

I think this is the proper solution:
- Instead of using the "mmc->supply.vmmc" to fetch the current voltage
level, let's use "mmc->ios.vdd" (we need to translate the bit into a
voltage levels), which thus make the new the API independent of valid
regulator for vmmc.

Until we fixed that, I am dropping patch3 and onwards.

Kind regards
Uffe

[1]
http://kernelci.org/boot/exynos5800-peach-pi/job/ulfh/kernel/v4.3-rc4-51-gaf00b2580295/defconfig/multi_v7_defconfig/
