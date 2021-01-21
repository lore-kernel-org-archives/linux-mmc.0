Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD701C433DB
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Jan 2021 13:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C55923118
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Jan 2021 13:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732063AbhAUNbB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Jan 2021 08:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730764AbhAUN2P (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jan 2021 08:28:15 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2FFC0613D6
        for <linux-mmc@vger.kernel.org>; Thu, 21 Jan 2021 05:26:29 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id b78so167096vke.12
        for <linux-mmc@vger.kernel.org>; Thu, 21 Jan 2021 05:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Rf1qKfSAnHAbgFgODbsvDUcmat4RodOPJkqQcCf2Woo=;
        b=T97ehu1rk5uA0WZ+CdJ0MAe4iMMeCR0gBWgjDQVjb8wLOrxE1kEuX0B7y0udkEwOfH
         ievh1lJbEOcF5tomDF2bAWCnTYAThZjJay4CXcJ0bds9Z5u6vzMLdlx/9hQTlHoVIpRn
         FhhfGFJedS1swKUrQcU0ZeDOuIuH+jAuAaaqjqKbsa6Yg1NVrO1bJKCam8IMxOxGdsQR
         Rj/Nj1PkVlW+djkp8KtIMIO25Q+lVIxSYkBwEJ60XQOrjfiZk/E0X/2CUQP3EdmFu110
         W6fT6f/VJITSZ/vkt9qvl9mDGZqPOVQBMt1nk/ssLGwySkaeWF6pLQ+TBp7ZSNKlinPq
         +HRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Rf1qKfSAnHAbgFgODbsvDUcmat4RodOPJkqQcCf2Woo=;
        b=L1tWmXqyL5TPW6iEvInv9Lm1909LpujsHDX95FGqZaJL6+W27btrGgi/GbtBEd6YXm
         esO87i+bvBuvEzEqBHhDR3plj6t+FDFeHuzYKioUEpTOJbipVqUgu0S/DOzq6fVdLg3W
         x2WDxpAGVoclCPi2SAf0laGiyUEUvEQuvXECPeTW/nzJWIjrjq8Opg8AB3SU7Vh38OZ8
         IxIF1jXQMFHbtrICQw1Yo7nzpBjxTNp7saNdcv/lccVc9hAj1c4EY4XPf7iCEZ2ZaYqU
         DLt9Vhc0T5vVHOyXTq1XOPj3ua+Kd2bKWkNEXjnJrrqtZZEd0NTqm6ZkizNaS+n57Y9M
         OwZQ==
X-Gm-Message-State: AOAM533bxdOfo0UnRPvSZfI87s5OXezkxjSFDWwyPqoIlyUqC5mOhPlb
        Ic7xLwBk8JUBGApmMerX4aWbZAKKgFQ0gd21a/dV1w==
X-Google-Smtp-Source: ABdhPJzOhzm6qoqtQhm6w1t4sBwg8GnWZKRJ/ZnZDG4y0uPCJ/DDG3kVxkPedLlZqB9dMpdp1Zo06lcHuxUSgxNBuEQ=
X-Received: by 2002:a1f:aecb:: with SMTP id x194mr870066vke.6.1611235588136;
 Thu, 21 Jan 2021 05:26:28 -0800 (PST)
MIME-Version: 1.0
References: <20210118042717.2549123-1-xiaolei.wang@windriver.com>
 <CAPDyKFq+qyuHGbduGp30AeLefN1ie9ZL2Bvm9PrPZUwmdfQeYg@mail.gmail.com> <PH0PR11MB507708B2E5662DC2F6E649B195A19@PH0PR11MB5077.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB507708B2E5662DC2F6E649B195A19@PH0PR11MB5077.namprd11.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Jan 2021 14:25:51 +0100
Message-ID: <CAPDyKFq1TcV-GCknCFVKjVgtqQZ3vZJc3PgSzb=UrzDdKnCvZw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Apply trim broken quirk to R1J57L
To:     "Wang, Xiaolei" <Xiaolei.Wang@windriver.com>,
        Fabio Estevam <festevam@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Fabio, Haibo

On Thu, 21 Jan 2021 at 10:54, Wang, Xiaolei <Xiaolei.Wang@windriver.com> wr=
ote:
>
> Hi
>
> >Are you sure this is an eMMC problem and not a mmc host driver issue?
>
> >Can you elaborate more what happens?
>
> When I use the mkfs.f2fs tool to format the eMMC file system on the imx8q=
xp board,
> because mkfs.f2fs will use secdiscard first, when entering mmc_blk_issue_=
secdiscard_rq erase,
> once the parameters are passed into MMC_SECURE_TRIM1_ARG, this function w=
ill take a long time to return .
> The program has not ended, has been in TASK_UNINTERRUPTIBLE state.
>
> I compared the mkfs.ext4 tool to format the file system. Because it direc=
tly uses mmc_blk_issue_discard_rq,
> this is a normal formatting phenomenon.
>
> mmc_blk_issue_secdiscard_rq and mmc_blk_issue_discard_rq are just differe=
nt commands and parameters sent by the host as a bus.
>  I did not see the description of trim in the data sheet. Could the host =
driver cause this problem?

Yes, it can - and we have had issues like these before. So before
adding a card quirk, I think we need to make sure this isn't the case.

When using MMC_SECURE_TRIM1_ARG, it's very likely that the request
takes longer to complete.

The mmc host is responsible for either dealing with busy detection
with the help of its HW/controller - or if that can't be supported,
the mmc core falls back to polling the card for busy with a CMD13.

See mmc_do_erase() in /drivers/mmc/core/core.c

>
> Note:
> The host driver I use is sdhci-esdhc-imx.c

Alright, I have looped in Fabio and Haibo that knows this driver,
let's see if they can help.

>
> Thanks
> Xiaolei

Kind regards
Uffe

>
> -----Original Message-----
> From: Ulf Hansson <ulf.hansson@linaro.org>
> Sent: Wednesday, January 20, 2021 9:41 PM
> To: Wang, Xiaolei <Xiaolei.Wang@windriver.com>
> Cc: Pali Roh=C3=A1r <pali@kernel.org>; Lee Jones <lee.jones@linaro.org>; =
linux-mmc@vger.kernel.org; Linux Kernel Mailing List <linux-kernel@vger.ker=
nel.org>
> Subject: Re: [PATCH] mmc: core: Apply trim broken quirk to R1J57L
>
> [Please note this e-mail is from an EXTERNAL e-mail address]
>
> On Mon, 18 Jan 2021 at 05:27, Xiaolei Wang <xiaolei.wang@windriver.com> w=
rote:
> >
> > R1J57L mmc chip hw capibility indicates that it supports trim
> > function, but this function does not work properly, the SDIO bus does
> > not respond, and the IO has been waiting so set quirks to skip trim
>
> Are you sure this is an eMMC problem and not a mmc host driver issue?
>
> Can you elaborate more what happens?
>
> Kind regards
> Uffe
>
> >
> > Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> > ---
> >  drivers/mmc/core/quirks.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> > index d68e6e513a4f..63e02391c133 100644
> > --- a/drivers/mmc/core/quirks.h
> > +++ b/drivers/mmc/core/quirks.h
> > @@ -89,6 +89,8 @@ static const struct mmc_fixup __maybe_unused mmc_blk_=
fixups[] =3D {
> >                   MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
> >         MMC_FIXUP("VZL00M", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_quir=
k_mmc,
> >                   MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
> > +       MMC_FIXUP("R1J57L", CID_MANFID_MICRON, CID_OEMID_ANY, add_quirk=
_mmc,
> > +                 MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
> >
> >         /*
> >          *  On Some Kingston eMMCs, performing trim can result in @@
> > -98,6 +100,8 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fi=
xups[] =3D {
> >                   MMC_QUIRK_TRIM_BROKEN),
> >         MMC_FIXUP("V10016", CID_MANFID_KINGSTON, CID_OEMID_ANY, add_qui=
rk_mmc,
> >                   MMC_QUIRK_TRIM_BROKEN),
> > +       MMC_FIXUP("R1J57L", CID_MANFID_MICRON, CID_OEMID_ANY, add_quirk=
_mmc,
> > +                 MMC_QUIRK_TRIM_BROKEN),
> >
> >         END_FIXUP
> >  };
> > --
> > 2.25.1
> >
