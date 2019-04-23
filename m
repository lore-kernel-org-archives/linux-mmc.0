From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v2 0/7] mmc: meson-gx: clean up and tuning update
Date: Tue, 23 Apr 2019 11:02:28 +0200
Message-ID: <20190423090235.17244-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The purpose of this series is too improve reliability of the amlogic mmc
driver on new (g12a) and old ones (axg, gxl, gxbb, etc...)

* The 3 first patches are just harmless clean ups.
* Patch 4 makes sure HS400 can't be enabled, we still have not been able
  to crack this modes.
* Patch 5 removes some clock glitches when switching to DDR modes
* Patch 6 and 7 changes the tuning method from Rx phase to signal
  resampling. It could have been done in a single patch but the unified
  diff was extremely ugly. The change has been split in two patches to
  ease review.

The last tuning update that went through was meant to improve the axg
support. Since then, it was reported to break some other boards, like the
s912 vim2.

Also with the current tuning method, it was impossible to find phase
settings which would work on all the SoCs, including the new ones.

After redoing all the tests from scratch, it appeared that Rx phase made
(strangely) almost no difference, especially on g12a and axg. However, it
showed that it is important to have a phase shift between the Core and Tx
clock, 180 works best.

I discussed the test results with Amlogic. They suggested to use 180/0 or
0/180 for the Core and Tx phase. For tuning, they suggested to use
signal resampling.

So far, so good ... here the platform and modes tested:

NanoPi-K2 (S905): SD UHS SDR50/DDR50, SDIO HS
Odroid-C2 (S905): SD UHS SDR50/DDR50, eMMC DDR52/HS200 (16GB module)
Khadas Vim (S905X): SD HS, SDIO HS, eMMC HS200
Libretech CC (S905X): SD HS, eMMC HS200
Khadas Vim2 (S912): SD HS, SDIO HS, eMMC HS200
S400 (A113D): SDIO UHS SDR104, eMMC DDR52/HS200
U200 (S905D2): SD HS, eMMC DDR52/HS200
SEI510 (S905X2): SD HS, eMMC DDR52/HS200

Changes since v1 [0]:
* Add missing writel in patch 5 (error when switching width)
* Change patch 3 commit description

[0]: https://lkml.kernel.org/r/20190417204355.469-1-jbrunet@baylibre.com

Jerome Brunet (7):
  mmc: meson-gx: remove open coded read with timeout
  mmc: meson-gx: ack only raised irq
  mmc: meson-gx: correct irq flag
  mmc: meson-gx: disable HS400
  mmc: meson-gx: avoid clock glitch when switching to DDR modes
  mmc: meson-gx: remove Rx phase tuning
  mmc: meson-gx: add signal resampling tuning

 drivers/mmc/host/meson-gx-mmc.c | 419 +++++++++-----------------------
 1 file changed, 114 insertions(+), 305 deletions(-)

-- 
2.20.1
