From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v3 0/3] mmc: renesas_sdhi: add R-Car Gen[123] fallback compatibility strings
Date: Tue, 17 Oct 2017 08:01:01 +0200
Message-ID: <20171017060104.11039-1-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Add fallback compatibility strings for R-Car Gen 1, 2 and 3 to the SDHI
bindings and driver.

In the case of Renesas R-Car hardware we know that there are generations of
SoCs, f.e. Gen 1 and 2. But beyond that its not clear what the relationship
between IP blocks might be. For example, I believe that r8a7790 is older
than r8a7791 but that doesn't imply that the latter is a descendant of the
former or vice versa.

We can, however, by examining the documentation and behaviour of the
hardware at run-time observe that the current driver implementation appears
to be compatible with the IP blocks on SoCs within a given generation.

For the above reasons and convenience when enabling new SoCs a
per-generation fallback compatibility string scheme being adopted for
drivers for Renesas SoCs.

Based on mmc/next

Changes since v2:
* Update example to current upstream using newer CPG/MSSR bindings

Changes since v1:
* Describe example in patch one as being for the r8a7790 (R-Car H2) rather
  than the r8a7779 (R-Car H1)
* Accumulate review tags from Geert Uytterhoeven

Simon Horman (3):
  dt-bindings: mmc: renesas_sdhi: provide example in bindings
    documentation
  dt-bindings: mmc: renesas_sdhi: add R-Car Gen[123] fallback
    compatibility strings
  mmc: renesas_sdhi: implement R-Car Gen[123] fallback compatibility
    strings

 Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 70 +++++++++++++++++++++-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |  1 +
 drivers/mmc/host/renesas_sdhi_sys_dmac.c           |  5 +-
 3 files changed, 74 insertions(+), 2 deletions(-)

-- 
2.11.0
