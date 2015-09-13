From: Petr Cvek <petr.cvek@tul.cz>
Subject: [BUG] Kernel error when first driver unbind with empty MMC slot
Date: Sun, 13 Sep 2015 05:15:27 +0200
Message-ID: <55F4EA4F.4050204@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bubo.tul.cz ([147.230.16.1]:33775 "EHLO bubo.tul.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754884AbbIMDPc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 12 Sep 2015 23:15:32 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, robert.jarzmik@free.fr
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

During testing of these patches

	[PATCH] mmc: pxamci: fix card detect threaded interrupt
	[PATCH 1/3] dmaengine: virt-dma: don't always free descriptor upon completion

I have found unrelated error.	

How to reproduce:

1) Remove any SD card
2) No CPLD initial power for card (in magician.c, probably irrelevant)
3) Boot into an initrd filesystem
4) Run command echo -n "pxa2xx-mci.0" > /sys/class/mmc_host/mmc0/device/driver/unbind
5) Error message will be printed:

[ 97.877519] irq 39: nobody cared (try booting with the "irqpoll" option)
[ 97.884283] CPU: 0 PID: 153 Comm: sh Not tainted 4.2.0-next-20150910-00015-g03de31f-dirty #16
[ 97.892757] Hardware name: HTC Magician
[ 97.896726] [<c000edac>] (unwind_backtrace) from [<c000cb0c>] (show_stack+0x10/0x14)
[ 97.904503] [<c000cb0c>] (show_stack) from [<c00450ac>] (__report_bad_irq+0x24/0xb4)
[ 97.912221] [<c00450ac>] (__report_bad_irq) from [<c00453f4>] (note_interrupt+0x250/0x2b4)
[ 97.920452] [<c00453f4>] (note_interrupt) from [<c0043450>] (handle_irq_event_percpu+0xa8/0x164)
[ 97.929195] [<c0043450>] (handle_irq_event_percpu) from [<c0043538>] (handle_irq_event+0x2c/0x40)
[ 97.938027] [<c0043538>] (handle_irq_event) from [<c0045d0c>] (handle_level_irq+0x94/0x118)
[ 97.946342] [<c0045d0c>] (handle_level_irq) from [<c0042dc4>] (generic_handle_irq+0x20/0x30)
[ 97.954739] [<c0042dc4>] (generic_handle_irq) from [<c0042ebc>] (__handle_domain_irq+0x4c/0xa4)
[ 97.963395] [<c0042ebc>] (__handle_domain_irq) from [<c0009414>] (ichp_handle_irq+0x28/0x38)
[ 97.971794] [<c0009414>] (ichp_handle_irq) from [<c000d5b0>] (__irq_svc+0x50/0x64)
[ 97.979321] Exception stack(0xc23f1de0 to 0xc23f1e28)
[ 97.984366] 1de0: c34030e0 00000027 00000000 00000000 c3400220 fffffffa c34002d4 ffffffff
[ 97.992506] 1e00: 000000d0 c15536c0 000000ec 0116f2dc 00000001 c23f1e34 c0043c48 c01a0504
[ 98.000633] 1e20: 20000013 ffffffff
[ 98.004159] [<c000d5b0>] (__irq_svc) from [<c01a0504>] (__radix_tree_lookup+0x60/0xcc)
[ 98.012043] [<c01a0504>] (__radix_tree_lookup) from [<c0043c48>] (free_irq+0x10/0x88)
[ 98.019895] [<c0043c48>] (free_irq) from [<c024e350>] (pxamci_remove+0xa4/0x154)
[ 98.027285] [<c024e350>] (pxamci_remove) from [<c0202940>] (platform_drv_remove+0x18/0x30)
[ 98.035578] [<c0202940>] (platform_drv_remove) from [<c0201574>] (__device_release_driver+0x84/0x104)
[ 98.044769] [<c0201574>] (__device_release_driver) from [<c0201610>] (device_release_driver+0x1c/0x28)
[ 98.054034] [<c0201610>] (device_release_driver) from [<c01ffad4>] (unbind_store+0x58/0x90)
[ 98.062346] [<c01ffad4>] (unbind_store) from [<c01ff358>] (drv_attr_store+0x20/0x2c)
[ 98.070103] [<c01ff358>] (drv_attr_store) from [<c00f14c4>] (sysfs_kf_write+0x44/0x48)
[ 98.077998] [<c00f14c4>] (sysfs_kf_write) from [<c00f0b30>] (kernfs_fop_write+0xec/0x1ac)
[ 98.086171] [<c00f0b30>] (kernfs_fop_write) from [<c009b7b8>] (__vfs_write+0x2c/0xd8)
[ 98.093980] [<c009b7b8>] (__vfs_write) from [<c009c660>] (vfs_write+0x94/0x150)
[ 98.101260] [<c009c660>] (vfs_write) from [<c009c8ec>] (SyS_write+0x40/0x8c)
[ 98.108284] [<c009c8ec>] (SyS_write) from [<c000a460>] (ret_fast_syscall+0x0/0x38)
[ 98.115800] handlers:
[ 98.118073] [<c024f19c>] pxamci_irq
[ 98.121559] Disabling IRQ #39

Error exists in versions before the dmaengine patches was created. Specifically:

	1efdb5f0a9243ca8f3460a5ce1b407b06a021f02

Applying the DMA engine patches (list at the beginning of this mail) does not make any change to this bug behavior.

Petr Cvek
