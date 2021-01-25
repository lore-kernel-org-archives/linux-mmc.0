Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278BCC433DB
	for <linux-mmc@archiver.kernel.org>; Mon, 25 Jan 2021 10:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E96A722CA2
	for <linux-mmc@archiver.kernel.org>; Mon, 25 Jan 2021 10:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbhAYKsS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 25 Jan 2021 05:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727647AbhAYKr6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Jan 2021 05:47:58 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42244C06174A;
        Mon, 25 Jan 2021 02:47:12 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id u11so14647981ljo.13;
        Mon, 25 Jan 2021 02:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=43PJHRr7+l80ZYDB7hOC3rOmJdG1RReABy3AisRh4fg=;
        b=XAyh9KY5g7j86h4QR6NEPrWSuHJRAeiIMTwMyGz9JXe5QcXte2sa4883HQhF/p2S4C
         VIiBFkKTPRKdFid5tJo/1NRDnlk0ur/xIz8cNmxTJafPpLsYTHvQ+xlkv2mqULzh5peW
         BFYK/0Bul0/4k6zlrnDvUE43VgUrtMqKGgomeGT56Jpl7Bsbm5zrurXg1nZvPSAIJb00
         PkK2PoDJil8NHdh4pK9osiiLiBq6UeD7EGJVdYC4C1E+d0sM3QNzioB91h2wk4gF06ff
         GWkGmK0Iok3dBFKxO/IqLwLIpsjbPok1D+vJDmS2z9jKHunE3ZQWcf5Lyc6RihH+3kSX
         xnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=43PJHRr7+l80ZYDB7hOC3rOmJdG1RReABy3AisRh4fg=;
        b=gtkc6JgMAtKgYBv1oiL9fENcsx2OExFq8o6QbLD4YkwJm7LCv31F8hfmoTU9DSYyG+
         TivKiUUsL0juA/eXYVkjaDWUbRjM3dGhyIba9aNzDHnx39+koCAA9mPweqrRKpv/xp2p
         HP+JpF3F/LjbVNxGCkkhNTQAoCSkv31BcC7+33aNOBhmrolTUWtUzffbTA28w79F6kTK
         nw0za8m6bpaYMApF+Dx2ycmYOYdGMov/KvmfmTnsRUoOkAWCzNJzOIAsRrLHgAXlLOQD
         Q+p3fUgU5vwtkuW53UK2GMVjJmyIFTrBamy5vqSRRAr10Np6REMT6RCQNW7yLBLdK0uQ
         TtHA==
X-Gm-Message-State: AOAM531j+EMqXUPNredkLmoJERtx6cPJ4Qkw1vIds/O4jCeNYwE7XkFO
        EYKPl+Wiz4N2yow8Ih7wgqrnjSOa7GJwmEkeA+A=
X-Google-Smtp-Source: ABdhPJzt2gcJSi1fFWEOmw3kZrWnPL1qfZjofVBEUYQQfXMqLSd+1fY5kuHkgPkd550T2l6Tv30ByvMYI6XNGT65yvs=
X-Received: by 2002:a2e:8416:: with SMTP id z22mr1013328ljg.347.1611571630612;
 Mon, 25 Jan 2021 02:47:10 -0800 (PST)
MIME-Version: 1.0
References: <20210118042717.2549123-1-xiaolei.wang@windriver.com>
 <CAPDyKFq+qyuHGbduGp30AeLefN1ie9ZL2Bvm9PrPZUwmdfQeYg@mail.gmail.com>
 <PH0PR11MB507708B2E5662DC2F6E649B195A19@PH0PR11MB5077.namprd11.prod.outlook.com>
 <CAPDyKFq1TcV-GCknCFVKjVgtqQZ3vZJc3PgSzb=UrzDdKnCvZw@mail.gmail.com>
In-Reply-To: <CAPDyKFq1TcV-GCknCFVKjVgtqQZ3vZJc3PgSzb=UrzDdKnCvZw@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 25 Jan 2021 07:46:59 -0300
Message-ID: <CAOMZO5CFMT-OPX-3p5n6BEanPbyitz7Ng4s5PFN=k+cnsgpg7A@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Apply trim broken quirk to R1J57L
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Wang, Xiaolei" <Xiaolei.Wang@windriver.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Haibo,

Could you please take a look?

Thanks

