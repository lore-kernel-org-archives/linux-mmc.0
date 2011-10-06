From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/2] MMC: disable multiblock reads on controllers that don't
 support them
Date: Thu, 06 Oct 2011 14:50:30 -0600
Message-ID: <20111006205002.7083.94088.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: sakoman@gmail.com, dhylands@gmail.com, cjb@laptop.org
List-Id: linux-mmc@vger.kernel.org

Hello,

Some MMC controller instances integrated on older OMAP34xx/35xx chips
don't work correctly with multiple-block reads, due to a hardware bug.
This series fixes the problem by adding an MMC capability flag for this
case and making the appropriate changes to the MMC core code and OMAP HSMMC
driver to support this.

Once this series is merged, a subsequent patch will be needed by us OMAP
folks to pass the appropriate device data via hwmod - this will be posted
separately.


- Paul

---
mmc_errata_2.1.1.128_fix_3.2
   text	   data	    bss	    dec	    hex	filename
6325283	 655708	5591124	12572115	 bfd5d3	vmlinux.omap2plus_defconfig.orig
6329423	 655700	5591124	12576247	 bfe5f7	vmlinux.omap2plus_defconfig.patched

Paul Walmsley (2):
      MMC: add workaround for controllers with broken multiblock reads
      MMC: omap_hsmmc: disable multiblock reads when platform_data indicates that they are broken


 arch/arm/plat-omap/include/plat/mmc.h |   19 ++++++++++++++++++-
 drivers/mmc/card/block.c              |   21 ++++++++++++++-------
 drivers/mmc/host/omap_hsmmc.c         |    4 ++++
 include/linux/mmc/host.h              |    1 +
 4 files changed, 37 insertions(+), 8 deletions(-)

