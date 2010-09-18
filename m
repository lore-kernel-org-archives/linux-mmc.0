From: "kishore kadiyala" <kishore.kadiyala@ti.com>
Subject: [PATCH v2 0/4] OMAP4 hsmmc :card detect and Register offset
     handling
Date: Sat, 18 Sep 2010 22:03:49 +0530 (IST)
Message-ID: <33880.10.24.255.17.1284827629.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59415 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751551Ab0IRQdx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 18 Sep 2010 12:33:53 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The patch series is basically for OMAP4 and is based on mainline 2.6.36-rc4.
The series is tested on OMAP3430SDP and OMAP4430SDP and has dependency on
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg34718.html

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
 drivers/mfd/twl6030-irq.c             |   76 +++++++++++++++++++++++++++++++++
 drivers/mmc/host/omap_hsmmc.c         |   18 ++++++-
 include/linux/i2c/twl.h               |   31 +++++++++++++
 7 files changed, 146 insertions(+), 10 deletions(-)

