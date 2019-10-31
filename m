From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 03/11] DTS: ARM: pandora-common: define wl1251 as child
 node of mmc3
Date: Thu, 31 Oct 2019 17:59:05 +0100
Message-ID: <CAPDyKFrbOH=ROv_JefSQsEnmGqN6oFVfbhpqscOK=KUqJgzarw@mail.gmail.com>
References: <cover.1571510481.git.hns@goldelico.com> <bec9d76e6da03d734649b9bdf76e9d575c57631a.1571510481.git.hns@goldelico.com>
 <CAPDyKFrMQ3fBaeeAYVJfUdL8m=PDRU9Xt_9oGw6D1XOY68qDuQ@mail.gmail.com> <D9A82904-35BE-41F2-A308-9A49606428B1@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <D9A82904-35BE-41F2-A308-9A49606428B1-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Mike Rapoport <rppt-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, David Sterba <dsterba-IBi9RG/b67k@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Petr Mladek <pmladek-IBi9RG/b67k@public.gmane.org>, Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Kefeng Wang <wangkefeng.wang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Yangtao Li <tiny.windzz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexios Zavras <alexios.zavras-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Allison Randal <allison-wcfNWazeolPR7s880joybQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, 30 Oct 2019 at 18:25, H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> wrote:
>
>
> > Am 30.10.2019 um 17:44 schrieb Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>:
> >
> > On Sat, 19 Oct 2019 at 20:42, H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> wrote:
> >>
> >> Since v4.7 the dma initialization requires that there is a
> >> device tree property for "rx" and "tx" channels which is
> >> not provided by the pdata-quirks initialization.
> >>
> >> By conversion of the mmc3 setup to device tree this will
> >> finally allows to remove the OpenPandora wlan specific omap3
> >> data-quirks.
> >>
> >> Fixes: 81eef6ca9201 ("mmc: omap_hsmmc: Use dma_request_chan() for requesting DMA channel")
> >>
> >> Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
> >> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> # 4.7.0
> >> ---
> >> arch/arm/boot/dts/omap3-pandora-common.dtsi | 37 +++++++++++++++++++--
> >> 1 file changed, 35 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/arm/boot/dts/omap3-pandora-common.dtsi b/arch/arm/boot/dts/omap3-pandora-common.dtsi
> >> index ec5891718ae6..c595b3eb314d 100644
> >> --- a/arch/arm/boot/dts/omap3-pandora-common.dtsi
> >> +++ b/arch/arm/boot/dts/omap3-pandora-common.dtsi
> >> @@ -226,6 +226,18 @@
> >>                gpio = <&gpio6 4 GPIO_ACTIVE_HIGH>;     /* GPIO_164 */
> >>        };
> >>
> >> +       /* wl1251 wifi+bt module */
> >> +       wlan_en: fixed-regulator-wg7210_en {
> >> +               compatible = "regulator-fixed";
> >> +               regulator-name = "vwlan";
> >> +               regulator-min-microvolt = <1800000>;
> >> +               regulator-max-microvolt = <1800000>;
> >
> > I doubt these are correct.
> >
> > I guess this should be in the range of 2.7V-3.6V.
>
> Well, it is a gpio which enables some LDO inside the
> wifi chip. We do not really know the voltage it produces
> and it does not matter. The gpio voltage is 1.8V.
>
> Basically we use a fixed-regulator to "translate" a
> regulator into a control gpio because the mmc interface
> wants to see a vmmc-supply.

The vmmc supply represent the core power to the SDIO card (or
SD/(e)MMC). Depending on what voltage range the vmmc supply supports,
the so called OCR mask is created by the mmc core. The mask is then
used to let the core negotiate the voltage level with the SDIO card,
during the card initialization. This is not to confuse with the I/O
voltage level, which is a different regulator.

Anyway, according to the TI WiLink series specifications, it looks
like vmmc should be a regulator supporting 3-3.3V (in many schematics
it's called VBAT).

Furthermore I decided to dig into various DTS files that specifies the
vmmc regulator, of course for mmc nodes having a subnode specifying an
SDIO card for a TI WiLink. In most cases a 1.8V fixed GPIO regulator
is used. This looks wrong to me. The fixed GPIO regulator isn't really
the one that should model vmmc.

The proper solution, would rather be to use separate regulator for
vmmc and instead use a so called mmc-pwrseq node to manage the GPIO.

To conclude from my side, as we have lots of DTS that are wrong, I
don't really care if we add another one in the way you suggest above.
But feel free to look into the mmc-pwrseq option.

>
> >
> >> +               startup-delay-us = <50000>;
> >> +               regulator-always-on;
> >
> > Always on?
>
> Oops. Yes, that is something to check!

As it's a GPIO regulator, for sure it's not always on.

>
> >
> >> +               enable-active-high;
> >> +               gpio = <&gpio1 23 GPIO_ACTIVE_HIGH>;
> >> +       };
> >> +
> >>        /* wg7210 (wifi+bt module) 32k clock buffer */
> >>        wg7210_32k: fixed-regulator-wg7210_32k {
> >>                compatible = "regulator-fixed";
> >> @@ -522,9 +534,30 @@
> >>        /*wp-gpios = <&gpio4 31 GPIO_ACTIVE_HIGH>;*/    /* GPIO_127 */
> >> };
> >>
> >> -/* mmc3 is probed using pdata-quirks to pass wl1251 card data */
> >> &mmc3 {
> >> -       status = "disabled";
> >> +       vmmc-supply = <&wlan_en>;
> >> +
> >> +       bus-width = <4>;
> >> +       non-removable;
> >> +       ti,non-removable;
> >> +       cap-power-off-card;
> >> +
> >> +       pinctrl-names = "default";
> >> +       pinctrl-0 = <&mmc3_pins>;
> >> +
> >> +       #address-cells = <1>;
> >> +       #size-cells = <0>;
> >> +
> >> +       wlan: wl1251@1 {
> >> +               compatible = "ti,wl1251";
> >> +
> >> +               reg = <1>;
> >> +
> >> +               interrupt-parent = <&gpio1>;
> >> +               interrupts = <21 IRQ_TYPE_LEVEL_HIGH>;  /* GPIO_21 */
> >> +
> >> +               ti,wl1251-has-eeprom;
> >> +       };
> >> };
> >>
> >> /* bluetooth*/
> >> --
> >> 2.19.1
> >>
>
> BR and thanks,
> Nikolaus
>

Kind regards
Uffe
