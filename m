From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/6] mmc: sh_mmcif: revision-specific CCS and CLK_CTRL2 handling
Date: Wed, 10 Jul 2013 21:21:11 +0200
Message-ID: <1373484077-10460-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Chris Ball <cjb@laptop.org>, Nobuyuki HIRAI <nobuyuki.hirai.xe@renesas.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
List-Id: linux-mmc@vger.kernel.org

This patch series adds version-specific support for Command Completion 
Signal and the CE_CLK_CTRL2 register. Presumably, the first two patches 
will go via the MMC tree, the rest should be applied after them.

Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Guennadi Liakhovetski (6):
  mmc: sh_mmcif: revision-specific Command Completion Signal handling
  mmc: sh_mmcif: revision-specific CLK_CTRL2 handling
  ARM: shmobile: armadillo800eva: disable MMCIF Command Completion
    Signal
  ARM: shmobile: kzm9g: disable MMCIF Command Completion Signal
  ARM: shmobile: ape6evm: disable MMCIF Command Completion Signal
  ARM: shmobile: lager: disable MMCIF Command Completion Signal, add
    CLK_CTRL2

 arch/arm/mach-shmobile/board-ape6evm.c         |    1 +
 arch/arm/mach-shmobile/board-armadillo800eva.c |    1 +
 arch/arm/mach-shmobile/board-kzm9g.c           |    1 +
 arch/arm/mach-shmobile/board-lager.c           |    2 +
 drivers/mmc/host/sh_mmcif.c                    |   31 +++++++++++++++++++----
 include/linux/mmc/sh_mmcif.h                   |    3 ++
 6 files changed, 33 insertions(+), 6 deletions(-)

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
