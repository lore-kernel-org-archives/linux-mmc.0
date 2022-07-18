Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79134C433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 18 Jul 2022 20:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbiGRU7L (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 Jul 2022 16:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236188AbiGRU7I (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jul 2022 16:59:08 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF65DEFD
        for <linux-mmc@vger.kernel.org>; Mon, 18 Jul 2022 13:59:07 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id z23so23562966eju.8
        for <linux-mmc@vger.kernel.org>; Mon, 18 Jul 2022 13:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=from:content-transfer-encoding:mime-version:subject:date:references
         :to:in-reply-to:message-id;
        bh=G4xt1tsCAE5v1aPuO5mOncHkPCmfTeAk54UxkIc2Qmo=;
        b=aZZxh1rhvlV3iS5yeU8mQplf8hQFrCKIoPgu4ncOEANuQNQ2S1+jZVJSYliXp3IZZ7
         f4bmNDrHEYEKmqnJ77+sCdX769dLBdO32ogqumghD9tv9lRmIGBQ/3R/975HzecAD1SE
         IQUdoGRzZCS/brdX93651zSNgJNc0i/wmT8gGL/OwvZ/R8usWYb7M14KTC0Sbc5x0O/H
         Z7I3DgirWW0Rzsbh5tAfFofYBXmrCUg9ahFQUF35wcMctolakdIc4iRKKRQF3dLixdkw
         /hsy3QeG0XgwIZD0MLxKIaTHOx8z1hf6dn/SRvezJj2n3xvek+8EYFKm6sPXgeepEgLK
         StGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:date:references:to:in-reply-to:message-id;
        bh=G4xt1tsCAE5v1aPuO5mOncHkPCmfTeAk54UxkIc2Qmo=;
        b=TWJkUb1u798mNmv/+UkA7wmNtDV9b4LnfnSjrbhkzUls5aprO9TmsxlTEXa5mBDluW
         otU5z3ZN2JC9fbwHYFDRgk2/E0pDXDJjFWujg3u0v1aY3D6ARnN/5snVSvj0pSCIsQue
         nCVvPHzU9i5QiA0BjqwLTYzNRCkIylxMsv9mVJ9jpv7cOTYhJXuCk6UtXepDbc9OCM31
         htAUZzR+IyCOSuS+7vWCiw0YkEC49hjwCq8cTjUjFv62wYr57rYbQQvZkf27QzDAKSDC
         Cc8Vhc0q9Rqq2BsGZiS/OE4asSbTtxwb55uT6W7ewDO3LPKGbh0f4rQwjgZXzGL9iVVM
         y/xA==
X-Gm-Message-State: AJIora/3FtT7IWGfGhyiAEvBdTzuDA7rTJRZ+DCeyXsx40fnWEdOBOTe
        SdYT5tAquI4j8zS3ON2oR8/mOEOXedyK7Lwq
X-Google-Smtp-Source: AGRyM1tVB4vvb5f/bKXAFwDhyy9bAciaV/Gd3r6IsQlbV9u1J3/xCyjaIxTW/riej87bVuuJQTaAPw==
X-Received: by 2002:a17:907:2c75:b0:72b:3431:2a0a with SMTP id ib21-20020a1709072c7500b0072b34312a0amr27796230ejc.234.1658177945709;
        Mon, 18 Jul 2022 13:59:05 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id n9-20020a17090695c900b006f3ef214ddesm5814209ejy.68.2022.07.18.13.59.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jul 2022 13:59:04 -0700 (PDT)
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH v2] arm64: dts: rockchip: rk3399-nanopi4: Fix voltage
 regulator config
Date:   Mon, 18 Jul 2022 22:59:03 +0200
References: <963AF33B-54B7-4172-92D1-E2898E256A7E@kohlschutter.com>
 <14EE0603-99C5-49AE-BDDB-C22C5B1924E2@kohlschutter.com>
 <7AFECB02-5A87-43DD-8161-6068720AB8E3@kohlschutter.com>
To:     Robin Murphy <robin.murphy@arm.com>, wens@kernel.org,
        =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Markus Reichl <m.reichl@fivetechno.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
In-Reply-To: <7AFECB02-5A87-43DD-8161-6068720AB8E3@kohlschutter.com>
Message-Id: <C8ED2EFC-A7D5-418D-A7D9-E1D37B5BECFD@kohlschutter.com>
X-Mailer: Apple Mail (2.3696.100.31)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Am 18.07.2022 um 14:02 schrieb Christian Kohlsch=C3=BCtter =
<christian@kohlschutter.com>:
>>=20
>> A series of issues exist around the "vcc3v0_sd" voltage regulator =
that
>> made it necessary to mark it "always-on".
>>=20
>> With the patch "regulator: core: Resolve supply name earlier to =
prevent
>> double-init", this option is no longer necessary.
>> ...
>=20
> Walking back on my claim in the commit message that no further patches =
are needed for the u-boot integration to work.
> Other than that, the actual patch is unchanged.

This change (removing regulator-always-on) doesn't work reliably; please =
disregard for now.

