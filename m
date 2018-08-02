From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v3 1/4] dt-bindings: usb: dwc2: add description for px30
Date: Thu, 02 Aug 2018 15:03:15 +0200
Message-ID: <1906917.Z0b3HQLJhP@phil>
References: <1533113116-8820-1-git-send-email-cl@rock-chips.com> <1533113116-8820-2-git-send-email-cl@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533113116-8820-2-git-send-email-cl@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: cl@rock-chips.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, klaus.goger@theobroma-systems.com, hjc@rock-chips.com, jagan@amarulasolutions.com, djw@t-chip.com.cn, jacob-chen@iotwrt.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, frank.wang@rock-chips.com, lgirdwood@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org, gregkh@linuxfoundation.org, catalin.marinas@arm.com, will.deacon@arm.com, yamada.masahiro@socionext.com, arnd@arndb.de, zhangqing@rock-chips.com, shawn.lin@rock-chips.com, kever.yang@rock-chips.com, david.wu@rock-chips.com, huangtao@rock-chips.com, tony.xie@rock-chips.com, sugar.zhang@rock-chips.com, huibin.hong@rock-chips.com
List-Id: linux-mmc@vger.kernel.org

Am Mittwoch, 1. August 2018, 10:45:13 CEST schrieb cl@rock-chips.com:
> From: Liang Chen <cl@rock-chips.com>
> 
> This patch adds the compatible of dwc2 for PX30 SoCs.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Liang Chen <cl@rock-chips.com>

I've split out the dwc2 things from the px30 dts and readded them
in a new series and also moved the binding addition over there [0]

Heiko

[0] https://patchwork.kernel.org/cover/10553569/
