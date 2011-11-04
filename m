From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 0/4] omap hsmmc device tree support
Date: Fri, 4 Nov 2011 17:20:37 +0530
Message-ID: <1320407441-29697-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, thomas.abraham@linaro.org, balajitk@ti.com, cjb@laptop.org, tony@atomide.com, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-mmc@vger.kernel.org

This series adds device tree support for omap hsmmc
driver. The series is currently based on my patch
series[1] to add dt support for twl-regulators, since
hsmmc requires regulators to work.
I have also pulled the patch from Thomas Abraham which
adds mmc host controller bindings[2]
'mmc: Add OF bindings support for mmc host controller capabilities'

The series currently adds supports for only omap4-panda and
omap4-sdp boards and uses auxdata to pass platform specific
function pointers to the driver.

All the dependent patches along with this series can be found here
git://gitorious.org/omap-pm/linux.git for-dt/regulator-i2c-twl-mmc

regards,
Rajendra

[1] http://lists.ozlabs.org/pipermail/devicetree-discuss/2011-October/009185.html
[2] http://lists.ozlabs.org/pipermail/devicetree-discuss/2011-November/009237.html

Rajendra Nayak (4):
  mmc: Add additional binding for mmc host controller
  mmc: omap: adapt the hsmmc driver to device tree
  omap4: mmc: Pass SoC and board data for omap4 mmc from dt
  omap4: mmc: use auxdata to pass platform function ptrs

 .../devicetree/bindings/mmc/linux-mmc-host.txt     |    1 +
 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   50 ++++++++
 arch/arm/boot/dts/omap4-panda.dts                  |   23 ++++
 arch/arm/boot/dts/omap4-sdp.dts                    |   33 +++++
 arch/arm/boot/dts/omap4.dtsi                       |   46 +++++++
 arch/arm/mach-omap2/board-generic.c                |   19 +++-
 arch/arm/mach-omap2/hsmmc.c                        |    9 +-
 arch/arm/mach-omap2/hsmmc.h                        |    5 +
 drivers/mmc/core/host.c                            |    2 +
 drivers/mmc/host/omap_hsmmc.c                      |  125 ++++++++++++++++++++
 10 files changed, 307 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
