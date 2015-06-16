From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v6 0/7] Add Mediatek MMC driver
Date: Tue, 16 Jun 2015 10:03:06 +0200
Message-ID: <CAPDyKFrAbAFR7_p5O4bPh6FZEBVhGZ2rq3htCKcF2QgQuCEf2g@mail.gmail.com>
References: <1434367253-26577-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:35281 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756409AbbFPIDI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Jun 2015 04:03:08 -0400
Received: by qgeu36 with SMTP id u36so2490354qge.2
        for <linux-mmc@vger.kernel.org>; Tue, 16 Jun 2015 01:03:06 -0700 (PDT)
In-Reply-To: <1434367253-26577-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Chris Ball <chris@printf.net>, Mark Rutland <mark.rutland@arm.com>, James Liao <jamesjj.liao@mediatek.com>, srv_heupstream <srv_heupstream@mediatek.com>, Arnd Bergmann <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Hongzhou Yang <hongzhou.yang@mediatek.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-mmc <linux-mmc@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, =?UTF-8?B?QmluIFpoYW5nICjnq6Dmlowp?= <bin.zhang@mediatek.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek

On 15 June 2015 at 13:20, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> This series enables MMC support on the MT8135/MT8173 platform.
> MT8135 has 5 MMC controllers and MT8173 has 4 MMC controllers.
>
> Changes base on Ulf's comments
> Make hclk mandatory in the driver code
> Change host->hclk to host->src_clk_freq
> Add linux/pm.h
>
> Chaotian Jing (3):
>   mmc: dt-bindings: add Mediatek MMC bindings
>   mmc: mediatek: Add Mediatek MMC driver
>   mmc: mediatek: Add PM support for MMC driver
>
> Eddie Huang (2):
>   arm64: dts: mediatek: Add MT8173 MMC dts
>   arm64: mediatek: Add Mediatek MMC support in defconfig
>
> Yingjoe Chen (2):
>   ARM: mediatek: dts: Add emmc support to mt8135
>   ARM: multi_v7_defconfig: Enable Mediatek MMC support multi-v7
>
>  Documentation/devicetree/bindings/mmc/mtk-sd.txt |   32 +
>  arch/arm/boot/dts/mt8135-evbp1.dts               |  158 +++
>  arch/arm/boot/dts/mt8135.dtsi                    |   55 +
>  arch/arm/configs/multi_v7_defconfig              |    1 +
>  arch/arm64/boot/dts/mediatek/mt8173-evb.dts      |  126 ++
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi         |   45 +-
>  arch/arm64/configs/defconfig                     |    1 +
>  drivers/mmc/host/Kconfig                         |    8 +
>  drivers/mmc/host/Makefile                        |    1 +
>  drivers/mmc/host/mtk-sd.c                        | 1461 ++++++++++++++++++++++
>  include/linux/mmc/core.h                         |    1 +
>  11 files changed, 1888 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/mtk-sd.txt
>  create mode 100644 drivers/mmc/host/mtk-sd.c
>
> --
> 1.8.1.1.dirty
>

Hi Chaotian,

I have applied patch 1->3 for my next branch, which thus includes the
mmc driver parts. I could potentially also pick the ARM patches, but
then those needs to be acked from the ARM SoC folks.

Kind regards
Uffe
