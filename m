Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7FBC43334
	for <linux-mmc@archiver.kernel.org>; Mon, 18 Jul 2022 12:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbiGRMEg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 Jul 2022 08:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbiGRMEf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jul 2022 08:04:35 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B64DCE11
        for <linux-mmc@vger.kernel.org>; Mon, 18 Jul 2022 05:04:34 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id tk8so9425119ejc.7
        for <linux-mmc@vger.kernel.org>; Mon, 18 Jul 2022 05:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=from:content-transfer-encoding:mime-version:subject:date:references
         :to:in-reply-to:message-id;
        bh=PQ4rIL+dXxSoAf2L0QQkIcDArwZfdbAiRX/9Z9IDwAw=;
        b=dr8niMg/x9uzV0DOsVncE9RkhT1oLr5LE0woFvKhtJ45utWsNlJnyZ/8DTL+kBmYVc
         LcBOcGwzSlhjgw0BS1N2Be/+xR+0sD/1ccVATUv/ntkZ/t8gC7vGoG6pCmQeeh7/N0AR
         5050cBbIH78lYFq5F0xJBYqyo0XmgaI8x/al1bhu9EDHSi5hDqq7+iezJ+4YCCItM/9Q
         VIK15dubVZb6YSdGmdOwO/WLsyyfi1oiqOi/I8YQx5BkNX4K9dO4afPIGOXiq2XzIpVv
         RcEdogrJE7WMtu8hwTuuxewAB85SB3hUOCCzviAzaaGRQClJT8dbhQ88asS7735HCsKC
         PvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:date:references:to:in-reply-to:message-id;
        bh=PQ4rIL+dXxSoAf2L0QQkIcDArwZfdbAiRX/9Z9IDwAw=;
        b=0LTNjiIFXsFCctSpHOGZnYSDrPoD8SiRSGsqlQzDwS33U+M+6TjS/XAEhOxsP4BzWm
         dmLQ/YsM8m0XGwyPIWv+/dyxuErm+qPMRWqJ5cIX6VGryXsbE27jDxoDhKUC5s+Ou8XZ
         +Yppkt9pQ0fo+xxiT37gxeWz7zmR+wIkOqBq/mzjItZqnfTE0EggiFteUvIYXbF9zlwm
         QQQrrRUcyeRnl4OxTgubDascKx2w+ou5uJXLJ9vwLgdxD3B1b2OnolXtHIJ9B/DNS3qN
         8oyY2pozFyAPZ6wRL88HVslFt48Yrrq5ue+9DPvFtZXztyCGEE/ByYGdxIX9t3R0rlPl
         ++jQ==
X-Gm-Message-State: AJIora/KnQkkkCF/OuaHGtcCJkv4CrCL+XVYz0GINlcNZ6DUL16GpJk1
        Rf/tkXEZo0ROeAC32PIjoJeKFA==
X-Google-Smtp-Source: AGRyM1uWQJUGPqMWpWdlTVf5h7q2TWkLPk6FGThh1XPMLHY9dPNkba2XOHKyvOSAHt30hQyeppF+3g==
X-Received: by 2002:a17:906:6a29:b0:72e:e716:d220 with SMTP id qw41-20020a1709066a2900b0072ee716d220mr17696601ejc.82.1658145872777;
        Mon, 18 Jul 2022 05:04:32 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id mb1-20020a170906eb0100b0072aa38d768esm5430355ejb.64.2022.07.18.05.04.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jul 2022 05:04:32 -0700 (PDT)
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: [PATCH v6] arm64: dts: rockchip: Fix SD card init on rk3399-nanopi4
Date:   Mon, 18 Jul 2022 14:04:31 +0200
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
 <115AD6A4-021B-4879-BFB5-BC7689A0203E@kohlschutter.com>
 <17a4c6f6-d79c-a7b2-860f-e5944b778f9f@arm.com>
 <9405b97a-6758-ad4e-ccff-eed072096539@arm.com>
 <BF7CC548-88C9-4889-8A41-8E99C31EF81C@kohlschutter.com>
 <daf3b61c-d886-98eb-0443-de233d742041@arm.com>
 <CDF716FC-F6CF-44A9-84D9-B48C46E6AC2C@kohlschutter.com>
 <3912A668-9F73-40FD-8993-5060F632238A@kohlschutter.com>
 <7E830C9F-BB5D-4EFC-B3F4-1C580E9326A3@kohlschutter.com>
To:     Robin Murphy <robin.murphy@arm.com>, wens@kernel.org,
        =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Markus Reichl <m.reichl@fivetechno.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
In-Reply-To: <7E830C9F-BB5D-4EFC-B3F4-1C580E9326A3@kohlschutter.com>
Message-Id: <E5A1A1E7-449F-4161-87B9-7A6CA0CAA42C@kohlschutter.com>
X-Mailer: Apple Mail (2.3696.100.31)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

mmc/SD-card initialization may fail on NanoPi R4S with
"mmc1: problem reading SD Status register" /
"mmc1: error -110 whilst initialising SD card"
either on cold boot or after a reboot.

Moreover, the system would also sometimes hang upon reboot.

This is caused by vcc3v0-sd's "regulator-always-on", which triggers
an erroneous double-initialization of the regulator. This causes
voltage fluctuations that can, depending on timing, prevent the
SD card from initializing correctly.

Adding some liberal delay via "off-on-delay-us" is ineffective since
that codepath is skipped as long "regulator-always-on" is set.

Removing "regulator-always-on" alone is not sufficient because that
would allow the system to set GPIO0_A1 to LOW upon reboot, which may
cause the system to hang.

In order to allow the system to set GPIO0_A1 to HIGH upon initialization
but prevent it from changing it back to LOW, this patch increases the
usage count of vcc3v0-sd from 1 to 2, whereas the additional reference,
"vcc1v8_s3", is marked as "always-on", causing permanent retention.

Signed-off-by: Christian Kohlsch=C3=BCtter <christian@kohlschutter.com>
---
arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi | 13 +++++++++++--
1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi =
b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
index 8c0ff6c96e03..38507a6e3046 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
@@ -61,7 +61,17 @@ vcc1v8_s3: vcc1v8-s3 {
		regulator-min-microvolt =3D <1800000>;
		regulator-max-microvolt =3D <1800000>;
		regulator-name =3D "vcc1v8_s3";
-		vin-supply =3D <&vcc_1v8>;
+
+		/*
+		 * Workaround to skip setting gpio0 RK_PA1 to LOW upon =
reboot,
+		 * which may freeze the system.
+		 *
+		 * Adding a reference to vcc3v0_sd increases its =
num_users
+		 * count to 2, preventing deactivation since this =
regulator is
+		 * marked "always-on".
+		 */
+		// vin-supply =3D <&vcc_1v8>; // actual supply
+		vin-supply =3D <&vcc3v0_sd>;
	};

	vcc3v0_sd: vcc3v0-sd {
@@ -70,7 +80,6 @@ vcc3v0_sd: vcc3v0-sd {
		gpio =3D <&gpio0 RK_PA1 GPIO_ACTIVE_HIGH>;
		pinctrl-names =3D "default";
		pinctrl-0 =3D <&sdmmc0_pwr_h>;
-		regulator-always-on;
		regulator-min-microvolt =3D <3000000>;
		regulator-max-microvolt =3D <3000000>;
		regulator-name =3D "vcc3v0_sd";
--=20
2.36.1=
