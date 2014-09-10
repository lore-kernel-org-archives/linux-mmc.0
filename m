From: Paolo Pisati <p.pisati@gmail.com>
Subject: 3.15+: omap4: mmc: multi_v7: can't boot off mmc
Date: Wed, 10 Sep 2014 17:33:16 +0200
Message-ID: <20140910153316.GA12169@luxor.wired.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-mmc' <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

I'm having an hard time making the vanilla v7_defconfig boot off the mmc on my
pandaboard:

[    1.698272] omap_hsmmc 4809c000.mmc: unable to get vmmc regulator -517
[    1.705139] platform 4809c000.mmc: Driver omap_hsmmc requests probe deferral
[    1.712890] omap_hsmmc 480d5000.mmc: unable to get vmmc regulator -517
[    1.719787] platform 480d5000.mmc: Driver omap_hsmmc requests probe deferral
[    1.727691] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.734619] usbcore: registered new interface driver usbhid
[    1.740478] usbhid: USB HID core driver
[    1.749359] TCP: cubic registered
[    1.752838] NET: Registered protocol family 17
[    1.757690] Key type dns_resolver registered
[    1.762756] Power Management for TI OMAP4+ devices.
[    1.767883] Power Management for TI OMAP4.
[    1.772186] OMAP4 PM: u-boot >= v2012.07 is required for full PM support
[    1.779296] ThumbEE CPU extension supported.
[    1.779296] Registering SWP/SWPB emulation handler
[    1.790008] vwl1271: 1800 mV 
[    1.794952] Skipping twl internal clock init and using bootloader value (unknown osc rate)
[    1.805358] twl 0-0048: PIH (irq 39) nested IRQs
[    1.811340] twl_rtc rtc.14: Power up reset detected.
[    1.817260] twl_rtc rtc.14: Enabling TWL-RTC
[    1.824249] twl_rtc rtc.14: rtc core: registered rtc.14 as rtc0
[    1.831451] VAUX1_6030: 1000 <--> 3000 mV at 1800 mV 
[    1.837677] VAUX2_6030: 1200 <--> 2800 mV at 1800 mV 
[    1.844024] VAUX3_6030: 1000 <--> 3000 mV at 1200 mV 
[    1.850311] VMMC: 1200 <--> 3000 mV at 3000 mV 
[    1.855957] VPP: 1800 <--> 2500 mV at 1900 mV 
[    1.861572] VUSIM: 1200 <--> 2900 mV at 1800 mV 
[    1.866577] VDAC: 1800 mV 
[    1.869964] VANA: 2100 mV 
[    1.874114] VCXIO: 1800 mV 
[    1.877624] VUSB: 3300 mV 
[    1.881317] V1V8: 1800 mV 
[    1.884979] V2V1: 2100 mV 
[    1.967407] usb 1-1: new high-speed USB device number 2 using ehci-omap
[    2.094512] omap_i2c 48070000.i2c: bus 0 rev0.10 at 400 kHz
[    2.104583] omap_i2c 48072000.i2c: bus 1 rev0.10 at 400 kHz
[    2.114044] omap_i2c 48060000.i2c: bus 2 rev0.10 at 100 kHz
[    2.121582] hub 1-1:1.0: USB hub found
[    2.125854] hub 1-1:1.0: 5 ports detected
[    2.131744] omap_i2c 48350000.i2c: bus 3 rev0.10 at 400 kHz
[    2.140686] omap_hsmmc 4809c000.mmc: pins are not configured from the driver
[    2.321166] twl_rtc rtc.14: setting system clock to 2000-01-01 00:00:00 UTC (946684800)
[    2.336578] ALSA device list:
[    2.339782]   No soundcards found.
[    2.339782] VFS: Cannot open root device "mmcblk0p2" or unknown-block(0,0): error -6
[    2.352478] Please append a correct "root=" boot option; here are the available partitions:
[    2.361297] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
[    2.367980] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 3.14.0-12143-g552e691 #70
[    2.377716] [<c02155f4>] (unwind_backtrace) from [<c0211234>] (show_stack+0x10/0x14)
[    2.385864] [<c0211234>] (show_stack) from [<c080b2c8>] (dump_stack+0x88/0x98)
[    2.390289] [<c080b2c8>] (dump_stack) from [<c0808d10>] (panic+0xa0/0x208)
[    2.400695] [<c0808d10>] (panic) from [<c0ade00c>] (mount_block_root+0x1a0/0x230)
[    2.408569] [<c0ade00c>] (mount_block_root) from [<c0ade1a4>] (mount_root+0x108/0x110)
[    2.408569] [<c0ade1a4>] (mount_root) from [<c0ade304>] (prepare_namespace+0x158/0x1a0)
[    2.425292] [<c0ade304>] (prepare_namespace) from [<c0addcc8>] (kernel_init_freeable+0x1cc/0x1dc)
[    2.430084] [<c0addcc8>] (kernel_init_freeable) from [<c0806184>] (kernel_init+0x8/0xf0)
[    2.443145] [<c0806184>] (kernel_init) from [<c020e338>] (ret_from_fork+0x14/0x3c)
[    2.447967] CPU0: stopping
[    2.451110] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.14.0-12143-g552e691 #70
[    2.451110] [<c02155f4>] (unwind_backtrace) from [<c0211234>] (show_stack+0x10/0x14)
[    2.451110] [<c0211234>] (show_stack) from [<c080b2c8>] (dump_stack+0x88/0x98)
[    2.451110] [<c080b2c8>] (dump_stack) from [<c0213e1c>] (handle_IPI+0x148/0x174)
[    2.477386] [<c0213e1c>] (handle_IPI) from [<c0208818>] (gic_handle_irq+0x58/0x5c)
[    2.477386] [<c0208818>] (gic_handle_irq) from [<c0211dc0>] (__irq_svc+0x40/0x50)
[    2.477386] Exception stack(0xc0b6def0 to 0xc0b6df38)
[    2.506256] dee0:                                     00000000 c0b7bf54 c0b7bf54 0000004c
[    2.506256] df00: 91be7a33 00000000 92080d44 00000000 eaf94de8 c0c8f2bc 00000000 ea4bdd94
[    2.523437] df20: 00000010 c0b6df38 c06bcbf8 c06bcc04 60000153 ffffffff
[    2.523437] [<c0211dc0>] (__irq_svc) from [<c06bcc04>] (cpuidle_enter_state+0x68/0xf8)
[    2.523437] [<c06bcc04>] (cpuidle_enter_state) from [<c06be65c>] (cpuidle_enter_state_coupled+0x130/0x378)
[    2.523437] [<c06be65c>] (cpuidle_enter_state_coupled) from [<c0277ed4>] (cpu_startup_entry+0x200/0x230)
[    2.558868] [<c0277ed4>] (cpu_startup_entry) from [<c0addaf0>] (start_kernel+0x348/0x354)
[    2.567474] [<c0addaf0>] (start_kernel) from [<80208074>] (0x80208074)
[    2.567474] ---[ end Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)

i tracked it down to the "PBIAS on DT" merge in 3.15-rc1:

commit 97e18dc007546fce8e99098480b921a02ebb3037
Merge: 042f7b7 c674801
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed Apr 9 08:39:39 2014 -0700

    Merge tag 'mmc-updates-for-3.15-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc

in particular those commits:

mmc: omap_hsmmc: remove pbias workaround
ARM: OMAP: enable SYSCON and REGULATOR_PBIAS in omap2plus_defconfig
ARM: dts: add pbias dt node
mmc: omap_hsmmc: adapt hsmmc to use pbias regulator
regulator: add pbias regulator support

but i've turned on REGULATOR_PBIAS in my config and i still can't boot multi_v7 off mmc on my pandas, any idea
what could it be?
-- 
bye,
p.
