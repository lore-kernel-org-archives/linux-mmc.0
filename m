From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH v6 4/7] arm64: dts: mediatek: Add MT8173 MMC dts
Date: Mon, 29 Jun 2015 19:24:12 +0800
Message-ID: <CAGS+omBi88UtEcyyUX6N4OfO9Frwxbsr1Aap1b6uRBKvB=zsrg@mail.gmail.com>
References: <1434367253-26577-1-git-send-email-chaotian.jing@mediatek.com>
 <1434367253-26577-5-git-send-email-chaotian.jing@mediatek.com>
 <CAGS+omCwxH5vTTKNOEcN9C9s=1yBpYEqbMz1NygYoLY9OFKchg@mail.gmail.com>
 <CAGS+omDMprTvjwpXfdh7mg9i=WXdzO_Fv-oEop3z6AEVCG=DFQ@mail.gmail.com>
 <1434593063.23303.3.camel@mtksdaap41> <1434594513.26032.6.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1434594513.26032.6.camel@mtksdaap41>
Sender: linux-gpio-owner@vger.kernel.org
To: Eddie Huang <eddie.huang@mediatek.com>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, James Liao <jamesjj.liao@mediatek.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, srv_heupstream <srv_heupstream@mediatek.com>, Arnd Bergmann <arnd@arndb.de>, "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>, Hongzhou Yang <hongzhou.yang@mediatek.com>, Catalin Marinas <catalin.marinas@arm.com>, bin.zhang@mediatek.com, linux-mmc@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, linux-gpio@vger.kernel.org, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, "Joe.C" <yingjoe.chen@mediatek.com>"linux-arm-kernel@lists.infradead.org" <li>
List-Id: linux-mmc@vger.kernel.org

On Thu, Jun 18, 2015 at 10:28 AM, Eddie Huang <eddie.huang@mediatek.com> wrote:
>
> Hi Dan,
>
> On Thu, 2015-06-18 at 10:04 +0800, Eddie Huang wrote:
> > Hi Dan,
> >
> > On Tue, 2015-06-16 at 20:20 +0800, Daniel Kurtz wrote:
> > > On Tue, Jun 16, 2015 at 7:39 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:
> > > > On Mon, Jun 15, 2015 at 7:20 PM, Chaotian Jing
> > > > <chaotian.jing@mediatek.com> wrote:
> > > >> From: Eddie Huang <eddie.huang@mediatek.com>
> > > >>
> > > >> Add node mmc0 ~ mmc3 for mt8173.dtsi
> > > >> Add node mmc0, mmc1 for mt8173-evb.dts
> > > >>
> > > >> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> > > >> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> > > >> ---
> > > >>  arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 126 ++++++++++++++++++++++++++++
> > > >>  arch/arm64/boot/dts/mediatek/mt8173.dtsi    |  45 +++++++++-
> > > >>  2 files changed, 170 insertions(+), 1 deletion(-)
> > > >>
> > > >> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> > > >> index b1560c9..762ec61 100644
> > > >> --- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> > > >> +++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> > > >> @@ -33,6 +33,132 @@
> > > >>         chosen { };
> > > >>  };
> > > >>
> > > >> +&mmc0 {
> > > >> +       pinctrl-names = "default", "state_uhs";
> > > >> +       pinctrl-0 = <&mmc0_pins_default>;
> > > >> +       pinctrl-1 = <&mmc0_pins_uhs>;
> > > >> +       status = "okay";
> > > >> +       bus-width = <8>;
> > > >> +       max-frequency = <50000000>;
> > > >> +       cap-mmc-highspeed;
> > > >> +       vmmc-supply = <&mt6397_vemc_3v3_reg>;
> > > >> +       vqmmc-supply = <&mt6397_vio18_reg>;
> > >
> > > I also can't find phandles for these regulators.
> > >
> > > >> +       non-removable;
> > > >> +};
> > > >> +
> > > >> +&mmc1 {
> > > >> +       pinctrl-names = "default", "state_uhs";
> > > >> +       pinctrl-0 = <&mmc1_pins_default>;
> > > >> +       pinctrl-1 = <&mmc1_pins_uhs>;
> > > >> +       status = "okay";
> > > >> +       bus-width = <4>;
> > > >> +       max-frequency = <50000000>;
> > > >> +       cap-sd-highspeed;
> > > >> +       sd-uhs-sdr25;
> > > >> +       cd-gpios = <&pio 132 0>;
> > > >> +       vmmc-supply = <&mt6397_vmch_reg>;
> > > >> +       vqmmc-supply = <&mt6397_vmc_reg>;
> > >
> > > nor these regulators.
> > >
> > > Which kernel branch are you basing your patch set on?
> > >
> > It is based on 4.1-rc1, and Sascha's regulator dts patch.
> > [3/4] ARM: dts: mt8135-evbp1: Add PMIC support:
> > https://patchwork.kernel.org/patch/6261161/
> >
> My mistake, we only sent mt8135-evbp1.dts, but this patch need
> mt8173-evb.dts, we will send this.


Hi Eddie,

When do you plan to send an updated mmc patch set?

Thanks,
-Dan

>
>
> Eddie
> Thanks
>
>
>
>
