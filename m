From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Subject: [PATCH v4 0/5] Add DT support for davinci_mmc driver
Date: Fri, 15 Feb 2013 11:51:57 +0530
Message-ID: <1360909322-1858-1-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk, nsekhar@ti.com, hs@denx.de, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, davinci-linux-open-source@linux.davincidsp.com, "Manjunathappa, Prakash" <prakash.pm@ti.com>
List-Id: linux-mmc@vger.kernel.org

Patch set adds DT support for davinci_mmc driver and is
verified on da850-evm without card_detect/write_protect and
EDMA support. Also takecare to derive controller IP version from
platform_device_id table, remove version specification in pdata.

DT patches depends on below patches under review:
1) Patch "drivers/pinctrl: grab default handles from device core"
	http://www.gossamer-threads.com/lists/linux/kernel/1664015?page=last
2) Patch "mmc: davinci: allow driver to work without DMA resource"
	http://www.mail-archive.com/linux-mmc@vger.kernel.org/msg18771.html

Applies on top of v3.9/dt-2 branch of linux_davinci tree:
git://gitorious.org/linux-davinci/linux-davinci.git

Since v3:
Added support to derive IP version information from platform_device_id table.

Since v2:
Modified the default value for bus-width and skipping the property specifications
for highspeed card capabilties for now. Re-ordered patch 2 and 3.

Since v1:
Modified the DT parse function to take default values, updated DT binding
documentation accordingly.

Manjunathappa, Prakash (5):
  ARM: davinci: mmc: derive version information from device name
  mmc: davinci_mmc: derive controller IP version from
    platform_device_id
  mmc: davinci_mmc: add DT support
  ARM: davinci: da850: add mmc DT entries
  ARM: davinci: da850: override mmc DT node device name

 .../devicetree/bindings/mmc/davinci_mmc.txt        |   25 ++++++
 arch/arm/boot/dts/da850-evm.dts                    |    7 ++
 arch/arm/boot/dts/da850.dtsi                       |   14 ++++
 arch/arm/mach-davinci/board-da830-evm.c            |    1 -
 arch/arm/mach-davinci/board-da850-evm.c            |    2 -
 arch/arm/mach-davinci/board-dm355-evm.c            |    1 -
 arch/arm/mach-davinci/board-dm365-evm.c            |    1 -
 arch/arm/mach-davinci/board-dm644x-evm.c           |    1 -
 arch/arm/mach-davinci/board-neuros-osd2.c          |    1 -
 arch/arm/mach-davinci/board-omapl138-hawk.c        |    1 -
 arch/arm/mach-davinci/board-tnetv107x-evm.c        |    1 -
 arch/arm/mach-davinci/da830.c                      |    2 +-
 arch/arm/mach-davinci/da850.c                      |    4 +-
 arch/arm/mach-davinci/da8xx-dt.c                   |    2 +
 arch/arm/mach-davinci/devices-da8xx.c              |    4 +-
 arch/arm/mach-davinci/devices-tnetv107x.c          |    4 +-
 arch/arm/mach-davinci/devices.c                    |    6 +-
 arch/arm/mach-davinci/dm355.c                      |    4 +-
 arch/arm/mach-davinci/dm365.c                      |    4 +-
 arch/arm/mach-davinci/dm644x.c                     |    2 +-
 arch/arm/mach-davinci/tnetv107x.c                  |    4 +-
 drivers/mmc/host/davinci_mmc.c                     |   83 +++++++++++++++++++-
 include/linux/platform_data/mmc-davinci.h          |    3 -
 23 files changed, 146 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/davinci_mmc.txt

-- 
1.7.4.1

