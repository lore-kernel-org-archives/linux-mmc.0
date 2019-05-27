From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 0/3] mmc: meson-gx: add dram-access-quirk support
Date: Mon, 27 May 2019 14:43:04 +0200
Message-ID: <20190527124307.32075-1-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@baylibre.com
Cc: Neil Armstrong <narmstrong@baylibre.com>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On the Amlogic G12A SoC family, (only) the SDIO controller fails to access
the data from DRAM, leading to a broken controller.

Add the amlogic,ddr-access-quirk property so signal this particular
controller has this bug and needs a quirk to work properly.

But each MMC controller has 1,5KiB of SRAM after the registers, that can
be used as bounce buffer to avoid direct DDR access from the integrated
DMAs (this SRAM may be used by the boot ROM when DRAM is not yet initialized).

The quirk is to disable the chained descriptor for this controller, and
use this SRAM memory zone as buffer for the bounce buffer fallback mode.

The performance hit hasn't been evaluated, but the fix has been tested
using a WiFi AP6398S SDIO module, and the iperf3 Bandwidth measurement gave
55.2 Mbits/sec over a 63 Hours long test, with the SDIO ios set as High-Speed
at 50MHz clock. It gave around 170 Mbits/sec as SDR104 and 200MHz clock.

Changes since v1:
* use DRAM instead of DDR, added details in bindings on internal DMA controller
* fix probe() to not try to unallocate bounce buffer on error
* replace DT patch adding SDIO property to patch adding SDIO controller

Jerome Brunet (1):
  arm64: dts: meson: g12a: add SDIO controller

Neil Armstrong (2):
  dt-bindings: mmc: meson-gx: add dram-access-quirk property
  mmc: meson-gx: add dram-access-quirk

 .../bindings/mmc/amlogic,meson-gx.txt         |  4 ++
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi   | 37 ++++++++++
 drivers/mmc/host/meson-gx-mmc.c               | 70 +++++++++++++++----
 3 files changed, 96 insertions(+), 15 deletions(-)

-- 
2.21.0
