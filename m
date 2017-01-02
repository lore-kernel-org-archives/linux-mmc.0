From: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 0/5] arm64: sunxi: A64: enable MMC support
Date: Mon,  2 Jan 2017 23:03:41 +0000
Message-ID: <1483398226-29321-1-git-send-email-andre.przywara@arm.com>
Reply-To: andre.przywara-5wv7dgnIgG8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDNZNK75ZIKRBYFYVPBQKGQECDEDMIY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Hans De Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

So far the Allwinner A64/Pine64 DT was missing MMC support, because we
observed issues with that. Those have now been fixed (patch 1 and 2),
so we can enable the MMC IP block in the SoC .dtsi and the Pine64 .dts.
As this gives access to the SD card (as the only mass storage device on
most boards), this makes the kernel support actually useful.
The A64 MMC controller has more up its sleeves, but for now this level
of support is good enough.
Thanks a lot to Maxime for investigating the eMMC failure and coming up
with a nice fix for that.
Maxime: I picked that patch from some pastebin drop of yours, please holler
if there's something wrong with that (patch 2/5).

I send the BananaPi M64 .dts patch along with that series, as the eMMC on
that board now makes some difference.

Cheers,
Andre.

Andre Przywara (4):
  drivers: mmc: sunxi: fix A64 calibration routine
  arm64: dts: sun50i: add MMC nodes
  arm64: dts: Pine64: add MMC support
  arm64: dts: add BananaPi-M64 support

Maxime Ripard (1):
  drivers: mmc: sunxi: limit A64 MMC2 to 8K DMA buffer

 .../devicetree/bindings/mmc/sunxi-mmc.txt          |   1 +
 arch/arm64/boot/dts/allwinner/Makefile             |   1 +
 .../boot/dts/allwinner/sun50i-a64-bananapi-m64.dts | 125 +++++++++++++++++++++
 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |  18 +++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      |  77 +++++++++++++
 drivers/mmc/host/sunxi-mmc.c                       |  37 ++++--
 6 files changed, 247 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts

-- 
2.8.2
