From: "kishore kadiyala" <kishore.kadiyala@ti.com>
Subject: [PATCH v3 0/4] omap4 hsmmc: Card detect and Register offset
     handling
Date: Wed, 22 Sep 2010 22:13:15 +0530 (IST)
Message-ID: <14831.10.24.255.18.1285173795.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

The patch series is based on mainline 2.6.36-rc5.
The series is tested on OMAP3430SDP and OMAP4430SDP and has dependency on
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg34718.html

V2:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg35135.html

V1:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg34040.html

Kishore Kadiyala (3):
  omap4 hsmmc : Adding card detect support for MMC1
  omap4 hsmmc: Register offset handling
  omap4 hsmmc: Update ocr mask for MMC2 for regulator to use

Benoit Cousson (1);
  omap4 hsmmc: Fix the init if CONFIG_MMC_OMAP_HS is not set

 arch/arm/mach-omap2/board-4430sdp.c   |   16 ++++++-
 arch/arm/mach-omap2/devices.c         |    8 +--
 arch/arm/mach-omap2/hsmmc.c           |    4 ++
 arch/arm/plat-omap/include/plat/mmc.h |    3 +
 drivers/mfd/twl6030-irq.c             |   72 +++++++++++++++++++++++++++++++++
 drivers/mmc/host/omap_hsmmc.c         |   18 +++++++-
 include/linux/i2c/twl.h               |   31 ++++++++++++++
 7 files changed, 143 insertions(+), 9 deletions(-)


