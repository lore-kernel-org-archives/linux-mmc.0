From: "Manjunathappa, Prakash" <prakash.pm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v7 0/5] Add DT support for davinci_mmc driver
Date: Thu, 28 Mar 2013 18:40:06 +0530
Message-ID: <1364476211-14322-1-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, hs-ynQEQJNshbs@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Patch set adds DT support for davinci_mmc driver and is
verified on da850-evm without card_detect/write_protect and
EDMA support. Also takecare to derive controller IP version from
platform_device_id table, remove version specification in pdata.

Applies on top of below patch series under community review:
"Enable SPI flash support on da850-evm DT kernel"
http://www.spinics.net/lists/arm-kernel/msg231546.html

This series is reviewed and tested by Sekhar Nori, with and
without DT on da850 EVM.

Since v6:
Add DMA handling capability, but not tested.

Since v5:
Add below patch to this series.
"mmc: davinci: allow driver to work without DMA resource"
Choose smaller device name, da830-mmc instead of davinci-mmc-da830
and dm6441-mmc instead of davinci-mmc-dm355.

Since v4:
Minor nit, check on return value for failure of max-frequency property
parsing.
Merged patch "ARM: davinci: mmc: derive version information from device name"
with patch 1/4.

Since v3:
Added support to derive IP version information from platform_device_id table.

Since v2:
Modified the default value for bus-width and skipping the property specifications
for highspeed card capabilties for now. Re-ordered patch 2 and 3.

Since v1:
Modified the DT parse function to take default values, updated DT binding
documentation accordingly.

Manjunathappa, Prakash (5):
  mmc: davinci: allow driver to work without DMA resource
  ARM: davinci: mmc: derive version information from device name
  mmc: davinci_mmc: add DT support
  ARM: davinci: da850: add mmc DT entries
  ARM: davinci: da850: override mmc DT node device name

 .../devicetree/bindings/mmc/davinci_mmc.txt        |   33 +++++++
 arch/arm/boot/dts/da850-evm.dts                    |    7 ++
 arch/arm/boot/dts/da850.dtsi                       |   15 +++
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
 arch/arm/mach-davinci/da8xx-dt.c                   |    1 +
 arch/arm/mach-davinci/devices-da8xx.c              |    4 +-
 arch/arm/mach-davinci/devices-tnetv107x.c          |    4 +-
 arch/arm/mach-davinci/devices.c                    |    6 +-
 arch/arm/mach-davinci/dm355.c                      |    4 +-
 arch/arm/mach-davinci/dm365.c                      |    4 +-
 arch/arm/mach-davinci/dm644x.c                     |    2 +-
 arch/arm/mach-davinci/tnetv107x.c                  |    4 +-
 drivers/mmc/host/davinci_mmc.c                     |   98 ++++++++++++++++++--
 include/linux/platform_data/mmc-davinci.h          |    3 -
 23 files changed, 163 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/davinci_mmc.txt

-- 
1.7.4.1
