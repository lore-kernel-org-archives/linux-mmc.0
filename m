From: =?UTF-8?q?Antoine=20T=C3=A9nart?=
	<antoine.tenart@free-electrons.com>
Subject: [PATCH 0/4] ARM: berlin: add SDHCI support
Date: Wed, 16 Apr 2014 14:40:07 +0200
Message-ID: <1397652011-21284-1-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:47866 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754523AbaDPMkP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Apr 2014 08:40:15 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: sebastian.hesselbarth@gmail.com, chris@printf.net, anton@enomsg.org
Cc: =?UTF-8?q?Antoine=20T=C3=A9nart?= <antoine.tenart@free-electrons.com>, alexandre.belloni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

This series adds the support for the SDHCI controller for Marvell Berli=
n
SoCs and enable the SD card reader and eMMC for the BG2Q DMP. The
controller supports 3 sockets.

Tested on the BG2Q DMP.

This series applies on top of Alexandre's patches for the Berlin's pll:
https://patchwork.kernel.org/patch/3890341/
https://patchwork.kernel.org/patch/3876271/

Antoine T=C3=A9nart (4):
  mmc: sdhci: add a driver for Berlin SoCs
  Documentation: bindings: add the sdhci-berlin
  ARM: dts: berlin: add the SDHCI nodes for the BG2Q
  ARM: dts: berlin: enable SD card reader and eMMC for the BG2Q DMP

 .../devicetree/bindings/mmc/sdhci-berlin.txt       |  18 +++
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts         |   8 ++
 arch/arm/boot/dts/berlin2q.dtsi                    |  40 +++++++
 drivers/mmc/host/Kconfig                           |  11 ++
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/sdhci-berlin.c                    | 129 +++++++++++++=
++++++++
 6 files changed, 207 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-berlin.=
txt
 create mode 100644 drivers/mmc/host/sdhci-berlin.c

--=20
1.8.3.2

