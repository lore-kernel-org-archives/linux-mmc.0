From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH v6 0/7] Add Mediatek MMC driver
Date: Wed, 17 Jun 2015 17:01:33 -0400
Message-ID: <CAP=VYLpBymmAVY7LoFJR5+QTxL4CN7t+PrLFCxaoAN_a9S4Jbw@mail.gmail.com>
References: <1434367253-26577-1-git-send-email-chaotian.jing@mediatek.com> <CAPDyKFrAbAFR7_p5O4bPh6FZEBVhGZ2rq3htCKcF2QgQuCEf2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:35834 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753194AbbFQVCF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Jun 2015 17:02:05 -0400
In-Reply-To: <CAPDyKFrAbAFR7_p5O4bPh6FZEBVhGZ2rq3htCKcF2QgQuCEf2g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Chris Ball <chris@printf.net>, Mark Rutland <mark.rutland@arm.com>, James Liao <jamesjj.liao@mediatek.com>, srv_heupstream <srv_heupstream@mediatek.com>, Arnd Bergmann <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Hongzhou Yang <hongzhou.yang@mediatek.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-mmc <linux-mmc@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, =?UTF-8?B?QmluIFpoYW5nICjnq6Dmlowp?= <bin.zhang@mediatek.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm>

On Tue, Jun 16, 2015 at 4:03 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 15 June 2015 at 13:20, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>> This series enables MMC support on the MT8135/MT8173 platform.
>> MT8135 has 5 MMC controllers and MT8173 has 4 MMC controllers.
>>
>> Changes base on Ulf's comments
>> Make hclk mandatory in the driver code
>> Change host->hclk to host->src_clk_freq
>> Add linux/pm.h
>>
>> Chaotian Jing (3):
>>   mmc: dt-bindings: add Mediatek MMC bindings
>>   mmc: mediatek: Add Mediatek MMC driver.

This commit breaks when merged to linux-next since it gets
exposed as an implicit module.h user that does not include
that header:

   drivers/mmc/host/mtk-sd.c:1459:1: note: in expansion of macro
'module_platform_driver'
    module_platform_driver(mt_msdc_driver);
    ^
   include/linux/device.h:1296:1: error: type defaults to 'int' in
declaration of 'module_init' [-Werror=implicit-int]
    module_init(__driver##_init); \
    ^

Since the code doesn't exist in mainline, I can't fix it from
within my header cleanup series, so can you please add
an appropriate include of module.h to the above?

Also, I noticed the Makefile addition from this commit
is whitespace mangled; might as well fix that too if
rebasing to fix the include problem.

Thanks,
Paul.
--

>>   mmc: mediatek: Add PM support for MMC driver
>>
>> Eddie Huang (2):
>>   arm64: dts: mediatek: Add MT8173 MMC dts
>>   arm64: mediatek: Add Mediatek MMC support in defconfig
>>
>> Yingjoe Chen (2):
>>   ARM: mediatek: dts: Add emmc support to mt8135
>>   ARM: multi_v7_defconfig: Enable Mediatek MMC support multi-v7
>>
>>  Documentation/devicetree/bindings/mmc/mtk-sd.txt |   32 +
>>  arch/arm/boot/dts/mt8135-evbp1.dts               |  158 +++
>>  arch/arm/boot/dts/mt8135.dtsi                    |   55 +
>>  arch/arm/configs/multi_v7_defconfig              |    1 +
>>  arch/arm64/boot/dts/mediatek/mt8173-evb.dts      |  126 ++
>>  arch/arm64/boot/dts/mediatek/mt8173.dtsi         |   45 +-
>>  arch/arm64/configs/defconfig                     |    1 +
>>  drivers/mmc/host/Kconfig                         |    8 +
>>  drivers/mmc/host/Makefile                        |    1 +
>>  drivers/mmc/host/mtk-sd.c                        | 1461 ++++++++++++++++++++++
>>  include/linux/mmc/core.h                         |    1 +
>>  11 files changed, 1888 insertions(+), 1 deletion(-)
>>  create mode 100644 Documentation/devicetree/bindings/mmc/mtk-sd.txt
>>  create mode 100644 drivers/mmc/host/mtk-sd.c
>>
>> --
>> 1.8.1.1.dirty
>>
>
> Hi Chaotian,
>
> I have applied patch 1->3 for my next branch, which thus includes the
> mmc driver parts. I could potentially also pick the ARM patches, but
> then those needs to be acked from the ARM SoC folks.
>
> Kind regards
> Uffe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
