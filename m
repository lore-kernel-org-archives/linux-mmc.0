From: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v4 1/7] mmc: dt-bindings: add Mediatek MMC bindings
Date: Tue, 26 May 2015 14:27:37 +0800
Message-ID: <1432621657.647.9.camel@mhfsdcap03>
References: <1432017411-2996-1-git-send-email-chaotian.jing@mediatek.com>
 <1432017411-2996-2-git-send-email-chaotian.jing@mediatek.com>
 <CAPDyKFq+YAz2pt1820YnqWaVKO6sn5eB+NxuM2dhP236FSKa9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <CAPDyKFq+YAz2pt1820YnqWaVKO6sn5eB+NxuM2dhP236FSKa9g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Please see my comment:
On Tue, 2015-05-19 at 11:41 +0200, Ulf Hansson wrote:
> On 19 May 2015 at 08:36, Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> > Document the device-tree binding of Mediatek MMC host
> >
> > Signed-off-by: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > ---
> >  Documentation/devicetree/bindings/mmc/mtk-sd.txt | 33 ++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mmc/mtk-sd.txt
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> > new file mode 100644
> > index 0000000..ba6d668
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> > @@ -0,0 +1,33 @@
> > +* MTK MMC controller
> > +
> > +The MTK  MSDC can act as a MMC controller
> > +to support MMC, SD, and SDIO types of memory cards.
> > +
> > +This file documents differences between the core properties in mmc.txt
> > +and the properties used by the msdc driver.
> > +
> > +Required properties:
> > +- compatible: Should be "mediatek,mt8173-mmc","mediatek,mt8135-mmc".
> > +- interrupts: Should contain MSDC interrupt number
> > +- clocks: MSDC source clock, HCLK, HCLK is mandatory when it is not controlled by Infra
> 
> This seems strange. Either it's mandatory since it's under the
> "Required properties" section or it should be moved to the "Optional
> properties" section.
> 
Yes, as you see, the "HCLK" is mandatory for MSDC0 & MSDC3, but MSDC1 &
MSDC2 do not have corresponding HCLK.
By the way, I will make the vqmmc-supply to mandatory, As the pinctrl
select depend on it.
> > +- clock-names: "source", "hclk"
> > +- pinctrl-names: should be "default", "state_uhs"
> > +- pinctrl-0: should contain default/high speed pin ctrl
> > +- pinctrl-1: should contain uhs mode pin ctrl
> > +- vmmc-supply: power to the Core
> > +
> > +Optional properties:
> > +- vqmmc-supply: power to the IO(for SD/SDIO)
> > +
> > +Examples:
> > +mmc0: mmc@11230000 {
> > +       compatible = "mediatek,mt8173-mmc", "mediatek,mt8135-mmc";
> > +       reg = <0 0x11230000 0 0x108>;
> > +       interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_LOW>;
> > +       vmmc-supply = <&mt6397_vemc_3v3_reg>;
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
