From: Alexandre Torgue <alexandre.torgue@st.com>
Subject: Re: [PATCH v3 00/14] Add MMCI support for STM32F SoCs family
Date: Thu, 18 Jan 2018 18:01:44 +0100
Message-ID: <a39cebbe-55b8-9a0c-cc2c-b05d435ed170@st.com>
References: <1516286070-24927-1-git-send-email-patrice.chotard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:60009 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932357AbeARRCV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Jan 2018 12:02:21 -0500
In-Reply-To: <1516286070-24927-1-git-send-email-patrice.chotard@st.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: patrice.chotard@st.com, Russell King <linux@armlinux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org

Hi Patrice,


On 01/18/2018 03:34 PM, patrice.chotard@st.com wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
> 
> This series reworks patches submitted one year ago by Andrea Merello [1]
> but without succeed to merged it.
> 
> STM32F4 and STM32F7 SoCs families embeds a variant of the ARM PrimeCell
> PL18x SD host controller, for which the mmci driver exists.
> This series adds support for these SoCs to the mmci driver.
> 
> As other variants, this one need some specific quirks, that this
> series address.
> 
> This series has been tested on following boards :
> 	_ stm32f429-eval
> 	_ stm32f469-disco
> 	_ stm32f746-eval
> 	_ stm32f769-disco
> 
> DT update for stm32f7 pinctrl, stm32f746-eval and stm32f769-disco boards
> will be sent later to avoid conflict with pending stm32f7 series [1] which
> is not yet merged on kernel mainline.
> 
> [1] https://www.spinics.net/lists/linux-mmc/msg41616.html
> [2] https://patchwork.kernel.org/patch/10104447/
> 
> v3: _ patch 3: use variant->opendrain instead of host->variant->opendrain
>      _ patch 4: exit from probe() if no pinctrl dt node are found
>      _ previous patch 15: removed as already applied in pinctrl tree
> 
> v2: _ add Revievied-by, Acked-by in some patches
>      _ replace bool by u32 for start_err and opendrain fields of struct variant_data
>      _ split previous patch 3 in two parts, first patch clean the open drain bit code
>        and second part add pinctrl pins management when no open drain bit is available.
>      _ replace "pl180" by "PL180" in patch "mmc: mmci: Add STM32 variant"
> 
> Andrea Merello (2):
>    ARM: dts: stm32: Add pin map for SDIO controller on stm32f4
>    ARM: dts: stm32: Enable SDIO controller on stm32f469 disco board

Looks good for STM32 machine part (DT/configs/mach-stm32). I will apply 
them in my next pull request.

Thanks.

Alex

> 
> Patrice Chotard (12):
>    mmc: mmci: Don't pretend all variants to have MMCIMASK1 register
>    mmc: mmci: Don't pretend all variants to have MCI_STARBITERR flag
>    mmc: mmci: Don't pretend all variants to have OPENDRAIN bit
>    mmc: mmci: Add support for setting pad type via pinctrl
>    mmc: mmci: Add STM32 variant
>    ARM: dts: stm32: Add SDIO controller for stm32f746
>    ARM: dts: stm32: Add SDIO controller for stm32f429
>    ARM: dts: stm32: Enable SDIO controller on stm32429i-eval board
>    ARM: stm32: Add AMBA support for STM32F4 and STM32F7 SoCs
>    ARM: configs: stm32: Enable MMC_ARMMMCI support
>    ARM: configs: stm32: Enable EXT3_FS support
>    clk: stm32: Add clk entry for SDMMC2 on stm32F769
> 
>   arch/arm/boot/dts/stm32429i-eval.dts   |  19 +++++
>   arch/arm/boot/dts/stm32f4-pinctrl.dtsi |  31 +++++++++
>   arch/arm/boot/dts/stm32f429.dtsi       |  11 +++
>   arch/arm/boot/dts/stm32f469-disco.dts  |  19 +++++
>   arch/arm/boot/dts/stm32f746.dtsi       |  22 ++++++
>   arch/arm/configs/stm32_defconfig       |   3 +
>   arch/arm/mach-stm32/Kconfig            |   3 +
>   drivers/clk/clk-stm32f4.c              |   3 +-
>   drivers/mmc/host/mmci.c                | 124 ++++++++++++++++++++++++++++-----
>   drivers/mmc/host/mmci.h                |   6 ++
>   10 files changed, 224 insertions(+), 17 deletions(-)
> 
