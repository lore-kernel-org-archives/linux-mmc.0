From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v3 1/4] ARM: dts: Add emmc and sdmmc to the rk3288 device tree
Date: Tue, 12 Aug 2014 16:24:30 -0700
Message-ID: <CAD=FV=XCNRTrzScXKskLT-KRFvYODVA-+ODx3T4jZjZapCdO-Q@mail.gmail.com>
References: <1407344984-14176-1-git-send-email-dianders@chromium.org>
	<1407344984-14176-2-git-send-email-dianders@chromium.org>
	<CAD=FV=Wsc-Pkvg9jumdg9i1oO+T1=jtZTfbc+qE5RDrCXaaezA@mail.gmail.com>
	<1445128.HbmmWnRJOL@phil>
	<CAPz6YkX2ht62Swzepd=g6bBy6w2+SJ2C2M4xvBmWbtAjRHEocg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPz6YkX2ht62Swzepd=g6bBy6w2+SJ2C2M4xvBmWbtAjRHEocg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Kever Yang <kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Sonny and Heiko,

On Tue, Aug 12, 2014 at 3:11 PM, Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrot=
e:
> On Tue, Aug 12, 2014 at 3:07 PM, Heiko St=C3=BCbner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>=
 wrote:
>> Am Dienstag, 12. August 2014, 14:06:11 schrieb Doug Anderson:
>>> Heiko,
>>>
>>> On Wed, Aug 6, 2014 at 10:09 AM, Doug Anderson <dianders@chromium.o=
rg>
>> wrote:
>>> > This adds support for the sdmmc and emmc ports on the rk3288 usin=
g the
>>> >
>>> > currently posted driver from Addy at:
>>> >   https://patchwork.kernel.org/patch/4653631/
>>> >
>>> > Note:
>>> > * This is not baesd on Jaehoon's patch series removing the slot n=
ode,
>>> >
>>> >   but it does use new syntax like putting the bus width at the to=
p
>>> >   level and using the new cap-mmc-highspeed / cap-sd-highspeed.  =
A
>>> >   future patch will modify this one to remove the slot node.
>>> >
>>> > Signed-off-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>>> > Acked-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
>>> > ---
>>> > Changes in v3: None
>>> > Changes in v2:
>>> > - New patchwork link for Addy's patch
>>> >
>>> >  arch/arm/boot/dts/rk3288.dtsi | 22 ++++++++++++++++++++++
>>> >  1 file changed, 22 insertions(+)
>>> >
>>> > diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk=
3288.dtsi
>>> > index e7cb008..dc98a5b 100644
>>> > --- a/arch/arm/boot/dts/rk3288.dtsi
>>> > +++ b/arch/arm/boot/dts/rk3288.dtsi
>>> > @@ -78,6 +78,28 @@
>>> >
>>> >                 clock-frequency =3D <24000000>;
>>> >
>>> >         };
>>> >
>>> > +       sdmmc: dwmmc@ff0c0000 {
>>> > +               compatible =3D "rockchip,rk3288-dw-mshc";
>>> > +               clocks =3D <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>;
>>> > +               clock-names =3D "biu", "ciu";
>>> > +               fifo-depth =3D <0x100>;
>>> > +               interrupts =3D <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
>>> > +               reg =3D <0xff0c0000 0x4000>;
>>> > +               #address-cells =3D <1>;
>>> > +               #size-cells =3D <0>;
>>>
>>> When doing other testing I realized that I missed a:
>>>   status =3D "disabled";
>>>
>>> ...from both of these two nodes.  I'm happy to repost with this fix=
 or
>>> I'm happy if you want to add to the patch when applying.
>>>
>>> Let me know.  Thanks!
>>
>> I don't really have a preference :-) . Btw. I also did plan on mergi=
ng patches
>> 1 +4 and 2+3 now that the slot-removal series has landed.
>> Would this be ok with you?
>>
>> So if you want to repost, you could do this as two patches already :=
-).
>
> Please repost with the status =3D "disabled"; the fact that they were
> enabled by the dtsi was confusing to some of us at least once already
> :-)

Done.  Please let me know if it looks OK or if there are any other
spins needed.  ;)

-Doug
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
