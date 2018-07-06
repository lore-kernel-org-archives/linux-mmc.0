From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: [PATCH v2 0/2] mmc: add SDHCI OF Synopsys DWC MSHC dirver
Date: Fri, 6 Jul 2018 15:19:30 +0800
Message-ID: <20180706151930.78b3024b@xhacker.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Prabu Thangamuthu <Prabu.T@synopsys.com>, Manjunath M B <Manjunath.MB@synopsys.com>
List-Id: linux-mmc@vger.kernel.org

Add support for Synopsys SDHCI compatible DesignWare Cores Mobile
Storage Host Controller which can support eMMC/SD/SDIO.

Since v1:
  - move the dt bindings into a separate patch

Jisheng Zhang (2):
  dt: bindings: Add bindings for SDHCI Synopsys DWC MSHC
  mmc: sdhci-of-dwcmshc: add SDHCI OF Synopsys DWC MSHC dirver

 .../bindings/mmc/sdhci-of-dwcmshc.txt         |  20 +++
 drivers/mmc/host/Kconfig                      |  11 ++
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/sdhci-of-dwcmshc.c           | 116 ++++++++++++++++++
 4 files changed, 148 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
 create mode 100644 drivers/mmc/host/sdhci-of-dwcmshc.c

-- 
2.18.0
