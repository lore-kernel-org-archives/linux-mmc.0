From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 00/27] add
	pm_runtime_last_busy_and_autosuspend() helper
Date: Wed, 24 Sep 2014 21:44:50 +0530
Message-ID: <1411575342-31048-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: linux-kernel@vger.kernel.org
Cc: linux-wireless@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>, patches@opensource.wolfsonmicro.com, linux-doc@vger.kernel.org, Seungwon Jeon <tgih.jun@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Chris Ball <chris@printf.net>, dri-devel@lists.freedesktop.org, Marcin Wojtas <mw@semihalf.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Herrmann <dh.herrmann@gmail.com>, Shinya Kuribayashi <skuribay@pobox.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, vinod.koul@intel.com, Jingoo Han <jg1.han@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Jani Nikula <jani.nikula@intel.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Alan Stern <stern@rowland.harvard.edu>, Ben Skeggs <bskeggs@redhat.com>, Bjorn Andersson <bjorn.andersson@sonymobile.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-mmc@vger.kernel.org

This patch series adds a simple macro pm_runtime_last_busy_and_autosuspend()
which invokes pm_runtime_mark_last_busy() and pm_runtime_put_autosuspend()
sequentially. Then we do a tree wide update of current patterns which are
present. As evident from log below this pattern is frequent in the
kernel.

This series can be found at
git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/slave-dma.git
topic/pm_runtime_last_busy_and_autosuspend

Fengguang's kbuild has tested it so it shouldn't break things for anyone.
Barring one patch (explictyly mentioned in its changelog) rest are simple
replacements.

If all are okay, this should be merged thru PM tree as it depends on macro
addition.

Subhransu S. Prusty (1):
  PM: Add helper pm_runtime_last_busy_and_autosuspend()

Vinod Koul (26):
  dmaengine: ste_dma: use pm_runtime_last_busy_and_autosuspend helper
  extcon: arizona: use pm_runtime_last_busy_and_autosuspend helper
  drm/i915: use pm_runtime_last_busy_and_autosuspend helper
  drm/nouveau: use pm_runtime_last_busy_and_autosuspend helper
  drm/radeon: use pm_runtime_last_busy_and_autosuspend helper
  vga_switcheroo: use pm_runtime_last_busy_and_autosuspend helper
  i2c: designware: use pm_runtime_last_busy_and_autosuspend helper
  i2c: omap: use pm_runtime_last_busy_and_autosuspend helper
  i2c: qup: use pm_runtime_last_busy_and_autosuspend helper
  mfd: ab8500-gpadc: use pm_runtime_last_busy_and_autosuspend helper
  mfd: arizona: use pm_runtime_last_busy_and_autosuspend helper
  mei: use pm_runtime_last_busy_and_autosuspend helper
  mmc: use pm_runtime_last_busy_and_autosuspend helper
  mmc: mmci: use pm_runtime_last_busy_and_autosuspend helper
  mmc: omap_hsmmc: use pm_runtime_last_busy_and_autosuspend helper
  mmc: sdhci-pxav3: use pm_runtime_last_busy_and_autosuspend helper
  mmc: sdhci: use pm_runtime_last_busy_and_autosuspend helper
  NFC: trf7970a: use pm_runtime_last_busy_and_autosuspend helper
  pm2301-charger: use pm_runtime_last_busy_and_autosuspend helper
  spi: omap2-mcspi: use pm_runtime_last_busy_and_autosuspend helper
  spi: orion: use pm_runtime_last_busy_and_autosuspend helper
  spi: ti-qspi: use pm_runtime_last_busy_and_autosuspend helper
  spi: core: use pm_runtime_last_busy_and_autosuspend helper
  tty: serial: omap: use pm_runtime_last_busy_and_autosuspend helper
  usb: musb: omap2430: use pm_runtime_last_busy_and_autosuspend helper
  video: fbdev: use pm_runtime_last_busy_and_autosuspend helper

 Documentation/power/runtime_pm.txt          |    4 ++
 drivers/dma/ste_dma40.c                     |   30 ++++---------
 drivers/extcon/extcon-arizona.c             |    6 +--
 drivers/gpu/drm/i915/intel_pm.c             |    3 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c |    3 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c       |    9 +---
 drivers/gpu/drm/radeon/radeon_connectors.c  |   15 ++----
 drivers/gpu/drm/radeon/radeon_drv.c         |    5 +-
 drivers/gpu/drm/radeon/radeon_kms.c         |    6 +--
 drivers/gpu/vga/vga_switcheroo.c            |    7 +--
 drivers/i2c/busses/i2c-designware-core.c    |    3 +-
 drivers/i2c/busses/i2c-omap.c               |    6 +--
 drivers/i2c/busses/i2c-qup.c                |    3 +-
 drivers/mfd/ab8500-gpadc.c                  |    6 +--
 drivers/mfd/arizona-irq.c                   |    3 +-
 drivers/misc/mei/client.c                   |   12 ++----
 drivers/mmc/core/core.c                     |    3 +-
 drivers/mmc/host/mmci.c                     |   12 ++----
 drivers/mmc/host/omap_hsmmc.c               |   19 ++-------
 drivers/mmc/host/sdhci-pxav3.c              |    6 +--
 drivers/mmc/host/sdhci.c                    |    3 +-
 drivers/nfc/trf7970a.c                      |    3 +-
 drivers/power/pm2301_charger.c              |    3 +-
 drivers/spi/spi-omap2-mcspi.c               |    9 +---
 drivers/spi/spi-orion.c                     |    3 +-
 drivers/spi/spi-ti-qspi.c                   |    5 +-
 drivers/spi/spi.c                           |    6 +--
 drivers/tty/serial/omap-serial.c            |   60 +++++++++------------------
 drivers/usb/musb/omap2430.c                 |    6 +--
 drivers/video/fbdev/auo_k190x.c             |    9 +---
 include/linux/pm_runtime.h                  |    6 +++
 31 files changed, 97 insertions(+), 177 deletions(-)


Thanks
-- 
~Vinod
