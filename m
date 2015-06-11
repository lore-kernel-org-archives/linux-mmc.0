From: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v5 1/7] mmc: dt-bindings: add Mediatek MMC bindings
Date: Thu, 11 Jun 2015 09:33:51 +0800
Message-ID: <1433986431.14592.2.camel@mhfsdcap03>
References: <1433903088-14407-1-git-send-email-chaotian.jing@mediatek.com>
 <1433903088-14407-2-git-send-email-chaotian.jing@mediatek.com>
 <CAPDyKFojmJYcQOdk3CkgsJ0xOzgjH86VVwvYCy2whjtiPxAFKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <CAPDyKFojmJYcQOdk3CkgsJ0xOzgjH86VVwvYCy2whjtiPxAFKg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, James Liao <jamesjj.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hongzhou Yang <hongzhou.yang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Bin Zhang =?UTF-8?Q?=28=E7=AB=A0=E6=96=8C=29?= <bin.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Joe.C" <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kern>
List-Id: linux-mmc@vger.kernel.org

Dear Ulf,
Thanks for your review!
please see my comment:
On Wed, 2015-06-10 at 14:02 +0200, Ulf Hansson wrote:
> On 10 June 2015 at 04:24, Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> > Document the device-tree binding of Mediatek MMC host
> >
> > Signed-off-by: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > ---
> >  Documentation/devicetree/bindings/mmc/mtk-sd.txt | 32 ++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mmc/mtk-sd.txt
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> > new file mode 100644
> > index 0000000..a1adfa4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> > @@ -0,0 +1,32 @@
> > +* MTK MMC controller
> > +
> > +The MTK  MSDC can act as a MMC controller
> > +to support MMC, SD, and SDIO types of memory cards.
> > +
> > +This file documents differences between the core properties in mmc.txt
> > +and the properties used by the msdc driver.
> > +
> > +Required properties:
> > +- compatible: Should be "mediatek,mt8173-mmc","mediatek,mt8135-mmc"
> > +- interrupts: Should contain MSDC interrupt number
> > +- clocks: MSDC source clock, HCLK
> > +- clock-names: "source", "hclk"
> 
> According to the mmc driver, hclk is treated as an optional clock.
> Therefore I think you should list it under an "Optional properties"
> section instead.
> 
I will make the hclk to mandatory at next driver revision.
if there was no hclk at dtsi, then the host would probe fail.

> > +- pinctrl-names: should be "default", "state_uhs"
> > +- pinctrl-0: should contain default/high speed pin ctrl
> > +- pinctrl-1: should contain uhs mode pin ctrl
> > +- vmmc-supply: power to the Core
> > +- vqmmc-supply: power to the IO
> > +
> > +Examples:
> > +mmc0: mmc@11230000 {
> > +       compatible = "mediatek,mt8173-mmc", "mediatek,mt8135-mmc";
> > +       reg = <0 0x11230000 0 0x108>;
> > +       interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_LOW>;
> > +       vmmc-supply = <&mt6397_vemc_3v3_reg>;
> > +       vqmmc-supply = <&mt6397_vio18_reg>;
> > +       clocks = <&pericfg CLK_PERI_MSDC30_0>, <&topckgen CLK_TOP_MSDC50_0_H_SEL>;
> > +       clock-names = "source", "hclk";
> > +       pinctrl-names = "default", "state_uhs";
> > +       pinctrl-0 = <&mmc0_pins_default>;
> > +       pinctrl-1 = <&mmc0_pins_uhs>;
> > +};
> > --
> > 1.8.1.1.dirty
> >
> 
> Kind regards
> Uffe
