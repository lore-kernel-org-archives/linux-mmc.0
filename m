From: Igor Plyatov <plyatov@gmail.com>
Subject: mmc: host: sdhci-esdhc-imx.c: seems driver is broken
Date: Wed, 2 Sep 2015 20:05:06 +0300
Message-ID: <55E72C42.4060504@gmail.com>
Reply-To: plyatov@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Dong Aisheng <aisheng.dong@freescale.com>, Johan Derycke <johan.derycke@barco.com>, Fabio Estevam <fabio.estevam@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, Aisheng Dong <b29396@freescale.com>
List-Id: linux-mmc@vger.kernel.org

Hello dear developers!

Please advise how to resolve issue with SD card driver.

I work on adaptation of Voipac i.MX51 board for linux-4.2.0. Generally, 
this is the creation of suitable Device-tree file.
..
&esdhc1 {
     pinctrl-names = "default";
     pinctrl-0 = <&pinctrl_esdhc1>;
     bus-width = <4>;
     no-1-8-v;
     cd-gpios = <&gpio3 28 GPIO_ACTIVE_LOW>;
     voltage-ranges = <3300 3300>;
     status = "okay";
};
..
         pinctrl_esdhc1: esdhc1grp { /* bits are same as from linux-3.8.5 */
             fsl,pins = <
                 MX51_PAD_SD1_CMD__SD1_CMD        0x400020d4
                 MX51_PAD_SD1_CLK__SD1_CLK        0x21d4
                 MX51_PAD_SD1_DATA0__SD1_DATA0        0x400020d4
                 MX51_PAD_SD1_DATA1__SD1_DATA1        0x400020d4
                 MX51_PAD_SD1_DATA2__SD1_DATA2        0x400020d4
                 MX51_PAD_SD1_DATA3__SD1_DATA3        0x400020d4
                 MX51_PAD_NANDF_D12__GPIO3_28        0x100 /* SD1_CD */
             >;
         };
..

Previously, different SD cards work as a charm on linux-3.8.5, but 
current kernel produce a lot of error messages during writing to the SD 
card.

Here is a kernel log filtered for MMC related messages:

sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
sdhci-pltfm: SDHCI platform and OF driver helper
sdhci-esdhc-imx 70004000.esdhc: Got CD GPIO
sdhci-esdhc-imx 70004000.esdhc: No vmmc regulator found
sdhci-esdhc-imx 70004000.esdhc: No vqmmc regulator found
mmc0: SDHCI controller on 70004000.esdhc [70004000.esdhc] using ADMA
mmc0: host does not support reading read-only switch, assuming write-enable
mmc0: new high speed SDHC card at address 1f0c
mmcblk0: mmc0:1f0c SD04G 3.69 GiB
  mmcblk0: p1
...
Starting udev
udevd[101]: starting version 182
mmc0: Timeout waiting for hardware interrupt.
mmcblk0: error -110 transferring data, sector 2048, nr 1, cmd response 
0x0, card status 0x0
mmc0: tried to reset card
mmc0: Timeout waiting for hardware interrupt.
mmcblk0: error -110 transferring data, sector 2048, nr 1, cmd response 
0x0, card status 0x0
blk_update_request: I/O error, dev mmcblk0, sector 2048
Buffer I/O error on dev mmcblk0p1, logical block 0, lost sync page write


Errors does not appear during data reading:

root@vmx51:~# dd if=/dev/mmcblk0 of=/dev/null bs=512 count=1000000
1000000+0 records in
1000000+0 records out


Appear during card unmounting:

root@vmx51:~# umount /dev/mmcblk0p1
mmc0: Timeout waiting for hardware interrupt.
mmcblk0: error -110 transferring data, sector 2048, nr 1, cmd response 
0x0, card status 0x0
blk_update_request: I/O error, dev mmcblk0, sector 2048
Buffer I/O error on dev mmcblk0p1, logical block 0, lost sync page write
------------[ cut here ]------------
WARNING: CPU: 0 PID: 436 at fs/block_dev.c:57 __blkdev_put+0x10c/0x1fc()
Modules linked in:
CPU: 0 PID: 436 Comm: umount Not tainted 
4.2.0-1.1.0_beta2-04291-geef812a #68
Hardware name: Freescale i.MX51 (Device Tree Support)
Backtrace:
[<80011f10>] (dump_backtrace) from [<80012104>] (show_stack+0x18/0x1c)
  r6:80660b6c r5:00000009 r4:00000000 r3:00400100
