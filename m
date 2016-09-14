From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 0/4] tmio: add support for eMMC with 8 bit bus width
Date: Wed, 14 Sep 2016 19:05:54 +0200
Message-ID: <20160914170558.1561-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46003 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761877AbcINRGF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 14 Sep 2016 13:06:05 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Dirk Behme <dirk.behme@gmail.com>, Wolfram Sang <wsa@the-dreams.de>

From: Wolfram Sang <wsa@the-dreams.de>

This series enables SDHI instances on R-Car Gen3 to access eMMC with 8 bit bus
width. I think the patch descriptions speak for themselves.

I decided to not protect this new feature with a flag because it needs
specifically to be enabled by setting the bus width to 8. No legacy platform
does that.

The DTS changes for R-Car Gen3 will come via a seperate series. Note that
'non-removable' is not supported yet because of Runtime PM issues. It seems we
need to overhaul Runtime PM handling for other reasons as well, so I suggest
the basic support goes in like this and DTS do not use 'non-removable' for now.

These patches are based on top of Simon's sdr104-v7 patches but they apply to
current mmc/next as well. A branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/topic/sdhi-8bit-emmc-driver

Please review, comment, apply...

   Wolfram


Wolfram Sang (4):
  mmc: add define for R1 response without CRC
  mmc: rtsx_pci: use new macro for R1 without CRC
  mmc: rtsx_usb: use new macro for R1 without CRC
  mmc: tmio: add eMMC support

 drivers/mmc/host/rtsx_pci_sdmmc.c |  2 +-
 drivers/mmc/host/rtsx_usb_sdmmc.c |  2 +-
 drivers/mmc/host/tmio_mmc.h       |  3 +++
 drivers/mmc/host/tmio_mmc_pio.c   | 29 +++++++++++++++++------------
 include/linux/mmc/core.h          |  3 +++
 5 files changed, 25 insertions(+), 14 deletions(-)

-- 
2.9.3

