From: Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH 0/2] mmc: Add support for the ASPEED SD controller
Date: Wed, 10 Jul 2019 23:46:09 +0930
Message-ID: <20190710141611.21159-1-andrew@aj.id.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrew Jeffery <andrew@aj.id.au>, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, joel@jms.id.au, adrian.hunter@intel.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, ryanchen.aspeed@gmail.com
List-Id: linux-mmc@vger.kernel.org

Hello,

This short series introduce devicetree bindings and a driver for the ASPEED SD
controller. Please review!

Andrew

Andrew Jeffery (2):
  dt-bindings: mmc: Document Aspeed SD controller
  mmc: Add support for the ASPEED SD controller

 .../bindings/mmc/sdhci-of-aspeed.yaml         |  91 ++++++
 drivers/mmc/host/Kconfig                      |  12 +
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/sdhci-of-aspeed.c            | 307 ++++++++++++++++++
 4 files changed, 411 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-of-aspeed.yaml
 create mode 100644 drivers/mmc/host/sdhci-of-aspeed.c

-- 
2.20.1
