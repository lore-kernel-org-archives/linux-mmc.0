From: Ivan Mikhaylov <i.mikhaylov@yadro.com>
Subject: [PATCH v3 0/3] add inversion signal presence support
Date: Mon, 18 Nov 2019 13:46:43 +0300
Message-ID: <20191118104646.3838-1-i.mikhaylov@yadro.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Ivan Mikhaylov <i.mikhaylov@yadro.com>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, openbmc@lists.ozlabs.org
List-Id: linux-mmc@vger.kernel.org

Vesnin BMC uses microSD with card presence signal inversion in the
schematics. Add the .read_l callback to detect 'cd-inverted' option
in dts. There is no WP switch, due to this 'disable-wp' also was added
into vesnin dts for sdhci.

Ivan Mikhaylov (3):
  aspeed: dts: add sd card for vesnin
  mmc: sdhci-of-aspeed: enable CONFIG_MMC_SDHCI_IO_ACCESSORS
  mmc: sdhci-of-aspeed: add inversion signal presence

 arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts | 13 +++++++++++++
 drivers/mmc/host/Kconfig                    |  1 +
 drivers/mmc/host/sdhci-of-aspeed.c          | 12 ++++++++++++
 3 files changed, 26 insertions(+)

-- 
2.20.1
