From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: Re: [PATCH 02/12] arm64: dts: mt8173: remove "mediatek,mt8135-mmc"
 from mmc nodes
Date: Wed, 27 Sep 2017 09:14:45 +0800
Message-ID: <1506474885.19851.5.camel@mhfsdcap03>
References: <1505207272-16983-1-git-send-email-chaotian.jing@mediatek.com>
         <1505207272-16983-3-git-send-email-chaotian.jing@mediatek.com>
         <CAPDyKFo7rC5UVWw9VyJ7ws1wW4kCvSW7Jcsgqd6gY_nifB6fTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFo7rC5UVWw9VyJ7ws1wW4kCvSW7Jcsgqd6gY_nifB6fTw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, yong mao <yong.mao@mediatek.com>, Linus Walleij <linus.walleij@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Heiner Kallweit <hkallweit1@gmail.com>, Phong LE <ple@baylibre.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, srv_heupstream <srv_heupstream@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, 2017-09-27 at 00:37 +0200, Ulf Hansson wrote:
> On 12 September 2017 at 11:07, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> > devicetree bindings has been updated to support multi-platforms,
> > so that each platform has its owns compatible name.
> > And, this compatible name may used in driver to distinguish with
> > other platform.
> 
> This does not seems to be DT backwards compatible.
> 
> If the driver starts interpreting the "mt8135-mmc" differently,
> wouldn't that lead to old DTBs to become broken?
> 
> Kind regards
> Uffe
At patch 03/12, it shows that no difference between "mt8135-mmc" and
"mt8173-mmc", and following changes will make difference between these
two.
but, the user should update DTS & driver together,then will do not have
compatible issue.
> 
> >
> > Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > index b99a273..26396ef 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > @@ -682,8 +682,7 @@
> >                 };
> >
> >                 mmc0: mmc@11230000 {
> > -                       compatible = "mediatek,mt8173-mmc",
> > -                                    "mediatek,mt8135-mmc";
> > +                       compatible = "mediatek,mt8173-mmc";
> >                         reg = <0 0x11230000 0 0x1000>;
> >                         interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_LOW>;
> >                         clocks = <&pericfg CLK_PERI_MSDC30_0>,
> > @@ -693,8 +692,7 @@
> >                 };
> >
> >                 mmc1: mmc@11240000 {
> > -                       compatible = "mediatek,mt8173-mmc",
> > -                                    "mediatek,mt8135-mmc";
> > +                       compatible = "mediatek,mt8173-mmc";
> >                         reg = <0 0x11240000 0 0x1000>;
> >                         interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_LOW>;
> >                         clocks = <&pericfg CLK_PERI_MSDC30_1>,
> > @@ -704,8 +702,7 @@
> >                 };
> >
> >                 mmc2: mmc@11250000 {
> > -                       compatible = "mediatek,mt8173-mmc",
> > -                                    "mediatek,mt8135-mmc";
> > +                       compatible = "mediatek,mt8173-mmc";
> >                         reg = <0 0x11250000 0 0x1000>;
> >                         interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_LOW>;
> >                         clocks = <&pericfg CLK_PERI_MSDC30_2>,
> > @@ -715,8 +712,7 @@
> >                 };
> >
> >                 mmc3: mmc@11260000 {
> > -                       compatible = "mediatek,mt8173-mmc",
> > -                                    "mediatek,mt8135-mmc";
> > +                       compatible = "mediatek,mt8173-mmc";
> >                         reg = <0 0x11260000 0 0x1000>;
> >                         interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_LOW>;
> >                         clocks = <&pericfg CLK_PERI_MSDC30_3>,
> > --
> > 1.8.1.1.dirty
> >
