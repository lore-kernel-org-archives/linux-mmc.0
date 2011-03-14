From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 0/4] [rfc v3] mmc, ARM: Add zboot from eSD support for SuperH Mobile ARM
Date: Mon, 14 Mar 2011 11:57:11 +0900
Message-ID: <1300071435-26759-1-git-send-email-horms@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:40248 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753504Ab1CNC50 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Mar 2011 22:57:26 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Paul Mundt <lethal@linux-sh.org>

This allows a ROM-able zImage to be written to eSD and for SuperH Mobile
ARM to boot directly from the SDHI hardware block.

The first three patches shuffle some code around.
The fourth patch has the new boot code and the bulk of the code.

 Documentation/arm/SH-Mobile/zboot-rom-sdhi.txt       |   43 +
 arch/arm/Kconfig                                     |   35 -
 arch/arm/boot/compressed/Makefile                    |    9 
 arch/arm/boot/compressed/head-shmobile.S             |   12 
 arch/arm/boot/compressed/mmcif-sh7372.c              |   14 
 arch/arm/boot/compressed/sdhi-shmobile.c             |  501 ++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/mmc-ap4eb.h      |   29 +
 arch/arm/mach-shmobile/include/mach/mmc-mackerel.h   |   38 +
 arch/arm/mach-shmobile/include/mach/mmc.h            |   18 
 arch/arm/mach-shmobile/include/mach/mmcif-ap4eb.h    |   29 -
 arch/arm/mach-shmobile/include/mach/mmcif-mackerel.h |   39 -
 arch/arm/mach-shmobile/include/mach/mmcif.h          |   18 
 arch/arm/mach-shmobile/include/mach/sdhi-sh7372.h    |   58 ++
 arch/arm/mach-shmobile/include/mach/sdhi.h           |   16 
 arch/sh/boot/romimage/mmcif-sh7724.c                 |   10 
 drivers/mmc/host/tmio_mmc.c                          |   46 -
 include/linux/mmc/boot.h                             |    7 
 include/linux/mmc/sh_mmcif.h                         |    3 
 include/linux/mmc/tmio.h                             |   49 +
 19 files changed, 812 insertions(+), 162 deletions(-)

