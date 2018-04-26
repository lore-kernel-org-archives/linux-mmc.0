From: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
Subject: [PATCH 0/3] Enable basic MMC support on Allwinner H6
Date: Thu, 26 Apr 2018 22:07:25 +0800
Message-ID: <20180426140728.43155-1-icenowy@aosc.io>
Reply-To: icenowy-h8G6r0blFSE@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDS6XAN6ZADRBUV2Q7LQKGQE3WHCDWY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Allwinner H6 features 3 SD/MMC controllers. The first and second ones
are similar to the ones on the Allwinner A64/H5 SoCs, and the third one
adds the function to use EMCE (EMbedded Crypto Engine) on the Allwinner
H6 chip to do full-disk encryption.

Enable basic MMC support on Allwinner H6. Higher speed bins are not
supported, similar to A64/H5. EMCE is also not supported, and keeps its
bypassed status by default.

Icenowy Zheng (3):
  mmc: sunxi: add support for the MMC controller on H6
  arm64: allwinner: h6: add device tree nodes for MMC controllers
  arm64: allwinner: h6: enable MMC0/2 on Pine H64

 .../devicetree/bindings/mmc/sunxi-mmc.txt          |  2 +
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts      | 32 +++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi       | 56 ++++++++++++++++++++++
 drivers/mmc/host/sunxi-mmc.c                       | 16 +++++++
 4 files changed, 106 insertions(+)

-- 
2.15.1
