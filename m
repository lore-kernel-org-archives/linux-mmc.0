From: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v6 4/7] arm64: dts: mediatek: Add MT8173 MMC dts
Date: Thu, 18 Jun 2015 10:28:33 +0800
Message-ID: <1434594513.26032.6.camel@mtksdaap41>
References: <1434367253-26577-1-git-send-email-chaotian.jing@mediatek.com>
 <1434367253-26577-5-git-send-email-chaotian.jing@mediatek.com>
 <CAGS+omCwxH5vTTKNOEcN9C9s=1yBpYEqbMz1NygYoLY9OFKchg@mail.gmail.com>
 <CAGS+omDMprTvjwpXfdh7mg9i=WXdzO_Fv-oEop3z6AEVCG=DFQ@mail.gmail.com>
 <1434593063.23303.3.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1434593063.23303.3.camel@mtksdaap41>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, James Liao <jamesjj.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Hongzhou Yang <hongzhou.yang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "Joe.C" <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "open
 list:OPEN FIRMWARE AND..." <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, bin.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Henry Chen <henryc.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Dan,

On Thu, 2015-06-18 at 10:04 +0800, Eddie Huang wrote:
> Hi Dan,
> 
> On Tue, 2015-06-16 at 20:20 +0800, Daniel Kurtz wrote:
> > On Tue, Jun 16, 2015 at 7:39 PM, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> > > On Mon, Jun 15, 2015 at 7:20 PM, Chaotian Jing
> > > <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> > >> From: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > >>
> > >> Add node mmc0 ~ mmc3 for mt8173.dtsi
> > >> Add node mmc0, mmc1 for mt8173-evb.dts
> > >>
> > >> Signed-off-by: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > >> Signed-off-by: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > >> ---
> > >>  arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 126 ++++++++++++++++++++++++++++
> > >>  arch/arm64/boot/dts/mediatek/mt8173.dtsi    |  45 +++++++++-
> > >>  2 files changed, 170 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> > >> index b1560c9..762ec61 100644
> > >> --- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> > >> +++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> > >> @@ -33,6 +33,132 @@
> > >>         chosen { };
> > >>  };
> > >>
> > >> +&mmc0 {
> > >> +       pinctrl-names = "default", "state_uhs";
> > >> +       pinctrl-0 = <&mmc0_pins_default>;
> > >> +       pinctrl-1 = <&mmc0_pins_uhs>;
> > >> +       status = "okay";
> > >> +       bus-width = <8>;
> > >> +       max-frequency = <50000000>;
> > >> +       cap-mmc-highspeed;
> > >> +       vmmc-supply = <&mt6397_vemc_3v3_reg>;
> > >> +       vqmmc-supply = <&mt6397_vio18_reg>;
> > 
> > I also can't find phandles for these regulators.
> > 
> > >> +       non-removable;
> > >> +};
> > >> +
> > >> +&mmc1 {
> > >> +       pinctrl-names = "default", "state_uhs";
> > >> +       pinctrl-0 = <&mmc1_pins_default>;
> > >> +       pinctrl-1 = <&mmc1_pins_uhs>;
> > >> +       status = "okay";
> > >> +       bus-width = <4>;
> > >> +       max-frequency = <50000000>;
> > >> +       cap-sd-highspeed;
> > >> +       sd-uhs-sdr25;
> > >> +       cd-gpios = <&pio 132 0>;
> > >> +       vmmc-supply = <&mt6397_vmch_reg>;
> > >> +       vqmmc-supply = <&mt6397_vmc_reg>;
> > 
> > nor these regulators.
> > 
> > Which kernel branch are you basing your patch set on?
> > 
> It is based on 4.1-rc1, and Sascha's regulator dts patch.
> [3/4] ARM: dts: mt8135-evbp1: Add PMIC support:
> https://patchwork.kernel.org/patch/6261161/
> 
My mistake, we only sent mt8135-evbp1.dts, but this patch need
mt8173-evb.dts, we will send this.

Eddie
Thanks
