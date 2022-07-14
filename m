Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9947BC433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jul 2022 17:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiGNR5g (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Jul 2022 13:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiGNR5g (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jul 2022 13:57:36 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE13A1A07D
        for <linux-mmc@vger.kernel.org>; Thu, 14 Jul 2022 10:57:34 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id w12so3372725edd.13
        for <linux-mmc@vger.kernel.org>; Thu, 14 Jul 2022 10:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Kp+K99xgr+TGedF33oXgcsqqibvo1diAm10fyZoaWhY=;
        b=hdkgVpkjvjjgdfQm2tqhoEOO5im6XnIjZWfnOPJppBazhDNPUg2Fpup31PjaFGb/Tt
         iB0GxO1las2zJbo6VCXWEowtUkRHBSjcW8DqsEQR/9rxdZJcbrAOGc9DCrvKSnAJJHTH
         1xnuftVbWyHq6yW90MXjkHGaEy1CJUVIcD681d2im3FVq2+XEuzVl5nPckHDWpx862Gf
         guV3K+vwpOCRsvBgtFLf/x2reOrkcLyHnGmADs2rqZ+o5WNMAGKgO+nE03IfqKxuach9
         mrwmLS0t8iDwmqbZKRvu6X2GQKgOsXLXKIyfftN5QayrM524YO0IikYK8XE7dzdtMwHb
         4anQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Kp+K99xgr+TGedF33oXgcsqqibvo1diAm10fyZoaWhY=;
        b=HR4pF2n9b7hZLwp8uEQf9ziVEInl8hwDB572wOPoxzCbl1BKm1hb9s/ElzU+F3542f
         Tg1pwWAYLLnAvrQaMAfqvRfvoi/AL7gbTF5SiKZ3geZXEVyllkLN70WVpLRiYp/izNY/
         qLzC+UabcqLFpw1m8Z+8bWMsPcn4CyoA3fseYc70CTI53EU8E3XKbEkTPp0Ps+R9xfJ2
         yPwe+NeSyF5oRqSKW/sl1snYqCC/W52xvQZqyrrnp8+AKFi3PABmMSxxjuMFGGsxjePt
         0lOGo6VZm6udU60Wl+s1P8KMLrmrrmUyqJsFHhH2cnghYoXlemrgfTvRyjX7qo/1IFcJ
         WvEw==
X-Gm-Message-State: AJIora/wniriAC8zKnd0CTS2q+9uo5dsoKbwx0Jew2XHMBl+wBK0JmwN
        lK4/Hed6JaDRWNPEcsWN7y16LUOLSdqTzPdp
X-Google-Smtp-Source: AGRyM1u/Qfgd+1kjEfG5MeEMA+kZ7cC2XlCJVQd2C5XHMQgdYlzBUtVpALKtNw1mjM2dynllJ7uM8w==
X-Received: by 2002:a05:6402:3297:b0:43a:9233:23b4 with SMTP id f23-20020a056402329700b0043a923323b4mr13834408eda.397.1657821453341;
        Thu, 14 Jul 2022 10:57:33 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id t21-20020aa7d4d5000000b0043a5bcf80a2sm1451885edr.60.2022.07.14.10.57.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jul 2022 10:57:32 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH v2] arm64: dts: rockchip: Fix SD card init on
 rk3399-nanopi4
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
In-Reply-To: <5ca9bd94-54d9-04f8-0098-a56ffb6f5fe1@arm.com>
Date:   Thu, 14 Jul 2022 19:57:31 +0200
Cc:     Markus Reichl <m.reichl@fivetechno.de>,
        =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3DC86B72-41E7-47C2-8401-D511B8818972@kohlschutter.com>
References: <C639AD88-77A1-4485-BAEA-2FF8FC15A844@kohlschutter.com>
 <12878108.O9o76ZdvQC@diego> <103b714c-b07c-f016-1062-84bd94786b22@arm.com>
 <9AF1E75F-5947-49B0-887D-82C426527B99@kohlschutter.com>
 <590f7a08-a6ca-be54-4254-363343642a52@arm.com>
 <A6B896E5-CD25-4441-B6A5-0BE1FA284B2C@kohlschutter.com>
 <A9634366-A012-43D2-B253-8BB9BF6005C7@kohlschutter.com>
 <CAGb2v65Ehbu1wrib2CzF1fDZuD3fHZQDhKfVusyUF9KnxTvi+Q@mail.gmail.com>
 <5ca9bd94-54d9-04f8-0098-a56ffb6f5fe1@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>, wens@kernel.org
X-Mailer: Apple Mail (2.3696.100.31)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Am 14.07.2022 um 19:35 schrieb Robin Murphy <robin.murphy@arm.com>:
>=20
> On 14/07/2022 6:02 pm, Chen-Yu Tsai wrote:
>> On Fri, Jul 15, 2022 at 12:27 AM Christian Kohlsch=C3=BCtter
>> <christian@kohlschutter.com> wrote:
>>>=20
>>> mmc/SD-card initialization may fail on NanoPi r4s with
>>> "mmc1: problem reading SD Status register" /
>>> "mmc1: error -110 whilst initialising SD card"
>>>=20
>>> Moreover, rebooting would also sometimes hang.
>>>=20
>>> This is caused by the gpio entry for the vcc3v0-sd regulator;
>>> even though it appears to be the correct GPIO pin, the presence
>>> of the binding causes these errors.
>>>=20
>>> Fix the regulator to drop the gpio binding and add a comment
>>> to prevent accidental reintroduction of that entry.
>>>=20
>>> Signed-off-by: Christian Kohlsch=C3=BCtter =
<christian@kohlschutter.com>
>>> ---
>>>  arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>=20
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi =
b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
>>> index 8c0ff6c96e03..d5f8a62e01be 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
>>> @@ -67,7 +67,7 @@ vcc1v8_s3: vcc1v8-s3 {
>>>         vcc3v0_sd: vcc3v0-sd {
>>>                 compatible =3D "regulator-fixed";
>>>                 enable-active-high;
>>> -               gpio =3D <&gpio0 RK_PA1 GPIO_ACTIVE_HIGH>;
>>> +               // gpio =3D <&gpio0 RK_PA1 GPIO_ACTIVE_HIGH>; // =
breaks SDHC card support
>> This change only means that the regulator no longer gets cycled when
>> it probes. It's not a proper fix. You're leaving the kernel without
>> any control over SD card power, and with whatever state the =
bootloader
>> left the GPIO in. If the bootloader left the GPIO low, then you don't
>> get to use the SD card, ever.

This is the current situation in the mainline kernel =
(regulator-always-on is there and unchanged), but yes, you are correct =
that's a bug.

See below for my results with your proposed changes.

>> It cycles because of the lack of regulator-boot-on, so the driver
>> requests the GPIO with initial low state, and then drives it
>> high to enable the regulator.
>=20
> Hmm, that's a good point - by the time we get to Linux, we should have =
control over the VCC_SDIO regulator and the I/O domain as well, so a =
full clean reset should really be no problem :/
>=20
> The "Tinkerboard problem" I was thinking of is when the SD card is the =
boot medium, VCC_SDIO stays at 1.8V over a reboot but the I/O domain =
gets reset back to 3.3V mode, thus cannot see a logic high on any of the =
I/O lines, thus the boot ROM gives up after failing to detect the card. =
If we're still able to boot as far as Linux, it's probably a different =
thing. Apologies for the confusion.

I believe it's that problem you describe.

In my case, I boot off the mmc card with u-boot mainline v2022.07, which =
invokes IPXE that boots the kernel (5.18.10 mainline) + =
rk3399-nanopi-r4s dtb over the network.=20
This lets me quickly test kernel changes without juggling sd-cards.

>=20
>>>                 pinctrl-names =3D "default";
>>>                 pinctrl-0 =3D <&sdmmc0_pwr_h>;
>>>                 regulator-always-on;
>> I think dropping "regulator-always-on" so that Linux can cycle power
>> and properly reset the SD card is the proper fix to the card being
>> stuck in UHS and not responding.
>> Also, the regulator used is RT9193, according to the schematics. That
>> chip has an enable delay under 50 micro-seconds. If that needs to be
>> modeled, then add regulator-enable-ramp-delay.
>=20
> Indeed, if it's a slow regulator and we're simply trying to probe the =
card too soon before its supply voltage has actually stabilised, that =
sounds entirely plausible, particularly if the failure is only =
intermittent.

With
> gpio =3D <&gpio0 RK_PA1 GPIO_ACTIVE_HIGH>;
> // regulator-always-on;
> regulator-enable-ramp-delay =3D <50>;
I'm still not getting the reset going. It looks the MMC gets detected =
reliably upon cold start, but I cannot test reboot/warm start.

It looks like there's one issue upon start (which MAY be fixed by these =
changes), but there's another issue upon restart ("suspend" in device =
tree lingo?).
I tried both

> regulator-state-mem {
>         regulator-off-in-suspend;
> };   =20
and
> regulator-state-mem {
>         regulator-on-in-suspend;
> };
to no avail (no difference; reboot still hangs).

What are we missing?

Best,
Christian

