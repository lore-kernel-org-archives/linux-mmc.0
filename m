Return-Path: <SRS0=Q/yj=6H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A942C55186
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Apr 2020 12:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26F1B2074F
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Apr 2020 12:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HGdvKG3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgDWMW1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Apr 2020 08:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726071AbgDWMW1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Apr 2020 08:22:27 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0537AC08E859
        for <linux-mmc@vger.kernel.org>; Thu, 23 Apr 2020 05:22:26 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id t8so5431777uap.3
        for <linux-mmc@vger.kernel.org>; Thu, 23 Apr 2020 05:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zQp/+NnZT7xuP7zQ8iR6+6K7f5pp2S+U2r/fnGuT0Ss=;
        b=HGdvKG3DWQOKq1jelJ/RuzPy/tbrJMWphiFTtCkymuxBRKdjlGhNtZEi0Kt0bmdV2a
         xv5A+t2HqrfGrEBgWa6pm40bDm/Mt2MnMzs/reNMk9qtbAPAsJ2vOjmhRnMrcD4DPupT
         py150V+OjRpFRb7Js3Y1+qiRop7emtt+QvDKjXFTqBDG2+hj/NJUXvh+e6L3T8VkCbYs
         6VCt0cXj1xKujb80FDNI8QwpbPoUe08QlFEViKzgkYVFBnkryx7zXQmnleUySwGv1fUj
         4oAxFklpVn5O/8ZEvAmWA1QeI5t6xWV0GXBCtpZT0NjbUNJQ8CiOq5QYefsmruUCADJ8
         EodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zQp/+NnZT7xuP7zQ8iR6+6K7f5pp2S+U2r/fnGuT0Ss=;
        b=JgNPaJFRM+QS2l08viPiAB3znG4zYr8FmTyvbWrbyO6rhSH8OvwJ91xlpZ++S3/LLS
         qZB3/BlD2WAKqV8GzuO01Z6Wqvfu1uYmHlFWvLAs9KiNb12XLOq72heyvju3MolXRdEc
         khELwSuXxcDSp4T27yS8x1xxRXnPYn0hXPxoXwSc1t/NMPXboSIg1A45FJrLiU7CV2LQ
         AftbMKiHeA/HGMxSL6s0G1KBvz+8hhqfQxXnpwGsNiJdZxvz8piY3VGlZie0cgme9K+k
         mMuerSUHeosW28vNN2mwnfW4JaED8GBOlDeCenBgMvVIfAs0J8/pJQhzzMvtmf8/8ZRc
         QGfg==
X-Gm-Message-State: AGi0Pua0TnWISIMwuG/ziql9ZuRa9uFx2EVWhhwk4QBbYvwIzdGnBhO7
        aUPLvGtGfoz9+V3VtvnXBrdu5AjblA5h+A0+32a+6J4bkDY=
X-Google-Smtp-Source: APiQypIvMNnUtDTaqa3c9rLP6PGh1YHIOgeazgeaHOCVrZkHTM+3JCNPyqBZXIAga7ZH8cCkAGiF5V8I8SCrgq4WWiY=
X-Received: by 2002:a67:f24b:: with SMTP id y11mr2692108vsm.165.1587644545946;
 Thu, 23 Apr 2020 05:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <1587633319-19835-1-git-send-email-zou_wei@huawei.com>
 <CAPDyKFogU2BT1vmcovrGvNEOtS+cxWwM09foMfN3bOPXEhhT3g@mail.gmail.com> <C3CD0DF8AD11A84CB25A1426DE537C61E59522ED@dggeml524-mbx.china.huawei.com>
