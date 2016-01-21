From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH RFC 00/15] mmc: sunxi: Support vqmmc
 regulator and eMMC DDR modes
Date: Thu, 21 Jan 2016 12:19:04 +0100
Message-ID: <56A0BEA8.1030901@redhat.com>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
Reply-To: hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Return-path: <linux-sunxi+bncBDRZXY4CYYORBMH5QK2QKGQEEDC6STY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1453354002-28366-1-git-send-email-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On 21-01-16 06:26, Chen-Yu Tsai wrote:
> Hi everyone,
>
> This series adds support for vqmmc regulator and eMMC DDR modes for
> sunxi-mmc. Allwinner's MMC controller supports eMMC 4.41 on earlier
> SoCs, and up to 5.0 on latest ones. UHS-1 modes are also supported
> by the hardware, but these are not covered in this series, as no
> boards have dedicated regulators for vqmmc.
>
> To support these faster modes, these patches adds vqmmc regulator
> support, which is used by the mmc core to switch to faster modes,
> even if the signaling voltage is fixed. Signal voltage switching
> support is also added, but not tested, as no available hardware has
> a dedicated vqmmc regulator.
>
> Support for eMMC reset in the controller, vs a GPIO and pwrseq, is
> also added where applicable.

Thanks for working on this. I've send my remarks to a few of the patches,
the ones I've not remarked on look good to me.

Regards,

Hans


>
> Patch 1 documents the mmc host init sequence. When the driver was
> ported, this part was copied verbatim and not documented. With inline
> comments from later SDKs and datasheet register definitions, this part
> is now clearer.
>
> Patch 2 makes the .set_ios callback return on errors from
> mmc_regulator_set_ocr.
>
> Patch 3 adds support (enabling/disable, and voltage control) for vqmmc
> regulator to sunxi-mmc.
>
> Patch 4 adds support signal voltage switch for the mmc controller. The
> Allwinner MMC controller uses a special bit for sending signal voltage
> switching command.
>
> Patch 5 adds timing delays for MMC_DDR52 mode.
>
> Patch 6 adds support for 8 bit eMMC DDR52 mode. Under this mode, the
> controller must run at twice the card clock, and different timing delays
> are needed.
>
> Patch 7 enables eMMC HS-DDR for sunxi-mmc.
>
> Patch 8 adds mmc3 pins for 8 bit emmc for A31/A31s.
>
> Patch 9 switches from mmc2 to mmc3 for the onboard eMMC on Sinlinx
> SinA31s. According to Allwinner, only mmc3 supports eMMC DDR52 on
> A31/A31s.
>
> Patch 10 adds the eMMC reset pin to the emmc pingroup for A23/A33.
>
> Patch 11 enables eMMC hardware reset and eMMC DDR52 mode for SinA33.
>
> Patch 12 switches A80 to sun9i specific mmc compatible. A80 has different
> timing delays, and a larger FIFO (TODO).
>
> Patch 13 adds the eMMC reset pin to the emmc pingroup for A80.
>
> Patch 14 enables eMMC hardware reset and eMMC DDR52 mode for A80 Optimus.
>
> Patch 15 enables eMMC hardware reset and eMMC DDR52 mode for Cubieboard4.
>
> Chen-Yu Tsai (15):
>    mmc: sunxi: Document host init sequence
>    mmc: sunxi: Return error on mmc_regulator_set_ocr() fail in .set_ios
>      op
>    mmc: sunxi: Block signal voltage switching (CMD11)
>    mmc: sunxi: Support vqmmc regulator
>    mmc: sunxi: Support MMC_DDR52 timing modes
>    mmc: sunxi: Support 8 bit eMMC DDR transfer modes
>    mmc: sunxi: Enable eMMC HS-DDR (MMC_CAP_1_8V_DDR) support
>    ARM: dts: sun6i: Add mmc3 pins for 8 bit emmc
>    ARM: dts: sun6i: sina31s: Switch to mmc3 for onboard eMMC
>    ARM: dts: sun8i: Include SDC2_RST pin in mmc2_8bit_pins
>    ARM: dts: sun8i: sina33: Enable hardware reset and HS-DDR for eMMC
>    ARM: dts: sun9i: Use sun9i specific mmc compatible
>    ARM: dts: sun9i: Include SDC2_RST pin in mmc2_8bit_pins
>    ARM: dts: sun9i: a80-optimus: Enable hardware reset and HS-DDR for
>      eMMC
>    ARM: dts: sun9i: cubieboard4: Enable hardware reset and HS-DDR for
>      eMMC
>
>   arch/arm/boot/dts/sun6i-a31.dtsi               | 10 +++
>   arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi |  6 +-
>   arch/arm/boot/dts/sun8i-a23-a33.dtsi           |  2 +-
>   arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts |  3 +
>   arch/arm/boot/dts/sun9i-a80-cubieboard4.dts    |  6 ++
>   arch/arm/boot/dts/sun9i-a80-optimus.dts        |  6 ++
>   arch/arm/boot/dts/sun9i-a80.dtsi               | 11 +--
>   drivers/mmc/host/sunxi-mmc.c                   | 98 +++++++++++++++++++++++---
>   8 files changed, 126 insertions(+), 16 deletions(-)
>
