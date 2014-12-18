From: Alexandru M Stan <amstan@chromium.org>
Subject: [PATCH 0/3] mmc: dw_mmc: Generic clock phase tuning that works with rk3288 (possibly more!)
Date: Thu, 18 Dec 2014 15:01:00 -0800
Message-ID: <1418943663-10012-1-git-send-email-amstan@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:64391 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637AbaLRXBQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Dec 2014 18:01:16 -0500
Received: by mail-ob0-f175.google.com with SMTP id wp4so6986785obc.6
        for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2014 15:01:16 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: tgih.jun@samsung.com, jh80.chung@samsung.com, ulf.hansson@linaro.org
Cc: Heiko Stuebner <heiko@sntech.de>, Doug Anderson <dianders@chromium.org>, addy ke <addy.ke@rock-chips.com>, Andrew Bresticker <abrestic@chromium.org>, Sonny Rao <sonnyrao@chromium.org>, Kever Yang <kever.yang@rock-chips.com>, Mike Turquette <mturquette@linaro.org>, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Alexandru M Stan <amstan@chromium.org>

This series implements most of what's required to have tuning work on rk3288. A
lot of this is inspired by the exynos tuning code, but generalized to work for
any number of phases. At one point I realized that the tuning is not rockchip
specific so I changed it to work for any dw_mmc device.

Rockchip specific stuff:
"rk3288: Add drive/sample clocks" needs "ARM: dts: rockchip: set dw_mmc max-freq
150Mhz" to apply cleanly. So this series is based on heiko's github repository:
https://github.com/mmind/linux-rockchip/tree/wip/v3.20-armsoc/dts

The missing DTO interrupt is still a problem in DWMMC, at least on rockchip. So
if you want to test this you might want to grab "[PATCH v3] mmc: dw_mmc: add
quirk for broken data transfer over scheme" and my change in the replies there.
Warning: it still causes problems on some cards.

And of course one would have to enable the high speed functionality, something
like this would suffice:
https://chromium-review.googlesource.com/#/c/227199/34/arch/arm/boot/dts/rk3288-veyron.dtsi


Alexandru M Stan (3):
  mmc: dw_mmc: dt-binding: Add tuning related things
  mmc: dw_mmc: Generic MMC tuning with the clock phase framework
  ARM: dts: rk3288: Add drive/sample clocks for dw_mmc devices

 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |  14 +-
 arch/arm/boot/dts/rk3288.dtsi                      |  20 ++-
 drivers/mmc/host/dw_mmc.c                          | 189 +++++++++++++++++++++
 include/linux/mmc/dw_mmc.h                         |   3 +
 4 files changed, 214 insertions(+), 12 deletions(-)

-- 
2.2.0.rc0.207.ga3a616c

