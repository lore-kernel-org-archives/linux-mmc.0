From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.13 rc3
Date: Fri, 28 Jul 2017 10:04:52 +0200
Message-ID: <CAPDyKFow_4Dog-KN-0z+TtQRAcYYz2vB45tT0LWn7=70Yro-hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here are a couple of mmc fixes intended for v4.13-rc1.

I have also included a couple of cleanup patches in this PR for
OMAP2+, related to the omap_hsmmc driver. The reason is because of the
changes are also depending on OMAP SoC specific code, so this
simplifies how to deal with this. Please tell if you don't like this.

Details are as usual found in the signed tag. Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.13-rc1

for you to fetch changes up to 3f5b4b79d4c0fa71fd7d74c2a44bbc0869c04c9b:

  Documentation: dw-mshc: deprecate num-slots (2017-07-27 16:11:39 +0200)

----------------------------------------------------------------
MMC host:
 - sunxi: Correct time phase settings
 - omap_hsmmc: Clean up some dead code
 - dw_mmc: Fix message printed for deprecated num-slots DT binding
 - dw_mmc: Fix DT documentation

----------------------------------------------------------------
Chen-Yu Tsai (1):
      mmc: sunxi: Keep default timing phase settings for new timing mode

Faiz Abbas (2):
      ARM: OMAP2+: hsmmc.c: Remove dead code
      mmc: host: omap_hsmmc: remove unused platform callbacks

Shawn Lin (2):
      mmc: dw_mmc: fix the wrong condition check of getting num-slots from DT
      Documentation: dw-mshc: deprecate num-slots

 .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |   1 -
 .../devicetree/bindings/mmc/img-dw-mshc.txt        |   1 -
 .../devicetree/bindings/mmc/k3-dw-mshc.txt         |   2 -
 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |  16 +-
 .../devicetree/bindings/mmc/zx-dw-mshc.txt         |   1 -
 arch/arm/mach-omap2/hsmmc.c                        | 239 +--------------------
 arch/arm/mach-omap2/hsmmc.h                        |   9 -
 drivers/mmc/host/dw_mmc.c                          |   2 +-
 drivers/mmc/host/omap_hsmmc.c                      |  11 -
 drivers/mmc/host/sunxi-mmc.c                       |   8 +-
 include/linux/platform_data/hsmmc-omap.h           |  10 -
 11 files changed, 16 insertions(+), 284 deletions(-)
