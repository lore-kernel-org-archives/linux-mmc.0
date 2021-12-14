Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9821C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Dec 2021 12:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbhLNM4x (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Dec 2021 07:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbhLNM4w (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Dec 2021 07:56:52 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342F9C061574
        for <linux-mmc@vger.kernel.org>; Tue, 14 Dec 2021 04:56:52 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id a37so27083285ljq.13
        for <linux-mmc@vger.kernel.org>; Tue, 14 Dec 2021 04:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1FZZTetR/P0RMkY/shAktrybjzcJ8UfjNoMI6QX58FM=;
        b=Ews8P+oQzUpY9YsC0wxRiXck0o5RWmsD3N+6+WUUzVbFva2bR27cg2vJ2YylCcCV1N
         wpJfZ06+U3jAGcpaSgFZ1pqKRvTPb4gVv3vHGBHpVcr5wVJPXFWQ37lB/mmzrPepe9rz
         4m3BtVkh3mexS+7tMDTiBTsOfh0fI2AaXT5TR9r3OliFlzSCtnvANWz5Cp6uPq07PAnN
         paPOZVASmUlg0o0pvWlY+NA3Ztq5BAFYnBU8XBNaW0ShveuV+1THCnCNauvMWApgr7jx
         YbrlqtH22F6yey8OfvAqZPjIQb0hxQFgIgR60nufHogXFYXUs2e5lwOwHqjOCZ6zdfLh
         KVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1FZZTetR/P0RMkY/shAktrybjzcJ8UfjNoMI6QX58FM=;
        b=6/zSS09oFvZkmkPSrcT+DVBU1xl9eC84mMkdgFoJkWag6K0vkbJ+WrzTGfG/19ckVf
         96f8p+QbchNKBL+XX38BnN61l2zbKP5OE4CraFxIyCrP4UbFQkSE0VhpTw/sleRkZKVH
         Cc8YSdSKNWLN+Fpq86m3cbeT6GoEvwSdEKDT3j5wUjMPprFxHIA9+aYNCBeqWcrZ1Jmx
         tNTvpFON58X292norNixEG9vu8N5XP1oG2o9Vr0QYghVCFzSjWF7oHdPhUTr6Wam7xxG
         xorGq8OjlcuT90M1fuhLiTdiphZjXs+qU+ze1eFgDc7KfYIbRtqptyDKiLDO8fMDZhdB
         dlug==
X-Gm-Message-State: AOAM532B+LpUhVoixP0x1OZmiS40L0PJP4CNpMm5U/egZt2KINCeYuXZ
        ngf+K6eiz/N3ID+e1Z5p3mbzLGbxx2lLHuQzMY1CzrSGqME=
X-Google-Smtp-Source: ABdhPJzrNtoGy0rnwehohPas/v2xADVqPllBrQlIuB1dIOL2xy//vexYOeXCwxEHJ7TAcGbl6oAlPp4Byh5m7bWd5wU=
X-Received: by 2002:a05:651c:1507:: with SMTP id e7mr4985570ljf.300.1639486610431;
 Tue, 14 Dec 2021 04:56:50 -0800 (PST)
MIME-Version: 1.0
References: <20211202161910.3944640-1-quentin.schulz@theobroma-systems.com>
 <CAPDyKFoVyqR6h6oy7uhCfReQKk3_ErQF9iBG6bwDrxzSAY2HPg@mail.gmail.com> <20211213094514.rzalbzlgedpctekw@fedora>
In-Reply-To: <20211213094514.rzalbzlgedpctekw@fedora>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 Dec 2021 13:56:14 +0100
Message-ID: <CAPDyKFqLA2o9bYEiZDvaSQ7mHGuaa-94ROGDCBLuq8fJkdkqJQ@mail.gmail.com>
Subject: Re: [PATCH] mmc_cmds: add HS400 data rates
To:     Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc:     Avri Altman <avri.altman@wdc.com>, linux-mmc@vger.kernel.org,
        Quentin Schulz <foss+kernel@0leil.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 13 Dec 2021 at 10:45, Quentin Schulz
<quentin.schulz@theobroma-systems.com> wrote:
>
> Hi Ulf,
>
> On Wed, Dec 08, 2021 at 11:14:01AM +0100, Ulf Hansson wrote:
> > + Avri
> >
> > On Thu, 2 Dec 2021 at 17:19, Quentin Schulz
> > <quentin.schulz@theobroma-systems.com> wrote:
> > >
> > > JEDEC 5.1 JESD84-B50.1 DEVICE_TYPE [196] specifies that bit 6 is for
> > > "HS400 Dual Data Rate e=E2=80=A2MMC at 200 MHz =E2=80=93 1.8 V I/O" a=
nd bit 7 for
> > > "HS400 Dual Data Rate e=E2=80=A2MMC at 200 MHz =E2=80=93 1.2 V I/O" s=
o let's add those.
> > >
> > > Cc: Quentin Schulz <foss+kernel@0leil.net>
> >
> > Future wise, please don't use this to cc yourself another email. No
> > need to resend this time.
> >
>
> I've contributed to OSS projects with three different companies, each
> obviously having a different mail address.
>
> The point of the Cc was to be nice and give a way to contact me, were my
> mail address in the SoB to bounce in a few years.
>
> How do you usually handle that? or do you not care that much? Being
> curious how different project tackle this kind of issues.

Well, honestly I don't know how to best manage this.

Some people move into using a personal stable email, even for work
related issues, but it's not really ideal and it simply isn't a good
fit for all cases.

As I don't have a good answer for you, let's keep your cc, then we can
come back how to deal with this.

>
> > > Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> >
> > Even if the patch is trivial and looks good to me, I have added Avri
> > who helps to maintain mmc-utils, to make sure there are no objections.
> >
>
> Thanks for forwarding to the appropriate people.
>
> BTW, I struggled to find how to contribute to mmc-utils, would anyone be
> ok with adding a CONTRIBUTING or README at the root of the project?

That's certainly a good idea. Do you want to send a patch? Or just
tell me and I can do it.

We are more or less trying to follow the principles of how to
contribute to the kernel.
Avri acts as a reviewer and I take care of the git tree.

>
> Kind regards,
> Quentin

Kind regards
Uffe
