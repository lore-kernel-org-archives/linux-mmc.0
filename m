Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CBCC433C1
	for <linux-mmc@archiver.kernel.org>; Wed, 31 Mar 2021 09:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E2A461981
	for <linux-mmc@archiver.kernel.org>; Wed, 31 Mar 2021 09:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbhCaJmB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 31 Mar 2021 05:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbhCaJlp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Mar 2021 05:41:45 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF209C061574
        for <linux-mmc@vger.kernel.org>; Wed, 31 Mar 2021 02:41:44 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id a15so9587464vsi.0
        for <linux-mmc@vger.kernel.org>; Wed, 31 Mar 2021 02:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CyV5l/qSm/ag0naSSeMCM51DYTUF9l9ZCJDa+1CrGYI=;
        b=I0U0pnY4a7V0lhAlSeDo+FioSEBLfG93+/WFF4IoPAw7hUMJL913zYOl8b86poCEGx
         /LZWV7x5ytOCG9+azc7DyLT7cU4i/UpD+AF9K7CR7kt3dd+cPFHailo3cIxhX7zAkHAD
         2lXyZJQqAuuD2t56FR/p64z6I3NXQTMaV8yomothj9rJZDxsq7Dr3cDrEqd5n92I3d19
         YKYbV1VTN6AY6xc+KuZVKuLwkpfD9ok82Ju1S9gL7JhKmdAYRL0o6EltEFicnxfQ4eaY
         JgY/88nPEnxOaBnRhn2L25kk+JZCYTKJUvkdKGQ2dqHYsUOrtAtwBjyegwgejVoYx8Ow
         jthw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CyV5l/qSm/ag0naSSeMCM51DYTUF9l9ZCJDa+1CrGYI=;
        b=aH3PvhbXQUNwTiYPfcwD99gbOuflBt4bFX8efTF6QUHc9+AKxgiOW6xicl8ouYopEM
         +v4f7rIa1Bly1Sx1AvT9bhAKxT/obyGj6LcLeTEyHkKVBlJbc+S49pokXzo5Q0iw7gXs
         yi1wTQZW7BkQ9htr8T+pITtyQXTI5L2byNg1rYJzr6+f5O8OJPrDtcbGNh6ACKnGKPFj
         aSBdSItwjoVe291wBDcIb6WD7kjcF2Jz1cF9b0lgqp/6BSI449OhZ7/iS25GMwjMIi/3
         gwd3wD4N+HnAi8YoumtzMCgpmtQ2wKnaJlgAKKV3pfTFaqNuydh0cQXHBq2IBwDN9dZZ
         uwbw==
X-Gm-Message-State: AOAM533AbEvyLAJQSZ1AAfzk4QkaIilkufBHLzBVG+ju85VM5urltkQv
        xUC2ksrSptDP+Ivtr8HUpYbU97uH9VEXT+co+vMcRA==
X-Google-Smtp-Source: ABdhPJwFevTv9+zgThvrOEwWcCAYGexwuMe4G4wnz72ZHFbdhEkqxc3wB3Cr1Dq0wLLgQ5+kITUAPm38iaD9Xo1MjJA=
X-Received: by 2002:a05:6102:21d1:: with SMTP id r17mr932535vsg.19.1617183704054;
 Wed, 31 Mar 2021 02:41:44 -0700 (PDT)
MIME-Version: 1.0
References: <1351172418.3304142.1547483917896.JavaMail.root@zimbra64-e11.priv.proxad.net>
 <1823652044.3512532.1547484650178.JavaMail.root@zimbra64-e11.priv.proxad.net> <SN6PR04MB49257FCC0D21341EDB735C1FFC810@SN6PR04MB4925.namprd04.prod.outlook.com>
In-Reply-To: <SN6PR04MB49257FCC0D21341EDB735C1FFC810@SN6PR04MB4925.namprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 31 Mar 2021 11:41:06 +0200
Message-ID: <CAPDyKFp-eeAHizorBASn=rbKcYOX+1QjtK5qXcpiNHfny4=2ZA@mail.gmail.com>
Subject: Re: [PATCH mmc-utils] Fix parsing of Product Revision and Serial Number
To:     Stephane Fillod <f8cfe@free.fr>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Avri Altman <Avri.Altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 15 Jan 2019 at 11:38, Avri Altman <Avri.Altman@wdc.com> wrote:
>
> >
> > According to MMC Standard (similar to SDCard Standard).
> >
> > Signed-off-by: Stephane Fillod <f8cfe@free.fr>
> Acked-by: Avri Altman <avri.altman@wdc.com>
>

Applied to git.kernel.org/pub/scm/utils/mmc/mmc-utils.git master, thanks!

Kind regards
Uffe


> > ---
> >
> > Rem: the field parsing order is fine in print_sd_cid().
> >
> > diff --git a/lsmmc.c b/lsmmc.c
> > index 9737b37..98c0c4d 100644
> > --- a/lsmmc.c
> > +++ b/lsmmc.c
> > @@ -550,7 +582,7 @@ void print_mmc_cid(struct config *config, char *cid)
> >       unsigned int crc;
> >
> >       parse_bin(cid, "8u6r2u8u48a4u4u32u4u4u7u1r",
> > -             &mid, &cbx, &oid, &pnm[0], &psn, &prv_major, &prv_minor,
> > +             &mid, &cbx, &oid, &pnm[0], &prv_major, &prv_minor, &psn,
> >               &mdt_year, &mdt_month, &crc);
> >
> >       pnm[6] = '\0';
