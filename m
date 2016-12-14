From: Marcin Wojtas <mw@semihalf.com>
Subject: Re: [PATCH v4 00/12] mmc: Add support to Marvell Xenon SD Host Controller
Date: Wed, 14 Dec 2016 20:02:57 +0100
Message-ID: <CAPv3WKe9OZv_q-vJovcArFV+OdjV9PavS2cUmhikY-L++e3okA@mail.gmail.com>
References: <cover.67d726f70f6bd48d38a2023513f2711080bc66c8.1481651244.git-series.gregory.clement@free-electrons.com>
 <CAPv3WKeE_2gMn12MXraoUmDEJhi307mGuc4BgDYpethKNsMqRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:37370 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753897AbcLNTC6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Dec 2016 14:02:58 -0500
Received: by mail-it0-f44.google.com with SMTP id y23so8793590itc.0
        for <linux-mmc@vger.kernel.org>; Wed, 14 Dec 2016 11:02:58 -0800 (PST)
In-Reply-To: <CAPv3WKeE_2gMn12MXraoUmDEJhi307mGuc4BgDYpethKNsMqRQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Ziji Hu <huziji@marvell.com>, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ryan Gao <ygao@marvell.com>, Doug Jones <dougj@marvell.com>, Victor Gu <xigu@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Wilson Ding <dingwei@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Hanna Hawa <hannah@marvell.com>

Resend in plain text, sorry for noise.

2016-12-14 20:02 GMT+01:00 Marcin Wojtas <mw@semihalf.com>:
> Hi Gregory,
>
> Checked a3700 and a7k (both interfaces, CP - one after changing to use eMMC
> variant in DT). Everything works fine. You can add:
>
> Tested-by: Marcin Wojtas <mw@semihalf.com>
>
> Best regards,
> Marcin
>
> 2016-12-13 18:48 GMT+01:00 Gregory CLEMENT
> <gregory.clement@free-electrons.com>:
>>
>> Hello,
>>
>> This the forth version of the series adding support for the SDHCI
>> Xenon controller. It can be currently found on the Armada 37xx and the
>> Armada 7K/8K but will be also used in more Marvell SoC (and not only
>> the mvebu ones actually).
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
>>   Adjust and improve Xenon DT bindings. Move some caps setting from driver
>> into
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
>> Gregory CLEMENT (3):
>>   arm64: dts: marvell: add eMMC support for Armada 37xx
>>   arm64: dts: marvell: add sdhci support for Armada 7K/8K
>>   arm64: configs: enable SDHCI driver for Xenon
>>
>> Hu Ziji (9):
>>   mmc: sdhci: Export sdhci_set_ios() from sdhci.c
>>   mmc: sdhci: Export sdhci_start_signal_voltage_switch() in sdhci.c
>>   mmc: sdhci: Export sdhci_execute_tuning() in sdhci.c
>>   mmc: sdhci: Export sdhci_enable_sdio_irq() from sdhci.c
>>   MAINTAINERS: add entry for Marvell Xenon MMC Host Controller drivers
>>   dt: bindings: Add bindings for Marvell Xenon SD Host Controller
>>   mmc: sdhci-xenon: Add Marvell Xenon SDHC core functionality
>>   mmc: sdhci-xenon: Add support to PHYs of Marvell Xenon SDHC.
>>   mmc: sdhci-xenon: Add SOC PHY PAD voltage control
>>
>>  Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt | 197 ++-
>>  MAINTAINERS                                                   |   7 +-
>>  arch/arm64/boot/dts/marvell/armada-3720-db.dts                |  17 +-
>>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi                  |  11 +-
>>  arch/arm64/boot/dts/marvell/armada-7040-db.dts                |  14 +-
>>  arch/arm64/boot/dts/marvell/armada-ap806.dtsi                 |   9 +-
>>  arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi          |  10 +-
>>  arch/arm64/configs/defconfig                                  |   1 +-
>>  drivers/mmc/host/Kconfig                                      |   9 +-
>>  drivers/mmc/host/Makefile                                     |   3 +-
>>  drivers/mmc/host/sdhci-xenon-phy.c                            | 908
>> +++++++-
>>  drivers/mmc/host/sdhci-xenon.c                                | 615
>> +++++-
>>  drivers/mmc/host/sdhci-xenon.h                                | 111 +-
>>  drivers/mmc/host/sdhci.c                                      |  14 +-
>>  drivers/mmc/host/sdhci.h                                      |   5 +-
>>  15 files changed, 1926 insertions(+), 5 deletions(-)
>>  create mode 100644
>> Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
>>  create mode 100644 drivers/mmc/host/sdhci-xenon-phy.c
>>  create mode 100644 drivers/mmc/host/sdhci-xenon.c
>>  create mode 100644 drivers/mmc/host/sdhci-xenon.h
>>
>> base-commit: 9fe68cad6e74967b88d0c6aeca7d9cd6b6e91942
>> --
>> git-series 0.9.1
>
>
