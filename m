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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D81C433E6
	for <linux-mmc@archiver.kernel.org>; Sat, 23 Jan 2021 03:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8D2D23B1F
	for <linux-mmc@archiver.kernel.org>; Sat, 23 Jan 2021 03:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbhAWDIz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 Jan 2021 22:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbhAWDIx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Jan 2021 22:08:53 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86623C06174A
        for <linux-mmc@vger.kernel.org>; Fri, 22 Jan 2021 19:08:13 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id f3so1841907vkf.5
        for <linux-mmc@vger.kernel.org>; Fri, 22 Jan 2021 19:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s8JHLn+Lar9/GKwo8PLehYd6UqlO7FcpGVT9TrFycf8=;
        b=Z7xv19V8g1Qu095MDBmulWL/sTjoSEvPg2P6F2KuOoIMNxhvFE6JkzuM7teyOcNMQv
         Ul+esKA5hyvTpsvt36g8MXMpmqxBQvoWVzmo0jT/41Yo5CRHTVh4pQ+WNLr/GD4Q0whq
         BMNa1l5NSWyTsFK24GLry/ImvSYU1XWD5VH3Z6sA9VN2kEd7K4MU8j5gDwwNUfE3ZKqB
         7nQPI/jHqYtAnns2lUCVPz2J2jX1D2hgg3K213wDEbIAvLKHITSiqCfrfLnkLSsSb9QW
         m0uxy3nt5Gul3TjNE4VO5hTuGlOSjqQNRdMZ2otxcpv+bhFh2K9BxGMwoImdaVbVEHcx
         MqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s8JHLn+Lar9/GKwo8PLehYd6UqlO7FcpGVT9TrFycf8=;
        b=I+6368qZ6tdC9kwP7oPpixaqGY//rV7ACth2IlWpWaOr6Wn5d+ivX5uC+3NDlRgI8g
         k6pr51fiGycs4xjk8WnB3fbtcZCYO/EfV/0eTDuiJ87QhrLctEuNK0oD9A7nu24f6at9
         qfhLZ64ySBtE2SDwu3iD9zV2MzblztlflD5s+2N0toqfOqcqsgv+/U18a0qgxnmriRBe
         Xh5pDDPCFPGXXj2Eih9J5N7Y2b8adehSA0scjhZhZkCJpTPqoB49UI7hcfdGndrlkcb7
         0arYkmwz5d3feQikdB8LTbl08ijzqFK+pz3N6bwkmT5F3tysIRija9fgM+HzF/l4mXu7
         EuhA==
X-Gm-Message-State: AOAM531NZ9/rPauLc+CmbfoYaK3m8ooKYzylWo9lY44Cj7B4NJLWvNf6
        vSy4Wxsdjnfg/jm0GU98qpc6iP4uhmOS9Q5dsPk=
X-Google-Smtp-Source: ABdhPJzAloFeUFZDa13HhXYUGnFNb/gY4N7Qbb6EYfqlEEbbzAgE4td2H5c0szoNUhReQMALV4RwgBQdVwt3A0GPWQM=
X-Received: by 2002:ac5:cde4:: with SMTP id v4mr221699vkn.21.1611371292479;
 Fri, 22 Jan 2021 19:08:12 -0800 (PST)
MIME-Version: 1.0
References: <20210120144550.697303-1-fengnanchang@gmail.com> <CAPDyKFqQ1C4vuyzwTV82q7ty=s5w6-4HX06gFqhhfjtzDbFA-A@mail.gmail.com>
In-Reply-To: <CAPDyKFqQ1C4vuyzwTV82q7ty=s5w6-4HX06gFqhhfjtzDbFA-A@mail.gmail.com>
From:   fengnan chang <fengnanchang@gmail.com>
Date:   Sat, 23 Jan 2021 11:08:01 +0800
Message-ID: <CALWNXx_x84iPkBzA=6kKziRA030ok5anW9oMsmUUjZFfhd7_Wg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: limit the time of retries when analyse tuples failed
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

yeah, I think it should tag this for stable kernels as well.
I will send a new version later.

Ulf Hansson <ulf.hansson@linaro.org> =E4=BA=8E2021=E5=B9=B41=E6=9C=8820=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8811:29=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, 20 Jan 2021 at 15:47, Fengnan Chang <fengnanchang@gmail.com> wrot=
e:
> >
> > when analyse tuples failed, may enter an endless loop=EF=BC=8Cso limit =
the time of retries.
>
> Since this is fixing a real bug for you, it looks like we should tag
> this for stable kernels as well, right?
>
> >
> > Signed-off-by: Fengnan Chang <fengnanchang@gmail.com>
> > ---
> >  drivers/mmc/core/sdio_cis.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/mmc/core/sdio_cis.c b/drivers/mmc/core/sdio_cis.c
> > index dcb3dee59fa5..47423a6d13fb 100644
> > --- a/drivers/mmc/core/sdio_cis.c
> > +++ b/drivers/mmc/core/sdio_cis.c
> > @@ -266,6 +266,7 @@ static int sdio_read_cis(struct mmc_card *card, str=
uct sdio_func *func)
> >
> >         do {
> >                 unsigned char tpl_code, tpl_link;
> > +               u64 timeout =3D get_jiffies_64() + 10 * HZ;
>
> To be consistent with how we do time based polling (see
> __mmc_poll_for_busy() in mmc_ops.c for example) I would prefer if you
> use a define for the timeout, rather than a magic value as here.
>
> #define SDIO_READ_CIS_TIMEOUT_MS  (10 * 1000) /* 10s */
>
> Additionally, regular jiffies should be sufficient I think. Thus I
> prefer if you could specify the timeout along the lines like the
> below:
> timeout =3D jiffies + msecs_to_jiffies(SDIO_READ_CIS_TIMEOUT_MS);
>
> >
> >                 ret =3D mmc_io_rw_direct(card, 0, 0, ptr++, 0, &tpl_cod=
e);
> >                 if (ret)
> > @@ -318,6 +319,8 @@ static int sdio_read_cis(struct mmc_card *card, str=
uct sdio_func *func)
> >                         prev =3D &this->next;
> >
> >                         if (ret =3D=3D -ENOENT) {
> > +                               if (time_after64(get_jiffies_64(), time=
out))
> > +                                       break;
> >                                 /* warn about unknown tuples */
> >                                 pr_warn_ratelimited("%s: queuing unknow=
n"
> >                                        " CIS tuple 0x%02x (%u bytes)\n"=
,
> > --
> > 2.25.1
> >
>
> Other than that, this looks okay to me.
>
> Kind regards
> Uffe
