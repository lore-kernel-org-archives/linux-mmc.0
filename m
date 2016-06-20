From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v3 0/15] Changes to support 150 MHz eMMC on rk3399
Date: Mon, 20 Jun 2016 10:56:39 -0700
Message-ID: <1466445414-11974-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ulf.hansson@linaro.org, Heiko Stuebner <heiko@sntech.de>
Cc: mark.rutland@arm.com, catalin.marinas@arm.com, shawn.lin@rock-chips.com, will.deacon@arm.com, adrian.hunter@intel.com, wsa+renesas@sang-engineering.com, groeck@chromium.org, stefan.wahren@i2se.com, zhengxing@rock-chips.com, briannorris@chromium.org, michal.simek@xilinx.com, kishon@ti.com, linux-rockchip@lists.infradead.org, geert@linux-m68k.org, soren.brinkmann@xilinx.com, jay.xu@rock-chips.com, linus.walleij@linaro.org, wxt@rock-chips.com, devicetree@vger.kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, robh+dt@kernel.org, horms+renesas@verge.net.au, linux-arm-kernel@lists.infradead.org, xzy.xu@rock-chips.com, linux-mmc@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, andrei.pistirica@microchip.com, ludovic.desroches@atmel.com, galak@codeaurora.org, yangbo.lu@freescale.com
List-Id: linux-mmc@vger.kernel.org

The theme of this series of patches is to try to allow running the eMMC
at 150 MHz on the rk3399 SoC, though the changes should still be correct
and have merit on their own.  The motivation for running at 150 MHz is
that doing so improves signal integrity and (with some eMMC devices)
doesn't affect throughput.

These patches have been structured to keep things as separate as
possible, but nevertheless there are still some dependencies between
patches.  It probably makes the most sense for all of the non-device
tree patches to go through a single tree.  PHY patches now have Acks
from Kishon so that means things should be clear for all non-DTS patches
to go through the MMC tree if Ulf agrees.  Device tree patches should be
able to be landed separately and the worst what would happen is a
warning in the kernel log if you have the code without the device tree.

The code patches are based on Ulf's mmc-next.  In v3 of the series I've
pulled in the latest version of a previous PHY series posted by Brian
Norris.

The device tree patches are based on Heiko's v4.8-armsoc/dts64.

Changes in v3:
- Add Brian's PHY patches into my series
- Add collected tags
- Add dependency on COMMON_CLK (actually in v2.1) (Guenter Roeck)
- Use phy_init / phy_exit (Heiko)
- Add Kishon's Ack

Changes in v2:
- Drop 170 MHz comment (only applicable to a subtly different Arasan PHY)
- Indicate that 5.1 ms is calculated (Shawn).
- Clean up description of rk3399 PHY (Shawn)
- Add Rob Herring's Ack.
- Reorder includes (Shawn)
- Adjust commit message wording (Rob)
- List out clocks and clock names (Rob)
- Move code cleanup before set phyctrl_frqsel based on card clock (Shawn)
- Warn if we're more than 15 MHz from ideal rate (Shawn)
- Fix typo USB => SDHCI (Shawn)

Brian Norris (2):
  phy: rockchip-emmc: configure default output tap delay
  phy: rockchip-emmc: reindent the register definitions

Douglas Anderson (11):
  phy: rockchip-emmc: Increase lock time allowance
  mmc: sdhci-of-arasan: Always power the PHY off/on when clock changes
  Documentation: mmc: sdhci-of-arasan: Add soc-ctl-syscon for corecfg
    regs
  mmc: sdhci-of-arasan: Properly set corecfg_baseclkfreq on rk3399
  arm64: dts: rockchip: Add soc-ctl-syscon to sdhci for rk3399
  Documentation: mmc: sdhci-of-arasan: Add ability to export card clock
  mmc: sdhci-of-arasan: Add ability to export card clock
  Documentation: phy: Let the rockchip eMMC PHY get an exported card
    clock
  phy: rockchip-emmc: Minor code cleanup in
    rockchip_emmc_phy_power_on/off()
  phy: rockchip-emmc: Set phyctrl_frqsel based on card clock
  arm64: dts: rockchip: Provide emmcclk to PHY for rk3399

Shawn Lin (2):
  phy: rockchip-emmc: give DLL some extra time to be ready
  phy: rockchip-emmc: configure frequency range and drive impedance

 .../devicetree/bindings/mmc/arasan,sdhci.txt       |  35 ++-
 .../devicetree/bindings/phy/rockchip-emmc-phy.txt  |   9 +
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |   5 +
 drivers/mmc/host/Kconfig                           |   1 +
 drivers/mmc/host/sdhci-of-arasan.c                 | 333 +++++++++++++++++++--
 drivers/phy/phy-rockchip-emmc.c                    | 216 ++++++++++---
 6 files changed, 525 insertions(+), 74 deletions(-)

-- 
2.8.0.rc3.226.g39d4020
