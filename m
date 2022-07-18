Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DA2C43334
	for <linux-mmc@archiver.kernel.org>; Mon, 18 Jul 2022 12:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiGRMCM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 Jul 2022 08:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234492AbiGRMCL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jul 2022 08:02:11 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EE1237D4
        for <linux-mmc@vger.kernel.org>; Mon, 18 Jul 2022 05:02:10 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id x23-20020a05600c179700b003a30e3e7989so5003088wmo.0
        for <linux-mmc@vger.kernel.org>; Mon, 18 Jul 2022 05:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=from:content-transfer-encoding:mime-version:subject:date:references
         :to:in-reply-to:message-id;
        bh=/Wjhe1Q4ojz7rsMCyD5ctxYAYQynJVyQzOqbmq13x+M=;
        b=VBEN/bhJNUvzckZpVfCiDdHgAK7UigIWSvfal3rwFk/4tpUC4IOIkEAj5G+4goZB6h
         Wt1GdfMgSvRlczraz0wEPEkH1JI6uv0ItpYQti+5E5oBSwJSU2KUmMWIha0Tf9+Q4EH+
         HoJw/Cnl2rlwNMwvUCcXrEPcmcVvKMv4r6OG9DZJZEWevaMj99FBXji3gIa1V1KDQxa/
         OGZxbwDjQcEX77iv70P4fDjJ1jl9CNoN+6pa/+cz9k8AIt+0NK0XlUFfcmZF+H4TtuEx
         ehoPL9VfA52v6hQo5Msl65DUNHwQoywx8ez+UB1MIMNAAh+oLxr54svJD3Tnxn/noiVW
         i6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:date:references:to:in-reply-to:message-id;
        bh=/Wjhe1Q4ojz7rsMCyD5ctxYAYQynJVyQzOqbmq13x+M=;
        b=6D62an+Jm62ASraadpYIAPrgBi2sLC60KVV9bsfaqqdFYMKXGFCKP6n2MVb7wK+7az
         U9Npj9Rt0nldjvKtq0871e92yy8VSBIMq1PUic8lHJ8BLEd+5XTkc9Hw6nOzXnunJQaw
         mTdEf+gQLs1xSTtpXhmPlS6D5bDe9ptAX42/BXgJvxjceHyr3e0AsFZ4JgWCRj+cSaWX
         Yx3HpBaS0Q4jFxy3p9adjU7s8KS5xxCkLAn1ZNPMysQHeLBtf1GBJ1WMpzuyB8nA10VU
         dd7s62RW+2MeOgn3AkcOonS2Gr32qDQKficYLIMqrqAsk+m+gUwg5jkhTjq1i+0EvwXh
         dfTA==
X-Gm-Message-State: AJIora9Tba9zn14N69Ex+M6rn2UONVdIGa17r0wy+U7DfjrLB0cFr6kL
        DS/bzCygl05PCi3wZ162v/Sndw==
X-Google-Smtp-Source: AGRyM1tBFMDGVyuDtUpZDJKZn/k9znCha3K7cNXmOzqGeRLKOzqZjr0gyk4atocyOVVdijeJqID0XQ==
X-Received: by 2002:a05:600c:1f0a:b0:3a3:15a8:a8e1 with SMTP id bd10-20020a05600c1f0a00b003a315a8a8e1mr8485096wmb.167.1658145729122;
        Mon, 18 Jul 2022 05:02:09 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id o3-20020adfeac3000000b0021d6ac977fasm10639696wrn.69.2022.07.18.05.02.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jul 2022 05:02:08 -0700 (PDT)
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: [PATCH v2] arm64: dts: rockchip: rk3399-nanopi4: Fix voltage
 regulator config
Date:   Mon, 18 Jul 2022 14:02:07 +0200
References: <963AF33B-54B7-4172-92D1-E2898E256A7E@kohlschutter.com>
To:     Robin Murphy <robin.murphy@arm.com>, wens@kernel.org,
        =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Markus Reichl <m.reichl@fivetechno.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
In-Reply-To: <963AF33B-54B7-4172-92D1-E2898E256A7E@kohlschutter.com>
Message-Id: <14EE0603-99C5-49AE-BDDB-C22C5B1924E2@kohlschutter.com>
X-Mailer: Apple Mail (2.3696.100.31)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

A series of issues exist around the "vcc3v0_sd" voltage regulator that
made it necessary to mark it "always-on".

With the patch "regulator: core: Resolve supply name earlier to prevent
double-init", this option is no longer necessary.

Signed-off-by: Christian Kohlsch=C3=BCtter <christian@kohlschutter.com>
---
arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi | 1 -
1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi =
b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
index 8c0ff6c96e03..55b93eac2f99 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
@@ -70,7 +70,6 @@ vcc3v0_sd: vcc3v0-sd {
		gpio =3D <&gpio0 RK_PA1 GPIO_ACTIVE_HIGH>;
		pinctrl-names =3D "default";
		pinctrl-0 =3D <&sdmmc0_pwr_h>;
-		regulator-always-on;
		regulator-min-microvolt =3D <3000000>;
		regulator-max-microvolt =3D <3000000>;
		regulator-name =3D "vcc3v0_sd";
--=20
2.36.1