In-Reply-To: <C3CD0DF8AD11A84CB25A1426DE537C61E59522ED@dggeml524-mbx.china.huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Apr 2020 14:21:50 +0200
Message-ID: <CAPDyKFpf7HWUk3Ss=swvrGYBh_nDoKW02vqThbN=CWwekp4zrA@mail.gmail.com>
Subject: Re: [PATCH -next] mmc: core: Use DEFINE_DEBUGFS_ATTRIBUTE instead of DEFINE_SIMPLE_ATTRIBUTE
To:     "Zouwei (Samuel)" <zou_wei@huawei.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 23 Apr 2020 at 13:55, Zouwei (Samuel) <zou_wei@huawei.com> wrote:
>
> Hi Ulf,
>
> Thanks for your review and reply.
>
> 1. DEFINE_SIMPLE_ATTRIBUTE + debugfs_create_file() imposes some significa=
nt overhead as compared to DEFINE_DEBUGFS_ATTRIBUTE + debugfs_create_file_u=
nsafe().
>   You can refer to the patch of 1a2b3666da58 ("mt76: fix debugfs_simple_a=
ttr.cocci warnings")

I see.

> 2. debugfs_create_file_unsafe(...&mmc_clock_fops) is corresponds to DEFIN=
E_DEBUGFS_ATTRIBUTE(mmc_clock_fops...), so I only modified this one.

I have now read the complete function header of
debugfs_create_file_unsafe() and realized that this is indeed okay.

>
> -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Ulf Hansson [mailto:ulf.hansson@linaro.org]
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2020=E5=B9=B44=E6=9C=8823=E6=97=A5 =
19:17
> =E6=94=B6=E4=BB=B6=E4=BA=BA: Zouwei (Samuel) <zou_wei@huawei.com>
> =E6=8A=84=E9=80=81: linux-mmc@vger.kernel.org; Linux Kernel Mailing List =
<linux-kernel@vger.kernel.org>
> =E4=B8=BB=E9=A2=98: Re: [PATCH -next] mmc: core: Use DEFINE_DEBUGFS_ATTRI=
BUTE instead of DEFINE_SIMPLE_ATTRIBUTE
>
> On Thu, 23 Apr 2020 at 11:09, Zou Wei <zou_wei@huawei.com> wrote:
> >
> > Fixes coccicheck warning:
> >
> > drivers/mmc/core/debugfs.c:222:0-23: WARNING: mmc_clock_fops should be
> > defined with DEFINE_DEBUGFS_ATTRIBUTE
> >
> > Use DEFINE_DEBUGFS_ATTRIBUTE rather than DEFINE_SIMPLE_ATTRIBUTE for
> > debugfs files
> >
> > Fixes: 703aae3d09a4b ("mmc: add a file to debugfs for changing host
> > clock at runtime")
> > Fixes: a04c50aaa916f ("mmc: core: no need to check return value of
> > debugfs_create functions")
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Zou Wei <zou_wei@huawei.com>

Applied for next, thanks!

Kind regards
Uffe

> > ---
> >  drivers/mmc/core/debugfs.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> > index 09e0c76..9ec84c8 100644
> > --- a/drivers/mmc/core/debugfs.c
> > +++ b/drivers/mmc/core/debugfs.c
> > @@ -219,7 +219,7 @@ static int mmc_clock_opt_set(void *data, u64 val)
> >         return 0;
> >  }
> >
> > -DEFINE_SIMPLE_ATTRIBUTE(mmc_clock_fops, mmc_clock_opt_get,
> > mmc_clock_opt_set,
> > +DEFINE_DEBUGFS_ATTRIBUTE(mmc_clock_fops, mmc_clock_opt_get,
> > +mmc_clock_opt_set,
> >         "%llu\n");
> >
> >  void mmc_add_host_debugfs(struct mmc_host *host) @@ -232,8 +232,8 @@
> > void mmc_add_host_debugfs(struct mmc_host *host)
> >         debugfs_create_file("ios", S_IRUSR, root, host, &mmc_ios_fops);
> >         debugfs_create_x32("caps", S_IRUSR, root, &host->caps);
> >         debugfs_create_x32("caps2", S_IRUSR, root, &host->caps2);
> > -       debugfs_create_file("clock", S_IRUSR | S_IWUSR, root, host,
> > -                           &mmc_clock_fops);
> > +       debugfs_create_file_unsafe("clock", S_IRUSR | S_IWUSR, root, ho=
st,
> > +                                  &mmc_clock_fops);
>
> Apologize for my ignorance, but why convert to the *_unsafe option for th=
is one, but not for the others?
>
> [...]
>
> Kind regards
> Uffe
