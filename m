Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698ADC433ED
	for <linux-mmc@archiver.kernel.org>; Tue, 11 May 2021 12:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AC8A6187E
	for <linux-mmc@archiver.kernel.org>; Tue, 11 May 2021 12:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbhEKMVV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 11 May 2021 08:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbhEKMVV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 May 2021 08:21:21 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81155C061574
        for <linux-mmc@vger.kernel.org>; Tue, 11 May 2021 05:20:13 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id c17so940925vke.3
        for <linux-mmc@vger.kernel.org>; Tue, 11 May 2021 05:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J9p0IV9O/0BHMoRbDshc2d2b/2+hF9lZpmTlcmjAloA=;
        b=RbVZmRNIsScv4qi8gxjWkiSJG43CXZdX+0+a5AkcDFjoJ9J5eGTxj+1afg4LX90EmW
         k4R/qk6hyDZar8BWrQIHMd/bKTgWKR14kz47HRjhO7tSLL8VnV0qUitEzDXamyivkMLO
         tTEQlbTn1hHYt7+cwbYDnxrmimrp9f4Gv4Chkv7sTeG5CH/vBG92miOM9cnzK6/xjX55
         xoL7WuR3RrBtW7t3pDFPbVI/VCm1cJP7KK3ZCLRqDzJ5NJ6LdFZ7/+Pdac5VaWLpHLTp
         NFi7KFoj+47/9/VUPlyzAZu0KrDASFcJfMWvfA+bfCiWK9BavfWWSwv18yn+JnboCSVG
         nBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J9p0IV9O/0BHMoRbDshc2d2b/2+hF9lZpmTlcmjAloA=;
        b=krkxc/SAidgHu3fbgl9YbVN3xPtDa/keoBmhfiMvUU8Rx1KTsNdl66lD7YV9pKhVHI
         VusRRyhlmNIO/aSn8046ZutO+Tx0qjk9jV32ds4Pu0z62Cy+8+dT8/q6FM2Yvmfvptzz
         eSsSoJOkIljmiQDwwIlQglBvfJhhXZzXHRsZEGsCtovcGj3+G5UXMAbkbXx0JMl++DZj
         9sMcmRFF34dj6iUcn3aiCRjT0rI14olCGu3X9B4dV7l4xDOiARF0rzxZXIwpWpvHhYvz
         shEGcAR4yy0PicShuD3SJbfixdAyju2a5vczwUN+9+B42yBTF/mqVi1MfGz70NGz06jm
         vYEA==
X-Gm-Message-State: AOAM532QQWLL8owsGR4pRM40Z8H25mAP1qsh2Tr14YxXpvuelFrLdX3r
        PWzvKOabtKtzTsBZ2CWhjZ96vVr1mdJY6+tTgFCICw2rsHQBdQ==
X-Google-Smtp-Source: ABdhPJyy0HX6uiYQyMYND+Hu2ICNbRj8Qpd12xxBCQ/P4A91seUGfmc8gvrGzRUb+45J3s5mY3TfTuSa8mgEplFrUfM=
X-Received: by 2002:a1f:aecf:: with SMTP id x198mr22224995vke.6.1620735612522;
 Tue, 11 May 2021 05:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210510190400.105162-1-l.stach@pengutronix.de>
 <20210510190400.105162-3-l.stach@pengutronix.de> <CAPDyKFrAe-+CENhXkY2fGNw04g-zn+ebcAXSVGa9Td5pJcsujA@mail.gmail.com>
 <0aa51fabade743fbaac70a149a771f37e7d05165.camel@pengutronix.de>
In-Reply-To: <0aa51fabade743fbaac70a149a771f37e7d05165.camel@pengutronix.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 May 2021 14:19:36 +0200
Message-ID: <CAPDyKFpii+q+oLqtt7he+qjqyzeUY39Oy0Wqq4cn5rXfEB6KiA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mmc: core: add support for disabling HS400 mode
 via DT
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Chris Ruehl <chris.ruehl@gtsys.com.hk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 11 May 2021 at 13:54, Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Hi Ulf,
>
> Am Dienstag, dem 11.05.2021 um 13:14 +0200 schrieb Ulf Hansson:
> > + Chris Ruehl
> >
> > On Mon, 10 May 2021 at 21:04, Lucas Stach <l.stach@pengutronix.de> wrote:
> > >
> > > From: Lucas Stach <dev@lynxeye.de>
> > >
> > > On some boards the data strobe line isn't wired up, rendering HS400
> > > support broken, even if both the controller and the eMMC claim to
> > > support it. Allow to disable HS400 mode via DT.
> >
> > Before I review the series, I just wanted to highlight that quite
> > recently we got a related series posted from Chris [1]. I made some
> > comments, but he hasn't replied yet.
> >
> > In any case, if I understood it correctly, it looks like some
> > controllers may support HS400 ES, but not HS200. Could that be the
> > case here as well? Or is this a different problem?
> >
> >
> That's not the issue I'm trying to solve here. HS400 modes, whether ES
> nor not, require the data strobe line to work. ES mode just defines how
> this line is used. I know for a fact that the board I'm dealing with
> here, just hasn't wired up this line between the SoC and the eMMC. Thus
> HS400 modes fail to work, even though both controller and eMMC support
> this mode.
>
> When HS400 is disabled, like in this series, communication falls back
> to HS200 mode and works fine this way.

Alright, thanks for clarifying. I will look into the series soon.

Kind regards
Uffe

>
> Regards,
> Lucas
>
> > Kind regards
> > Uffe
> >
> > [1]
> > https://patchwork.kernel.org/project/linux-mmc/patch/20201208061839.21163-7-chris.ruehl@gtsys.com.hk/
> >
> > >
> > > Signed-off-by: Lucas Stach <dev@lynxeye.de>
> > > ---
> > > v2:
> > > - move to core
> > > - actually disable all HS400 modes
> > > ---
> > >  drivers/mmc/core/host.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> > > index 9b89a91b6b47..0e066c5f5243 100644
> > > --- a/drivers/mmc/core/host.c
> > > +++ b/drivers/mmc/core/host.c
> > > @@ -351,6 +351,9 @@ int mmc_of_parse(struct mmc_host *host)
> > >                 host->caps2 |= MMC_CAP2_NO_SD;
> > >         if (device_property_read_bool(dev, "no-mmc"))
> > >                 host->caps2 |= MMC_CAP2_NO_MMC;
> > > +       if (device_property_read_bool(dev, "no-mmc-hs400"))
> > > +               host->caps2 &= ~(MMC_CAP2_HS400_1_8V | MMC_CAP2_HS400_1_2V |
> > > +                                MMC_CAP2_HS400_ES);
> > >
> > >         /* Must be after "non-removable" check */
> > >         if (device_property_read_u32(dev, "fixed-emmc-driver-type", &drv_type) == 0) {
> > > --
> > > 2.31.1
> > >
>
>
