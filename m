From: David Lechner <david@lechnology.com>
Subject: [PATCH v3 0/5] davinci_mmc fixes
Date: Wed, 16 Mar 2016 22:45:30 -0500
Message-ID: <1458186341-6970-1-git-send-email-david@lechnology.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: David Lechner <david@lechnology.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

I have replaced one of my patches with the patch from Peter Ujfalusi and fixed
a mistake in the "fix unwinding..." patch.

Tested working on LEGO MINDSTORMS EV3 (da850-ish).

David Lechner (4):
  mmc: davinci: remove matching string
  mmc: davinci: fix unwinding in probe
  mmc: davinci: prepare clock
  ARM: davinci: remove mmc dma resources

Peter Ujfalusi (1):
  mmc: davinci_mmc: Use dma_request_chan() to requesting DMA channel

 arch/arm/mach-davinci/devices-da8xx.c |  20 -----
 arch/arm/mach-davinci/devices.c       |  16 ----
 drivers/mmc/host/davinci_mmc.c        | 147 ++++++++++++----------------------
 3 files changed, 50 insertions(+), 133 deletions(-)

-- 
1.9.1
