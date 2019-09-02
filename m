From: Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH v2 0/4] mmc: sdhci-of-aspeed: Fixes for AST2600 eMMC support
Date: Mon,  2 Sep 2019 13:28:38 +0930
Message-ID: <20190902035842.2747-1-andrew@aj.id.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrew Jeffery <andrew@aj.id.au>, adrian.hunter@intel.com, ulf.hansson@linaro.org, joel@jms.id.au, openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hello,

I've added a couple of patches since v1 of this series. The horizon has
broadened slightly with a fix for SPARC builds as well in patch 1/4. Ulf
suggested a minor cleanup on v1 with respect to handling of the current clock
value, so that's now patch 2/4. Patches 3/4 and 4/4 are as they were in v1.

The v1 series can be found here:

https://patchwork.ozlabs.org/cover/1155757/

Please review!

Andrew

Andrew Jeffery (4):
  mmc: sdhci-of-aspeed: Fix link failure for SPARC
  mmc: sdhci-of-aspeed: Drop redundant assignment to host->clock
  mmc: sdhci-of-aspeed: Uphold clocks-on post-condition of set_clock()
  mmc: sdhci-of-aspeed: Allow max-frequency limitation of SDCLK

 drivers/mmc/host/sdhci-of-aspeed.c | 62 ++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 20 deletions(-)

-- 
2.20.1
