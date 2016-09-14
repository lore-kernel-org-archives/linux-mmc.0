From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 0/2] gen3: dts: enable on-board eMMC
Date: Wed, 14 Sep 2016 19:09:41 +0200
Message-ID: <20160914170943.1663-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Dirk Behme <dirk.behme@gmail.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-mmc@vger.kernel.org

From: Wolfram Sang <wsa@the-dreams.de>

Here are the DTS changes to enable the on-board eMMC memory at 8 bit bus
widths on R-Car Gen3 Salvator-X boards.

Note that 'non-removable' is not supported yet because of Runtime PM issues. It
seems we need to overhaul Runtime PM handling for other reasons as well, so I
suggest the basic support goes in like this and DTS do not use 'non-removable'
for now.

Note also that I decided to use the pattern that pinctrl-0 is 3.3v and
pinctrl-1 is 1.8v, although the eMMC is fixed at 1.8v. I tried a few ways to
only use pinctrl-0 being 1.8v here, but they all ended up to be confusing for
users IMO, so I sticked to the most consistent solution after all.

These patches are based on top of Simon's sdr104-v7 patches and the accompanied
driver patches sent a minute ago. A branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/topic/sdhi-8bit-emmc

Please review, comment, apply...

   Wolfram

Wolfram Sang (2):
  arm64: dts: r8a7795: salvator: enable on-board eMMC
  arm64: dts: r8a7796: salvator: enable on board eMMC

 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 43 +++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts | 44 +++++++++++++++++++++-
 2 files changed, 86 insertions(+), 1 deletion(-)

-- 
2.9.3
