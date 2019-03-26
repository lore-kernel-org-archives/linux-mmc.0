From: Takao Orito <orito.takao@socionext.com>
Subject: [PATCH v1 0/2] mmc: sdhci_f_sdh30: Add support for Milbeaut
Date: Tue, 26 Mar 2019 14:53:29 +0900
Message-ID: <1553579609-6100-1-git-send-email-orito.takao@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org, sugaya.taichi@socionext.com, kasai.kazuhiro@socionext.com, kanematsu.shinji@socionext.com, orito.takao@socionext.com
List-Id: linux-mmc@vger.kernel.org

The following patches add driver support for SD Host controller on
Socionext's Milbeaut M10V platforms.

SD Host controller on Milbeaut is consist of two controller parts.
One is core controller F_SDH30, this is similar to sdhci-fujitsu
controller.
Another is bridge controller. This bridge controller is not compatible
with sdhci-fujitsu controller. This is special for Milbeaut series.

It has the several parts,
 - reset control
 - clock enable / select for SDR50/25/12
 - hold control of DATA/CMD line
 - select characteristics for WP/CD/LED line
 - Re-tuning control for mode3
 - Capability setting
   Timeout Clock / Base Clock / Timer Count for Re-Tuning /
   Debounce period
These requires special procedures at reset or clock enable/change or
 further tuning of clock.

Takao Orito (2):
  dt-bindings: mmc: sdhci-fujitsu.txt: add miilbeaut driver
  mmc: sdhci_f_sdh30: Add support for Milbeaut M10V host controller

 .../devicetree/bindings/mmc/sdhci-fujitsu.txt      |  22 +-
 drivers/mmc/host/sdhci_f_sdh30.c                   | 324 +++++++++++++++++++--
 2 files changed, 315 insertions(+), 31 deletions(-)

-- 
1.9.1
