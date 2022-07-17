Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0F4C433EF
	for <linux-mmc@archiver.kernel.org>; Sun, 17 Jul 2022 19:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiGQT3H (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 17 Jul 2022 15:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiGQT3G (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 17 Jul 2022 15:29:06 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FA010561
        for <linux-mmc@vger.kernel.org>; Sun, 17 Jul 2022 12:29:05 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id m13so2607367edc.5
        for <linux-mmc@vger.kernel.org>; Sun, 17 Jul 2022 12:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=xXctcMyuUmlawA3nFYo56xgNoTbeCn1PRUaqrpg5K6E=;
        b=ZpSFJBjLczjzFvqWi4xf6rD2u41QbN6ixUWvq4q5pvigNainMwifZSgf75VyxrlPAf
         sQgXbaMvxeNjQaJWdiMJetC17XtmkeuTf2mKXLFKa54rSGwY0+8uff0tn4nHEilysL6f
         VyjRfO2Sx7diYK5Ps4+ch4/83peRJzMKXy5zHVWFjT0TdnRigeEPGU1KZHm+NxG32ucC
         zxeCoo0+GSlrw+DvexE3T3InHv6l7W9b/5NnAS7Xa4nfY1YsLILXclbpHRVRm29kA72w
         OOdFi7tuHFTa9us2m+oJV93aABLzwTRNXNkjn2QpYiJ3uQhTDysv0L1nS04zf+3ZFJC+
         aPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=xXctcMyuUmlawA3nFYo56xgNoTbeCn1PRUaqrpg5K6E=;
        b=gzYPwAIGrAfno8z6ZlWBZ4HNgvd4u4MMG7pCh4rP++VDfqetOAoTFcGRqGOkIVUEXM
         RuP7kPT6uQvNthwaZ/vZnPX5qVK7M64B8mTPkNLYMawFEWvcWnq5qpM/JrRrcxr5d6pd
         0oFL9j9O1g/gvO5trmbcb3ePypXaiMFDa0/Dw2yU/z/y2VLCthPRGu+H0D0YnDsHsWVC
         q3e8FK8801Oz4sQmPyvyv/ilXt1mNEs7TugOrXewgvG0S+BnLuc/Vvh2AXoHO7etiJwf
         gfjVvRGH9HIYRRxscqDgZXTiXCAiQnewwXgirvmJ5wVfl6v3opQ+plXRtlhPtHYQW2BW
         gxlA==
X-Gm-Message-State: AJIora9kKBfyu3dl4RvqQvSnG+e6JynZC5lgxYvd5AQnaECt1mgCerGf
        Vusm4HMNVsjwBKoYFEkvvcNV5w==
X-Google-Smtp-Source: AGRyM1vFPngnTHOdEyGGe9wlwswHpg+d4JNRLJTxJLUUakuz8oH/gNyvv0Ar9Ezb/ipbBjAMqefHVA==
X-Received: by 2002:aa7:cac7:0:b0:43a:c5ba:24a6 with SMTP id l7-20020aa7cac7000000b0043ac5ba24a6mr32372348edt.84.1658086144315;
        Sun, 17 Jul 2022 12:29:04 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id lc10-20020a170906f90a00b0070efa110afcsm4676844ejb.83.2022.07.17.12.29.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jul 2022 12:29:03 -0700 (PDT)
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: [PATCH] arm64: dts: rockchip: rk3399-nanopi4: Fix voltage regulator
 config
Message-Id: <963AF33B-54B7-4172-92D1-E2898E256A7E@kohlschutter.com>
Date:   Sun, 17 Jul 2022 21:29:01 +0200
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>, wens@kernel.org,
        =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Markus Reichl <m.reichl@fivetechno.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.3696.100.31)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

A series of issues exist around the "vcc3v0_sd" voltage regulator that
made it necessary to mark it "always-on".

With the patch "regulator: core: Resolve supply name earlier to prevent
double-init", this option is no longer necessary.

Removing this option not only prevents a hang when rebooting Nanopi R4S,
it also ensures that bootloaders like u-boot can boot from an SD card
right away, without out-of-tree patches that re-initialize voltage =
levels.

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


