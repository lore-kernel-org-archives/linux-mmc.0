Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968B2C433F5
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Nov 2021 15:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7663B61207
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Nov 2021 15:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240196AbhKHPDZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Nov 2021 10:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234731AbhKHPDY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Nov 2021 10:03:24 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A886C061570
        for <linux-mmc@vger.kernel.org>; Mon,  8 Nov 2021 07:00:40 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id p16so36863493lfa.2
        for <linux-mmc@vger.kernel.org>; Mon, 08 Nov 2021 07:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NSTQzYJRWmUa8HDHRPnVFUMCKGtizSx9Zp/eRuhf0I4=;
        b=KFog4aZDxepJW+x80u2oSQVis6MUievGTZprsC/FLW5RLc5MOd0W60MK1xlJCbHtIL
         aSvdbgJvOzJhnb+PtwRUtsqFxCrx1V85R4YyppgN/qJopJ/66F/ofVVlz9IOobryEBJm
         vi3r9gZRR8gpBmVyESbdchFFv9ap3apHIbfXasWZlQnHT2as1nP+WsK56OSC0obS/E4c
         7ksFjh5xqzT+RtghecV0JeY9NHihqBVJXY0rfqk8OSBCMEG1POlXreVqFlooPEGeH1DK
         scMbIScbPWCKWfGx5oqWz7vapdTSrzs2oM9AnG9Bq7zLIm53GrJnoqCaVCZMaAh3qLUn
         Brqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NSTQzYJRWmUa8HDHRPnVFUMCKGtizSx9Zp/eRuhf0I4=;
        b=jZIIb/s/4mAXvfLmIiHYzU3zZ/jexJIrgOt9E9IDdkPySi56rodgncaXtc8EX4D+gG
         KJ4v6y0A/WHy+qcUoAGaULiIxbejeDkwiQDpE3S/7j6zE9/tQGgncGR+Q1bVufb/BOkW
         30e753N2N+SJHIl/L+g9tO2u5G4wGekHMX7Edryqle9z/zibtKdYer9XEoK8bGjklNsl
         C9epLm7e1yJwyG9uTD7X8IewQv6nWCU+YTcCUV130ME00LUMiGVlEGNMVxJmFb6qe+36
         0R/FBPqq2TGyyMOApmaQFYwE2PBmIxA1Pgeki5M1zwr2Ru+UN3iJhd2MNFxseLJWJdHK
         bCzg==
X-Gm-Message-State: AOAM532eYPZgp8ATKKug+Rm2OUGBaha++5mhnTSQe3ukI7gU6Cfpl3UJ
        SWxX9jMDUrcyQbLb7WvYTbLY+GF++mgC85Fjq1o8YQ==
X-Google-Smtp-Source: ABdhPJwIkFTWhf65ohVl5zLi9xzGO3YL9vA7Sp8rqRwe+aOyuz1yYzAemJJVh4ab8ZlwS3nPfsFt7vdw0lCgtagWByU=
X-Received: by 2002:a19:8c4d:: with SMTP id i13mr119053lfj.254.1636383638105;
 Mon, 08 Nov 2021 07:00:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1636103151.git.hns@goldelico.com> <e072de2b480103dbebd941f35be96197534642ee.1636103151.git.hns@goldelico.com>
 <4570288.hTGhjlNkSs@pc-42> <7121F069-56C7-402C-BA82-A922B1A36587@goldelico.com>
In-Reply-To: <7121F069-56C7-402C-BA82-A922B1A36587@goldelico.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 8 Nov 2021 16:00:02 +0100
Message-ID: <CAPDyKFo09xhaWbGgWuPa2=x0zXCfir0VMDhd4ZdSc8rh25nG9A@mail.gmail.com>
Subject: Re: [RFC v4 2/6] mmc: core: allow to match the device tree to apply quirks
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <Jerome.Pouiller@silabs.com>,
        Avri Altman <avri.altman@wdc.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Bean Huo <beanhuo@micron.com>, notasas@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 6 Nov 2021 at 15:31, H. Nikolaus Schaller <hns@goldelico.com> wrote=
:
>
> Hi J=C3=A9r=C3=B4me,
>
> > Am 05.11.2021 um 15:27 schrieb J=C3=A9r=C3=B4me Pouiller <jerome.pouill=
er@silabs.com>:
> >
> > On Friday 5 November 2021 10:05:47 CET H. Nikolaus Schaller wrote:
> >> From: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
> >>
> >> MMC subsystem provides a way to apply quirks when a device match some
> >> properties (VID, PID, etc...) Unfortunately, some SDIO devices does no=
t
> >> comply with the SDIO specification and does not provide reliable VID/P=
ID
> >> (eg. Silabs WF200).
> >>
> >> So, the drivers for these devices rely on device tree to identify the
> >> device.
> >>
> >> This patch allows the MMC to also rely on the device tree to apply a
> >> quirk.
> >>
> >> Signed-off-by: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
> >
> > Thank you for to have taken care of that (Maybe, you would like to add =
a
> > "Co-developed-by:" tag).
>
> Well, I just have taken your and Ulf's proposal and done 90% copy&paste.
> So there wasn't much development, just editing...
>
> >
> >
> >> ---
> >> drivers/mmc/core/card.h   |  3 +++
> >> drivers/mmc/core/quirks.h | 17 +++++++++++++++++
> >> 2 files changed, 20 insertions(+)
> >>
> >> +static inline bool mmc_fixup_of_compatible_match(struct mmc_card *car=
d,
> >> +                                                const char *const *co=
mpat_list)

After a second thought, I am not sure we really need a list of
compatibles here. The quirks we may want to apply should be specific
per device and most likely not shared among a family of devices, don't
you think?

> >> +{
> >> +       struct device_node *np;
> >> +
> >> +       for_each_child_of_node(mmc_dev(card->host)->of_node, np) {
> >> +               if (of_device_compatible_match(np, compat_list))
> >> +                       return true;
> >
> > Intel robot complains about of_device_compatible_match():
> >
> >    ERROR: modpost: "of_device_compatible_match" [drivers/mmc/core/mmc_c=
ore.ko] undefined!
> >
> > I think we have to add this line:
> >
> >    EXPORT_SYMBOL(of_device_compatible_match);
> >
> > in drivers/of/base.c

If we change to use one compatible string, rather than a list - then
we can use of_device_is_compatible() instead, which is already
properly exported with EXPORT_SYMBOL().

>
> I had seen the krobot message as well but could not figure out
> what it meant...
>
> But with your hint it indeed looks like an omission in drivers/of/base.c
> Having something exported in include/linux/of.h but code not
> marked EXPORT_SYMBOL...
>
> That needs a separate patch. I'll add one with a
>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
>
> and some Fixes: tag. Since it has a different audience I think
> I should post it separately.
>
> BTW: krobot noted the same issue for mmc_of_find_child_device()
> in drivers/mmc/core/core.c (which we do not touch in this series).
> But maybe it should be fixed as well.

If there is an existing problem, please send a separate fix/patch for that.

>
> So let's wait for more comments and then I may distribute a [PATCH v1].
> Or should I do a [PATCH v5] to continue version counting?

I suggest moving from RFC into using PATCH v1, as this isn't really an
RFC any more.

>
> BR,
> Nikolaus
>

Kind regards
Uffe
