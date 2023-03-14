Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF62C74A44
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Mar 2023 07:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjCNH2a (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Mar 2023 03:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjCNH21 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Mar 2023 03:28:27 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABF811157
        for <linux-mmc@vger.kernel.org>; Tue, 14 Mar 2023 00:28:22 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id c4so9146368pfl.0
        for <linux-mmc@vger.kernel.org>; Tue, 14 Mar 2023 00:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678778902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zrI9sVCqqmiSpcdBkCHHv05oCLBJ25Dqqg/e/HY1PE=;
        b=C9Ey32sJTJaASu+z/1FyslqsbfnyNdmJUNUB6+oB2OmmFLHW3TXdFt4/QmkDEnPkXd
         J+oc1JqjQ8+RGLMBczqsDWq8yStl1QMxo29VJMhOqitTFiKyguQUDPIIasYjKO17wHtT
         ng8Vb3hQv4v493VlrtpS5Bl24vFIuA7GnsgJts+pUOY/YGNteg6pBDhmx6ob8nHqvrTc
         aTsaVCGKF4NRp1KsEXNOuw+ii/VCp08zCDb5Qzz7Cx1Tea++NbjUycXOEphG27a5Hx4u
         K6rD7s+ZuEbs4YHjEVgPqBSYxTWJ6abqoQQ5oeQktZjIjVT6HK9Iqwt6DgFmDgHWCydb
         pk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678778902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2zrI9sVCqqmiSpcdBkCHHv05oCLBJ25Dqqg/e/HY1PE=;
        b=L1nhSXZBIiss9iqspVmFnpp9dbZcWK8GV/A4ZaC25kcyZc5QnKU7T1LjdK62HCGWTH
         XS8fmB6l8JPrHdSoVfSY7pSZrwCNr7fFmfwhlksEfHU1B9kqge0qnYfngSoeVhNHzHo/
         jWyVZ0l5clbux79bOZInXma+b8Lh+8c6yeu85VZPAYbixE7S7LAI5NtO76+0ggbx0nfL
         Tt1DrRZL0etj0IRqzrE//RoHBT9k6KZOU6w6Dnay1g93GxyI0pBMU271T2FhMldSsDQN
         qH5nXsI4t98obBcC9bl9j4jX7q9RBZFev6dGKnwCY2rI2H9+TxTf+PJslIljZ5hcdyB6
         NxSQ==
X-Gm-Message-State: AO0yUKVzpm64vo5UndnCwwzXvcxjC8xhuRBfgEmRwUYOd8S39TpsIL7W
        N9Z7u9OLx/RTrn6iTcsTB5PV+HjMICytOWTFF+E4PQ==
X-Google-Smtp-Source: AK7set/ymRCuQVVjd2YSJZ2ksOxjN0aMC8SJdN2Byssx3rCYzgon3Q33ArJQyLMI7amWxCU0riaxj2d7lDIOIcFTf1A=
X-Received: by 2002:a63:7d03:0:b0:503:a268:b81e with SMTP id
 y3-20020a637d03000000b00503a268b81emr12895598pgc.5.1678778901900; Tue, 14 Mar
 2023 00:28:21 -0700 (PDT)
MIME-Version: 1.0
References: <05977cbb-8a8f-0a67-b4bd-b265dbb83280@free.fr> <895a3812-e490-cc40-0f8e-a88e166e8f24@linaro.org>
 <c1a215cf-94be-871b-2a8a-3cc381588f83@free.fr> <13676dcc-944f-cf3d-8adf-ee3d4e8fa699@free.fr>
 <e5baf73b-3b9d-1011-2ed9-4b6fc7ee644f@free.fr> <CAPDyKFoAT-jMkYb7=m--q_eEb2xxH-VPQy5vaHNvw4s=WiAeCg@mail.gmail.com>
 <0450e34e-7190-104c-832a-150f15f7c825@free.fr> <3d91a067-c9c3-6d71-11a7-1289ea67f109@free.fr>
 <eecb86be-81e3-09cd-8ec7-4e77c42f2795@free.fr> <CAFBinCDHRhLSyFsEv7cdhSgZorj-TdR3HhqSBnAQcUtEsecV=Q@mail.gmail.com>
 <6ac1ecb1-eba4-b0a3-579c-afcbe532a474@free.fr>
In-Reply-To: <6ac1ecb1-eba4-b0a3-579c-afcbe532a474@free.fr>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 Mar 2023 08:27:45 +0100
Message-ID: <CAPDyKFrC3a5-VP2DvCYGYUzKtX4Jc7cvNQOKfutW0sha=szOyg@mail.gmail.com>
Subject: Re: [RFC PATCH] brcmfmac: add 43751 SDIO ids and initialization
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Alexander Prutskov <alep@cypress.com>,
        Joseph chuang <jiac@cypress.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Angus Ainslie <angus@akkea.ca>,
        Pierre-Hugues Husson <phh@phh.me>,
        linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 13 Mar 2023 at 22:42, Marc Gonzalez <marc.w.gonzalez@free.fr> wrote=
:
>
> On 13/03/2023 21:04, Martin Blumenstingl wrote:
>
> > On Mon, Mar 13, 2023 at 6:09=E2=80=AFPM Marc Gonzalez wrote:
> > [...]
> >> QUESTION:
> >> It's not clear to me why we sleep twice for host->ios.power_delay_ms?
> >
> > I'm not sure but I think host->ios.power_delay_ms is independent from
> > the post-power-on-delay-ms property of "mmc-pwrseq-simple".
>
> They are distinct indeed (the props have the same name & similar purpose =
though).

Correct.

>
> host->ios.power_delay_ms is set via:
>
> drivers/mmc/core/host.c:        device_property_read_u32(dev, "post-power=
-on-delay-ms",

This is a property that may be specified in the host's OF node. See
Documentation/devicetree/bindings/mmc/mmc-controller.yaml.

> drivers/mmc/core/host.c-                                 &host->ios.power=
_delay_ms);

Note that the default value is set to 10 ms, in mmc_alloc_host(). So,
if you need a different value, that can be specified in DT.

>
>
> pwrseq->post_power_on_delay_ms is set via:
>
> drivers/mmc/core/pwrseq_simple.c:       device_property_read_u32(dev, "po=
st-power-on-delay-ms",

This is a property that may be specified in the pwrseq OF node. See
Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml.

> drivers/mmc/core/pwrseq_simple.c-                                &pwrseq-=
>post_power_on_delay_ms);
>
>
> However, they are both used to delay mmc_power_up(),
> and the host delay is used to sleep twice, which I
> found confusing ;)

It's certainly a bit hairy to follow, but I think you have understood
things correctly.

>
> Regards
>

Looks like you are getting closer to the solution, at least for the
first step to make sure the SDIO card is getting detected properly.
Nice!

Kind regards
Uffe
