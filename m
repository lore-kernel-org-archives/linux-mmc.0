Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AC0C433FE
	for <linux-mmc@archiver.kernel.org>; Fri,  1 Oct 2021 15:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 068D061A07
	for <linux-mmc@archiver.kernel.org>; Fri,  1 Oct 2021 15:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbhJAPZp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 1 Oct 2021 11:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbhJAPZl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Oct 2021 11:25:41 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFE0C06177F
        for <linux-mmc@vger.kernel.org>; Fri,  1 Oct 2021 08:23:56 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x27so39745230lfa.9
        for <linux-mmc@vger.kernel.org>; Fri, 01 Oct 2021 08:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HcXgng2hGoCgpa31It0A0pLwW+Q4lJvcKTzTM93uitk=;
        b=RFJCXjfPz7w+MgF8CFN1piJl7iQ8/TURuVojjSPJssZjjMtcBF9liI0WwJNfyFEEcd
         8IJSGrlA9u3b9pWEImoCky/7xFxWVqnXBg+dKziSgxFWho1RtTOFho0iLNT5Va/Pfr0z
         CLUDEENIVFDT1hlQWnfJK7Dcioabcr33NG3vFFewmv7Uky1hvd7bMjHgrXNJgBDAJhc1
         HWIP5+uxMehbvFplWuzCEvNm3/bj6BPP+wASfjqky2EetC1AMTYbX72aiCpjVBKiYjDq
         qD/+xxRSHt9ODqns8AAJAREeH/j10omS6wxAm8Pmcm2JHgakO4yZLEHgECVaK92EKVWg
         vyog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HcXgng2hGoCgpa31It0A0pLwW+Q4lJvcKTzTM93uitk=;
        b=vxUuqcQrhBpd6f+uC616aP/LYEN8LQoCVC6QmwjIpjpfgtgsqqvrVqyxr6FTEg4mTf
         A7cuKRidEVpM3zOZ5jvLSdttVWDdq8FCgWKTdauy4u1/xt3/Kk35OU8so6VyMZKErXv0
         IuhSSxewZnSydcy21wICb+7W4Kb2tM65h0IhNNe/djKfkm0LY1r2myrJQvbCIJ4WjFsi
         hf5/y9CpyC/7E6yz3xarvtcA+wgWBOMsA11SfUwGKjwn8nR6a4qrtd2cXgmA6hjVTcxX
         PTmZUaZQrPJ+YINL8C+PgpYSPGhkRhXw1SPQdMTNNCWr0JbkT/pLN/CkT7Hbs0dcqds8
         q1xQ==
X-Gm-Message-State: AOAM5300ghpbGanlp45okUVCGx9vXKBlJYjJ6TrWrjXIg4ZGEEGwbuED
        AOWite2aMB/gd6gRnUQILgv8/4lkjwTiOEfQtyitSA==
X-Google-Smtp-Source: ABdhPJyd+dupirVhzxZl8i5tUK5MA4VFOlbkWZql2eI+cR5FeK8ToELQVt75Qd+XOf7vM9xDkeQcoV0JFkAVU9VSXDY=
X-Received: by 2002:ac2:4157:: with SMTP id c23mr5908876lfi.184.1633101833061;
 Fri, 01 Oct 2021 08:23:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210920161136.2398632-1-Jerome.Pouiller@silabs.com>
 <20210920161136.2398632-9-Jerome.Pouiller@silabs.com> <CAPDyKFp2_41mScO=-Ev+kvYD5xjShQdLugU_2FTTmvzgCxmEWA@mail.gmail.com>
 <19731906.ZuIkq4dnIL@pc-42> <20210930170646.cffsuytdpa72izbh@pali>