[<800120ec>] (show_stack) from [<8053cb24>] (dump_stack+0x20/0x28)
[<8053cb04>] (dump_stack) from [<8001f4e0>] (warn_slowpath_common+0x90/0xb8)
[<8001f450>] (warn_slowpath_common) from [<8001f5ac>] 
(warn_slowpath_null+0x24/0x2c)
  r8:8755e1d0 r7:00000083 r6:8700f800 r5:831da028 r4:8755e1c0
[<8001f588>] (warn_slowpath_null) from [<800ef298>] 
(__blkdev_put+0x10c/0x1fc)
[<800ef18c>] (__blkdev_put) from [<800efc50>] (blkdev_put+0x154/0x160)
  r10:00000000 r9:831da000 r8:8000f024 r7:8755e1d0 r6:00000083 r5:00000001
  r4:8755e1c0 r3:00000000
[<800efafc>] (blkdev_put) from [<800bf144>] (kill_block_super+0x60/0x6c)
  r7:00000034 r6:80751e90 r5:00000083 r4:8755e1c0
[<800bf0e4>] (kill_block_super) from [<800bf458>] 
(deactivate_locked_super+0x4c/0x7c)
  r6:80751e90 r5:80728508 r4:87141c00 r3:800bf0e4
[<800bf40c>] (deactivate_locked_super) from [<800bf8c4>] 
(deactivate_super+0x58/0x5c)
  r5:00000000 r4:87141c00
[<800bf86c>] (deactivate_super) from [<800d9d18>] (cleanup_mnt+0x54/0x74)
  r4:872420c0 r3:00000000
[<800d9cc4>] (cleanup_mnt) from [<800d9d94>] (__cleanup_mnt+0x14/0x18)
  r4:87a10cc0 r3:800d9d80
[<800d9d80>] (__cleanup_mnt) from [<800368ec>] (task_work_run+0x94/0xa8)
[<80036858>] (task_work_run) from [<80011bfc>] (do_work_pending+0xa0/0xb8)
  r6:831dbfb0 r5:831da010 r4:8000f024 r3:872420dc
[<80011b5c>] (do_work_pending) from [<8000eecc>] (work_pending+0xc/0x20)
  r6:00015198 r5:48ad4644 r4:00015038 r3:00000004
---[ end trace 3da0cc3c43e8a19e ]---


And appear again during data write:

root@vmx51:~# dd of=/dev/mmcblk0 if=/dev/zero bs=512 count=1
mmc0: Timeout waiting for hardware interrupt.
------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at drivers/mmc/host/sdhci.c:1001 
sdhci_send_command+0x30/0xd58()
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Tainted: G        W 
4.2.0-1.1.0_beta2-04291-geef812a #68
Hardware name: Freescale i.MX51 (Device Tree Support)
Backtrace:
[<80011f10>] (dump_backtrace) from [<80012104>] (show_stack+0x18/0x1c)
  r6:8069d411 r5:00000009 r4:00000000 r3:00200000
[<800120ec>] (show_stack) from [<8053cb24>] (dump_stack+0x20/0x28)
[<8053cb04>] (dump_stack) from [<8001f4e0>] (warn_slowpath_common+0x90/0xb8)
[<8001f450>] (warn_slowpath_common) from [<8001f5ac>] 
(warn_slowpath_null+0x24/0x2c)
  r8:87bd9ac0 r7:00000001 r6:8700f5d4 r5:8700f608 r4:87bd9ac0
