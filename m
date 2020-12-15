Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F18C4361B
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Dec 2020 09:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F28382072C
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Dec 2020 09:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgLOJTI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Dec 2020 04:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727699AbgLOJSz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Dec 2020 04:18:55 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC9DC06179C
        for <linux-mmc@vger.kernel.org>; Tue, 15 Dec 2020 01:18:09 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id 186so18381666qkj.3
        for <linux-mmc@vger.kernel.org>; Tue, 15 Dec 2020 01:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bkM2HbhDcW0W7natkzNnj9048me2YUlGqvZ/Ms8LWRY=;
        b=v+qyurL3slnKuwSPDsELpzzsc50fSVMPcAZBbsFiRPhaPFh3tabqlSbjpu3erjAZXl
         Ld6OYWnssIrKYY12qg5+6UQxLhjD/FbSa6bmJGGBpCP666O6EqyGHzKv4BIqGqT1fOlj
         zyitO2VGDTL5UBBj+hC1sIJg+wcA2feF+VMuU+waAOrkUy+Oz4H2fdPi2jAKk/36QgX1
         1kKJykJSn8JxzTULwyOL2hpnA/ejDukDh7FzTO5TDAP7BSxr54VIJYz601bg2JyigPYI
         Q1T/3EpnvxupDzoR/OR9yIThXAssgKCxpnQLvJw3f6ZS4ENYRscJr3sem5ivPulPCr+/
         B1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bkM2HbhDcW0W7natkzNnj9048me2YUlGqvZ/Ms8LWRY=;
        b=kwGswsM6awvOowODeMgSULqxawCdRPJP9MKhGViuBISlrBJLKUl8m4b3Wf2v8fj3Rs
         NBVX5tXiisJQxPz7cQHuE2WzrTbmjGKqNQvsft1KVz6VECoC1O6sTIdsjHiD9PJ3wI1X
         GX+iefyTrhDfPC6IG/nm5JkjQyqfCECD+SxjcyU5MDrIwb0R7bly3JBWoaBfhvDA4epW
         q5E4aN99sb1ckqJICalgqSoTgTByp6d7i8UHGGq0aftDljbv/vHU95BO88sqc212x/H6
         hKwN5G9y1Y6W75PX//EjoyBKFg+hgMjBjeIcjng1LwtsKqCAZPzjeBoNwtYY+CpEWj8j
         /n8w==
X-Gm-Message-State: AOAM5321OlRxzTOsRlfceej93jxZ0l5h4tKN8XMn7HyssGJOY+JMtEwq
        0Oaw+AMRjU9vjcb0Bkc1BxCwvihpDZG4YQG8cKCQSg==
X-Google-Smtp-Source: ABdhPJxgmDF7FB4QO+7Fwlq6nJzZlVTHDITT9LbIKhf3znJs+qjDoODiKucjR2feitnWooIGigYul+2I+Ga8L/Bs7+A=
X-Received: by 2002:ae9:e855:: with SMTP id a82mr38490647qkg.300.1608023888983;
 Tue, 15 Dec 2020 01:18:08 -0800 (PST)
MIME-Version: 1.0
References: <20201211141656.24915-1-mw@semihalf.com> <f6d0f22c-2a19-d1dc-b370-4238a7d2d9b3@intel.com>
In-Reply-To: <f6d0f22c-2a19-d1dc-b370-4238a7d2d9b3@intel.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Tue, 15 Dec 2020 10:17:57 +0100
Message-ID: <CAPv3WKfsfDC9PFYFWZBXWk=h+bfyQaaLwca-vujS_G8=Rd1jSQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-xenon: fix 1.8v regulator stabilization
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Ziji Hu <huziji@marvell.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Kostya Porotchkin <kostap@marvell.com>,
        Alex Leibovich <alexl@marvell.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

wt., 15 gru 2020 o 09:04 Adrian Hunter <adrian.hunter@intel.com> napisa=C5=
=82(a):
>
> On 11/12/20 4:16 pm, Marcin Wojtas wrote:
> > From: Alex Leibovich <alexl@marvell.com>
> >
> > Automatic Clock Gating is a feature used for the power
> > consumption optimisation. It turned out that
> > during early init phase it may prevent the stable voltage
> > switch to 1.8V - due to that on some platfroms an endless
>
> platfroms -> platforms
>
> > printout in dmesg can be observed:
> > "mmc1: 1.8V regulator output did not became stable"
> > Fix the problem by disabling the ACG at very beginning
> > of the sdhci_init and let that be enabled later.
> >
> > Fixes: 3a3748dba881 ("mmc: sdhci-xenon: Add Marvell Xenon SDHC core fun=
ctionality")
> > Signed-off-by: Alex Leibovich <alexl@marvell.com>
> > Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> > Cc: stable@vger.kernel.org
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>

Thank you, I'll repost right away with the typos correction.

Best regards,
Marcin

> > ---
> >  drivers/mmc/host/sdhci-xenon.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xe=
non.c
> > index c67611fdaa8a..4b05f6fdefb4 100644
> > --- a/drivers/mmc/host/sdhci-xenon.c
> > +++ b/drivers/mmc/host/sdhci-xenon.c
> > @@ -168,7 +168,12 @@ static void xenon_reset_exit(struct sdhci_host *ho=
st,
> >       /* Disable tuning request and auto-retuning again */
> >       xenon_retune_setup(host);
> >
> > -     xenon_set_acg(host, true);
> > +     /*
> > +      * The ACG should be turned off at the early init time, in order
> > +      * to solve a possile issues with the 1.8V regulator stabilizatio=
n.
>
> a possile -> possible
>
> > +      * The feature is enabled in later stage.
> > +      */
> > +     xenon_set_acg(host, false);
> >
> >       xenon_set_sdclk_off_idle(host, sdhc_id, false);
> >
> >
>
