From: Sonny Rao <sonnyrao@chromium.org>
Subject: Re: [PATCH v3 1/4] ARM: dts: Add emmc and sdmmc to the rk3288 device tree
Date: Tue, 12 Aug 2014 15:11:31 -0700
Message-ID: <CAPz6YkX2ht62Swzepd=g6bBy6w2+SJ2C2M4xvBmWbtAjRHEocg@mail.gmail.com>
References: <1407344984-14176-1-git-send-email-dianders@chromium.org>
 <1407344984-14176-2-git-send-email-dianders@chromium.org> <CAD=FV=Wsc-Pkvg9jumdg9i1oO+T1=jtZTfbc+qE5RDrCXaaezA@mail.gmail.com>
 <1445128.HbmmWnRJOL@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:42941 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578AbaHLWLx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Aug 2014 18:11:53 -0400
Received: by mail-qa0-f46.google.com with SMTP id v10so9469603qac.33
        for <linux-mmc@vger.kernel.org>; Tue, 12 Aug 2014 15:11:52 -0700 (PDT)
In-Reply-To: <1445128.HbmmWnRJOL@phil>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: Doug Anderson <dianders@chromium.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Addy Ke <addy.ke@rock-chips.com>, Kever Yang <kever.yang@rock-chips.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Aug 12, 2014 at 3:07 PM, Heiko St=C3=BCbner <heiko@sntech.de> w=
rote:
> Am Dienstag, 12. August 2014, 14:06:11 schrieb Doug Anderson:
>> Heiko,
>>
>> On Wed, Aug 6, 2014 at 10:09 AM, Doug Anderson <dianders@chromium.or=
g>
> wrote:
>> > This adds support for the sdmmc and emmc ports on the rk3288 using=
 the
>> >
>> > currently posted driver from Addy at:
>> >   https://patchwork.kernel.org/patch/4653631/
>> >
>> > Note:
>> > * This is not baesd on Jaehoon's patch series removing the slot no=
de,
>> >
>> >   but it does use new syntax like putting the bus width at the top
>> >   level and using the new cap-mmc-highspeed / cap-sd-highspeed.  A
>> >   future patch will modify this one to remove the slot node.
>> >
>> > Signed-off-by: Doug Anderson <dianders@chromium.org>
>> > Acked-by: Arnd Bergmann <arnd@arndb.de>
>> > ---
>> > Changes in v3: None
>> > Changes in v2:
>> > - New patchwork link for Addy's patch
>> >
>> >  arch/arm/boot/dts/rk3288.dtsi | 22 ++++++++++++++++++++++
>> >  1 file changed, 22 insertions(+)
>> >
>> > diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3=
288.dtsi
>> > index e7cb008..dc98a5b 100644
>> > --- a/arch/arm/boot/dts/rk3288.dtsi
>> > +++ b/arch/arm/boot/dts/rk3288.dtsi
>> > @@ -78,6 +78,28 @@
>> >
>> >                 clock-frequency =3D <24000000>;
>> >
>> >         };
>> >
>> > +       sdmmc: dwmmc@ff0c0000 {
>> > +               compatible =3D "rockchip,rk3288-dw-mshc";
>> > +               clocks =3D <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>;
>> > +               clock-names =3D "biu", "ciu";
>> > +               fifo-depth =3D <0x100>;
>> > +               interrupts =3D <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
>> > +               reg =3D <0xff0c0000 0x4000>;
>> > +               #address-cells =3D <1>;
>> > +               #size-cells =3D <0>;
>>
>> When doing other testing I realized that I missed a:
>>   status =3D "disabled";
>>
>> ...from both of these two nodes.  I'm happy to repost with this fix =
or
>> I'm happy if you want to add to the patch when applying.
>>
>> Let me know.  Thanks!
>
> I don't really have a preference :-) . Btw. I also did plan on mergin=
g patches
> 1 +4 and 2+3 now that the slot-removal series has landed.
> Would this be ok with you?
>
> So if you want to repost, you could do this as two patches already :-=
).

Please repost with the status =3D "disabled"; the fact that they were
enabled by the dtsi was confusing to some of us at least once already
:-)

>
>
> Heiko
>
>>
>> > +       };
>> > +
>> > +       emmc: dwmmc@ff0f0000 {
>> > +               compatible =3D "rockchip,rk3288-dw-mshc";
>> > +               clocks =3D <&cru HCLK_EMMC>, <&cru SCLK_EMMC>;
>> > +               clock-names =3D "biu", "ciu";
>> > +               fifo-depth =3D <0x100>;
>> > +               interrupts =3D <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
>> > +               reg =3D <0xff0f0000 0x4000>;
>> > +               #address-cells =3D <1>;
>> > +               #size-cells =3D <0>;
>> > +       };
>> > +
>> >
>> >         i2c1: i2c@ff140000 {
>> >
>> >                 compatible =3D "rockchip,rk3288-i2c";
>> >                 reg =3D <0xff140000 0x1000>;
>> >
>> > --
>> > 2.0.0.526.g5318336
>