[<8001f588>] (warn_slowpath_null) from [<803968e8>] 
(sdhci_send_command+0x30/0xd58)
[<803968b8>] (sdhci_send_command) from [<80397858>] 
(sdhci_finish_data+0x248/0x2f0)
  r10:8071a000 r9:80397900 r8:87bd9ac0 r7:00000001 r6:00000001 r5:8700f608
  r4:87bd9ac0
[<80397610>] (sdhci_finish_data) from [<80397978>] 
(sdhci_timeout_timer+0x78/0xf4)
  r10:8071a000 r9:80397900 r8:87bd9ac0 r7:00200200 r6:80397900 r5:20000113
  r4:87bd9ac0
[<80397900>] (sdhci_timeout_timer) from [<80058004>] 
(call_timer_fn.isra.33+0x2c/0x9c)
  r5:00000000 r4:00000101
[<80057fd8>] (call_timer_fn.isra.33) from [<800582c0>] 
(run_timer_softirq+0x1f0/0x270)
  r6:80725640 r5:00000000 r4:80724e00
[<800580d0>] (run_timer_softirq) from [<80021e14>] (__do_softirq+0xd8/0x20c)
  r9:80751a04 r8:0000000a r7:00000101 r6:807519c0 r5:00000002 r4:40000001
[<80021d3c>] (__do_softirq) from [<800221bc>] (irq_exit+0x88/0xec)
  r10:00000020 r9:807514e8 r8:00000001 r7:87808400 r6:00000000 r5:8072f4bc
  r4:00000000
[<80022134>] (irq_exit) from [<8004a908>] (__handle_domain_irq+0x8c/0xa8)
  r4:00000000 r3:00000110
[<8004a87c>] (__handle_domain_irq) from [<800093fc>] 
(tzic_handle_irq+0x78/0xa8)
  r8:8071bed0 r7:807514e8 r6:00000007 r5:00000001 r4:00000080 r3:8071bed0
[<80009384>] (tzic_handle_irq) from [<80012bc0>] (__irq_svc+0x40/0x74)
Exception stack(0x8071bed0 to 0x8071bf18)
bec0:                                     00000000 00000099 579e7fd6 
80723d10
bee0: 00000000 80746788 579e7fd6 00000099 80720ca4 00000000 00000000 
8071bf5c
bf00: 8071bf18 8071bf18 8037f404 8037f44c 60000013 ffffffff
  r10:00000000 r9:00000000 r8:80720ca4 r7:8071bf04 r6:ffffffff r5:60000013
  r4:8037f44c
[<8037f334>] (cpuidle_enter_state) from [<8037f56c>] 
(cpuidle_enter+0x1c/0x20)
  r10:00000000 r9:87eee400 r8:8071c10c r7:8071c10c r6:8071a000 r5:80720c64
  r4:00000000
[<8037f550>] (cpuidle_enter) from [<800436a8>] (call_cpuidle+0x50/0x54)
[<80043658>] (call_cpuidle) from [<800437d4>] 
(cpu_startup_entry+0x128/0x18c)
  r4:80746788 r3:00000001
[<800436ac>] (cpu_startup_entry) from [<80539fc0>] (rest_init+0x78/0x90)
  r7:8071c040 r3:8071a000
[<80539f48>] (rest_init) from [<806e3c34>] (start_kernel+0x2ec/0x344)
  r4:00000000 r3:8071a000
[<806e3948>] (start_kernel) from [<90008078>] (0x90008078)
---[ end trace 3da0cc3c43e8a19f ]---
mmcblk0: error -110 sending stop command, original cmd response 0x0, 
card status 0x400900
mmcblk0: error -110 transferring data, sector 0, nr 8, cmd response 0x0, 
card status 0x0
blk_update_request: I/O error, dev mmcblk0, sector 0
Buffer I/O error on dev mmcblk0, logical block 0, lost async page write
1+0 records in
1+0 records out
root@vmx51:~# mmcblk0: error -84 transferring data, sector 7741312, nr 
8, cmd response 0x900, card status 0xb00
mmc0: tried to reset card

Best wishes.
--
Igor Plyatov
