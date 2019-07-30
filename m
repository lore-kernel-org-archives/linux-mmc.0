From: Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH v3 0/2] mmc: Add support for the ASPEED SD controller
Date: Tue, 30 Jul 2019 15:53:14 +0930
Message-ID: <20190730062316.32037-1-andrew@aj.id.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrew Jeffery <andrew@aj.id.au>, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, joel@jms.id.au, adrian.hunter@intel.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, ryanchen.aspeed@gmail.com
List-Id: linux-mmc@vger.kernel.org

Hello,

v3 of the ASPEED SDHCI driver makes a bunch of fixes to the driver and the
devicetree binding, including the addition of the AST2600 compatible string.

v2 can be found here:

https://lists.ozlabs.org/pipermail/linux-aspeed/2019-July/002013.html

Please review!

Andrew

Andrew Jeffery (2):
  dt-bindings: mmc: Document Aspeed SD controller
  mmc: Add support for the ASPEED SD controller

 .../devicetree/bindings/mmc/aspeed,sdhci.yaml | 100 ++++++
 drivers/mmc/host/Kconfig                      |  12 +
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/sdhci-of-aspeed.c            | 328 ++++++++++++++++++
 4 files changed, 441 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
 create mode 100644 drivers/mmc/host/sdhci-of-aspeed.c

-- 
2.20.1
