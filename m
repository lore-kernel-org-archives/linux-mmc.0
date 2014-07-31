From: Doug Anderson <dianders@chromium.org>
Subject: [PATCH v2 0/4] Add eMMC and SD card support for rk3288-evb
Date: Thu, 31 Jul 2014 09:13:16 -0700
Message-ID: <1406823200-20911-1-git-send-email-dianders@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f74.google.com ([209.85.220.74]:64045 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752987AbaGaQNY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 31 Jul 2014 12:13:24 -0400
Received: by mail-pa0-f74.google.com with SMTP id lj1so523633pab.5
        for <linux-mmc@vger.kernel.org>; Thu, 31 Jul 2014 09:13:23 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Addy Ke <addy.ke@rock-chips.com>, Kever Yang <kever.yang@rock-chips.com>, Sonny Rao <sonnyrao@chromium.org>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Doug Anderson <dianders@chromium.org>, mark.rutland@arm.com, devicetree@vger.kernel.org, linux@arm.linux.org.uk, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, linux-kernel@vger.kernel.org, robh+dt@kernel.org, galak@codeaurora.org

This series adds basic eMMC and SD card support for the rk3288-evb
board based on Addy's posted dw_mmc patch from:
  https://patchwork.kernel.org/patch/4653631/

The series is a little tricky because:
* Jaehoon has some outstanding patches to remove the slot node.  Since
  those haven't landed yet, I've posted my original patch with the
  slot node and then some future patches that can land with Jaehoon's
  patches.

So just to be explicit:
- Patch #1 and #2 can land after Addy's patch lands.
- Patch #3 and #4 can land after Jaehoon's patch lands, though there's
  no huge hurry since Jaehoon's patch supports the old mode (it just
  prints a warning).

Note that we don't have regulators specified yet (no regulator driver
for rk808-based board).  We also don't yet support UHS modes (which
require regulator support plus dw_mmc driver support for tuning).
Those features can come later.

Changes in v2:
- New patchwork link for Addy's patch
- Squashed in the DDR50 mode since Addy spun his patch.
- Refer to the new title of Jaehoon's patch

Doug Anderson (4):
  ARM: dts: Add emmc and sdmmc to the rk3288 device tree
  ARM: dts: Enable emmc and sdmmc on the rk3288-evb boards
  ARM: dts: Take the mmc slot node out of rk3288-evb
  ARM: dts: mmc slot node gone on rk3288 => no more address / size cells

 arch/arm/boot/dts/rk3288-evb.dtsi | 25 +++++++++++++++++++++++++
 arch/arm/boot/dts/rk3288.dtsi     | 18 ++++++++++++++++++
 2 files changed, 43 insertions(+)

-- 
2.0.0.526.g5318336

