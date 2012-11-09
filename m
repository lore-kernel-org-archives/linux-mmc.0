From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] mmc: hsmmc: Fix NULL pointer dereference on unload when
 booted with device tree
Date: Fri, 9 Nov 2012 10:25:34 -0800
Message-ID: <20121109182534.GR6801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:36985 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753997Ab2KISZh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Nov 2012 13:25:37 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Venkatraman S <svenkatr@ti.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org

When booting with device tree, we don't have any pdata, and will
get the following when trying to unload omap_hsmmc:

Unable to handle kernel NULL pointer dereference at virtual address 00000044
pgd = edafc000
*pgd=adbbd831, *pte=00000000, *ppte=00000000
SMP ARM
Modules linked in: omap_hsmmc(-) omap_serial pinctrl_single
CPU: 1    Not tainted  (3.7.0-rc4-00044-g8ca5f6a-dirty #245)
PC is at omap_hsmmc_gpio_free+0x8/0x3c [omap_hsmmc]
LR is at omap_hsmmc_remove+0xf0/0x174 [omap_hsmmc]
   psr: 60000113
sp : ee887ef0  ip : 00000040  fp : be83cc14
r10: 00000000  r9 : ee886000  r8 : c0014348
r7 : ee886000  r6 : eea1d010  r5 : eea1d000  r4 : 00000000
r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : 00000000
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c53c7d  Table: adafc04a  DAC: 00000015
Process rmmod (pid: 1758, stack limit = 0xee886240)
Stack: (0xee887ef0 to 0xee888000)
7ee0:                                     edbe1400 bf01250c eea1d018 eea1d010
7f00: bf0138ac c0331c64 ee886000 c0330528 eea1d010 bf0138ac eea1d044 c033063c
7f20: 00000000 bf0138ac c079f250 c032f618 00000000 00000880 bf013980 c00a42d0
7f40: c02ce9b4 70616d6f 6d73685f 0000636d c04ef560 c0014348 ee886000 ee886000
7f60: eeb21600 00000001 c00142a0 60000110 00000000 ef000000 be83cc14 00095f40
7f80: bf013980 00000880 ee887f8c 00000000 00000081 be83cba8 00000000 00000000
7fa0: 00000081 c00141a0 be83cba8 00000000 be83cba8 00000880 00000880 be83cba8
7fc0: be83cba8 00000000 00000000 00000081 00000000 00000000 b6f42000 be83cc14
7fe0: 00000000 be83cba0 000091cc b6eb48bc 60000110 be83cba8 aaaaaaaa aabaaaaa
(omap_hsmmc_remove+0xf0/0x174 [omap_hsmmc])
(platform_drv_remove+0x1c/0x24)
(__device_release_driver+0x90/0xf0)
(driver_detach+0xb4/0xb8)
(bus_remove_driver+0x88/0xdc)
(sys_delete_module+0x144/0x220)
(ret_fast_syscall+0x0/0x3c)
Code: eaffffbe c073a1f0 e92d4010 e1a04000 (e5900044)

Signed-off-by: Tony Lindgren <tony@atomide.com>

---

This is against v3.7-rc4, would be nice to get in during the -rc cycle.

--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -377,6 +377,9 @@ static int omap_hsmmc_gpio_init(struct omap_mmc_platform_data *pdata)
 {
 	int ret;
 
+	if (!pdata)
+		return 0;
+
 	if (gpio_is_valid(pdata->slots[0].switch_pin)) {
 		if (pdata->slots[0].cover)
 			pdata->slots[0].get_cover_state =
@@ -418,6 +421,9 @@ err_free_sp:
 
 static void omap_hsmmc_gpio_free(struct omap_mmc_platform_data *pdata)
 {
+	if (!pdata)
+		return;
+
 	if (gpio_is_valid(pdata->slots[0].gpio_wp))
 		gpio_free(pdata->slots[0].gpio_wp);
 	if (gpio_is_valid(pdata->slots[0].switch_pin))
