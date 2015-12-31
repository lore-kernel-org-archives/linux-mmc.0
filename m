From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [RFC PATCH] ARM: dts: rockchip: Add wifi support for firefly
Date: Thu, 31 Dec 2015 13:29:53 +0100
Message-ID: <CAOf5uwmRLaeqyazrF4YRo7qq5u3Z6hd-Xig1baDC4UB0tEmb0w@mail.gmail.com>
References: <1438956725-4188-1-git-send-email-michael@amarulasolutions.com>
	<5702275.SOOuh5NPWf@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:34933 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbbLaM3y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 31 Dec 2015 07:29:54 -0500
Received: by mail-io0-f177.google.com with SMTP id 77so62485581ioc.2
        for <linux-mmc@vger.kernel.org>; Thu, 31 Dec 2015 04:29:54 -0800 (PST)
In-Reply-To: <5702275.SOOuh5NPWf@diego>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, linux-mmc@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, Romain Perier <romain.perier@gmail.com>, FUKAUMI Naoki <naobsd@gmail.com>

Hi Heiko

On Sat, Aug 8, 2015 at 11:05 PM, Heiko St=C3=BCbner <heiko@sntech.de> w=
rote:
> Hi Michael,
>
> Am Freitag, 7. August 2015, 16:12:05 schrieb Michael Trimarchi:
>> This patch enable wifi support for the firefly board.
>> Card answer to me that support from 2.0V but regulator is connected
>> to 1.8V, so voltage capability is wrong. In order to avoid this
>> we just defined a fixed regulator trigger by the wifi enable gpio
>> that report 2.0V.
>>
>> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
>> ---
>>  arch/arm/boot/dts/rk3288-firefly.dtsi | 43
>> +++++++++++++++++++++++++++++++++-- 1 file changed, 41 insertions(+)=
, 2
>> deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi
>> b/arch/arm/boot/dts/rk3288-firefly.dtsi index 0b42372..fcf234e 10064=
4
>> --- a/arch/arm/boot/dts/rk3288-firefly.dtsi
>> +++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
>> @@ -116,6 +116,28 @@
>>               vin-supply =3D <&vcc_io>;
>>       };
>>
>> +     io_domains: io-domains {
>> +             compatible =3D "rockchip,rk3288-io-voltage-domain";
>> +             rockchip,grf =3D <&grf>;
>> +
>> +             wifi-supply =3D <&vcc_18>;
>> +             audio-supply =3D <&vcca_33>;
>> +     };
>
> should be a separate patch and include the other interesting io-domai=
ns as
> well.
>

This is alredy in mainline

>> +
>> +     vcc_wifi: wifi-regulator {
>> +             compatible =3D "regulator-fixed";
>> +             enable-active-high;
>> +             gpio =3D <&gpio4 28 GPIO_ACTIVE_HIGH>;
>> +             pinctrl-names =3D "default";
>> +             pinctrl-0 =3D <&sdio0_pwr>;
>> +             regulator-name =3D "vcc_wifi";
>> +             regulator-min-microvolt =3D <2000000>;
>> +             regulator-max-microvolt =3D <2000000>;
>> +             startup-delay-us =3D <100000>;
>> +             regulator-always-on;
>> +             vin-supply =3D <&vcc_io>;
>> +     };
>> +
>>       vcc_flash: flash-regulator {
>>               compatible =3D "regulator-fixed";
>>               regulator-name =3D "vcc_flash";
>> @@ -437,13 +459,30 @@
>>  &sdio0 {
>>       broken-cd;
>>       bus-width =3D <4>;
>> +     clock-freq-min-max =3D <400000 50000000>;
>>       disable-wp;
>>       non-removable;
>> +     cap-sd-highspeed;
>>       num-slots =3D <1>;
>>       pinctrl-names =3D "default";
>> -     pinctrl-0 =3D <&sdio0_bus4>, <&sdio0_cmd>, <&sdio0_clk>;
>> -     vmmc-supply =3D <&vcc_18>;
>> +     pinctrl-0 =3D <&sdio0_bus4>, <&sdio0_cmd>, <&sdio0_clk>, <&sdi=
o0_int>;
>> +
>> +     sd-uhs-sdr50;
>> +     sd-uhs-sdr104;
>> +     sd-uhs-ddr50;
>
> we don't have mmc tuning capabilities yet, so please no sd-uhs-* stuf=
f. That
> way you should also be able to leave out the clock-freq-min-max above=
, as
> regular "highspeed" does not venture above the 50MHz limit.
>
>> +     cap-sdio-irq;
>> +
>> +     vmmc-supply =3D <&vcc_wifi>;
>
> the original supply is actually wrong in the dts. vcc_18 is the io vo=
ltage
> used on the
> pins _to_ the card, not to supply the card itself. So vcc_18 is actua=
lly the
> so called vqmmc-supply.
> vmmc-supply is done regularly from vcc_io. So your voltage hack above=
 can go
> away too.
>
> Bringup should also use a mmc-power-sequency so you can make sure the
> rtc_clock is running, which is also needed by the wifi module.
>
>
>>       status =3D "okay";
>
> missing #address-cells and #size-cells values for the subnodes
>

I can confirm that patch 2 fix the issue of subnodes.
I will try to complete here the support

Michael

>> +
>> +     brcmf: bcrmf@0 {
>> +             compatible =3D "brcm,bcm4329-fmac";
>> +             interrupt-parent =3D <&gpio4>;
>> +             reg =3D <0>;
>> +             interrupts =3D <30 IRQ_TYPE_EDGE_FALLING>;
>> +             interrupt-names =3D "host-wake";
>> +             status =3D "okay";
>> +     };
>>  };
>>
>>  &sdmmc {
>
> I took the liberty to move stuff around how it should look like, but =
did not
> find the time to actually test this. So maybe you can take a look at =
the
> attached patches.
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
