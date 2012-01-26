From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/7 v2] extract a simple dmaengine library from
	shdma.c
Date: Thu, 26 Jan 2012 15:56:17 +0100
Message-ID: <1327589784-4287-1-git-send-email-g.liakhovetski@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-mmc@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, linux-serial@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

This is v2 of the simple DMA dmaengine library. It addresses Paul's 
comments to v1 - thanks, adds some comments.

Guennadi Liakhovetski (7):
  dmaengine: add a simple dma library
  dma: shdma: prepare for simple DMA conversion
  mmc: sh_mmcif: remove unneeded struct sh_mmcif_dma, prepare for
    simple DMA
  mmc: sh_mobile_sdhi: prepare for conversion to simple DMA
  serial: sh-sci: prepare for conversion to simple DMA
  ASoC: SIU: prepare for conversion to simple DMA
  dma: shdma: convert to the simple DMA library

 drivers/dma/Kconfig               |    4 +
 drivers/dma/Makefile              |    1 +
 drivers/dma/dma-simple.c          |  873 ++++++++++++++++++++++++++++
 drivers/dma/shdma.c               | 1138 +++++++++----------------------------
 drivers/dma/shdma.h               |   45 +-
 drivers/mmc/host/sh_mmcif.c       |   24 +-
 drivers/mmc/host/sh_mobile_sdhi.c |    8 +-
 drivers/tty/serial/sh-sci.c       |    8 +-
 include/linux/dma-simple.h        |  124 ++++
 include/linux/mmc/sh_mmcif.h      |    8 +-
 include/linux/sh_dma.h            |   39 +-
 sound/soc/sh/siu_pcm.c            |    8 +-
 12 files changed, 1334 insertions(+), 946 deletions(-)
 create mode 100644 drivers/dma/dma-simple.c
 create mode 100644 include/linux/dma-simple.h

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
