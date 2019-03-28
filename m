From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 23/24] arm64: dts: mediatek: add dtsi for MT8516
Date: Thu, 28 Mar 2019 14:22:12 -0500
Message-ID: <CAL_Jsq+Q06O84-MTpgTWGG312VXm_vGOkjMCjtWuS0eZ-j_0yw@mail.gmail.com>
References: <20190323211612.860-1-fparent@baylibre.com> <20190323211612.860-24-fparent@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190323211612.860-24-fparent@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabien Parent <fparent@baylibre.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Sean Wang <sean.wang@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>, Wenzhen Yu <wenzhen.yu@mediatek.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Yong Mao <yong.mao@mediatek.com>, jjian.zhou@mediatek.com, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, open list:SE
List-Id: linux-mmc@vger.kernel.org

On Sat, Mar 23, 2019 at 4:17 PM Fabien Parent <fparent@baylibre.com> wrote:
>
> The MT8516 SoC provides the following peripherals: GPIO, UART, USB2,
> SPI, eMMC, SDIO, NAND, Flash, ADC, I2C, PWM, Timers, IR, Ethernet, and
> Audio (I2S, SPDIF, TDM).
>
> This commit is adding the basic dtsi file with the support of the
> following IOs: GPIO, UART, SPI, eMMC, I2C, Timers.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8516-pinfunc.h | 663 ++++++++++++++++++
>  arch/arm64/boot/dts/mediatek/mt8516.dtsi      | 409 +++++++++++
>  2 files changed, 1072 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8516-pinfunc.h
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8516.dtsi

Reviewed-by: Rob Herring <robh@kernel.org>
