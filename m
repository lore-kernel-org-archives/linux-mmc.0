From: Sachin Kamat <sachin.kamat@samsung.com>
Subject: MMC regression with linux-next on Exynos5250
Date: Wed, 18 Jun 2014 15:41:43 +0530
Message-ID: <CAK5sBcEVEWwyHLj_y1=eTqWNELuahMUwrtyX2W_YzLe70Dsa4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:55076 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965039AbaFRKLp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Jun 2014 06:11:45 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: jh80.chung@samsung.com, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, tgih.jun@samsung.com, Sachin Kamat <spk.linux@gmail.com>, linux-samsung-soc@vger.kernel.org

Hi Jaehoon,

I get the below crash on Exyos5250 based Arndale board with linux-next
(20140618) kernel.
Looks like the following patch is causing it
Commit da118915cc72 " mmc: dw_mmc: replace "disable-wp" from slot's
quirk to host's quirk"

Reverting the above patch fixes the issue.

The below changes in dts file also did not help.

diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts
b/arch/arm/boot/dts/exynos5250-arndale.dts
index d0de1f50d15b..617fc5fe50f7 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -422,6 +422,7 @@
                num-slots = <1>;
                supports-highspeed;
                card-detect-delay = <200>;
+               disable-wp;
                samsung,dw-mshc-ciu-div = <3>;
                samsung,dw-mshc-sdr-timing = <2 3>;
                samsung,dw-mshc-ddr-timing = <1 2>;
@@ -432,7 +433,6 @@
                slot@0 {
                        reg = <0>;
                        bus-width = <4>;
-                       disable-wp;
                };
        };

Please check.


-- [    2.043665] mmc_host mmc0: Bus speed (slot 0) = 100000000Hz
(slot req 52000000Hz, actual 50000000HZ div = 1)
[    2.044300] Waiting for root device /dev/mmcblk1p3...
[    2.058350] mmc0: new DDR MMC card at address 0001
[    2.063256] mmcblk0: mmc0:0001 M4G1FA 3.72 GiB
[    2.067633] mmcblk0boot0: mmc0:0001 M4G1FA partition 1 1.00 MiB
[    2.073531] mmcblk0boot1: mmc0:0001 M4G1FA partition 2 1.00 MiB
[    2.079433] mmcblk0rpmb: mmc0:0001 M4G1FA partition 3 128 KiB
[    2.086554]  mmcblk0: p1 p2 p3 p4
[    2.089706]  mmcblk0boot1: unknown partition table
[    2.093953]  mmcblk0boot0: unknown partition table
[    2.098345] platform 122f0000.sata: Driver ahci requests probe deferral
[    2.172280] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot
req 50000000Hz, actual 50000000HZ div = 0)
[    2.180563] mmc1: new high speed SDHC card at address aaaa
[    2.186220] mmcblk1: mmc1:aaaa SU04G 3.69 GiB (ro)
[    2.192336]  mmcblk1: p1 p2 p3
[    2.194654] platform 122f0000.sata: Driver ahci requests probe deferral
[    2.250761] VFS: Cannot open root device "mmcblk1p3" or
unknown-block(179,67): error -30
[    2.257452] Please append a correct "root=" boot option; here are
the available partitions:
[    2.265787] b300         3907584 mmcblk0  driver: mmcblk
[    2.271059]   b301         2352800 mmcblk0p1 00000000-01
[    2.276312]   b302          507872 mmcblk0p2 00000000-02
[    2.281606]   b303          507840 mmcblk0p3 00000000-03
[    2.286899]   b304          507840 mmcblk0p4 00000000-04
[    2.292206] b330             128 mmcblk0rpmb  (driver?)
[    2.297406] b320            1024 mmcblk0boot1  (driver?)
[    2.302700] b310            1024 mmcblk0boot0  (driver?)
[    2.307994] b340         3872256 mmcblk1  driver: mmcblk
[    2.313289]   b341            4095 mmcblk1p1 0005ac11-01
[    2.318582]   b342           53248 mmcblk1p2 0005ac11-02
[    2.323876]   b343         3814912 mmcblk1p3 0005ac11-03
[    2.329174] Kernel panic - not syncing: VFS: Unable to mount root
fs on unknown-block(179,67)
[    2.337696] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
3.16.0-rc1-next-20140618-00048-g868c90fe6c88 #2106
[    2.347186] [<c0216130>] (unwind_backtrace) from [<c0211ccc>]
(show_stack+0x10/0x14)
[    2.354895] [<c0211ccc>] (show_stack) from [<c0822420>]
(dump_stack+0x8c/0x9c)
[    2.362090] [<c0822420>] (dump_stack) from [<c0821b80>] (panic+0xa4/0x21c)
[    2.368950] [<c0821b80>] (panic) from [<c0ae50d4>]
(mount_block_root+0x1a0/0x230)
[    2.376415] [<c0ae50d4>] (mount_block_root) from [<c0ae526c>]
(mount_root+0x108/0x110)
[    2.384313] [<c0ae526c>] (mount_root) from [<c0ae53cc>]
(prepare_namespace+0x158/0x19c)
[    2.392301] [<c0ae53cc>] (prepare_namespace) from [<c0ae4d90>]
(kernel_init_freeable+0x1cc/0x1dc)
[    2.401159] [<c0ae4d90>] (kernel_init_freeable) from [<c081fed4>]
(kernel_init+0xc/0xe8)
[    2.409229] [<c081fed4>] (kernel_init) from [<c020e838>]
(ret_from_fork+0x14/0x3c)
[    2.416770] CPU1: stopping
[    2.419453] CPU: 1 PID: 0 Comm: swapper/1 Not tainted
3.16.0-rc1-next-20140618-00048-g868c90fe6c88 #2106
[    2.428948] [<c0216130>] (unwind_backtrace) from [<c0211ccc>]
(show_stack+0x10/0x14)
[    2.436660] [<c0211ccc>] (show_stack) from [<c0822420>]
(dump_stack+0x8c/0x9c)
[    2.443856] [<c0822420>] (dump_stack) from [<c02149ac>]
(handle_IPI+0x150/0x170)
[    2.451233] [<c02149ac>] (handle_IPI) from [<c0208910>]
(gic_handle_irq+0x64/0x68)
[    2.458781] [<c0208910>] (gic_handle_irq) from [<c0212840>]
(__irq_svc+0x40/0x50)
[    2.466239] Exception stack(0xe989ff90 to 0xe989ffd8)
[    2.471268] ff80:                                     ffffffed
00000000 ffffffed c021f6c0
[    2.479438] ffa0: e989e020 c0b94458 c0b944c4 00000000 00000000
e989e000 c082ef44 c0b88da8
[    2.487594] ffc0: c0b95858 e989ffd8 c020f374 c020f378 60000113 ffffffff
[    2.494195] [<c0212840>] (__irq_svc) from [<c020f378>]
(arch_cpu_idle+0x38/0x3c)
[    2.501587] [<c020f378>] (arch_cpu_idle) from [<c027d7e4>]
(cpu_startup_entry+0x1e8/0x23c)
[    2.509823] [<c027d7e4>] (cpu_startup_entry) from [<40208a44>] (0x40208a44)
[    2.516761] ---[ end Kernel panic - not syncing: VFS: Unable to
mount root fs on unknown-block(179,67)
***********************************


Regards,
Sachin.
