From: Chris Ball <cjb@laptop.org>
Subject: 2.6.37 planning, and cjb in Taipei Oct 19-Nov 2
Date: Thu, 07 Oct 2010 16:11:23 -0400
Message-ID: <m3hbgxoj9w.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:40338 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751258Ab0JGUGu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 7 Oct 2010 16:06:50 -0400
Received: from pullcord.laptop.org ([18.85.46.20])
	by void.printf.net with esmtp (Exim 4.69)
	(envelope-from <cjb@laptop.org>)
	id 1P3wjp-0004ZC-Sn
	for linux-mmc@vger.kernel.org; Thu, 07 Oct 2010 21:06:50 +0100
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,

Below is the current list of patches queued for 2.6.37.  If you'd like
a patch to be considered for 2.6.37 that isn't listed, please let me
know.

I'm going to be in Taipei for an OLPC board bringup from Oct 19th
to Nov 2nd -- the start of the trip will probably be during the merge
window.  I'll make time to ensure that the merge goes okay, but I'll
be busier than usual, so I'm planning to have my tree ready for a pull
request before I leave.  Also, if you happen to be in Taipei during
that time (or in Cambridge, MA directly afterwards) I'd be happy to
meet up in person.  Thanks!


Patches in mmc-next:

Adrian Hunter (4):
      mmc_test: fix performance tests that go over max_blk_count
      mmc_test: fix memory allocation segment limits
      mmc_test: fix display of .5 KiB
      mmc: Fixes for Dual Data Rate (DDR) support

Alan Cox (2):
      mmc: sdhci: Allow the probe handler to override slots
      mmc: sdhci: Add Moorestown device support

Andy Shevchenko (6):
      mmc: make mmc_dev_to_card() macro public
      mmc: rename dev_to_mmc_card() to mmc_dev_to_card()
      mmc_test: use API to check card type
      mmc_test: change simple_strtol() to strict_strtol()
      mmc_test: collect data and show it via sysfs by demand
      mmc_test: move files from sysfs to debugfs

David Vrabel (1):
      mmc: USB SD Host Controller (USHC) driver

Ethan Du (1):
      mmc: name mmc queue thread by host index

George G. Davis (1):
      mmc: sdhci: Make consistent use of CONFIG_MMC_DEBUG for "DEBUG"ging

Giuseppe Cavallaro (4):
      mmc: sdhci: add MMC_CAP_8_BIT_DATA in the host capabilities
      mmc: sdhci-pltfm: add suspend/resume functions
      mmc: sdhci: fix "pwr may be used uninitialized" warning
      mmc: sdhci: split up sdhci.h for sdhci-pltfm users

H Hartley Sweeten (3):
      mmc: at91_mci.c: use resource_size()
      mmc: atmel-mci.c: use resource_size()
      mmc: au1xmmc.c: use resource_size()

Hanumath Prasad (1):
      mmc: MMC 4.4 DDR support

Hein Tibosch (1):
      mmc: Make ID freq configurable

Jaehoon Chung (1):
      mmc: sdhci: disable MMC_CAP_NEEDS_POLL in nonremovable case

JiebingLi (1):
      mmc: Use snprintf, not sprintf.

Linus Walleij (1):
      mmc: Move regulator handling closer to core

Martin K. Petersen (1):
      mmc: Remove distinction between hw and phys segments

Matt Fleming (1):
      mmc: Add helper function to check if a card is removable

Ohad Ben-Cohen (9):
      mmc: sdio: fully reconfigure oldcard on resume
      mmc: propagate power save/restore ops return value
      mmc: sdio: add power_restore support
      mmc: add runtime PM handlers
      mmc: sdio: use the generic runtime PM handlers
      mmc: sdio: enable runtime PM for SDIO cards
      mmc: sdio: enable runtime PM for SDIO functions
      mmc: sdio: ensure mmc_sdio_detect is powered
      mmc: sdio: support suspend/resume while runtime suspended

Olof Johansson (1):
      mmc: make number of mmcblk minors configurable

Philip Rakity (1):
      mmc: sdhci: print out controller name for register debug

Thomas Gleixner (1):
      mmc: Convert "mutex" to semaphore

Xiaochen Shen (1):
      mmc: sdhci: Intel Medfield support

Zhangfei Gao (4):
      mmc: SDHC 3.0: support 10-bit divided clock mode
      mmc: SDHC 3.0: Base clock frequency change in spec 3.0
      mmc: sdhci: Enable high-speed support for MMC cards
      mmc: sdhci: correct f_min calculation with SD 3.0 spec

matt mooney (1):
      mmc: Makefile: Fix EXTRA_CFLAGS assignment

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
