From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 0/6] mmc: omap_hsmmc: start using generic non-removable DT binding
Date: Wed, 16 Oct 2013 20:48:21 +0530
Message-ID: <1381936707-10336-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59661 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758644Ab3JPPTM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 16 Oct 2013 11:19:12 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: linux-omap@vger.kernel.org, uri.y@variscite.com, Balaji T K <balajitk@ti.com>

start using generic non-removable DT binding and few cleanups for
am335x-boneblack.dts and omap4-var-som.dts. Dropped changes for omap4-sdp and
omap4-panda-common.dtsi from Sekhar Nori's series [1] as non-removable already
exist for mmc5 on omap4-sdp and omap4-panda-common.dtsi
and ti,non-removable is needed for eMMC detection during boot on omap4-sdp.

[1]
http://comments.gmane.org/gmane.linux.kernel.mmc/22424

Balaji T K (3):
  ARM: dts: dra7-evm: mark eMMC as non removable
  ARM: dts: am335x-boneblack: remove unused ti,vcc-aux-disable-is-sleep
  ARM: dts: omap4-var-some: fix bus-width

Sekhar Nori (3):
  mmc: omap_hsmmc: start using generic non-removable DT binding
  ARM: dts: OMAP4/5: start using generic binding for non-removable mmc
    cards
  ARM: dts: am335x-boneblack: mark eMMC as non removable

 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |    2 +-
 arch/arm/boot/dts/am335x-boneblack.dts             |    2 +-
 arch/arm/boot/dts/dra7-evm.dts                     |    1 +
 arch/arm/boot/dts/omap4-var-som.dts                |    4 ++--
 arch/arm/boot/dts/omap5-uevm.dts                   |    4 ++--
 drivers/mmc/host/omap_hsmmc.c                      |    3 +++
 6 files changed, 10 insertions(+), 6 deletions(-)

-- 
1.7.5.4

