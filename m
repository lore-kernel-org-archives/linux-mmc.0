From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 0/3] Optimize voltage switch for the SD controller
Date: Fri, 21 Jun 2019 14:12:30 +0800
Message-ID: <cover.1561094029.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: baolin.wang@linaro.org, vincent.guittot@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

This patch set is used to optimize voltage switch for the
Spreadtrum SD host controller.

Any comments are welcome. Thanks.

Baolin Wang (3):
  mmc: sdhci-sprd: Add start_signal_voltage_switch ops
  dt-bindings: mmc: sprd: Add pinctrl support
  mmc: sdhci-sprd: Add pin control support for voltage switch

 .../devicetree/bindings/mmc/sdhci-sprd.txt         |    7 ++
 drivers/mmc/host/sdhci-sprd.c                      |   78 ++++++++++++++++++++
 2 files changed, 85 insertions(+)

-- 
1.7.9.5
