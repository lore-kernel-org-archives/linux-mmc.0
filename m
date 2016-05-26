From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v6 0/5] Add enhanced strobe support for emmc version 5.1 or later
Date: Thu, 26 May 2016 09:55:07 +0800
Message-ID: <1464227707-30616-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com, Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org


Hello all,

This patch is going to support enhanced strobe function
for emmc version 5.1+ introduced by JEDEC recently.

Enchanced strobe is a optional function, so we add a new cap* for drivers to
decide whether to use it.

When introduing hs400 mode, JEDEC asks controllers to use data strobe line
to latch the data from emmc devives. But for cmd-reponse, not mentioned yet.
Since emmc version 5.1 published, JEDEC adds enhanced strobe function to deal
with cmd-response the same way as data-read. This feature is optional.

>From the spec(section 6.6.2.3), the standard scenario to select HS400 enhanced
strobe mode illustrated like this:
(1) set HS_TIMIMG (Highspeed)
(2) Host change freq to <= 52Mhz
(3) set the bus width to Enhanced strobe and DDR8Bit(CMD6), EXT_CSD[183] = 0x86
instead of 0x80
(4) set HS_TIMING to 0x3 (HS400)
(5) Host change freq to <= 200Mhz
(6) Host select HS400 enhanced strobe complete

I can't find a upstreamed controller claimed to support it, as well as the
mmc stack. But my "arasan,sdhci-5.1" actually supports this function. So I decide
to work for this part.

By looking into the SDHCI spec, I find there isn't any registers to enable the
enhanced strobe function. But from my "arasan,sdhci-5.1" databook, it describes a
register called VENDOR_REGISTER(0x78) to trigger this mode. So I guess other sdhci
variant drivers may also need s vendor specific register to deal with it.

If we are sure that our controller supports enhanced strobe mode, just add
mmc-hs400-enhanced-strobe in DT. Once emmc devices claims to support this mode,
we enable it automatically. Of course, other sdhci*/non-sdhci drivers should
implement/overwrite the hs400_enhanced_strobe by themselves. I believe all of the
platforms which need to support this mode should do some basic preparation for their
controllers. Currently I just limit the callback within ths scope of arasan,sdhci-5.1,
but I prone to believe arasan will use VENDOR_REGISTER to tirgger this mode from now on
because I do believe vendor will consider the registers' compatibility.

With this patchset applied, we can successfully run in HS400 enhanced strobe mode on
RK3399 platform with Samsung eMMC KLMBG2JENB-B041(v5.1, 16GB).

mmc1: new HS400 Enhanced strobe MMC card at address 0001
mmcblk0: mmc1:0001 AJNB4R 14.6 GiB
mmcblk0boot0: mmc1:0001 AJNB4R partition 1 4.00 MiB
mmcblk0boot1: mmc1:0001 AJNB4R partition 2 4.00 MiB
mmcblk0rpmb: mmc1:0001 AJNB4R partition 3 4.00 MiB

Also I check this patchset with removing some caps to make sure
all the init sequences for hs400/hs200/DDR52/HighSpeed are correct.


Changes in v6:
- add Doug's test-tag and Jaehoon's review-test-tag
- add Doug's review-test-tag and Jaehoon's test-tag
- a minor string assignment

Changes in v5:
- avoid to call hs400_enhanced+_strobe in mmc_set_initial_state
  if no setting MMC_CAP2_HS400_ES.
- add Adrian's ack for patch[5/5]

Changes in v4:
- check avail_type with EXT_CSD_CARD_TYPE_HS400 instead of
  card_type
- check if host support 8-bit when selecting hs400es
- some minor fix suggested by Douglas and add his review tag

Changes in v3:
- remove helper function and shorten cap2 to MMC_CAP2_HS400_ES
- rename callback to hs400_enhanced_strobe and make it return void
- add enhanced_strobe in mmc_ios and pass it to hs400_enhanced_strobe
- disable host's enhanced strobe in mmc_set_initial_state
- remove bus checking after switching hs400es
- add new function for hs400es timing selection
- fix wrong judgement of mmc_card_hs400es

Changes in v2:
- switch to HS400ES from Highspeed mode directly

Shawn Lin (5):
  Documentation: mmc: add mmc-hs400-enhanced-strobe
  mmc: core: add mmc-hs400-enhanced-strobe support
  mmc: core: implement enhanced strobe support
  mmc: debugfs: add HS400 enhanced strobe description
  mmc: sdhci-of-arasan: implement enhanced strobe callback

 Documentation/devicetree/bindings/mmc/mmc.txt |  1 +
 drivers/mmc/core/bus.c                        |  3 +-
 drivers/mmc/core/core.c                       |  9 +++
 drivers/mmc/core/debugfs.c                    |  3 +-
 drivers/mmc/core/host.c                       |  2 +
 drivers/mmc/core/mmc.c                        | 84 ++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci-of-arasan.c            | 20 +++++++
 include/linux/mmc/card.h                      |  1 +
 include/linux/mmc/host.h                      | 12 ++++
 include/linux/mmc/mmc.h                       |  3 +
 10 files changed, 134 insertions(+), 4 deletions(-)

-- 
2.3.7
