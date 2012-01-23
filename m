From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: kernel oops during boot process
Date: Mon, 23 Jan 2012 09:29:55 +0200
Message-ID: <4F1D0C73.7040702@intel.com>
References: <4F1AEBA3.4040300@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:4632 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751156Ab2AWH3x (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 23 Jan 2012 02:29:53 -0500
In-Reply-To: <4F1AEBA3.4040300@googlemail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-15?Q?Frank_Sch=E4fer?= <fschaefer.oss@googlemail.com>
Cc: linux-mmc@vger.kernel.org

On 21/01/12 18:45, Frank Sch=E4fer wrote:
> Hi,
>=20
> I get the following kernel-oops during boot process:
>=20
> [   11.754604] sdhci-pci 0000:06:09.4: SDHCI controller found [104c:8=
034]
> (rev 0)
> [   11.754622] sdhci-pci 0000:06:09.4: PCI INT A -> GSI 22 (level, lo=
w) ->
> IRQ 22
> [   11.754661] _regulator_get: 0000:06:09.4 supply vmmc not found, us=
ing
> dummy regulator

With CONFIG_REGULATOR_DUMMY, every MMC host controller on the PCI devic=
e
tries to create the same dummy regulator.  You could try deselecting
CONFIG_REGULATOR_DUMMY.


> [   11.754740] Registered led device: mmc0::
> [   11.755782] mmc0: SDHCI controller on PCI [0000:06:09.4] using PIO
> [   11.755804] _regulator_get: 0000:06:09.4 supply vmmc not found, us=
ing
> dummy regulator
> [   11.755812] ------------[ cut here ]------------
> [   11.755820] WARNING: at fs/sysfs/dir.c:481 sysfs_add_one+0x8a/0xb0=
()
> [   11.755823] Hardware name: AMILO Pro V2065
> [   11.755825] sysfs: cannot create duplicate filename
> '/devices/pci0000:00/0000:00:1e.0/0000:06:09.4/microamps_requested_00=
00:06:09.4-vmmc'
>=20
> [   11.755828] Modules linked in: firewire_ohci(+) firewire_core iTCO=
_wdt
> tifm_7xx1(+) sdhci_pci(+) sdhci yenta_socket pcmcia_rsrc sr_mod parpo=
rt_pc
> soundcore rfkill sg iTCO_vendor_support cdrom parport joydev mmc_core
> serio_raw pcspkr button ac pcmcia_core tifm_core video lm90 r8169 i2c=
_i801
> crc_itu_t lib80211 snd_page_alloc battery ext4 jbd2 crc16 usbhid hid
> uhci_hcd ehci_hcd radeon ttm drm_kms_helper drm i2c_algo_bit rtc_cmos
> i2c_core intel_agp intel_gtt usbcore usb_common sd_mod fan processor
> ata_generic ata_piix ahci libahci libata scsi_mod thermal thermal_sys=
 hwmon
> [   11.755878] Pid: 514, comm: modprobe Not tainted 3.2.0-0.1-default=
+ #5
> [   11.755881] Call Trace:
> [   11.755887]  [<c0245a7d>] warn_slowpath_common+0x6d/0xa0
> [   11.755891]  [<c03648da>] ? sysfs_add_one+0x8a/0xb0
> [   11.755894]  [<c03648da>] ? sysfs_add_one+0x8a/0xb0
> [   11.755898]  [<c0245b2e>] warn_slowpath_fmt+0x2e/0x30
> [   11.755901]  [<c03648da>] sysfs_add_one+0x8a/0xb0
> [   11.755905]  [<c0363a4e>] sysfs_add_file_mode+0x7e/0xb0
> [   11.755909]  [<c0363a93>] sysfs_add_file+0x13/0x20
> [   11.755913]  [<c0363b4c>] sysfs_create_file+0x1c/0x20
> [   11.755918]  [<c0494633>] device_create_file+0x13/0x20
> [   11.755923]  [<c0466d68>] create_regulator+0xc8/0x320
> [   11.755928]  [<c0290063>] ? queue_stop_cpus_work+0x43/0xa0
> [   11.755932]  [<c0467096>] _regulator_get+0xd6/0x230
> [   11.755938]  [<c029e6ff>] ? request_threaded_irq+0xbf/0x120
> [   11.755942]  [<c046720a>] regulator_get+0xa/0x10
> [   11.755949]  [<f9629907>] sdhci_add_host+0x5d7/0xc60 [sdhci]
> [   11.755956]  [<f96341d0>] sdhci_pci_probe+0x363/0x49a [sdhci_pci]
> [   11.755962]  [<c0411d52>] local_pci_probe+0x42/0xb0
> [   11.755966]  [<c0412bd0>] pci_device_probe+0x60/0x80
> [   11.755970]  [<c0497413>] driver_probe_device+0x83/0x2d0
> [   11.755974]  [<c04976d9>] __driver_attach+0x79/0x80
> [   11.755977]  [<c0496553>] bus_for_each_dev+0x43/0x70
> [   11.755981]  [<c0413010>] ? store_new_id+0x100/0x100
> [   11.755985]  [<c04970c9>] driver_attach+0x19/0x20
> [   11.755988]  [<c0497660>] ? driver_probe_device+0x2d0/0x2d0
> [   11.755992]  [<c0496d25>] bus_add_driver+0x135/0x270
> [   11.756014]  [<c0413010>] ? store_new_id+0x100/0x100
> [   11.756018]  [<c0497bf5>] driver_register+0x65/0x110
> [   11.756022]  [<c0412def>] __pci_register_driver+0x3f/0xb0
> [   11.756027]  [<f9637017>] sdhci_drv_init+0x17/0x19 [sdhci_pci]
> [   11.756031]  [<c0201210>] do_one_initcall+0x30/0x170
> [   11.756036]  [<f9637000>] ? 0xf9636fff
> [   11.756041]  [<c027bd7f>] sys_init_module+0xef/0x19b0
> [   11.756048]  [<c05d6ed8>] sysenter_do_call+0x12/0x28
> [   11.756051] ---[ end trace b75d0c663d9ce945 ]---
> [   11.756054] create_regulator: dummy: could not add regulator_dev
> requested microamps sysfs entry
> [   11.756057] mmc1: no vmmc regulator found
> [   11.756091] Registered led device: mmc1::
> [   11.757561] mmc1: SDHCI controller on PCI [0000:06:09.4] using PIO
> [   11.757585] _regulator_get: 0000:06:09.4 supply vmmc not found, us=
ing
> dummy regulator
> [   11.757592] ------------[ cut here ]------------
> [   11.757596] WARNING: at fs/sysfs/dir.c:481 sysfs_add_one+0x8a/0xb0=
()
> [   11.757598] Hardware name: AMILO Pro V2065
> [   11.757601] sysfs: cannot create duplicate filename
> '/devices/pci0000:00/0000:00:1e.0/0000:06:09.4/microamps_requested_00=
00:06:09.4-vmmc'
>=20
> [   11.757604] Modules linked in: firewire_ohci(+) firewire_core iTCO=
_wdt
> tifm_7xx1(+) sdhci_pci(+) sdhci yenta_socket pcmcia_rsrc sr_mod parpo=
rt_pc
> soundcore rfkill sg iTCO_vendor_support cdrom parport joydev mmc_core
> serio_raw pcspkr button ac pcmcia_core tifm_core video lm90 r8169 i2c=
_i801
> crc_itu_t lib80211 snd_page_alloc battery ext4 jbd2 crc16 usbhid hid
> uhci_hcd ehci_hcd radeon ttm drm_kms_helper drm i2c_algo_bit rtc_cmos
> i2c_core intel_agp intel_gtt usbcore usb_common sd_mod fan processor
> ata_generic ata_piix ahci libahci libata scsi_mod thermal thermal_sys=
 hwmon
> [   11.757648] Pid: 514, comm: modprobe Tainted: G        W  =20
> 3.2.0-0.1-default+ #5
> [   11.757651] Call Trace:
> [   11.757654]  [<c0245a7d>] warn_slowpath_common+0x6d/0xa0
> [   11.757658]  [<c03648da>] ? sysfs_add_one+0x8a/0xb0
> [   11.757662]  [<c03648da>] ? sysfs_add_one+0x8a/0xb0
> [   11.757666]  [<c0245b2e>] warn_slowpath_fmt+0x2e/0x30
> [   11.757669]  [<c03648da>] sysfs_add_one+0x8a/0xb0
> [   11.757673]  [<c0363a4e>] sysfs_add_file_mode+0x7e/0xb0
> [   11.757677]  [<c0363a93>] sysfs_add_file+0x13/0x20
> [   11.757680]  [<c0363b4c>] sysfs_create_file+0x1c/0x20
> [   11.757684]  [<c0494633>] device_create_file+0x13/0x20
> [   11.757688]  [<c0466d68>] create_regulator+0xc8/0x320
> [   11.757692]  [<c0290063>] ? queue_stop_cpus_work+0x43/0xa0
> [   11.757696]  [<c0467096>] _regulator_get+0xd6/0x230
> [   11.757701]  [<c029e6ff>] ? request_threaded_irq+0xbf/0x120
> [   11.757705]  [<c046720a>] regulator_get+0xa/0x10
> [   11.757710]  [<f9629907>] sdhci_add_host+0x5d7/0xc60 [sdhci]
> [   11.757716]  [<f96341d0>] sdhci_pci_probe+0x363/0x49a [sdhci_pci]
> [   11.757720]  [<c0411d52>] local_pci_probe+0x42/0xb0
> [   11.757724]  [<c0412bd0>] pci_device_probe+0x60/0x80
> [   11.757728]  [<c0497413>] driver_probe_device+0x83/0x2d0
> [   11.757732]  [<c04976d9>] __driver_attach+0x79/0x80
> [   11.757736]  [<c0496553>] bus_for_each_dev+0x43/0x70
> [   11.757739]  [<c0413010>] ? store_new_id+0x100/0x100
> [   11.757743]  [<c04970c9>] driver_attach+0x19/0x20
> [   11.757746]  [<c0497660>] ? driver_probe_device+0x2d0/0x2d0
> [   11.757750]  [<c0496d25>] bus_add_driver+0x135/0x270
> [   11.757754]  [<c0413010>] ? store_new_id+0x100/0x100
> [   11.757758]  [<c0497bf5>] driver_register+0x65/0x110
> [   11.757762]  [<c0412def>] __pci_register_driver+0x3f/0xb0
> [   11.757767]  [<f9637017>] sdhci_drv_init+0x17/0x19 [sdhci_pci]
> [   11.757771]  [<c0201210>] do_one_initcall+0x30/0x170
> [   11.757775]  [<f9637000>] ? 0xf9636fff
> [   11.757779]  [<c027bd7f>] sys_init_module+0xef/0x19b0
> [   11.757784]  [<c05d6ed8>] sysenter_do_call+0x12/0x28
> [   11.757787] ---[ end trace b75d0c663d9ce946 ]---
> [   11.757790] create_regulator: dummy: could not add regulator_dev
> requested microamps sysfs entry
> [   11.757792] mmc2: no vmmc regulator found
> [   11.757826] Registered led device: mmc2::
> [   11.759037] mmc2: SDHCI controller on PCI [0000:06:09.4] using PIO
>=20
> Looks like it comes from the SDHCI controller ? Any idea what might b=
e wrong ?
> I get the same oops with kernel 2.6.34, so this seems to be a long ex=
isting
> issue.
>=20
> Regards,
> Frank
> --=20
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

