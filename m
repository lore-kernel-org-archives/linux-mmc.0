From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFC 0/3] mmc: Add dynamic frequency scaling
Date: Mon, 12 Jan 2015 10:23:02 +0100
Message-ID: <1421054585-9032-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:27907 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752053AbbALJXX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Jan 2015 04:23:23 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>

Hi,


I would like to hear some comments about idea of scaling MMC clock
frequency. The basic idea is to lower the clock when device is
completely idle or not busy enough.

The patchset adds MMC card as a devfreq device and uses simple_ondemand
as governor. In idle this gave benefits (less energy consumed during
idle):
1. Trats2 (Exynos4412): 2.6%
2. Rinato (Exynos3250): 1%

but (especially on Rinato) it had impact on performance (probably
because ondemand triggering a little to late). What is interesting
manually changing the clock (without this patchset) gave slightly
bigger benefits. Maybe the devfreq introduces noticeable overhead?


Comments are welcomed. Maybe on other platforms this has bigger impact?

Best regards,
Krzysztof


Krzysztof Kozlowski (3):
  mmc: Add dynamic frequency scaling
  ARM: dts: Specify MSHC realistic clocks and use frequency scaling
  ARM: dts: Use frequency scaling for MSHC

 Documentation/devicetree/bindings/mmc/mmc.txt |   2 +
 arch/arm/boot/dts/exynos3250-rinato.dts       |   1 +
 arch/arm/boot/dts/exynos4412-trats2.dts       |   4 +-
 drivers/mmc/card/block.c                      | 247 ++++++++++++++++++++++++++
 drivers/mmc/core/Kconfig                      |  16 ++
 drivers/mmc/core/core.h                       |   1 -
 drivers/mmc/core/host.c                       |   2 +
 include/linux/mmc/card.h                      |   8 +
 include/linux/mmc/host.h                      |   3 +
 9 files changed, 282 insertions(+), 2 deletions(-)

-- 
1.9.1

