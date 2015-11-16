From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [RFC PATCH] ARM: dts: rockchip: Add wifi support for firefly
Date: Mon, 16 Nov 2015 08:39:38 +0100
Message-ID: <CAOf5uwmAFnCGP5_D+uPykYkkvsLnHeiGF6aYaPr2t1U6E1edhg@mail.gmail.com>
References: <1438956725-4188-1-git-send-email-michael@amarulasolutions.com>
	<5702275.SOOuh5NPWf@diego>
	<20150809082640.GA5459@panicking>
	<4932422.vgAJTm4MIh@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:36590 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbbKPHjj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Nov 2015 02:39:39 -0500
Received: by igcph11 with SMTP id ph11so51835251igc.1
        for <linux-mmc@vger.kernel.org>; Sun, 15 Nov 2015 23:39:38 -0800 (PST)
In-Reply-To: <4932422.vgAJTm4MIh@diego>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, linux-mmc@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, Romain Perier <romain.perier@gmail.com>, FUKAUMI Naoki <naobsd@gmail.com>

Hi Heiko

Sorry for long delay, the product was moved from rk3288 to imx6

I will rebase everything and use your patches soon and test

Michael

On Sun, Aug 9, 2015 at 9:17 PM, Heiko St=C3=BCbner <heiko@sntech.de> wr=
ote:
> Hi Michael,
>
> Am Sonntag, 9. August 2015, 10:26:44 schrieb Michael Trimarchi:
>
> [...]
>
>> > >   num-slots =3D <1>;
>> > >   pinctrl-names =3D "default";
>> > >
>> > > - pinctrl-0 =3D <&sdio0_bus4>, <&sdio0_cmd>, <&sdio0_clk>;
>> > > - vmmc-supply =3D <&vcc_18>;
>> > > + pinctrl-0 =3D <&sdio0_bus4>, <&sdio0_cmd>, <&sdio0_clk>, <&sdi=
o0_int>;
>> > > +
>> > > + sd-uhs-sdr50;
>> > > + sd-uhs-sdr104;
>> > > + sd-uhs-ddr50;
>> >
>> > we don't have mmc tuning capabilities yet, so please no sd-uhs-* s=
tuff.
>> > That way you should also be able to leave out the clock-freq-min-m=
ax
>> > above, as regular "highspeed" does not venture above the 50MHz lim=
it.
>>
>> Ok, I have tested without it too and it works with a small hack on t=
he code.
>> Agree with you
>
> what was this supposed to fix? And what "hack" do you use now?
>
>
>> > > + cap-sdio-irq;
>> > > +
>> > > + vmmc-supply =3D <&vcc_wifi>;
>> >
>> > the original supply is actually wrong in the dts. vcc_18 is the io=
 voltage
>> > used on the
>> > pins _to_ the card, not to supply the card itself. So vcc_18 is ac=
tually
>> > the so called vqmmc-supply.
>> > vmmc-supply is done regularly from vcc_io. So your voltage hack ab=
ove can
>> > go away too.
>> >
>> > Bringup should also use a mmc-power-sequency so you can make sure =
the
>> > rtc_clock is running, which is also needed by the wifi module.
>>
>> Hack is used to because when sdio subsystem compare the wifi voltage
>> capability returned by a specific message on the bus with the possib=
le
>> voltage levels that hardware connection provides and take the minima=
l. The
>> card return to support from 2V up and this is the reason to declare =
it at
>> 2V. I will retest again
>
> after the supplies are corrected (see vmmc and vqmmc in the patches) =
the
> supply for the modules should actually be read as the 3.3V that are s=
upplying
> it (from vcc_io ... which is called vbat_wl in the schematics).
>
>
>> > >   status =3D "okay";
>> >
>> > missing #address-cells and #size-cells values for the subnodes
>>
>> Correct
>>
>> > > +
>> > > + brcmf: bcrmf@0 {
>> > > +         compatible =3D "brcm,bcm4329-fmac";
>> > > +         interrupt-parent =3D <&gpio4>;
>> > > +         reg =3D <0>;
>> > > +         interrupts =3D <30 IRQ_TYPE_EDGE_FALLING>;
>> > > +         interrupt-names =3D "host-wake";
>> > > +         status =3D "okay";
>> > > + };
>> > >
>> > >  };
>> > >
>> > >  &sdmmc {
>> >
>> > I took the liberty to move stuff around how it should look like, b=
ut did
>> > not find the time to actually test this. So maybe you can take a l=
ook at
>> > the attached patches.
>>
>> Perfect, I will retest as soon as I can and go back to you. Right no=
w
>> I have two hardware design around firefly that use the wifi
>
> great
>
>
> Heiko



--=20
| Michael Nazzareno Trimarchi                     Amarula Solutions BV =
|
| COO  -  Founder                                      Cruquiuskade 47 =
|
| +31(0)851119172                                 Amsterdam 1018 AM NL =
|
|                  [`as] http://www.amarulasolutions.com               =
|
