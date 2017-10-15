From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v3 0/3] mmc: support eMMC driver type selection with DT
Date: Sun, 15 Oct 2017 14:46:12 +0200
Message-ID: <20171015124615.31391-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

Some of the Renesas R-Car boards need to set the eMMC driver type to type 1 to
get stable HS200/400 speeds (HS400 support not upstream yet). Because the eMMC
memories are fixed (and thus the drive type), I decided to implement the DT
setup in a similar fashion to ACPI [1]. While implementing, I realized that all
I did was not Renesas specific but generic, so I ended up putting it into the
core.

So, whenever the new property (introduced in patch 1) is used, its value will
be used regardless of a potentially implemented host driver specific
select_drive_strength callback (patch 2). An example usage can be found in
patch 3. Note that currently only eMMC is handled

A branch for the Salvator-X(S) boards can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/topic/emmc-drive-strength

A wiki page describing my test procedure can be found here:

http://elinux.org/Tests:eMMC-fixed-drive-strength

Changes since RFC v2 are described per patch. It is mainly a rebase to mmc/next
and addressing Ulf's comments. Tested on Salvator-X (R-Car H3 ES1.0) and
Salvator-XS (R-Car H3 ES2.0).

I know that patch 3 needs to go via Simon, but I still include it here for
completeness.

Thanks,

   Wolfram

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=51ced59cc02e0d08f61772c888480b9b1749cef1


Wolfram Sang (3):
  dt-bindings: mmc: describe new eMMC binding for fixed driver type
  mmc: parse new binding for eMMC fixed driver type
  arm64: renesas: salvator: set driver type for eMMC

 Documentation/devicetree/bindings/mmc/mmc.txt    |  3 +++
 arch/arm64/boot/dts/renesas/salvator-common.dtsi |  1 +
 drivers/mmc/core/host.c                          | 13 ++++++++++++-
 drivers/mmc/core/mmc.c                           | 11 ++++++++---
 include/linux/mmc/host.h                         |  2 ++
 5 files changed, 26 insertions(+), 4 deletions(-)

-- 
2.11.0
