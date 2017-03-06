From: Romain Perier <romain.perier@collabora.com>
Subject: [PATCH v2 0/4] mmc: pwrseq: post_ios power sequence
Date: Mon,  6 Mar 2017 15:17:12 +0100
Message-ID: <20170306141716.19120-1-romain.perier@collabora.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57592 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbdCFORi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Mar 2017 09:17:38 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>, Romain Perier <romain.perier@collabora.com>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>

Some devices, like WiFi chipsets AP6335 require a specific power-up
sequence ordering before being used. You must enable the vqmmc power supply
and wait until it reaches its minimum voltage, gate the clock and wait
at least two cycles and then assert the reset line.

See DS 1/

Currently, there is no generic manner for doing this with pwrseq_simple.
This set of patches proposes an approach to support this use case.

It is related to the old patch 2/

1. http://www.t-firefly.com/download/firefly-rk3288/hardware/AP6335%20datasheet_V1.3_02102014.pdf
2. http://lists.infradead.org/pipermail/linux-arm-kernel/2017-March/490681.html

Changes in v2:
- Added missing power_off function in operations for post_ios
- Fixed warning found by 0day-ci about missing
  mmc_pwrseq_post_ios_power_on when CONFIG_OF is disabled.

Romain Perier (4):
  mmc: core: Add post_ios_power_on callback for power sequences
  mmc: pwrseq-simple: Add optional op. for post_ios_power_on callback
  mmc: pwrseq_simple: Add an optional pre-power-on-delay
  arm: dts: rockchip: Enable post_ios_power_on and pre-power-on-delay-ms

 .../devicetree/bindings/mmc/mmc-pwrseq-simple.txt  |  2 ++
 arch/arm/boot/dts/rk3288-rock2-square.dts          |  2 ++
 drivers/mmc/core/core.c                            |  1 +
 drivers/mmc/core/pwrseq.c                          |  8 ++++++++
 drivers/mmc/core/pwrseq.h                          |  3 +++
 drivers/mmc/core/pwrseq_simple.c                   | 22 +++++++++++++++++++++-
 6 files changed, 37 insertions(+), 1 deletion(-)

-- 
2.9.3

