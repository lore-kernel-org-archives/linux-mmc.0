From: Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>
Subject: [PATCH v4 0/3] mmc: dw_mmc: Add support for Rockchip variant
Date: Thu, 13 Jun 2013 10:55:48 +0200
Message-ID: <201306131055.49595.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:43218 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756822Ab3FMIzy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 13 Jun 2013 04:55:54 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Andy Shevchenko <andy.shevchenko@gmail.com>

The driver support for the mmc host is not needed for the core SoC support
and in the same way the mmc support does not need the SoC code to function.
Therefore it can be submitted (and hopefully merged) on its own.


Changes since v3:
- submit mmc driver standalone
- add dt binding documentation

Changes since v2:
- split "mmc: dw_mmc-pltfm: add Rockchip variant" into move and feature parts
  as suggested by Andy Shevchenko

Changes since v1:
none

Dependencies:
- "mmc: dw_mmc: Add support DW SD/MMC driver on SOCFPGA" from Dinh Nguyen that
  moves the SDMMC_CMD_USE_HOLD_REG constant into the common header, which is
  required on these Rockchip SoCs 


Heiko Stuebner (3):
  mmc: dw_mmc-pltfm: remove static from dw_mci_pltfm_remove
  mmc: dw_mmc-pltfm: move probe and remove below dt match table
  mmc: dw_mmc-pltfm: add Rockchip variant

 .../devicetree/bindings/mmc/rockchip-dw-mshc.txt   |   23 ++++++++++
 drivers/mmc/host/dw_mmc-pltfm.c                    |   47 ++++++++++++++------
 2 files changed, 56 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt

-- 
1.7.10.4

