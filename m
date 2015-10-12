From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH 0/5] fix sdhci-pxav3 clock name and berlin clk clean up
Date: Mon, 12 Oct 2015 13:46:31 +0800
Message-ID: <1444628796-5484-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:37155 "EHLO
	mx0a-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750729AbbJLFuu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Oct 2015 01:50:50 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, sebastian.hesselbarth@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, mturquette@baylibre.com, sboyd@codeaurora.org
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jisheng Zhang <jszhang@marvell.com>

The sdhci-pxav3's clock name isn't correct. The current "io" clock is really
the PXAv3 SDHCI IP's "core" clock which is manadatory. The current "core"
clock is really the IP's "axi" clock which is optional. We fix this in patch1.

The following patches add the axi clock properties to bg2q dtsi, then remove
the CLK_IGNORE_UNUSED flag for sdio clk(s).

Jisheng Zhang (5):
  mmc: sdhci-pxav3: fix optional clock name
  ARM: dts: berlin: correct BG2Q's sdhci2 axi clock
  ARM: dts: berlin: add axi clock for BG2Q sdhci0 and sdhci1
  clk: berlin: bg2q: remove CLK_IGNORE_UNUSED flag for sdio clk
  clk: berlin: bg2: remove CLK_IGNORE_UNUSED flag for sdio clk

 .../devicetree/bindings/mmc/sdhci-pxa.txt          |  8 ++---
 arch/arm/boot/dts/berlin2.dtsi                     |  6 ++--
 arch/arm/boot/dts/berlin2cd.dtsi                   |  2 +-
 arch/arm/boot/dts/berlin2q.dtsi                    | 10 +++---
 drivers/clk/berlin/bg2.c                           |  4 +--
 drivers/clk/berlin/bg2q.c                          |  2 +-
 drivers/mmc/host/sdhci-pxav3.c                     | 40 +++++++++++-----------
 7 files changed, 37 insertions(+), 35 deletions(-)

-- 
2.6.1

