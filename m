Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0037C433FE
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Mar 2022 15:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242767AbiCNPwt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 14 Mar 2022 11:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242754AbiCNPws (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Mar 2022 11:52:48 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E152C132
        for <linux-mmc@vger.kernel.org>; Mon, 14 Mar 2022 08:51:37 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bu29so28089022lfb.0
        for <linux-mmc@vger.kernel.org>; Mon, 14 Mar 2022 08:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GO6DO22NyOz74pRKEaDBeavTF5IzNMteCDkoxNllIjs=;
        b=C+MtGX9CMvggkG1qaBzQ7cD7DzChnpKOxlIfkKuGP5QvXmw69IBulUXax1WvA1adD3
         ddIMSnABoXDU2in9nYP4VXGeuIrxOGyP6u6nm81HlypZko7oyfWnQWOi4xdB4H3fDGO3
         Au802GbTgksVMv+cI84WSDkhpI8RES1YS8dJ8KGY3NLhIZnrsA1z+nPcJLmWiScSPsOQ
         3xbzgxQM9hrQSglBU6iUTGp07lNUv+EQWD0ji/zAJAA1vFeNcWq8GVWFu+Fz4KubEVoh
         Dd7tMx7xJDYZu5277JvRIlAepC2jprlPO74GXQEACdusmjs0E41lmYPnq5mrtWNg7giG
         NlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GO6DO22NyOz74pRKEaDBeavTF5IzNMteCDkoxNllIjs=;
        b=fPk78vjhO9ypl4rf7wT9sgd4AM7cuPvwDbbjJRBK6w0MV00IfeYYLcmbkpjTS69PW4
         7U/CuOLYufJ3a6R/vVLSuS1oJgKIMqaT+kyNmsOKSLaFLA5+OjrTrF/cQ/d71ErrA6em
         sAQ6Y5vCeTEOu6mAExaUoNsl5+9hG6BNKLxDVFOlRZ7tz4ap8BIGucl/+TeHodpII2Zl
         /A7IrUi7fVFqbH/dnzrWkYfKHQFJAMD9+d64rHHLY/B8x34OjIN486hZAgofkVcDJ5F/
         qcHw1jtxM5gP2NuuhCmu5+/ezOeQr5Bucg56mWbrQRpSX6g374pxDx1IQJ14Q6/KqHXy
         oWcg==
X-Gm-Message-State: AOAM531gIN1FVFTcUJNT8NbVVIsgdBs6v3W/DcWp/JyNz2j8zrATSi0H
        wCDJWAJR/0WCk+tT2RQh2rbzJcV9AEy0gdU52Iil5A==
X-Google-Smtp-Source: ABdhPJx1ExVE9qufvJAbY8tN7OfqPeyUdY8cYDJaBjP79yF9JHq/eJYG89IfJxx7LaUUQS2SzHYyxnTDJwTT8d7GQQ4=
X-Received: by 2002:a05:6512:e98:b0:448:8053:d34a with SMTP id
 bi24-20020a0565120e9800b004488053d34amr7045193lfb.680.1647273095785; Mon, 14
 Mar 2022 08:51:35 -0700 (PDT)
MIME-Version: 1.0
References: <20201211141656.24915-1-mw@semihalf.com> <CAPDyKFqsSO+f9iG8vccwXZXDDNHgLEg7bfUe-KfHn2C-ZnOU4A@mail.gmail.com>
 <20220314154033.4x74zscayee32rrj@pali>
In-Reply-To: <20220314154033.4x74zscayee32rrj@pali>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Mon, 14 Mar 2022 16:51:25 +0100
Message-ID: <CAPv3WKc4MFeLgnJMWx=YNT5Ta5yi6fVhb4f-Rf211FTEmkvyog@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-xenon: fix 1.8v regulator stabilization
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ziji Hu <huziji@marvell.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Kostya Porotchkin <kostap@marvell.com>,
        Alex Leibovich <alexl@marvell.com>,
        "# 4.0+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Pali,


pon., 14 mar 2022 o 16:40 Pali Roh=C3=A1r <pali@kernel.org> napisa=C5=82(a)=
:
>
> On Monday 11 January 2021 19:06:24 Ulf Hansson wrote:
> > On Fri, 11 Dec 2020 at 15:17, Marcin Wojtas <mw@semihalf.com> wrote:
> > >
> > > From: Alex Leibovich <alexl@marvell.com>
> > >
> > > Automatic Clock Gating is a feature used for the power
> > > consumption optimisation. It turned out that
> > > during early init phase it may prevent the stable voltage
> > > switch to 1.8V - due to that on some platfroms an endless
> > > printout in dmesg can be observed:
> > > "mmc1: 1.8V regulator output did not became stable"
> > > Fix the problem by disabling the ACG at very beginning
> > > of the sdhci_init and let that be enabled later.
> > >
> > > Fixes: 3a3748dba881 ("mmc: sdhci-xenon: Add Marvell Xenon SDHC core f=
unctionality")
> > > Signed-off-by: Alex Leibovich <alexl@marvell.com>
> > > Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> > > Cc: stable@vger.kernel.org
> >
> > Applied for fixes (by fixing the typos), thanks!
>
> Hello!
>
> Is not this patch address same issue which was fixed by patch which was
> merged earlier?
>
> bb32e1987bc5 ("mmc: sdhci-xenon: fix annoying 1.8V regulator warning")
> https://lore.kernel.org/linux-mmc/CAPDyKFqAsvgAjfL-c9ukFNWeGJmufQosR2Eg9S=
KjXMVpNitdkA@mail.gmail.com/
>

This indeed look similar. This fix was originally developed for CN913x
platform without the mentioned patch (I'm wondering if it would also
suffice to fix A3k board's problem). Anyway, I don't think we have an
issue here, as everything seems to work fine on top of mainline Linux
with both changes.

Best regards,
Marcin

> > Kind regards
> > Uffe
> >
> >
> > > ---
> > >  drivers/mmc/host/sdhci-xenon.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-=
xenon.c
> > > index c67611fdaa8a..4b05f6fdefb4 100644
> > > --- a/drivers/mmc/host/sdhci-xenon.c
> > > +++ b/drivers/mmc/host/sdhci-xenon.c
> > > @@ -168,7 +168,12 @@ static void xenon_reset_exit(struct sdhci_host *=
host,
> > >         /* Disable tuning request and auto-retuning again */
> > >         xenon_retune_setup(host);
> > >
> > > -       xenon_set_acg(host, true);
> > > +       /*
> > > +        * The ACG should be turned off at the early init time, in or=
der
> > > +        * to solve a possile issues with the 1.8V regulator stabiliz=
ation.
> > > +        * The feature is enabled in later stage.
> > > +        */
> > > +       xenon_set_acg(host, false);
> > >
> > >         xenon_set_sdclk_off_idle(host, sdhc_id, false);
> > >
> > > --
> > > 2.29.0
> > >
