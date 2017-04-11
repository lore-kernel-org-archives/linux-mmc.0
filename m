From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v7 00/13] mmc: Add support to Marvell Xenon SD Host Controller
Date: Tue, 11 Apr 2017 09:59:59 +0200
Message-ID: <87o9w3idc0.fsf@free-electrons.com>
References: <cover.51071caa64e5df81264a91b9a81ed1e94f47d2c4.1490886907.git-series.gregory.clement@free-electrons.com>
        <CAPDyKFqsU6vSmM3kMzGw4DmoB8JpUKaTJYzXUfwCz5cCbYM_3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:50689 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751255AbdDKIAB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Apr 2017 04:00:01 -0400
In-Reply-To: <CAPDyKFqsU6vSmM3kMzGw4DmoB8JpUKaTJYzXUfwCz5cCbYM_3A@mail.gmail.com>
        (Ulf Hansson's message of "Mon, 10 Apr 2017 17:14:29 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk <linux-clk@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ziji Hu <huziji@marvell.com>, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>R

Hi Ulf,
 
 On lun., avril 10 2017, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> On 30 March 2017 at 17:22, Gregory CLEMENT
> <gregory.clement@free-electrons.com> wrote:
>> Hello,
>>
>> This the seventh version of the series adding support for the SDHCI
>> Xenon controller. It can be currently found on the Armada 37xx and the
>> Armada 7K/8K but will be also used in more Marvell SoC (and not only
>> the mvebu ones actually).
>>
>> v6->v7:
>>  - Add comments on vqmmc and vmmc in examples in dt binding doc.
>>
>>  - Fix all the issues pointed out by Ulf and Adrian:
>>
>>    - Align the prefix of function and variable names.
>>    - Replace the if-else with switch statements when checking MMC_TIMING_*
>>    - Remove the spinlocks in set_ios.
>>    - Optimize the delay loop as Adrian patch does.
>>    - Add release of phy params structures
>>
>> - Add check of Vqmmc supply in Xenon signal voltage switch. If Vqmmc
>>   regulator doesn't exist, skip standard SD signal voltage regulator
>>   switch process.
>>
>> - Remove parse of child node mmc-card. Wait for a better solution.
>>
>> v5->v6:
>>
>> - Add a generic "mmc-card" parse in core layer.
>>
>> - Fix the spelling issues in Xenon dt binding doc and drivers.
>>
>> - Remove descriptions to common mmc properties from Xenon dt binding
>>   doc.
>>
>> - Split compatible string "marvell,armada-8k-sdhci" into
>>  "marvell,armada-ap806-sdhci" and "marvell,armada-cp110-sdhci".
>>
>> - Also updates the example in Xenon dt binding doc.
>>
>> - Remove unnecessary dependency on MMC_SDHCI from Xenon entry in
>>   Kconfig.
>>
>> - Move Xenon specific dt parse into a separate function.
>>
>> - Adjust warnings and condition check in Xenon PHY setting, to remove
>>  fragile hs200->hs400/hs400->hs200 sequence check function.
>>
>> - Enable PHY Slow Mode in MMC_TIMING_LEGACY timing if PHY Slow Mode is
>>  required in dts.
>>
>> - Add a patch allowing dts backwards compatible for the clock
>>
>> v4->v5:
>>
>> - Remove the patch to export sdhci_execute_tuning(). It is already
>>   exported in v4.10.
>>
>> - Introduce a patch adding a missing clock for the sdhci controller
>>   present on the CP master for A7K/A8K. There is no build dependency
>>   but obviously this patch is need to use the sdhci controller present
>>   on the CP part.
>>
>> - Adjust Xenon return setup, to avoid being overwritten by
>>    sdhci_add_host().
>>
>> - Change Xenon register definition prefix to "XENON_".
>>
>> -  Fix typos in Xenon driver and dt-binding docs.
>>
>> - Change compatible string "marvell,armada-7000-sdhci" to
>>   "marvell,armada-8k-sdhci". Actually the Armada 7K SoCs are a subset
>>   of the Armada 8K SoCs. Moreover, the use of the '000' is not
>>   consistent with all the other compatible string already used for the
>>   Armada 7K/8K family.
>>
>> - Added the Tested-by from Russell King on an Armada 8K based board.
>>
>> v3 -> v4:
>> For this version a few change have been done:
>> - fixes 2 bug  reported by kbuild-bot
>>   - remove extra of_node_put()
>>   - convert 0 in false for function returning boolean
>>
>> - add a device tree node for the sdhci controller present on the CP
>>   master for A7K/A8K. It also led to rename the sdhci0 node on AP to
>>   ap_sdhci0 to make a distinction with the one present on CP master.
>>
>> v2 -> v3
>> I think that now most (if not all) the remarks had been taking into
>> account since the second version. According to Ziji Hu, here are the
>> following changes:
>> " Changes in V3:
>>   Adjust and improve Xenon DT bindings. Move some caps setting from driver into
>>   DT. Use mmc-card sub-node to represent eMMC type.
>>   Remove PHY Sampling Fixed Delay Line scan in lower speed mode.
>>   Improve Xenon probe and ->init_card() functions.
>>   Export sdhci_enable_sdio_irq() and implement own SDIO IRQ control.
>>   Split PHY patch into two smaller patches.
>>   Temporarily remove AXI clock before its implementation is improved."
>>
>> Besides this changes I also
>> - Removed the sdhci-xenon-phy.h and moved its content in the
>> shc-xenon-phy.c file.
>> - Fixed the tuning-count usage
>> - Managed the error case for clk_prepare_enable
>>
>> For the record the change from v1 was:
>> " Changes in V2:
>>   rebase on v4.9-rc2.
>>   Re-write Xenon bindings. Ajust Xenon DT property naming.
>>   Add a new DT property to indicate eMMC card type, instead of using
>>   variable card_candidate.
>>   Clear quirks SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 in Xenon platform data
>>   Add support to HS400 retuning."
>>
>> Thanks,
>>
>> Gregory
>>
>> Gregory CLEMENT (4):
>>   clk: apn806: Turn the eMMC clock as optional for dts backwards compatible
>>   arm64: dts: marvell: add eMMC support for Armada 37xx
>>   arm64: dts: marvell: add sdhci support for Armada 7K/8K
>>   arm64: configs: enable SDHCI driver for Xenon
>>
>> Hu Ziji (8):
>>   mmc: sdhci: Export sdhci_set_ios() from sdhci.c
>>   mmc: sdhci: Export sdhci_start_signal_voltage_switch() in sdhci.c
>>   mmc: sdhci: Export sdhci_enable_sdio_irq() from sdhci.c
>>   dt: bindings: Add bindings for Marvell Xenon SD Host Controller
>>   mmc: sdhci-xenon: Add Marvell Xenon SDHC core functionality
>>   mmc: sdhci-xenon: Add support to PHYs of Marvell Xenon SDHC
>>   mmc: sdhci-xenon: Add SoC PHY PAD voltage control
>>   MAINTAINERS: add entry for Marvell Xenon MMC Host Controller drivers
>>
>> Konstantin Porotchkin (1):
>>   clk: apn806: Add eMMC clock to system controller driver
>>
>>  Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt | 170 +-
>>  MAINTAINERS                                                   |   7 +-
>>  arch/arm64/boot/dts/marvell/armada-3720-db.dts                |   9 +-
>>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi                  |  11 +-
>>  arch/arm64/boot/dts/marvell/armada-7040-db.dts                |  14 +-
>>  arch/arm64/boot/dts/marvell/armada-8040-db.dts                |  12 +-
>>  arch/arm64/boot/dts/marvell/armada-ap806.dtsi                 |  14 +-
>>  arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi          |  11 +-
>>  arch/arm64/configs/defconfig                                  |   1 +-
>>  drivers/clk/mvebu/ap806-system-controller.c                   |  21 +-
>>  drivers/mmc/host/Kconfig                                      |   8 +-
>>  drivers/mmc/host/Makefile                                     |   3 +-
>>  drivers/mmc/host/sdhci-xenon-phy.c                            | 835 +++++++-
>>  drivers/mmc/host/sdhci-xenon.c                                | 548 +++++-
>>  drivers/mmc/host/sdhci-xenon.h                                | 101 +-
>>  drivers/mmc/host/sdhci.c                                      |  11 +-
>>  drivers/mmc/host/sdhci.h                                      |   4 +-
>>  17 files changed, 1774 insertions(+), 6 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
>>  create mode 100644 drivers/mmc/host/sdhci-xenon-phy.c
>>  create mode 100644 drivers/mmc/host/sdhci-xenon.c
>>  create mode 100644 drivers/mmc/host/sdhci-xenon.h
>>
>> base-commit: a645cc1df4ff41ba54a2fb839962b8ff142121d9
>> --
>> git-series 0.9.1
>
>
> Thanks, applied patch 1->10 for next! 11->13 will have to go via the
> SoC maintainer tree.

Great, thanks!

Patch 11 and 12 are now applied on mvebu/dt64 and patch 13 on
mvebu/defconfig64.

Gregory

>
> Kind regards
> Uffe

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
