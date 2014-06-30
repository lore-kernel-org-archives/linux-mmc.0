From: Sachin Kamat <spk.linux@gmail.com>
Subject: Re: [PATCH 0/4] ARM: remove the sub-node and deprecated
 supports-highspeed property.
Date: Mon, 30 Jun 2014 15:46:31 +0530
Message-ID: <CAK5sBcG++_fCi3dK5v-sa-pW8cyAJBexNweBSeuPONfj7s7sHw@mail.gmail.com>
References: <1404112951-29467-1-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:62550 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486AbaF3KQd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Jun 2014 06:16:33 -0400
In-Reply-To: <1404112951-29467-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>, heiko@sntech.de, dinguyen@altera.com, Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene.kim@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Jaehoon,

On Mon, Jun 30, 2014 at 12:52 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Since used the mmc_of_parse(), didn't parse the sub-node.
> So we can remove the sub-node, because almost SoC used the only one card per a host.
> And supports-highspeed can be replaced to "cap-mmc/sd-highspeed" property.
>
> Jaehoon Chung (4):
>   mmc: dw_mmc: modify the dt-binding for removing slot-node and
>     supports-highspeed
>   ARM: dts: exynos: unuse the slot-node and deprecated the
>     supports-highspeed for dw-mmc

I still get the below crash on Exynos5250 Arndale boards with the above patches.
It works fine on 5250 Snow board.

[    3.072323] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot
req 50000000Hz, actual 50000000HZ div = 0)
[    3.072421] mmc1: new high speed SDHC card at address aaaa
[    3.075159] mmcblk1: mmc1:aaaa SU04G 3.69 GiB (ro)
[    3.076614]  mmcblk1: p1 p2 p3
[    3.098050] of_get_named_gpiod_flags exited with status 0
[    3.103444] of_get_named_gpiod_flags exited with status 0
[    3.108836] gpio-144: gpiod_set_debounce: missing set() or
set_debounce() operations
[    3.116626] gpio-145: gpiod_set_debounce: missing set() or
set_debounce() operations
[    3.124326] gpio-146: gpiod_set_debounce: missing set() or
set_debounce() operations
[    3.132060] gpio-147: gpiod_set_debounce: missing set() or
set_debounce() operations
[    3.139780] gpio-148: gpiod_set_debounce: missing set() or
set_debounce() operations
[    3.147507] gpio-149: gpiod_set_debounce: missing set() or
set_debounce() operations
[    3.155458] input: gpio_keys as /devices/gpio_keys/input/input0
[    3.161395] s3c-rtc 101e0000.rtc: setting system clock to
2000-01-01 00:00:00 UTC (946684800)
[    3.184653] hdmi-en: disabling
[    3.186272] MAIN_DC: disabling
[    3.190510] VFS: Cannot open root device "mmcblk1p3" or
unknown-block(179,35): error -30
[    3.197417] Please append a correct "root=" boot option; here are
the available partitions:
[    3.205736] b300         3907584 mmcblk0  driver: mmcblk
[    3.211009]   b301         2352800 mmcblk0p1 00000000-01
[    3.216269]   b302          507872 mmcblk0p2 00000000-02
[    3.221563]   b303          507840 mmcblk0p3 00000000-03
[    3.226858]   b304          507840 mmcblk0p4 00000000-04
[    3.232155] b318             128 mmcblk0rpmb  (driver?)
[    3.237363] b310            1024 mmcblk0boot1  (driver?)
[    3.242657] b308            1024 mmcblk0boot0  (driver?)
[    3.247951] b320         3872256 mmcblk1  driver: mmcblk
[    3.253246]   b321            4095 mmcblk1p1 0005ac11-01
[    3.258539]   b322           53248 mmcblk1p2 0005ac11-02
[    3.263835]   b323         3814912 mmcblk1p3 0005ac11-03
[    3.269132] Kernel panic - not syncing: VFS: Unable to mount root
fs on unknown-block(179,35)
[    3.277647] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W
3.16.0-rc3-next-20140630-00049-g6a4f4b293862 #182
[    3.288161] [<c0014230>] (unwind_backtrace) from [<c001150c>]
(show_stack+0x10/0x14)
[    3.295878] [<c001150c>] (show_stack) from [<c03c2ff0>]
(dump_stack+0x84/0xc4)
[    3.303079] [<c03c2ff0>] (dump_stack) from [<c03c24c4>] (panic+0xa4/0x200)
[    3.309937] [<c03c24c4>] (panic) from [<c052e0c8>]
(mount_block_root+0x218/0x298)
[    3.317403] [<c052e0c8>] (mount_block_root) from [<c052e428>]
(prepare_namespace+0x190/0x1d4)
[    3.325910] [<c052e428>] (prepare_namespace) from [<c052dd94>]
(kernel_init_freeable+0x1c8/0x1d8)
[    3.334763] [<c052dd94>] (kernel_init_freeable) from [<c03c16d4>]
(kernel_init+0xc/0xe8)
[    3.342835] [<c03c16d4>] (kernel_init) from [<c000e638>]
(ret_from_fork+0x14/0x3c)
[    3.350388] CPU1: stopping
[    3.353070] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W
3.16.0-rc3-next-20140630-00049-g6a4f4b293862 #182
[    3.363586] [<c0014230>] (unwind_backtrace) from [<c001150c>]
(show_stack+0x10/0x14)
[    3.371306] [<c001150c>] (show_stack) from [<c03c2ff0>]
(dump_stack+0x84/0xc4)
[    3.378507] [<c03c2ff0>] (dump_stack) from [<c0013508>]
(handle_IPI+0x17c/0x18c)
[    3.385885] [<c0013508>] (handle_IPI) from [<c00085f8>]
(gic_handle_irq+0x64/0x68)
[    3.393438] [<c00085f8>] (gic_handle_irq) from [<c0012080>]
(__irq_svc+0x40/0x70)
[    3.400898] Exception stack(0xee09ffa0 to 0xee09ffe8)
[    3.405930] ffa0: 00000001 c04a5378 0000058a 00000000 ee09e030
c0576484 c03cba84 c05ab257
[    3.414095] ffc0: c05ab257 ee09e000 00000000 00000000 c0305d78
ee09ffe8 c000f1a0 c000f1a4
[    3.422251] ffe0: 60000113 ffffffff
[    3.425724] [<c0012080>] (__irq_svc) from [<c000f1a4>]
(arch_cpu_idle+0x2c/0x30)
[    3.433109] [<c000f1a4>] (arch_cpu_idle) from [<c00514fc>]
(cpu_startup_entry+0x118/0x174)
[    3.441351] [<c00514fc>] (cpu_startup_entry) from [<40008684>] (0x40008684)
[    3.448294] ---[ end Kernel panic - not syncing: VFS: Unable to
mount root fs on unknown-block(179,35)

-- 
Regards,
Sachin.
