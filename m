Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27A9C6FD1D
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Mar 2023 11:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjCNLKL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Mar 2023 07:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbjCNLJ5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Mar 2023 07:09:57 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705FFCDDB
        for <linux-mmc@vger.kernel.org>; Tue, 14 Mar 2023 04:09:33 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id u3-20020a17090a450300b00239db6d7d47so14747958pjg.4
        for <linux-mmc@vger.kernel.org>; Tue, 14 Mar 2023 04:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678792172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQAiozzsgfoGxDlvyrCg9UpjYhNdzMFc50048gpfD9Y=;
        b=ANUC4vGZDGeomKUX9RdMwGHm9SlX9igqh9scv2CupwN4JAWrfLcY/+jqP/5/TjSa5B
         bKRF07o53l6Bqw+U5ADTeu5XopnqxR9c1/NeOqhGvwtmrhqqbUumpjIW93n6xAPZWwrI
         /P//0k7NoAyPy0sAYwO6rNTHOMU4TNG+ZEhxhYhTq7kRWEoKgplNFI2uZaaxv9SnhrtV
         YYoJWiH2HAwxicVlofMUuwhZ087g0/WabkvU0QFwpbxoeRlLh7rFMbOwgH+xv+hhv/OK
         xLfeKSLqBdODK8huo/wOMomMhQ6O036irhU+LGQKtVbEf7gOHSPudI8kUqr9PavPmQRF
         2WDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678792172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQAiozzsgfoGxDlvyrCg9UpjYhNdzMFc50048gpfD9Y=;
        b=yRJQZ2VNtKZhLBHRNTwM67V45b+KcDUoseLW8Nq5oxG8L4ugchJyZPLgkNnjjPjtlH
         xyyDHxxx41LKxlQMbucCNbEmZlmp15T1Sg/FNRRLILDkg0JAlfqynyTSRhCxA2XXwCUF
         Yla3xf+U3Dc4ckE0rf9Mi7CdJJe+tr8u6FvlUJQN9b9v54EqcXeX3kKswYdssb0kh743
         mKZtcvEEWkFIAGIh+4cIL9GyLqe5YhzrCWOmDxEjHz0wt/HIfAH28FO+e+5uTGQ0KFOX
         +puVWQ+j1QOT4+1uWfZ8Oz/1iyC847bcOoNUNhCpkttGDg06XchrkK8aswsfoIys41cx
         OXKg==
X-Gm-Message-State: AO0yUKXC38MQKrgffpv0Uaql+fLXP+lOdMP3uWMG0zSUIO3iD7ppk9BY
        1EfJ430JtehcWOxwcpRnBASbRH7YcRYWY5Rk3aLyaA==
X-Google-Smtp-Source: AK7set8SoG6+bZSlQ3lAG0t9/aOo3BMF7TfVI/qKa1YUYqwAfpb+sSg8EzKkriYHbUyFmsCPrb2ZqbrscDfcU7B55cA=
X-Received: by 2002:a17:902:ba94:b0:19f:2164:9b3b with SMTP id
 k20-20020a170902ba9400b0019f21649b3bmr4366905pls.13.1678792171819; Tue, 14
 Mar 2023 04:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <05977cbb-8a8f-0a67-b4bd-b265dbb83280@free.fr> <895a3812-e490-cc40-0f8e-a88e166e8f24@linaro.org>
 <c1a215cf-94be-871b-2a8a-3cc381588f83@free.fr> <13676dcc-944f-cf3d-8adf-ee3d4e8fa699@free.fr>
 <e5baf73b-3b9d-1011-2ed9-4b6fc7ee644f@free.fr> <CAPDyKFoAT-jMkYb7=m--q_eEb2xxH-VPQy5vaHNvw4s=WiAeCg@mail.gmail.com>
 <0450e34e-7190-104c-832a-150f15f7c825@free.fr> <3d91a067-c9c3-6d71-11a7-1289ea67f109@free.fr>
 <eecb86be-81e3-09cd-8ec7-4e77c42f2795@free.fr> <CAFBinCDHRhLSyFsEv7cdhSgZorj-TdR3HhqSBnAQcUtEsecV=Q@mail.gmail.com>
 <6ac1ecb1-eba4-b0a3-579c-afcbe532a474@free.fr> <CAPDyKFrC3a5-VP2DvCYGYUzKtX4Jc7cvNQOKfutW0sha=szOyg@mail.gmail.com>
 <c7e48c6f-530b-7198-b8bb-fc927a2fdc66@free.fr>
In-Reply-To: <c7e48c6f-530b-7198-b8bb-fc927a2fdc66@free.fr>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 Mar 2023 12:08:55 +0100
Message-ID: <CAPDyKFpJR9rgadXEBn+73FKgmLM8sZgzNbKV_x_udwOSRGH44Q@mail.gmail.com>
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

On Tue, 14 Mar 2023 at 09:33, Marc Gonzalez <marc.w.gonzalez@free.fr> wrote=
:
>
> On 14/03/2023 08:27, Ulf Hansson wrote:
>
> > On Mon, 13 Mar 2023 at 22:42, Marc Gonzalez wrote:
> >>
> >> On 13/03/2023 21:04, Martin Blumenstingl wrote:
> >>
> >>> On Mon, Mar 13, 2023 at 6:09=E2=80=AFPM Marc Gonzalez wrote:
> >>> [...]
> >>>> QUESTION:
> >>>> It's not clear to me why we sleep twice for host->ios.power_delay_ms=
?
> >>>
> >>> I'm not sure but I think host->ios.power_delay_ms is independent from
> >>> the post-power-on-delay-ms property of "mmc-pwrseq-simple".
> >>
> >> They are distinct indeed (the props have the same name & similar purpo=
se though).
> >
> > Correct.
> >
> >>
> >> host->ios.power_delay_ms is set via:
> >>
> >> drivers/mmc/core/host.c:        device_property_read_u32(dev, "post-po=
wer-on-delay-ms",
> >
> > This is a property that may be specified in the host's OF node. See
> > Documentation/devicetree/bindings/mmc/mmc-controller.yaml.
> >
> >> drivers/mmc/core/host.c-                                 &host->ios.po=
wer_delay_ms);
> >
> > Note that the default value is set to 10 ms, in mmc_alloc_host(). So,
> > if you need a different value, that can be specified in DT.
> >
> >>
> >>
> >> pwrseq->post_power_on_delay_ms is set via:
> >>
> >> drivers/mmc/core/pwrseq_simple.c:       device_property_read_u32(dev, =
"post-power-on-delay-ms",
> >
> > This is a property that may be specified in the pwrseq OF node. See
> > Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml.
> >
> >> drivers/mmc/core/pwrseq_simple.c-                                &pwrs=
eq->post_power_on_delay_ms);
> >>
> >>
> >> However, they are both used to delay mmc_power_up(),
> >> and the host delay is used to sleep twice, which I
> >> found confusing ;)
> >
> > It's certainly a bit hairy to follow, but I think you have understood
> > things correctly.
> >
> >>
> >> Regards
> >>
> >
> > Looks like you are getting closer to the solution, at least for the
> > first step to make sure the SDIO card is getting detected properly.
> > Nice!
>
> What I'm confused about is:
>
> Why would I specify the delay in the host rather than in the pwrseq?

If the delay is to manage vmmc and vqmmc, which is somewhat part of
the generic specifications (SD/MMC), then it should be described in
the host's node.

A pwrseq is something special, which is also platform and device
specific (the SDIO device). If the delays correspond to this, it
should be part of the pwrseq node.

>
> I'll have to study mmc_power_up() a bit more ;)

:-)

Kind regards
Uffe
