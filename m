From: Ido Yariv <ido@wizery.com>
Subject: [PATCH v2 0/6] arm: davinci: DA850: wl12xx expansion card
Date: Sun, 10 Jul 2011 16:14:33 +0300
Message-ID: <1310303679-17936-1-git-send-email-ido@wizery.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55270 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732Ab1GJNOu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 10 Jul 2011 09:14:50 -0400
Received: by wwe5 with SMTP id 5so3184676wwe.1
        for <linux-mmc@vger.kernel.org>; Sun, 10 Jul 2011 06:14:49 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: davinci-linux-open-source@linux.davincidsp.com, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Ido Yariv <ido@wizery.com>

The following series adds support for an optional wl12xx based expansion
card for the AM18x EVM:
http://processors.wiki.ti.com/index.php/AM18x_%2B_WL1271

The first couple of patches address issues which had to be fixed for this
series to work. However, these should be fixed regardless of the wl12xx
daughter board support.

Only the Wi-Fi functionality of the expansion card is supported. Bluetooth
functionality is not yet supported.

The patches are based on v3.0-rc6.

Changes from v1:
* Explicitly set the default queue for all channel controllers on all
  platforms. As it makes little sense to set DA850's default queue to an
  invalid value and then fix it, merge the two patches
* Move pinmux configurations to separate patches
* Remove FREF Kconfig entry, use a default value of 38MHz instead
* Use msleep for long delays, usleep_range for shorter ones
* Minor cleanups

Ido.


Ido Yariv (6):
  arm: davinci: Fix low level gpio irq handlers' argument
  arm: davinci: Explicitly set channel controllers' default queues
  arm: davinci: mmc: Add support for set_power callback
  arm: davinci: DA850: Add MMC/SD1 pinmux configuration
  arm: davinci: DA850: Add GPIO pinmux configuration for wl1271
  arm: davinci: DA850: Add wl1271/wlan support

 arch/arm/mach-davinci/Kconfig             |   10 +++
 arch/arm/mach-davinci/board-da850-evm.c   |  127 +++++++++++++++++++++++++++++
 arch/arm/mach-davinci/da850.c             |    9 ++
 arch/arm/mach-davinci/devices-da8xx.c     |    3 +
 arch/arm/mach-davinci/devices-tnetv107x.c |    1 +
 arch/arm/mach-davinci/dm355.c             |    1 +
 arch/arm/mach-davinci/dm644x.c            |    1 +
 arch/arm/mach-davinci/dm646x.c            |    1 +
 arch/arm/mach-davinci/dma.c               |    2 -
 arch/arm/mach-davinci/gpio.c              |   32 +++++++-
 arch/arm/mach-davinci/include/mach/mmc.h  |    3 +
 arch/arm/mach-davinci/include/mach/mux.h  |   10 +++
 drivers/mmc/host/davinci_mmc.c            |   13 +++
 13 files changed, 207 insertions(+), 6 deletions(-)

-- 
1.7.4.1

