From: kbuild test robot <fengguang.wu@intel.com>
Subject: [mmc:mmc-next 45/63] of_iommu.c:(.text+0x114dbc): undefined
 reference to `__aeabi_uldivmod'
Date: Mon, 26 Nov 2012 07:13:48 +0800
Message-ID: <50b2a62c.slEE/d1mNq4kUCUf%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:11076 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753625Ab2KYXOQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 25 Nov 2012 18:14:16 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haijun Zhang <Haijun.Zhang@freescale.com>
Cc: linux-mmc@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>, Chris Ball <cjb@laptop.org>

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git mmc-next
head:   b1dc46e6cd5f314f52a9864cc7ba1b7624b54bd7
commit: d29254e21ddddee37b3c8525817398d96d6403f3 [45/63] mmc: core: Use u64 to calculate the timeout value to avoid overflow
config: make ARCH=arm omap2plus_defconfig

All error/warnings:

drivers/built-in.o: In function `mmc_omap_start_request':
of_iommu.c:(.text+0x114dbc): undefined reference to `__aeabi_uldivmod'

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
