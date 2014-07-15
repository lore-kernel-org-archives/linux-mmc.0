From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 00/11] MMCIF and SDHI DMA support in DT for R-Car H2 and M2
Date: Wed, 16 Jul 2014 00:45:10 +0200
Message-ID: <1405464321-4723-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:54049 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297AbaGOWpU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Jul 2014 18:45:20 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian.molton@codethink.co.uk>

Hello,

This patch series enables DMA support for the MMCIF and SDHI devices on R-Car
H2 (r8a7790) and M2 (r8a7791) when booting through DT.

The first patch documents DT bindings for the MMCIF device. DT support is
implemented in the driver, but the bindings documentation was missing. Patches
02/11 to 05/11 then fix DMA slave configuration in the MMCIF and SDHI drivers.
Finally patches 06/11 to 11/11 enable DMA support in DT for H2 and M2.

Patches 08/11 to 11/11 depend on the R-Car Gen2 DMAC driver posted to the
dmaengine and linux-sh mailing lists as "[PATCH 0/7] R-Car Gen2 DMA Controller
driver".

The first five patches (driver changes) should go through the DMA engine tree,
while the last six patches (platform changes) should go through the Renesas
tree. If the driver changes could make it to v3.17 merging the platform
changes will be easier.

Laurent Pinchart (11):
  mmc: sh_mmcif: Document DT bindings
  mmc: sh_mmcif: Fix DMA slave address configuration
  mmc: sh_mmcif: Configure DMA slave bus width
  mmc: tmio: Configure DMA slave bus width
  mmc: tmio: Fix DMA source address
  ARM: shmobile: r8a7790: Rename mmcif node to mmc
  ARM: shmobile: r8a7791: Add MMCIF0 DT node
  ARM: shmobile: r8a7790: Reference DMA channels in MMCIF DT nodes
  ARM: shmobile: r8a7791: Reference DMA channels in MMCIF DT node
  ARM: shmobile: r8a7790: Reference DMA channels in SDHI DT nodes
  ARM: shmobile: r8a7791: Reference DMA channels in SDHI DT nodes

 .../devicetree/bindings/mmc/renesas,mmcif.txt      | 32 ++++++++++++++++++++++
 arch/arm/boot/dts/r8a7790.dtsi                     | 14 +++++++++-
 arch/arm/boot/dts/r8a7791.dtsi                     | 17 ++++++++++++
 drivers/mmc/host/sh_mmcif.c                        | 13 +++++++--
 drivers/mmc/host/tmio_mmc_dma.c                    |  4 ++-
 5 files changed, 75 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/renesas,mmcif.txt

-- 
Regards,

Laurent Pinchart