In-Reply-To: <20210930170646.cffsuytdpa72izbh@pali>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 1 Oct 2021 17:23:16 +0200
Message-ID: <CAPDyKFoaw8rdPRdjgAJz3-T2_fS1iA9jtonbwZAYE0npUNfOQQ@mail.gmail.com>
Subject: Re: [PATCH v7 08/24] wfx: add bus_sdio.c
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 30 Sept 2021 at 19:06, Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Thursday 30 September 2021 18:51:09 J=C3=A9r=C3=B4me Pouiller wrote:
> > Hello Ulf,
> >
> > On Thursday 30 September 2021 12:07:55 CEST Ulf Hansson wrote:
> > > On Mon, 20 Sept 2021 at 18:12, Jerome Pouiller
> > > <Jerome.Pouiller@silabs.com> wrote:
> > > >
> > > > From: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
> > > >
> > > > Signed-off-by: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.co=
m>
> > > > ---
> > > >  drivers/net/wireless/silabs/wfx/bus_sdio.c | 261 +++++++++++++++++=
++++
> > > >  1 file changed, 261 insertions(+)
> > > >  create mode 100644 drivers/net/wireless/silabs/wfx/bus_sdio.c
> > > >
> > > > diff --git a/drivers/net/wireless/silabs/wfx/bus_sdio.c b/drivers/n=
et/wireless/silabs/wfx/bus_sdio.c
> > >
> > > [...]
> > >
> > > > +
> > > > +static int wfx_sdio_probe(struct sdio_func *func,
> > > > +                         const struct sdio_device_id *id)
> > > > +{
> > > > +       struct device_node *np =3D func->dev.of_node;
> > > > +       struct wfx_sdio_priv *bus;
> > > > +       int ret;
> > > > +
> > > > +       if (func->num !=3D 1) {
> > > > +               dev_err(&func->dev, "SDIO function number is %d whi=
le it should always be 1 (unsupported chip?)\n",
> > > > +                       func->num);
> > > > +               return -ENODEV;
> > > > +       }
> > > > +
> > > > +       bus =3D devm_kzalloc(&func->dev, sizeof(*bus), GFP_KERNEL);
> > > > +       if (!bus)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       if (!np || !of_match_node(wfx_sdio_of_match, np)) {
> > > > +               dev_warn(&func->dev, "no compatible device found in=
 DT\n");
> > > > +               return -ENODEV;
> > > > +       }
> > > > +
> > > > +       bus->func =3D func;
> > > > +       bus->of_irq =3D irq_of_parse_and_map(np, 0);
> > > > +       sdio_set_drvdata(func, bus);
> > > > +       func->card->quirks |=3D MMC_QUIRK_LENIENT_FN0 |
> > > > +                             MMC_QUIRK_BLKSZ_FOR_BYTE_MODE |
> > > > +                             MMC_QUIRK_BROKEN_BYTE_MODE_512;
> > >
> > > I would rather see that you add an SDIO_FIXUP for the SDIO card, to
> > > the sdio_fixup_methods[], in drivers/mmc/core/quirks.h, instead of
> > > this.
> >
> > In the current patch, these quirks are applied only if the device appea=
rs
> > in the device tree (see the condition above). If I implement them in
> > drivers/mmc/core/quirks.h they will be applied as soon as the device is
> > detected. Is it what we want?
> >
> > Note: we already have had a discussion about the strange VID/PID declar=
ed
> > by this device:
> >   https://www.spinics.net/lists/netdev/msg692577.html
>
> Yes, vendor id 0x0000 is invalid per SDIO spec. So based on this vendor
> id, it is not possible to write any quirk in mmc/sdio generic code.
>
> Ulf, but maybe it could be possible to write quirk based on OF
> compatible string?

Yes, that would be better in my opinion.

We already have DT bindings to describe embedded SDIO cards (a subnode
to the mmc controller node), so we should be able to extend that I
think.

The main reason why I think it's a good idea, is that we may need to
know (future wise) about quirks from the mmc core point of view,
before the SDIO func driver gets probed.

[...]

Kind regards
Uffe
