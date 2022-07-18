Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F203FC43334
	for <linux-mmc@archiver.kernel.org>; Mon, 18 Jul 2022 12:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbiGRMEJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 Jul 2022 08:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234642AbiGRMEG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jul 2022 08:04:06 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B49FD6
        for <linux-mmc@vger.kernel.org>; Mon, 18 Jul 2022 05:04:05 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id t3so14976754edd.0
        for <linux-mmc@vger.kernel.org>; Mon, 18 Jul 2022 05:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=from:content-transfer-encoding:mime-version:subject:date:references
         :to:in-reply-to:message-id;
        bh=J5dOe3qrpwhe/mTO5TEDOsdj83anttAafBGUgOVvK+c=;
        b=A6LpQRPCboZ1AspzqoN4bdntSlMXB6dfD1lNPLJxeWeGkd6tfVcDUTG4jAzdnKvfxE
         TdLOcLCXKZA2+Nkj/3uZTroMW74hUFtXa6mlQHspaKwyxKx4up/f2zfGJ04zVGTjiTxH
         h8y/01xZFeQJp8sKo9Qjsd3AmqSTCpeCOAk7SmCPmGrZXYHoFGU6UVK9EDCRqSSzjibS
         T66HlPYEjU0eUzMiHvMlVtImH55Se6Avu9zEUDHHWijlmB8oOhmn//JTyNBCHdEn2yOz
         C7+sO41EtK1kpAkoXsu7DXwMc6DA61H/mtSxpNge8L0cfJX2rXb0Rx1UuVNoiUyxt2nM
         CddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:date:references:to:in-reply-to:message-id;
        bh=J5dOe3qrpwhe/mTO5TEDOsdj83anttAafBGUgOVvK+c=;
        b=DLealwSRL5gMC/D1lPWM1mPe78DamccmR8AROAGvUckEMFoQdbxgQV518PizOsVYi/
         488LwJ+RDX5AsvuQ6wMfXWWCFpmryR/pzlyIs2rohBRTPQlksbsyx/r07/E4k5k1Sa75
         CaC44IW5+iC2luAHo3b9NH39d8Km85fYlLnFs12IcjDI4mbGw2Rlv++HeW2vDQwA5k4e
         7SfaOjPkWAd3cu/daE+3zq4vHM5XND70hKdFGJOWjD2zUpNVGC/4i2Uz5lhakVP8ChDd
         798vqzjrraAyNN9z2+4d6LJVjqqQCLtH6Uyu6JEZzk8T6e20HNEjq0EvaMuHCL6RUrwj
         tAcA==
X-Gm-Message-State: AJIora+ksa+Fubf3ttXYeQzOiRjLGrvzf4hzmf+ywVmto5tlNYHv+9ji
        D4JWdS9DzXGxzAtd8oyNotJjlA==
X-Google-Smtp-Source: AGRyM1tMyLWy+XGWgajL31TM0hNIHdtRpK7GdQZ1WaJ0dLa8h4P4f34Y26ViVdXKxkfb34oUe82E8w==
X-Received: by 2002:a05:6402:1e95:b0:437:ce7f:e17a with SMTP id f21-20020a0564021e9500b00437ce7fe17amr35833626edf.169.1658145844061;
        Mon, 18 Jul 2022 05:04:04 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id mb1-20020a170906eb0100b0072aa38d768esm5430355ejb.64.2022.07.18.05.04.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jul 2022 05:04:03 -0700 (PDT)
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH v2] arm64: dts: rockchip: rk3399-nanopi4: Fix voltage
 regulator config
Date:   Mon, 18 Jul 2022 14:04:02 +0200
References: <963AF33B-54B7-4172-92D1-E2898E256A7E@kohlschutter.com>
 <14EE0603-99C5-49AE-BDDB-C22C5B1924E2@kohlschutter.com>
To:     Robin Murphy <robin.murphy@arm.com>, wens@kernel.org,
        =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Markus Reichl <m.reichl@fivetechno.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
In-Reply-To: <14EE0603-99C5-49AE-BDDB-C22C5B1924E2@kohlschutter.com>
Message-Id: <7AFECB02-5A87-43DD-8161-6068720AB8E3@kohlschutter.com>
X-Mailer: Apple Mail (2.3696.100.31)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Am 18.07.2022 um 14:02 schrieb Christian Kohlsch=C3=BCtter =
<christian@kohlschutter.com>:
>=20
> A series of issues exist around the "vcc3v0_sd" voltage regulator that
> made it necessary to mark it "always-on".
>=20
> With the patch "regulator: core: Resolve supply name earlier to =
prevent
> double-init", this option is no longer necessary.
> ...

Walking back on my claim in the commit message that no further patches =
are needed for the u-boot integration to work.
Other than that, the actual patch is unchanged.