On Thu, Jan 21, 2021 at 10:26 AM Ulf Hansson <ulf.hansson@linaro.org> wrote=
:
>
> + Fabio, Haibo
>
> On Thu, 21 Jan 2021 at 10:54, Wang, Xiaolei <Xiaolei.Wang@windriver.com> =
wrote:
> >
> > Hi
> >
> > >Are you sure this is an eMMC problem and not a mmc host driver issue?
> >
> > >Can you elaborate more what happens?
> >
> > When I use the mkfs.f2fs tool to format the eMMC file system on the imx=
8qxp board,
> > because mkfs.f2fs will use secdiscard first, when entering mmc_blk_issu=
e_secdiscard_rq erase,
> > once the parameters are passed into MMC_SECURE_TRIM1_ARG, this function=
 will take a long time to return .
> > The program has not ended, has been in TASK_UNINTERRUPTIBLE state.
> >
> > I compared the mkfs.ext4 tool to format the file system. Because it dir=
ectly uses mmc_blk_issue_discard_rq,
> > this is a normal formatting phenomenon.
> >
> > mmc_blk_issue_secdiscard_rq and mmc_blk_issue_discard_rq are just diffe=
rent commands and parameters sent by the host as a bus.
> >  I did not see the description of trim in the data sheet. Could the hos=
t driver cause this problem?
>
> Yes, it can - and we have had issues like these before. So before
> adding a card quirk, I think we need to make sure this isn't the case.
>
> When using MMC_SECURE_TRIM1_ARG, it's very likely that the request
> takes longer to complete.
>
> The mmc host is responsible for either dealing with busy detection
> with the help of its HW/controller - or if that can't be supported,
> the mmc core falls back to polling the card for busy with a CMD13.
>
> See mmc_do_erase() in /drivers/mmc/core/core.c
>
> >
> > Note:
> > The host driver I use is sdhci-esdhc-imx.c
>
> Alright, I have looped in Fabio and Haibo that knows this driver,
> let's see if they can help.
>
> >
> > Thanks
> > Xiaolei
>
> Kind regards
> Uffe
>
> >
> > -----Original Message-----
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> > Sent: Wednesday, January 20, 2021 9:41 PM
> > To: Wang, Xiaolei <Xiaolei.Wang@windriver.com>
> > Cc: Pali Roh=C3=A1r <pali@kernel.org>; Lee Jones <lee.jones@linaro.org>=
; linux-mmc@vger.kernel.org; Linux Kernel Mailing List <linux-kernel@vger.k=
ernel.org>
> > Subject: Re: [PATCH] mmc: core: Apply trim broken quirk to R1J57L
> >
> > [Please note this e-mail is from an EXTERNAL e-mail address]
> >
> > On Mon, 18 Jan 2021 at 05:27, Xiaolei Wang <xiaolei.wang@windriver.com>=
 wrote:
> > >
> > > R1J57L mmc chip hw capibility indicates that it supports trim
> > > function, but this function does not work properly, the SDIO bus does
> > > not respond, and the IO has been waiting so set quirks to skip trim
> >
> > Are you sure this is an eMMC problem and not a mmc host driver issue?
> >
> > Can you elaborate more what happens?
> >
> > Kind regards
> > Uffe
> >
> > >
> > > Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> > > ---
> > >  drivers/mmc/core/quirks.h | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> > > index d68e6e513a4f..63e02391c133 100644
> > > --- a/drivers/mmc/core/quirks.h
> > > +++ b/drivers/mmc/core/quirks.h
> > > @@ -89,6 +89,8 @@ static const struct mmc_fixup __maybe_unused mmc_bl=
k_fixups[] =3D {
> > >                   MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
> > >         MMC_FIXUP("VZL00M", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_qu=
irk_mmc,
> > >                   MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
> > > +       MMC_FIXUP("R1J57L", CID_MANFID_MICRON, CID_OEMID_ANY, add_qui=
rk_mmc,
> > > +                 MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
> > >
> > >         /*
> > >          *  On Some Kingston eMMCs, performing trim can result in @@
> > > -98,6 +100,8 @@ static const struct mmc_fixup __maybe_unused mmc_blk_=
fixups[] =3D {
> > >                   MMC_QUIRK_TRIM_BROKEN),
> > >         MMC_FIXUP("V10016", CID_MANFID_KINGSTON, CID_OEMID_ANY, add_q=
uirk_mmc,
> > >                   MMC_QUIRK_TRIM_BROKEN),
> > > +       MMC_FIXUP("R1J57L", CID_MANFID_MICRON, CID_OEMID_ANY, add_qui=
rk_mmc,
> > > +                 MMC_QUIRK_TRIM_BROKEN),
> > >
> > >         END_FIXUP
> > >  };
> > > --
> > > 2.25.1
> > >
