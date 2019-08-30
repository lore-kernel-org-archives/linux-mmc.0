From: Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH 0/2] mmc: sdhci-of-aspeed: Fixes for AST2600 eMMC support
Date: Fri, 30 Aug 2019 17:16:42 +0930
Message-ID: <20190830074644.10936-1-andrew@aj.id.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrew Jeffery <andrew@aj.id.au>, adrian.hunter@intel.com, ulf.hansson@linaro.org, joel@jms.id.au, ryanchen.aspeed@gmail.com, openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hello,

The ASPEED SDHCI driver patches sent previously were based on testing on the
AST2500. The SD controllers in the 2500 and 2600 had the same register layout
according to the documentation, so we added the necessary devicetree compatible
string at the same time.

Now that I've got access to 2600 hardware with an eMMC chip I have a couple of
patches that are fixes enabling support for it. I don't think the first patch
is too controversial - in some cases we weren't ensuring the clock was enabled
before returning from the set_clock() callback.

I'm a bit unsure about the second patch though which enables use of
max-frequency in the devicetree, it feels a bit hacky so I'm looking for any
suggestions on the approach.

Please review!

Andrew

Andrew Jeffery (2):
  mmc: sdhci-of-aspeed: Uphold clocks-on post-condition of set_clock()
  mmc: sdhci-of-aspeed: Allow max-frequency limitation of SDCLK

 drivers/mmc/host/sdhci-of-aspeed.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

-- 
2.20.1
