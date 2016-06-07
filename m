From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 0/11] Changes to support 150 MHz eMMC on rk3399
Date: Tue,  7 Jun 2016 15:44:33 -0700
Message-ID: <1465339484-969-1-git-send-email-dianders@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, kishon@ti.com, Heiko Stuebner <heiko@sntech.de>, robh+dt@kernel.org
Cc: shawn.lin@rock-chips.com, xzy.xu@rock-chips.com, briannorris@chromium.org, adrian.hunter@intel.com, linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, zhengxing@rock-chips.com, michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org, jay.xu@rock-chips.com, wxt@rock-chips.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, soren.brinkmann@xilinx.com, linux-kernel@vger.kernel.org, galak@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

The theme of this series of patches is to try to allow running the eMMC
at 150 MHz on the rk3399 SoC, though the changes should still be correct
and have merit on their own.  The motivation for running at 150 MHz is
that doing so improves signal integrity and (with some eMMC devices)
doesn't affect throughput.

These patches have been structured to keep things as separate as
possible, but nevertheless there are still some dependencies between
patches.  It probably makes the most sense for all of the non-device
tree patches to go through a single tree.  If others agree, perhaps the
most sane would be to get Acks from PHY maintainers and then to land the
patches in the MMC tree.  Device tree patches should be able to be
landed separately and the worst what would happen is a warning in the
kernel log if you have the code without the device tree.

The code patches are based on Ulf's mmc-next, then 4 patches that are
outstanding / ready to land.  Specifically:
- https://patchwork.kernel.org/patch/9086501/
  phy: rockchip-emmc: give DLL some extra time to be ready
- https://patchwork.kernel.org/patch/9093681/
  phy: rockchip-emmc: configure frequency range and drive impedance
- https://patchwork.kernel.org/patch/9086511/
  phy: rockchip-emmc: configure default output tap delay
- https://patchwork.kernel.org/patch/9086531/
  phy: rockchip-emmc: reindent the register definitions

The device tree patches are based on Heiko's v4.8-armsoc/dts64.

If requested, I could repost my series with the outstanding code patches
or I could try folding those patches into mine.  Since those patches
aren't in 4.7-rc1 presumably they would also make sense to take through
the MMC tree if others agree.


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
  phy: rockchip-emmc: Set phyctrl_frqsel based on card clock
  phy: rockchip-emmc: Minor code cleanup in
    rockchip_emmc_phy_power_off()
  arm64: dts: rockchip: Provide emmcclk to PHY for rk3399

 .../devicetree/bindings/mmc/arasan,sdhci.txt       |  35 ++-
 .../devicetree/bindings/phy/rockchip-emmc-phy.txt  |   7 +
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |   5 +
 drivers/mmc/host/sdhci-of-arasan.c                 | 333 +++++++++++++++++++--
 drivers/phy/phy-rockchip-emmc.c                    | 107 +++++--
 5 files changed, 427 insertions(+), 60 deletions(-)

-- 
2.8.0.rc3.226.g39d4020
