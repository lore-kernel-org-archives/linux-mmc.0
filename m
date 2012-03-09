From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 3/4] arm/dts: OMAP4: Add mmc controller nodes and board data
Date: Fri, 09 Mar 2012 08:49:11 -0700
Message-ID: <20120309154911.8C23C3E08E2@localhost>
References: <1329998490-27555-1-git-send-email-rnayak@ti.com> <1329998490-27555-4-git-send-email-rnayak@ti.com> <CANrkHUaP7cV_vSKQYZkeF-aS5CEi2CAp3_9aDJKCVOX-67oNPg@mail.gmail.com> <4F4765EC.1000102@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <4F4765EC.1000102@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>, "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Cc: cjb@laptop.org, linaro-dev@lists.linaro.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Fri, 24 Feb 2012 15:56:52 +0530, Rajendra Nayak <rnayak@ti.com> wrote:
> On Friday 24 February 2012 03:46 PM, T Krishnamoorthy, Balaji wrote:
> >> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> >> index 29f4589..9204f60 100644
> >> --- a/arch/arm/boot/dts/omap4.dtsi
> >> +++ b/arch/arm/boot/dts/omap4.dtsi
> >> @@ -25,6 +25,11 @@
> >>                 serial1 =&uart2;
> >>                 serial2 =&uart3;
> >>                 serial3 =&uart4;
> >> +               mmc1 =&mmc1;
> >> +               mmc2 =&mmc2;
> >> +               mmc3 =&mmc3;
> >> +               mmc4 =&mmc4;
> >> +               mmc5 =&mmc5;
> >>         };
> >>
> >>         cpus {
> >> @@ -155,5 +160,31 @@
> >>                         #size-cells =<0>;
> >>                         ti,hwmods = "i2c4";
> >>                 };
> >> +
> >> +               mmc1: mmc@1 {
> >> +                       compatible = "ti,omap4-hsmmc";
> >> +                       ti,hwmods = "mmc1";
> >> +                       ti,dual-volt;
> >> +               };
> >> +
> >> +               mmc2: mmc@2 {
> >> +                       compatible = "ti,omap4-hsmmc";
> >> +                       ti,hwmods = "mmc2";
> >> +               };
> >
> > Hi Rajendra,
> > Is there a way to control the device registration order,
> > eMMC connected to mmc2 needs to be registered as /dev/mmcblk0p ...
> > irrespective of whether SD card is mount or not on mmc1 card slot.
> > So that bootargs would not have to be modified when filesystem is on eMMC.
> 
> I don't know if we can, but even if we could, we take care of the same
> bootargs working on two boards (say sdp and panda) *if* on sdp I have my
> filesystem on eMMC and on panda I have it on external card.
> What happens if I want to use my filesystem on both boards on external
> card?

of_alias_get_id() may be able to help you here.  It will extract the id
numbering from the /aliases node.  That is the safe way to do global
enumeration of devices in the device tree (instead of 'cell-index' which
is strongly discouraged)

g.

> 
> >
> >> +
> >> +               mmc3: mmc@3 {
> >> +                       compatible = "ti,omap4-hsmmc";
> >> +                       ti,hwmods = "mmc3";
> >> +               };
> >> +
> >> +               mmc4: mmc@4 {
> >> +                       compatible = "ti,omap4-hsmmc";
> >> +                       ti,hwmods = "mmc4";
> >> +               };
> >> +
> >> +               mmc5: mmc@5 {
> >> +                       compatible = "ti,omap4-hsmmc";
> >> +                       ti,hwmods = "mmc5";
> >> +               };
> >>         };
> >>   };
> >> --
> >> 1.7.1
> >>
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies,Ltd.
