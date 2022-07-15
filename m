Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C29C43334
	for <linux-mmc@archiver.kernel.org>; Fri, 15 Jul 2022 17:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbiGORQm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 15 Jul 2022 13:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiGORQl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Jul 2022 13:16:41 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE474333F
        for <linux-mmc@vger.kernel.org>; Fri, 15 Jul 2022 10:16:23 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id dn9so10078936ejc.7
        for <linux-mmc@vger.kernel.org>; Fri, 15 Jul 2022 10:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=k9mYwQ4GZm0yX1uaonHMP1HNEcS1yGmWnGbQClcs4i0=;
        b=zFID5lvPR8/gCoMoKCKoy9rjEMsXVDH8styUKWjnB9OpkSx33TYhV9J4WZFvM6fW0U
         wi0Ki8iHWle+06SAd9C4E9SZqG3ioGoMmc2kbEdZV5HF74a0OWFlipC+4UM1jyL+gUtC
         mtZnctRxLTV1Red2PjGsuYaHdlmGnt/+V05EwivTqBK+p6sbIS37C2IPpCKdmXeCW1O0
         K2BlX8dvQesrp01srzrt1e8J85tnylx45T0fS+ntK8EblgVMsa+F/sdMGcL5Q+PufqSk
         K6DlfaDLk2TnQRjL/AN1wp2Zi/h6s5L23r61AaWV86P3f/84bf96pOiCEtEFmn1REXtO
         IfAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=k9mYwQ4GZm0yX1uaonHMP1HNEcS1yGmWnGbQClcs4i0=;
        b=2PhtCSQBmSwy4K5D7q91CShRHIZtXMPCP6E6H4cv5bLpzixLOzMphml5ECt1zD0FFw
         +QvlFgcU3nqraIZUBEQkoNRAY572YL5ofAMKvn0EYR1bLCyDDJeo9ugxCFLhsJo3aXqk
         pjPQf2VWkc4dak96J+mjRx6Hu3lC7a43BaA2mdwQ8T9apWIafAbzXd4KcluTyrKxhUK5
         sDXf1/XWF40Hb5kWNjdhzqtsXjyOL7LZwhaVPvPczGGepQ7PP2A3DCEQVX9M7sQ3Fy7s
         i2HL/8+pxXytpSM6/8EPwb6YOIm+fKkNcDrM1SqCiymvX9F4RY9EszXeXk5C0PN5DncN
         iSrw==
X-Gm-Message-State: AJIora+RvRut/mkarT6hcdGCTRACxZp/5qoXQ0sVqnMJWhdHYZjonLRz
        pAYrJ0rWPMLCN+ubwx62DuqjCQ==
X-Google-Smtp-Source: AGRyM1uWNXum1+XVv8QGfp0x8H8XzhBoBjU8AmosT0BHbLLPoFKM6gMxNHYuTmTumVbYDj6ukgHArw==
X-Received: by 2002:a17:906:6545:b0:722:7c99:1ad7 with SMTP id u5-20020a170906654500b007227c991ad7mr14438736ejn.325.1657905381857;
        Fri, 15 Jul 2022 10:16:21 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id j17-20020a17090623f100b0072a55ec6f3bsm2259246ejg.165.2022.07.15.10.16.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jul 2022 10:16:21 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH v4] arm64: dts: rockchip: Fix SD card init on
 rk3399-nanopi4
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
In-Reply-To: <73F9AED0-D2A8-4294-B6E1-1B92D2A36529@kohlschutter.com>
Date:   Fri, 15 Jul 2022 19:16:20 +0200
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <115AD6A4-021B-4879-BFB5-BC7689A0203E@kohlschutter.com>
References: <C639AD88-77A1-4485-BAEA-2FF8FC15A844@kohlschutter.com>
 <12878108.O9o76ZdvQC@diego> <103b714c-b07c-f016-1062-84bd94786b22@arm.com>
 <9AF1E75F-5947-49B0-887D-82C426527B99@kohlschutter.com>
 <590f7a08-a6ca-be54-4254-363343642a52@arm.com>
 <A6B896E5-CD25-4441-B6A5-0BE1FA284B2C@kohlschutter.com>
 <A9634366-A012-43D2-B253-8BB9BF6005C7@kohlschutter.com>
 <CAGb2v65Ehbu1wrib2CzF1fDZuD3fHZQDhKfVusyUF9KnxTvi+Q@mail.gmail.com>
 <5ca9bd94-54d9-04f8-0098-a56ffb6f5fe1@arm.com>
 <502b3fbe-3077-407e-6010-a8cb3ffce7d6@arm.com>
 <449292CA-CE60-4B90-90F7-295FBFEAB3F8@kohlschutter.com>
 <73F9AED0-D2A8-4294-B6E1-1B92D2A36529@kohlschutter.com>
To:     Robin Murphy <robin.murphy@arm.com>, wens@kernel.org,
        =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Markus Reichl <m.reichl@fivetechno.de>
X-Mailer: Apple Mail (2.3696.100.31)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

OK, this took me a while to figure out.

When no undervoltage limit is configured, I can reliably trigger the =
initialization bug upon boot.
When the limit is set to 3.0V, it rarely occurs, but just after I send =
the v3 patch, I was able to reproduce...

> Am 15.07.2022 um 19:12 schrieb Christian Kohlsch=C3=BCtter =
<christian@kohlschutter.com>:
>=20
> mmc/SD-card initialization may fail on NanoPi R4S with
> "mmc1: problem reading SD Status register" /
> "mmc1: error -110 whilst initialising SD card"
> either on cold boot or after a reboot.
>=20
> Moreover, the system would also sometimes hang upon reboot.
>=20
> This is prevented by setting an explicit undervoltage protection limit
> for the SD-card-specific vcc3v0_sd voltage regulator.
>=20
> Set the undervoltage protection limit to 2.7V, which is the minimum
> permissible SD card operating voltage.
>=20
> Signed-off-by: Christian Kohlsch=C3=BCtter =
<christian@kohlschutter.com>
> ---
> arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi | 4 ++++
> 1 file changed, 4 insertions(+)
> mode change 100644 =3D> 100755 =
arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi =
b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
> old mode 100644
> new mode 100755
> index 8c0ff6c96e03..669c74ce4d13
> --- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
> @@ -73,6 +73,10 @@ vcc3v0_sd: vcc3v0-sd {
> 		regulator-always-on;
> 		regulator-min-microvolt =3D <3000000>;
> 		regulator-max-microvolt =3D <3000000>;
> +
> +		// must be configured or SD card may fail to initialize =
occasionally
> +		regulator-uv-protection-microvolt =3D <2700000>;
> +
> 		regulator-name =3D "vcc3v0_sd";
> 		vin-supply =3D <&vcc3v3_sys>;
> 	};
> --=20
> 2.36.1

