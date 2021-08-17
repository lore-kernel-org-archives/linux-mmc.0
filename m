Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36915C4338F
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Aug 2021 07:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 181E060EB5
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Aug 2021 07:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238512AbhHQHiL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Aug 2021 03:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbhHQHiL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Aug 2021 03:38:11 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2F4C061764
        for <linux-mmc@vger.kernel.org>; Tue, 17 Aug 2021 00:37:38 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id j26so3214458vkn.4
        for <linux-mmc@vger.kernel.org>; Tue, 17 Aug 2021 00:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XVb/6r0UvvwsiAdMhUIlNLmTGfl4MxPdzSqrEHYP2EU=;
        b=Gh8m1IDuiDqiRng7TWN0EEbBdzHYZRHi/BPtICkDzyed59fEAFIK3MrSdvbItqAdAa
         LU9DurtK8cLSNOD9utsg+giNFoO0oool+POHMgtEn0sUAeRw6Giau0WC1Y7ntpYkMC5m
         BLEXfneVpEhbR+m22PVFusfFbj6yXwUz0DritbcO2LBOJAnw8UUdETe2KCtPfd2RM/Pa
         Y56xGr5Mfaa5SrfJkIT3sOMGeglhujzFdd9qobpbWtiLs8DmctYYaivxm7sFsQUt3Kzv
         lRBRKgavr348UEKhUp5tQpbXf3hSdKASd6m8S8XYUk3I6b2n3PINS5wtZK3C8RNA5lA+
         GdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XVb/6r0UvvwsiAdMhUIlNLmTGfl4MxPdzSqrEHYP2EU=;
        b=guz4PNVggLf9jvWa0GpOqp5cAyKViJjK4Mbc1DiDdftHHsGoFCBoD5pbDx+Hrj8609
         97SaMB5ijZiCbpJePa+jbzHyvujQzilVY3quQAiaseKb098eyZRuB/nzfITDY81GxtCO
         7/nVgEu6an28AzYExX0+Ppu4yQ3bfDWliD6SH+ZKSIEJEgk07WUDA3mWCu6fgYLQ8xfV
         48S8vEBBS8sFAtqbntxpUIpZIa9uyx1eQU46WMRkJqtUxqjSv52JQC7a2hQWPjUQ6C/u
         1dIVqIGDIz2cReHxEr3L10RMaL79LGgk0lCMaKjYvtEuTKU1beK7ROQb8UJ4B2CvvX9C
         Y6eQ==
X-Gm-Message-State: AOAM532dkITXfRRwapl9/hnxKFemst2L70Ymbjfvs+XYx/2L/tT2hy/d
        hPKk25cziuxFhRE4A6Jr5hf/9Bvl22NzIYmUUUANYw==
X-Google-Smtp-Source: ABdhPJywh2CZFLOB7ZzACQksK0ZiO+cpPq0ioKnhklOoEihoKroCYeFYMiOJhL7T0ptPyIYWSpKpC0dptNRWDZYXmc4=
X-Received: by 2002:a1f:a555:: with SMTP id o82mr1598874vke.8.1629185857318;
 Tue, 17 Aug 2021 00:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <1629117508-4886-1-git-send-email-haibo.chen@nxp.com>
 <1629117508-4886-3-git-send-email-haibo.chen@nxp.com> <CAPDyKFqagBkbnxxh+KWbV2=sjkj3mGrKXUweOL5TrMJ1-Hmnww@mail.gmail.com>
 <VI1PR04MB529432136DB9F5FEB5F5E98090FE9@VI1PR04MB5294.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB529432136DB9F5FEB5F5E98090FE9@VI1PR04MB5294.eurprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 17 Aug 2021 09:37:00 +0200
Message-ID: <CAPDyKFqv9R4R8u9vQLkDMFQy3C-+=B-_g4drktq9ncHhzX3pSw@mail.gmail.com>
Subject: Re: [PATCH 3/6] dt-bindings: mmc: fsl-imx-esdhc: add
 fsl,sdio-async-interrupt-enabled binding
