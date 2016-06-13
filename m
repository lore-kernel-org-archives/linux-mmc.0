From: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v2 0/11] Changes to support 150 MHz eMMC on rk3399
Date: Mon, 13 Jun 2016 16:04:24 -0700
Message-ID: <1465859076-4868-1-git-send-email-dianders@chromium.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
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

Changes in v2:
- Indicate that 5.1 ms is calculated (Shawn).
- Clean up description of rk3399 PHY (Shawn)
- Add Rob Herring's Ack.
- Reorder includes (Shawn)
- Adjust commit message wording (Rob)
- List out clocks and clock names (Rob)
- Move code cleanup before set phyctrl_frqsel based on card clock (Shawn)
- Warn if we're more than 15 MHz from ideal rate (Shawn)
- Fix typo USB => SDHCI (Shawn)

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

 .../devicetree/bindings/mmc/arasan,sdhci.txt       |  35 ++-
 .../devicetree/bindings/phy/rockchip-emmc-phy.txt  |   9 +
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |   5 +
 drivers/mmc/host/sdhci-of-arasan.c                 | 333 +++++++++++++++++++--
 drivers/phy/phy-rockchip-emmc.c                    | 120 ++++++--
 5 files changed, 442 insertions(+), 60 deletions(-)

-- 
2.8.0.rc3.226.g39d4020

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
