From: Ido Yariv <ido@wizery.com>
Subject: [PATCH 0/5] arm: davinci: DA850: wl12xx expansion board
Date: Fri,  8 Jul 2011 00:33:05 +0300
Message-ID: <1310074390-4277-1-git-send-email-ido@wizery.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48242 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805Ab1GGVdX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Jul 2011 17:33:23 -0400
Received: by wyg8 with SMTP id 8so928796wyg.19
        for <linux-mmc@vger.kernel.org>; Thu, 07 Jul 2011 14:33:22 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: davinci-linux-open-source@linux.davincidsp.com, linux-arm-kernel@lists.arm.linux.org.uk, linux-mmc@vger.kernel.org
Cc: Ido Yariv <ido@wizery.com>

The following series adds support for an optional wl12xx based expansion
board for the DA850:
http://processors.wiki.ti.com/index.php/AM18x_%2B_WL1271

The first couple of patches address issues which had to be fixed for
this series to work. However, these should be fixed regardless of the
DA850 expansion board support, and could influence other Davinci
platforms.

Only the Wi-Fi functionality of the expansion board is supported.
Bluetooth functionality is not yet supported.

The patches are based on v3.0-rc6.

Ido.

Ido Yariv (5):
  arm: davinci: Fix low level gpio irq handlers' argument
  arm: davinci: Allow EVENTQ_0 as a default queue
  arm: davinci: DA850: Set a default queue for CC1
  arm: davinci: mmc: Add support for set_power callback
  arm: davinci: DA850: Add wl12xx expansion board support

 arch/arm/mach-davinci/Kconfig             |   31 +++++++
 arch/arm/mach-davinci/board-da850-evm.c   |  128 +++++++++++++++++++++++++++++
 arch/arm/mach-davinci/da850.c             |    9 ++
 arch/arm/mach-davinci/devices-da8xx.c     |    3 +
 arch/arm/mach-davinci/dm365.c             |    4 +-
 arch/arm/mach-davinci/dma.c               |    5 +-
 arch/arm/mach-davinci/gpio.c              |   16 +++-
 arch/arm/mach-davinci/include/mach/edma.h |    2 +-
 arch/arm/mach-davinci/include/mach/mmc.h  |    3 +
 arch/arm/mach-davinci/include/mach/mux.h  |   10 ++
 drivers/mmc/host/davinci_mmc.c            |   13 +++
 11 files changed, 216 insertions(+), 8 deletions(-)

-- 
1.7.4.1

