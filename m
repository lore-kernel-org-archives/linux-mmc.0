From: Jan Glauber <jan.glauber-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v12 1/9] dt-bindings: mmc: Add Cavium SOCs MMC bindings
Date: Fri, 17 Mar 2017 11:51:06 +0100
Message-ID: <20170317105106.GC3011@hardcore>
References: <20170310132507.32025-1-jglauber@cavium.com>
 <20170310132507.32025-2-jglauber@cavium.com>
 <CAPDyKFqVHN--=AWttMz_uDEkGTO+aX8APM34enDuVxqM6XKYJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFqVHN--=AWttMz_uDEkGTO+aX8APM34enDuVxqM6XKYJg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, "Steven J . Hill" <Steven.Hill-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Mar 17, 2017 at 09:31:23AM +0100, Ulf Hansson wrote:
> On 10 March 2017 at 14:24, Jan Glauber <jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org> wrote:
> > Add description of Cavium Octeon and ThunderX SOC device tree bindings.
> >
> > CC: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > CC: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > CC: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
> > CC: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >
> > Signed-off-by: Jan Glauber <jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> > Signed-off-by: David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> > Signed-off-by: Steven J. Hill <steven.hill-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> > Acked-by: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > ---
> >  .../devicetree/bindings/mmc/cavium-mmc.txt         | 58 ++++++++++++++++++++++
> >  1 file changed, 58 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mmc/cavium-mmc.txt
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/cavium-mmc.txt b/Documentation/devicetree/bindings/mmc/cavium-mmc.txt
> > new file mode 100644
> > index 0000000..225c2be
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mmc/cavium-mmc.txt
> > @@ -0,0 +1,58 @@
> > +* Cavium Octeon & ThunderX MMC controller
> > +
> > +The highspeed MMC host controller on Caviums SoCs provides an interface
> > +for MMC and SD types of memory cards.
> > +
> > +Supported maximum speeds are the ones of the eMMC standard 4.41 as well
> > +as the speed of SD standard 4.0. Only 3.3 Volt is supported.
> > +
> > +Required properties:
> > + - compatible : should be one of:
> > +   cavium,octeon-6130-mmc
> > +   cavium,octeon-6130-mmc-slot
> > +   cavium,octeon-7890-mmc
> > +   cavium,octeon-7890-mmc-slot
> > +   cavium,thunder-8190-mmc
> > +   cavium,thunder-8190-mmc-slot
> > +   cavium,thunder-8390-mmc
> > +   cavium,thunder-8390-mmc-slot
> > + - reg : mmc controller base registers
> > + - clocks : phandle
> > +
> > +Optional properties:
> > + - for cd, bus-width and additional generic mmc parameters
> > +   please refer to mmc.txt within this directory
> > + - cavium,cmd-clk-skew : number of coprocessor clocks before sampling command
> > + - cavium,dat-clk-skew : number of coprocessor clocks before sampling data
> > +
> > +Deprecated properties:
> > +- spi-max-frequency : use max-frequency instead
> > +- cavium,bus-max-width : use bus-width instead
> > +
> > +Examples:
> > +       mmc_1_4: mmc@1,4 {
> > +               compatible = "cavium,thunder-8390-mmc";
> > +               reg = <0x0c00 0 0 0 0>; /* DEVFN = 0x0c (1:4) */
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +               clocks = <&sclk>;
> > +
> > +               mmc-slot@0 {
> > +                       compatible = "cavium,thunder-8390-mmc-slot";
> > +                       reg = <0>;
> 
> Just realized that I forgotten to follow up about the details for I
> think we should generally describe slots nodes in DT.
> 
> Currently we treat a child node of a host device node, with reg=0 as
> being an embedded mmc card [1] (in case it has the "mmc-card"
> compatible set).
> When reg is 1->7, those are reserved for SDIO function nodes [2] (as
> those can be exactly 7, according to the SDIO spec).
> 
> Let's take the above into account and consider that a slot node may
> also require a its own child node as to describe an embedded mmc card
> or SDIO funcs. In this context I don't think it makes sense to use SoC
> specific compatibles for slot nodes, instead I suggest we use only
> "mmc-slot".
> 
> Does that makes sense?

The slot compatible is currently not used, setting it to "mmc-slot" 
looks like good to me.

--Jan

> > +                       vmmc-supply = <&mmc_supply_3v3>;
> > +                       max-frequency = <42000000>;
> > +                       bus-width = <4>;
> > +                       cap-sd-highspeed;
> > +               };
> > +
> > +               mmc-slot@1 {
> > +                       compatible = "cavium,thunder-8390-mmc-slot";
> > +                       reg = <1>;
> > +                       vmmc-supply = <&mmc_supply_3v3>;
> > +                       max-frequency = <42000000>;
> > +                       bus-width = <8>;
> > +                       cap-mmc-highspeed;
> > +                       non-removable;
> > +               };
> > +       };
> > --
> > 2.9.0.rc0.21.g7777322
> >
> 
> Kind regards
> Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
