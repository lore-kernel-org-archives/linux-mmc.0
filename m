From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Subject: [PATCH v3 0/3] Add DT support for davinci_mmc driver
Date: Tue, 12 Feb 2013 12:07:35 +0530
Message-ID: <1360651058-5255-1-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk, nsekhar@ti.com, hs@denx.de, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, davinci-linux-open-source@linux.davincidsp.com, "Manjunathappa, Prakash" <prakash.pm@ti.com>
List-Id: linux-mmc@vger.kernel.org

Patch set adds DT support for davinci_mmc driver and is
verified on da850-evm without card_detect/write_protect and
EDMA support.

This patch depends on below patches under review:
1) Patch "drivers/pinctrl: grab default handles from device core"
	http://www.gossamer-threads.com/lists/linux/kernel/1664015?page=last
2) Patch "mmc: davinci: allow driver to work without DMA resource"
	http://www.mail-archive.com/linux-mmc@vger.kernel.org/msg18771.html

Applies on top of v3.9/dt-2 branch of linux_davinci tree:
git://gitorious.org/linux-davinci/linux-davinci.git

Since v2:
Modified the default value for bus-width and skipping the property specifications
for highspeed card capabilties for now. Re-ordered patch 2 and 3.
Since v1:
Modified the DT parse function to take default values, updated DT binding
documentation accordingly.

Manjunathappa, Prakash (3):
  mmc: davinci_mmc: add DT support
  ARM: davinci: da850: add mmc DT entries
  ARM: davinci: da850: override mmc DT node device name

 .../devicetree/bindings/mmc/davinci_mmc.txt        |   25 ++++++++
 arch/arm/boot/dts/da850-evm.dts                    |    7 ++
 arch/arm/boot/dts/da850.dtsi                       |   14 ++++
 arch/arm/mach-davinci/da8xx-dt.c                   |    2 +
 drivers/mmc/host/davinci_mmc.c                     |   65 +++++++++++++++++++-
 5 files changed, 111 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/davinci_mmc.txt

-- 
1.7.4.1

