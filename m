From: "Tim Kryger" <tim.kryger@linaro.org>
Subject: [RESEND PATCH v2 0/6] Update Kona drivers to use clocks
Date: Wed, 16 Oct 2013 14:47:04 -0700
Message-ID: <1381960030-1640-1-git-send-email-tim.kryger@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Daudt <bcm@fixthebug.org>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Chris Ball <cjb@laptop.org>
Cc: Tim Kryger <tim.kryger@linaro.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

This series declares the clocks present on bcm11351 (aka bcm281xx) SoCs
to be fixed at the rates configured by development bootloaders and then
updates the Kona drivers to make use of clock calls where appropriate.

This patch series depends on the following three commits being present:

https://lkml.org/lkml/2013/9/18/409
https://lkml.org/lkml/2013/9/20/305
http://www.spinics.net/lists/arm-kernel/msg274973.html

Changes in v2:
  - Renamed bsc4_clk to pmu_bsc_clk

Tim Kryger (6):
  ARM: dts: Declare clocks as fixed on bcm11351
  ARM: dts: Specify clocks for UARTs on bcm11351
  ARM: dts: Specify clocks for SDHCIs on bcm11351
  clocksource: kona: Add basic use of external clock
  ARM: dts: Specify clocks for timer on bcm11351
  mmc: sdhci-bcm-kona: Add basic use of clocks

 arch/arm/boot/dts/bcm11351.dtsi      | 111 +++++++++++++++++++++++++++++++++--
 drivers/clocksource/bcm_kona_timer.c |  14 ++++-
 drivers/mmc/host/sdhci-bcm-kona.c    |  30 +++++++++-
 3 files changed, 145 insertions(+), 10 deletions(-)

-- 
1.8.0.1
