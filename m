From: Yixun Lan <yixun.lan@amlogic.com>
Subject: [PATCH 0/3] mmc: meson-axg: initial support for AXG SoC platform
Date: Tue, 3 Apr 2018 18:06:48 +0800
Message-ID: <20180403100652.41056-1-yixun.lan@amlogic.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Yixun Lan <yixun.lan@amlogic.com>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>, Jerome Brunet <jbrunet@baylibre.com>, Heiner Kallweit <hkallweit1@gmail.com>, Rob Herring <robh@kernel.org>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

   The patches series try to enable basic eMMC support in the Meson-AXG platfrom.

   Currently HS200 mode is tested with clock running at 166MHz, since
not all boards are stable to running 200MHz (due to tuning phase error),
we will further improve the tuning phase driver in the future,
but in my opiton, this patch series itself is pretty good to go.

Nan Li (3):
  mmc: dt-bindings: update bindings doc to support Meson-AXG SoC
  mmc: meson-axg: add support for the Meson-AXG platform
  mmc: meson: update doc to support Meson-AXG platform

 .../devicetree/bindings/mmc/amlogic,meson-gx.txt   |  1 +
 drivers/mmc/host/Kconfig                           |  4 +-
 drivers/mmc/host/meson-gx-mmc.c                    | 63 ++++++++++++++++++----
 3 files changed, 55 insertions(+), 13 deletions(-)

-- 
2.16.2
