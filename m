Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7583AC77B7C
	for <linux-mmc@archiver.kernel.org>; Wed, 10 May 2023 20:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjEJUUn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 10 May 2023 16:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjEJUUm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 10 May 2023 16:20:42 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E353ABA
        for <linux-mmc@vger.kernel.org>; Wed, 10 May 2023 13:20:40 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-959a3e2dd27so1364716666b.3
        for <linux-mmc@vger.kernel.org>; Wed, 10 May 2023 13:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683750039; x=1686342039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAFo2QD9kP26+xLj7IQr31EYTyjtIOLhJ8ql3Ihcx00=;
        b=jxsmsS+gHVUJhyrdUSU1l6POO30DFjZvAUNL7ax2bs6B5GU/IFC6aC0LnwQX5zkrsx
         W/Nq0Z94IY3UyyadUsWpZDyLAaoy6pShR7AuyoznoXCXHVN5UKu4x+ioQKDdITW2GNPc
         am7MyjesHZcpOOaqtnKHkUegZ067hpj3saeOs31fcyOy4bdkWEEsFgtU21ZKYafg6bA2
         KL8lx28r5i1xZKrEjTbNYpjGDQmvISJNTGbQ9JKIjCUdI4ga/FhA03iXfRBXYhJnyvhj
         HEK+xU8GfzC47XnMA/+qWhX9uFByXx9EpBqLKRtLLQzwoEAruSlpkbA2YDasiHGldroa
         YHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683750039; x=1686342039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OAFo2QD9kP26+xLj7IQr31EYTyjtIOLhJ8ql3Ihcx00=;
        b=BF5tVDnKChHx7BzFrHEwimhmtmL3LPxmuRA+icKH+IlyZknpxf9niHzbGi1+lZWNlg
         2Q4M3P+xzWOVBLGDKC+0QLV6lCdZXw18JLmY2gf2dmPamRLN8mXpG3QMvTsKlx1zxXWc
         vIBcoZCFw4i+6wHfb1kfOHIIvy9NfTcSo9qzYmgr9hOSDOQsRjXRsmkAZh9GeO1uyuaC
         aSDsroTmnR3/naPEYPcOMnu39a1zkUMYDiqEVB5C9AIxG2o/8eEdV97ZvmJOfptt4p3A
         naOMmf4igReayoTLxYBZzrWXGpSmRdi9jyQPr37NuW8qpRsGrCFdsV7FB7jIX9XT36+8
         44LQ==
X-Gm-Message-State: AC+VfDwX2d9e5NzpSChODE/Y77J9qluDnAgZkZ+y77H07Hwq7Eyvo/2n
        HzS53r7AkPhmWFfdisWAMZ1hGJkdCDJhHd5Wlow=
X-Google-Smtp-Source: ACHHUZ6ZV3iLr3PUKpv3GxOStpEC4A5BOulRxZkBK+cDqBdXIdfnSBRtdzFLtvH4Qa3W8mSFyCCg+/4QeyJCLh7yU4g=
X-Received: by 2002:a17:907:e8b:b0:94f:764e:e310 with SMTP id
 ho11-20020a1709070e8b00b0094f764ee310mr19539753ejc.37.1683750038942; Wed, 10
 May 2023 13:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230510-mmc-sdhci-msm-function-cast-v1-1-5ae634b24fbd@kernel.org>
In-Reply-To: <20230510-mmc-sdhci-msm-function-cast-v1-1-5ae634b24fbd@kernel.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 10 May 2023 22:20:28 +0200
Message-ID: <CAFBinCBjvfNHUX5X=4jJ0Gtx1Z9MABMv7FioEabjvtbkOrTEkQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-mx-sdhc: Avoid cast to incompatible function type
To:     Simon Horman <horms@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, May 10, 2023 at 2:39=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> Rather than casting mmc_free_host to an incompatible function type,
> provide a trivial wrapper with the correct signature for the use-case.
>
> Reported by clang-16 with W=3D1:
>
>  .../meson-mx-sdhc-mmc.c:791:38: error: cast from 'void (*)(struct mmc_ho=
st *)' to 'void (*)(void *)' converts to incompatible function type [-Werro=
r,-Wcast-function-type-strict]
>          ret =3D devm_add_action_or_reset(dev, (void(*)(void *))mmc_free_=
host,
>                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
>  ./include/linux/device.h:265:38: note: expanded from macro 'devm_add_act=
ion_or_reset'
>          __devm_add_action_or_reset(release, action, data, #action)
>                                             ^~~~~~
>
> The same approach is taken in litex_mmc.c with the function
> litex_mmc_free_host_wrapper(). There may be scope for consolidation.
>
> No functional change intended.
> Compile tested only.
>
> Signed-off-by: Simon Horman <horms@kernel.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
