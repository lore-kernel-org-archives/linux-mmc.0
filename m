From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH v3 0/7] ARM: shmobile: DMAC, MMCIF and SDHI for H2 and APE6
Date: Mon,  8 Jul 2013 17:54:39 +0200
Message-ID: <1373298887-9877-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

These patches add support for DMA, MMCIF and SDHI controllers to non-DT 
APE6EVM and Lager board implementations, and MMCIF and SDHI DT templates 
for APE6 and H2 SoCs.

A note concerning SDHI OF compatibility strings. Patch 5 of this series 
adds OF compatibility strings for sh73a0, r8a73a4, r8a7790 to make it 
possible to use correct SoC names instead of a supposedly compatible one. 
Patches 6 and 7 then use those names in SDHI DT templates on r8a73a4 and 
r8a7790. This doesn't directly impose a commit order dependency, since 
those templates are added in a disabled state. Therefore these patches 
can be pushed upstream via different git-trees. Only when specific boards 
enable SDHI interfaces in their .dts files, only then will it be 
important to have both respective patches in the kernel: the drivers/mmc 
patch and the respective SoC .dtsi patch. It is therefore proposed to 
push these patches to 3.12 and to begin enabling SDHI interfaces in 
respective board .dtsi files from 3.13. Also note, that sh73a0 is already 
using "renesas,r8a7740-sdhi" compatibility in its .dtsi. After patch 5 
this still will work, but it also will become possible to use a more 
obvious "renesas,sh73a0-sdhi" OF compatibility string.

Developed and tested on top of Simon's renesas.git next snapshot of
08.07.2013.

Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Cc: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>

Guennadi Liakhovetski (7):
  ARM: shmobile: r8a73a4: add a DMAC platform device and clock for it
  ARM: shmobile: ape6evm: add MMCIF support
  ARM: shmobile: ape6evm: add SDHI interfaces
  ARM: shmobile: lager: add MMCIF support
  mmc: SDHI: add DT compatibility strings for further SoCs
  ARM: shmobile: r8a73a4: add MMCIF and SDHI DT templates
  ARM: shmobile: r8a7790: add MMCIF and SDHI DT templates

 arch/arm/boot/dts/r8a73a4.dtsi                |   45 ++++++++++++
 arch/arm/boot/dts/r8a7790.dtsi                |   54 +++++++++++++++
 arch/arm/mach-shmobile/board-ape6evm.c        |   81 ++++++++++++++++++++++
 arch/arm/mach-shmobile/board-lager.c          |   31 +++++++++
 arch/arm/mach-shmobile/clock-r8a73a4.c        |    4 +-
 arch/arm/mach-shmobile/include/mach/r8a73a4.h |    9 +++
 arch/arm/mach-shmobile/setup-r8a73a4.c        |   90 +++++++++++++++++++++++++
 drivers/mmc/host/sh_mobile_sdhi.c             |    3 +
 8 files changed, 316 insertions(+), 1 deletions(-)

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