To:     Bough Chen <haibo.chen@nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 17 Aug 2021 at 08:41, Bough Chen <haibo.chen@nxp.com> wrote:
>
> > -----Original Message-----
> > From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
> > Sent: 2021=E5=B9=B48=E6=9C=8816=E6=97=A5 21:43
> > To: Bough Chen <haibo.chen@nxp.com>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>; Shawn Guo
> > <shawnguo@kernel.org>; Rob Herring <robh+dt@kernel.org>; Sascha Hauer
> > <s.hauer@pengutronix.de>; Sascha Hauer <kernel@pengutronix.de>; Fabio
> > Estevam <festevam@gmail.com>; linux-mmc <linux-mmc@vger.kernel.org>;
> > dl-linux-imx <linux-imx@nxp.com>; DTML <devicetree@vger.kernel.org>; Li=
nux
> > ARM <linux-arm-kernel@lists.infradead.org>
> > Subject: Re: [PATCH 3/6] dt-bindings: mmc: fsl-imx-esdhc: add
> > fsl,sdio-async-interrupt-enabled binding
> >
> > On Mon, 16 Aug 2021 at 15:00, <haibo.chen@nxp.com> wrote:
> > >
> > > From: Haibo Chen <haibo.chen@nxp.com>
> > >
> > > Add a new fsl,sdio-async-interrupt-enabled binding for sdio devices
> > > which enable the async interrupt function. When get this property,
> > > driver will avoid to use DAT[1] for hardware auto tuning check.
> > >
> > > Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> > > ---
> > >  .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml         | 10
> > ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> > > b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> > > index b5baf439fbac..8a9f1775b0e2 100644
> > > --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> > > +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> > > @@ -122,6 +122,16 @@ properties:
> > >        - const: state_200mhz
> > >        - const: sleep
> > >
> > > +  fsl,sdio-async-interrupt-enabled:
> > > +    description: |
> > > +      Recommend for SDIO cards that enables SDIO async interrupt for
> > SDR104 and SDR50
> > > +      operating modes. SDIO async interrupt uses DAT[1] to signal th=
e
> > card's interrupt.
> > > +      uSDHC tuning mechanism must use DAT[0] and CMD signals to avoi=
d
> > a possible
> > > +      conflict and incorrect delay line calculated by the uSDHC auto=
 tuning
> > mechanism.
> > > +      Enabling this device tree property is only recommended for lay=
outs
> > that are
> > > +      matching the SD interface length.
> > > +    type: boolean
> >
> > We already have a common mmc property, "cap-sdio-irq", that tells wheth=
er
> > the controller supports SDIO irqs (which is delivered on DAT1).
> >
> > Can't you use this instead?
> >
> Hi Ulf,
>
> Thanks for your quick reply!
>
> According to our WiFi team reply, the sdio-irq has two types. Sync interr=
upt and Async interrupt.
> When WiFi send out the interrupt signal during the interrupt period, if i=
t sync with clock pad(just as
> when send out data), then this is sync interrupt. When this interrupt not=
 sync with clock, it is async
> interrupt. Async interrupt has a better overall performance than sync int=
errupt.

The async interrupt is what we refer to as SDIO irqs, which is being
delivered on DAT1.

>
> Logically, auto tuning circuit should only take care of the data and cmd =
line, and ignore interrupt signal.
> But unfortunately current i.mx-usdhc IP do not ignore interrupt signal. S=
o it detect the interrupt signal,
> and take this signal as a data signal, and adjust the delay cell accordin=
gly. For sync interrupt, due to it
> sync with clock, so no affect, but for async interrupt, it will involve w=
rong delay cell change randomly.

Okay.

>
> I involve a new property here, because in sdhci.c, we default use this "c=
ap-sdio-irq" for all sdio/sd/mmc.

I guess it's the similar variant of the controller for all slots then.

It can be debated whether the proper thing is to set "cap-sdio-irq"
only for the SDIO card slot. I think so, (and it's already being used
like that) if there is an embedded SDIO card attached, because
cap-sdio-irq would not make sense otherwise.

> I need one property which can use only for sdio device, and only when sdi=
o device enable async-interrupt.

If you really need a new DT property (let's discuss that more in patch
4/6), I suggest you add something along the lines of a
"broken-auto-tuning" DT property instead, because that is in principle
what this should be about, isn't it?

Kind regards
Uffe
