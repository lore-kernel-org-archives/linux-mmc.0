From: Shawn Guo <shawn.guo@freescale.com>
Subject: [PATCH 0/7] Add mmc driver for i.MX23/28
Date: Sat, 5 Feb 2011 10:18:40 +0800
Message-ID: <1296872327-21166-1-git-send-email-shawn.guo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:1773 "EHLO
	TX2EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799Ab1BDSR7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Feb 2011 13:17:59 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, s.hauer@pengutronix.de, u.kleine-koenig@pengutronix.de, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

This patch set is to add mmc host driver for i.MX23/28.  It was
tested on both mx23evk and mx28evk boards against Sascha's
imx-for-2.6.39 tree plus the mxs-dma patch set.

Thanks for review.

Regards,
Shawn

Shawn Guo (7)
 [PATCH 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
 [PATCH 2/7] ARM: mxs/clock: fix base address missing in name##_set_parent
 [PATCH 3/7] ARM: mxs: make ssp error irq definition consistent
 [PATCH 4/7] ARM: mxs: dynamically allocate mmc device
 [PATCH 5/7] ARM: mxs: fix typo "GPO" in iomux-mx23.h
 [PATCH 6/7] ARM: mxs/mx23evk: add mmc device
 [PATCH 7/7] ARM: mxs/mx28evk: add mmc device

 arch/arm/mach-mxs/Kconfig                       |    2 +
 arch/arm/mach-mxs/clock-mx23.c                  |   18 +-
 arch/arm/mach-mxs/clock-mx28.c                  |   20 +-
 arch/arm/mach-mxs/devices-mx23.h                |    4 +
 arch/arm/mach-mxs/devices-mx28.h                |    4 +
 arch/arm/mach-mxs/devices/Kconfig               |    3 +
 arch/arm/mach-mxs/devices/Makefile              |    1 +
 arch/arm/mach-mxs/devices/platform-mmc.c        |   80 ++
 arch/arm/mach-mxs/include/mach/devices-common.h |   13 +
 arch/arm/mach-mxs/include/mach/iomux-mx23.h     |  190 +++---
 arch/arm/mach-mxs/include/mach/mmc.h            |   15 +
 arch/arm/mach-mxs/include/mach/mx23.h           |    2 +-
 arch/arm/mach-mxs/include/mach/mx28.h           |    8 +-
 arch/arm/mach-mxs/mach-mx23evk.c                |   58 ++
 arch/arm/mach-mxs/mach-mx28evk.c                |  102 +++-
 drivers/mmc/host/Kconfig                        |    9 +
 drivers/mmc/host/Makefile                       |    1 +
 drivers/mmc/host/mxs-mmc.c                      |  884 +++++++++++++++++++++++
 18 files changed, 1310 insertions(+), 104 deletions(-)

