From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 00/13] mmc: Add support to Marvell Xenon SD Host Controller
Date: Mon, 10 Apr 2017 17:14:29 +0200
Message-ID: <CAPDyKFqsU6vSmM3kMzGw4DmoB8JpUKaTJYzXUfwCz5cCbYM_3A@mail.gmail.com>
References: <cover.51071caa64e5df81264a91b9a81ed1e94f47d2c4.1490886907.git-series.gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.51071caa64e5df81264a91b9a81ed1e94f47d2c4.1490886907.git-series.gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-clk <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ziji Hu <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Jimmy Xu <zmxu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ryan
List-Id: linux-mmc@vger.kernel.org

On 30 March 2017 at 17:22, Gregory CLEMENT
<gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> Hello,
>
> This the seventh version of the series adding support for the SDHCI
> Xenon controller. It can be currently found on the Armada 37xx and the
> Armada 7K/8K but will be also used in more Marvell SoC (and not only
> the mvebu ones actually).
>
> v6->v7:
>  - Add comments on vqmmc and vmmc in examples in dt binding doc.
>
>  - Fix all the issues pointed out by Ulf and Adrian:
>
>    - Align the prefix of function and variable names.
>    - Replace the if-else with switch statements when checking MMC_TIMING_*
>    - Remove the spinlocks in set_ios.
>    - Optimize the delay loop as Adrian patch does.
>    - Add release of phy params structures
>
> - Add check of Vqmmc supply in Xenon signal voltage switch. If Vqmmc
>   regulator doesn't exist, skip standard SD signal voltage regulator
>   switch process.
>
> - Remove parse of child node mmc-card. Wait for a better solution.
>
> v5->v6:
>
> - Add a generic "mmc-card" parse in core layer.
>
> - Fix the spelling issues in Xenon dt binding doc and drivers.
>
> - Remove descriptions to common mmc properties from Xenon dt binding
>   doc.
>
> - Split compatible string "marvell,armada-8k-sdhci" into
>  "marvell,armada-ap806-sdhci" and "marvell,armada-cp110-sdhci".
>
> - Also updates the example in Xenon dt binding doc.
>
> - Remove unnecessary dependency on MMC_SDHCI from Xenon entry in
>   Kconfig.
>
> - Move Xenon specific dt parse into a separate function.
>
> - Adjust warnings and condition check in Xenon PHY setting, to remove
>  fragile hs200->hs400/hs400->hs200 sequence check function.
>
> - Enable PHY Slow Mode in MMC_TIMING_LEGACY timing if PHY Slow Mode is
>  required in dts.
>
> - Add a patch allowing dts backwards compatible for the clock
>
> v4->v5:
>
> - Remove the patch to export sdhci_execute_tuning(). It is already
>   exported in v4.10.
>
> - Introduce a patch adding a missing clock for the sdhci controller
>   present on the CP master for A7K/A8K. There is no build dependency
>   but obviously this patch is need to use the sdhci controller present
>   on the CP part.
>
> - Adjust Xenon return setup, to avoid being overwritten by
>    sdhci_add_host().
>
> - Change Xenon register definition prefix to "XENON_".
>
> -  Fix typos in Xenon driver and dt-binding docs.
>
> - Change compatible string "marvell,armada-7000-sdhci" to
>   "marvell,armada-8k-sdhci". Actually the Armada 7K SoCs are a subset
>   of the Armada 8K SoCs. Moreover, the use of the '000' is not
>   consistent with all the other compatible string already used for the
>   Armada 7K/8K family.
>
> - Added the Tested-by from Russell King on an Armada 8K based board.
>
> v3 -> v4:
> For this version a few change have been done:
> - fixes 2 bug  reported by kbuild-bot
>   - remove extra of_node_put()
>   - convert 0 in false for function returning boolean
>
> - add a device tree node for the sdhci controller present on the CP
>   master for A7K/A8K. It also led to rename the sdhci0 node on AP to
>   ap_sdhci0 to make a distinction with the one present on CP master.
>
> v2 -> v3
> I think that now most (if not all) the remarks had been taking into
> account since the second version. According to Ziji Hu, here are the
> following changes:
> " Changes in V3:
>   Adjust and improve Xenon DT bindings. Move some caps setting from driver into
>   DT. Use mmc-card sub-node to represent eMMC type.
>   Remove PHY Sampling Fixed Delay Line scan in lower speed mode.
>   Improve Xenon probe and ->init_card() functions.
>   Export sdhci_enable_sdio_irq() and implement own SDIO IRQ control.
>   Split PHY patch into two smaller patches.
>   Temporarily remove AXI clock before its implementation is improved."
>
> Besides this changes I also
> - Removed the sdhci-xenon-phy.h and moved its content in the
> shc-xenon-phy.c file.
> - Fixed the tuning-count usage
> - Managed the error case for clk_prepare_enable
>
> For the record the change from v1 was:
> " Changes in V2:
>   rebase on v4.9-rc2.
>   Re-write Xenon bindings. Ajust Xenon DT property naming.
>   Add a new DT property to indicate eMMC card type, instead of using
>   variable card_candidate.
>   Clear quirks SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 in Xenon platform data
>   Add support to HS400 retuning."
>
> Thanks,
>
> Gregory
>
> Gregory CLEMENT (4):
>   clk: apn806: Turn the eMMC clock as optional for dts backwards compatible
>   arm64: dts: marvell: add eMMC support for Armada 37xx
>   arm64: dts: marvell: add sdhci support for Armada 7K/8K
>   arm64: configs: enable SDHCI driver for Xenon
>
> Hu Ziji (8):
>   mmc: sdhci: Export sdhci_set_ios() from sdhci.c
>   mmc: sdhci: Export sdhci_start_signal_voltage_switch() in sdhci.c
>   mmc: sdhci: Export sdhci_enable_sdio_irq() from sdhci.c
>   dt: bindings: Add bindings for Marvell Xenon SD Host Controller
>   mmc: sdhci-xenon: Add Marvell Xenon SDHC core functionality
>   mmc: sdhci-xenon: Add support to PHYs of Marvell Xenon SDHC
>   mmc: sdhci-xenon: Add SoC PHY PAD voltage control
>   MAINTAINERS: add entry for Marvell Xenon MMC Host Controller drivers
>
> Konstantin Porotchkin (1):
>   clk: apn806: Add eMMC clock to system controller driver
>
>  Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt | 170 +-
>  MAINTAINERS                                                   |   7 +-
>  arch/arm64/boot/dts/marvell/armada-3720-db.dts                |   9 +-
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi                  |  11 +-
>  arch/arm64/boot/dts/marvell/armada-7040-db.dts                |  14 +-
>  arch/arm64/boot/dts/marvell/armada-8040-db.dts                |  12 +-
>  arch/arm64/boot/dts/marvell/armada-ap806.dtsi                 |  14 +-
>  arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi          |  11 +-
>  arch/arm64/configs/defconfig                                  |   1 +-
>  drivers/clk/mvebu/ap806-system-controller.c                   |  21 +-
>  drivers/mmc/host/Kconfig                                      |   8 +-
>  drivers/mmc/host/Makefile                                     |   3 +-
>  drivers/mmc/host/sdhci-xenon-phy.c                            | 835 +++++++-
>  drivers/mmc/host/sdhci-xenon.c                                | 548 +++++-
>  drivers/mmc/host/sdhci-xenon.h                                | 101 +-
>  drivers/mmc/host/sdhci.c                                      |  11 +-
>  drivers/mmc/host/sdhci.h                                      |   4 +-
>  17 files changed, 1774 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
>  create mode 100644 drivers/mmc/host/sdhci-xenon-phy.c
>  create mode 100644 drivers/mmc/host/sdhci-xenon.c
>  create mode 100644 drivers/mmc/host/sdhci-xenon.h
>
> base-commit: a645cc1df4ff41ba54a2fb839962b8ff142121d9
> --
> git-series 0.9.1


Thanks, applied patch 1->10 for next! 11->13 will have to go via the
SoC maintainer tree.

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
