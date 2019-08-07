From: Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH v5 0/2] mmc: Add support for the ASPEED SD controller
Date: Wed,  7 Aug 2019 10:06:27 +0930
Message-ID: <20190807003629.2974-1-andrew@aj.id.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrew Jeffery <andrew@aj.id.au>, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, joel@jms.id.au, adrian.hunter@intel.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, ryanchen.aspeed@gmail.com
List-Id: linux-mmc@vger.kernel.org

Hello,

v5 of the ASPEED SDHCI patches fixes an error-path cleanup issue pointed out by
Adrian.

v4 can be found here:

http://patchwork.ozlabs.org/cover/1141949/

Please review!

Andrew

Andrew Jeffery (2):
  dt-bindings: mmc: Document Aspeed SD controller
  mmc: Add support for the ASPEED SD controller

 .../devicetree/bindings/mmc/aspeed,sdhci.yaml | 105 ++++++
 drivers/mmc/host/Kconfig                      |  12 +
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/sdhci-of-aspeed.c            | 332 ++++++++++++++++++
 4 files changed, 450 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
 create mode 100644 drivers/mmc/host/sdhci-of-aspeed.c

-- 
2.20.1
