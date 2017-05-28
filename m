From: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
Subject: [PATCH 0/7] tree-wide: use proper 'R-Car' product name
Date: Sun, 28 May 2017 11:30:43 +0200
Message-ID: <20170528093051.11816-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Small series to get the R-Car product name proper. Based on
renesas-drivers/master, but can be applied to current linus/master as well.
Except for the MMC patch, which depends on mmc/next.

Please apply.

Wolfram Sang (7):
  dmaengine: use proper name for the R-Car SoC
  i2c: use proper name for the R-Car SoC
  iio: use proper name for the R-Car SoC
  mmc: use proper name for the R-Car SoC
  pci: use proper name for the R-Car SoC
  [media] soc_camera: rcar_vin: use proper name for the R-Car SoC
  [media] v4l: rcar_fdp1: use proper name for the R-Car SoC

 Documentation/devicetree/bindings/dma/shdma.txt               | 2 +-
 Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt | 2 +-
 Documentation/devicetree/bindings/media/rcar_vin.txt          | 4 ++--
 Documentation/devicetree/bindings/pci/rcar-pci.txt            | 2 +-
 drivers/i2c/busses/i2c-rcar.c                                 | 2 +-
 drivers/media/platform/rcar_fdp1.c                            | 2 +-
 drivers/mmc/host/renesas_sdhi_core.c                          | 2 +-
 include/linux/mfd/tmio.h                                      | 2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.11.0
