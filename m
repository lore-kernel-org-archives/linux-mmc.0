Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A59C43334
	for <linux-mmc@archiver.kernel.org>; Fri, 15 Jul 2022 17:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiGORMd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 15 Jul 2022 13:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiGORMc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Jul 2022 13:12:32 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271576173F
        for <linux-mmc@vger.kernel.org>; Fri, 15 Jul 2022 10:12:14 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y4so7121338edc.4
        for <linux-mmc@vger.kernel.org>; Fri, 15 Jul 2022 10:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KXfsOmRJt+ko9q2xCFE2u/0piZsS+7uuoZliHVGfwJQ=;
        b=JrUCiOaL0g8EZjc7wwNGSWCtN8AoXNWc/FBN+G13zkfhPnZfEyApW41SbcCUJVq6VO
         dR7HcyqrkF58dvkmfAe5ylq+x4m6VpO7NMbfqSSS19cfgNYETRuS3UrwNSOsLk23EDvp
         k1Ux3y42VDgKAghB/G3mnPHggMBKcCQYjJzDEalT18pNvI14L+0dDiBVMOQo1cTafUzf
         fep39I8Wf6WaljcC8DGRHErqfQaFQsMSQHrE7CJH1vANwCMDcKWNXL0wgIYpiD8x97zr
         BnQUicxkYqw/8dfPVegc4muo10PfDYkr1DNLyiuq2VZPfINs4wTMyGy2wPz9QQHw+MHD
         2C7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KXfsOmRJt+ko9q2xCFE2u/0piZsS+7uuoZliHVGfwJQ=;
        b=RQySmnQ1B5D9ZQTaW19mRZ48OKR+IopsmQG/KRSnvgK6RmwKCdwSJ90n2BKHrRus+t
         awDOlBMduAWppsqh5w9RoyqJ89MTdpAIkh2wXUe9qccb6+xWCNxQI46c+qk97GFZA7Me
         +gxzIQZlIyDKkFBLt5iZikhNF8KZtaidslrtYcZCQ8UeUypWljcmKlrJRKmnCSTxHX35
         hsj0XlEUZHu8HN0f6kbYJkPrfN9a9FTL/H2wz3rtDNTgZYHOQKp4tsQg3TSFk0C3kfSu
         cWTpWyjw6C36sNleoGn/kl+msFJsUZN9DGlVPUVWapsRtS8tuDod3tRYK9iKKoNtc+eB
         F2hw==
X-Gm-Message-State: AJIora/ZlZtp0YfgeKcA/tl3W+xxMPINE7YDK7Q+wstwbH0lLU2lX+rn
        Xn0zKllFRvGBpJHQ8eJ/kEcuVw==
X-Google-Smtp-Source: AGRyM1sSLPziXUwYzLmFnukeeceHvDSD/6Jo8MXOHXz40mmUWueDudeIQrT56eXfaH9gWvcZcE3Acw==
X-Received: by 2002:a05:6402:34c1:b0:43a:bd7a:898a with SMTP id w1-20020a05640234c100b0043abd7a898amr20426220edc.426.1657905132673;
        Fri, 15 Jul 2022 10:12:12 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id l5-20020aa7c3c5000000b0043575ae2051sm3179899edr.62.2022.07.15.10.12.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jul 2022 10:12:12 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: [PATCH v4] arm64: dts: rockchip: Fix SD card init on rk3399-nanopi4
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
In-Reply-To: <449292CA-CE60-4B90-90F7-295FBFEAB3F8@kohlschutter.com>
Date:   Fri, 15 Jul 2022 19:12:11 +0200
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <73F9AED0-D2A8-4294-B6E1-1B92D2A36529@kohlschutter.com>
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
To:     Robin Murphy <robin.murphy@arm.com>, wens@kernel.org,
        =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Markus Reichl <m.reichl@fivetechno.de>
X-Mailer: Apple Mail (2.3696.100.31)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

mmc/SD-card initialization may fail on NanoPi R4S with
"mmc1: problem reading SD Status register" /
"mmc1: error -110 whilst initialising SD card"
either on cold boot or after a reboot.

Moreover, the system would also sometimes hang upon reboot.

This is prevented by setting an explicit undervoltage protection limit
for the SD-card-specific vcc3v0_sd voltage regulator.

Set the undervoltage protection limit to 2.7V, which is the minimum
permissible SD card operating voltage.

Signed-off-by: Christian Kohlsch=C3=BCtter <christian@kohlschutter.com>
---
arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi | 4 ++++
1 file changed, 4 insertions(+)
mode change 100644 =3D> 100755 =
arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi =
b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
old mode 100644
new mode 100755
index 8c0ff6c96e03..669c74ce4d13
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
@@ -73,6 +73,10 @@ vcc3v0_sd: vcc3v0-sd {
		regulator-always-on;
		regulator-min-microvolt =3D <3000000>;
		regulator-max-microvolt =3D <3000000>;
+
+		// must be configured or SD card may fail to initialize =
occasionally
+		regulator-uv-protection-microvolt =3D <2700000>;
+
		regulator-name =3D "vcc3v0_sd";
		vin-supply =3D <&vcc3v3_sys>;
	};
--=20
2.36.1=
