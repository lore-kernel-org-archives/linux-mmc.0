Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71299C001E0
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Aug 2023 11:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbjHOLl3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Aug 2023 07:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236851AbjHOLlX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Aug 2023 07:41:23 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D76010E0
        for <linux-mmc@vger.kernel.org>; Tue, 15 Aug 2023 04:41:19 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d3d729a08e4so5139906276.3
        for <linux-mmc@vger.kernel.org>; Tue, 15 Aug 2023 04:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692099678; x=1692704478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEvbIYBzqlpIbOwD2jshBnebopDU4klP4ZBGtz/pQuE=;
        b=X3k0VgdImwLs8QKcRHdbHT9eFroEIF0IMV1dfxc0uH1u0PBhjdHCp+ls0y6y2S2bJJ
         hWcNx8HqHT2V0Lu/e2pAehvNA2lm5459HhyifUnn8vbN4jW2xLwhXdL2UTv1GQBO8+m5
         LjB8kUmSGmUnf24UpULRfjNFRTYDXqNHTQ0NK5tn6OQTUXd0d8alJ4DUcxO2NSUgj7t/
         UhE59MHNvpnzgOzdNmbY7fIfSGkypRS57G9323c0lJx6t8tIXJQ6Aui5wGe+XtpnqXRy
         fiPCC7LV2Wr6LMso0py3geqZkAmfvqoZ7+62y4YqcxSuahWa3KtXuXR4nIQma/iC7sG2
         8vzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692099678; x=1692704478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEvbIYBzqlpIbOwD2jshBnebopDU4klP4ZBGtz/pQuE=;
        b=dE4+JnVxmxPBXuZvUEwwTpdIh9J92aZ4b4sH0Q0TbkLko57QIel+uTgmbpSoA8WhJZ
         /Qmzu9c7XEND5rxv9RiSbncO5QaM/beS7dgcs84QSr3ZCLxxYYYDu6mY2jbmZv+uSxa8
         UZQnCoTEET0cpz8WA417+9SyOqKUjqwjuUSkM38KMLsh1wkDjSpJjxf/be0iS3rRLXHT
         R87v1RKJq4q1fGplKAL4ZgD2RuWzNHBVj76ksSbK696QUjSx8mNk8dQM4PnBwBLJUQMB
         04bJMnZEHfD5xFLNRyjOM8ie0obsGJtINHe5s32NLRMPVyM48soLXR6hCyucFAmE1aDM
         LgWQ==
X-Gm-Message-State: AOJu0YyOPEH9Q7DrWbX6j1B6Hh66nuVdQAX4hdLdNQI1nC4iPxP5lLLZ
        dIM4ZKy5GfeVXu3EDBGgY7mWXEbljNmsuj2GYaOuVw==
X-Google-Smtp-Source: AGHT+IGqqVEBuRmiao39L6hulgTQo9WV9b/yGcuLKO6d2VRjQFykkOwgZpNtoMOiF8U9pOBkiPjPEieITDA1co8zhmI=
X-Received: by 2002:a25:23d6:0:b0:d05:1eb8:2c43 with SMTP id
 j205-20020a2523d6000000b00d051eb82c43mr11982408ybj.30.1692099678580; Tue, 15
 Aug 2023 04:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230727070051.17778-1-frank.li@vivo.com> <CAPDyKFr5smUN5VHCo-O_iFB=qzHFg5Gn9d6wm3bw+5UEy9n=Ww@mail.gmail.com>
In-Reply-To: <CAPDyKFr5smUN5VHCo-O_iFB=qzHFg5Gn9d6wm3bw+5UEy9n=Ww@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 15 Aug 2023 13:40:42 +0200
Message-ID: <CAPDyKFpv_KzH0KcQVUsysBpWohdwEz=+JXN6QTuw0_+jxh94SQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/62] mmc: sunxi: Convert to platform remove callback
 returning void
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 7 Aug 2023 at 17:26, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 27 Jul 2023 at 09:01, Yangtao Li <frank.li@vivo.com> wrote:
> >
> > The .remove() callback for a platform driver returns an int which makes
> > many driver authors wrongly assume it's possible to do error handling b=
y
> > returning an error code. However the value returned is (mostly) ignored
> > and this typically results in resource leaks. To improve here there is =
a
> > quest to make the remove callback return void. In the first step of thi=
s
> > quest all drivers are converted to .remove_new() which already returns
> > void.
> >
> > Trivially convert this driver from always returning zero in the remove
> > callback to the void returning variant.
> >
> > Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
>
> Normally I would prefer one patch per host driver, but in this series
> the changes are so trivial that it just becomes more difficult for me
> to manage.
>
> Please squash all changes that convert from using ->remove() to
> .remove_new() into one single patch for the mmc host drivers. Note
> that, I discovered there are some additional cleanups being part of
> the series, those deserve to be submitted indepently of this.

Okay, so I decided to pick the series anyway. Applied for next (except
for patch 62 which went to fixes), thanks!

Kind regards
Uffe



>
> Kind regards
> Uffe
>
> > ---
> >  drivers/mmc/host/sunxi-mmc.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.=
c
> > index 69dcb8805e05..d3bd0ac99ec4 100644
> > --- a/drivers/mmc/host/sunxi-mmc.c
> > +++ b/drivers/mmc/host/sunxi-mmc.c
> > @@ -1486,7 +1486,7 @@ static int sunxi_mmc_probe(struct platform_device=
 *pdev)
> >         return ret;
> >  }
> >
> > -static int sunxi_mmc_remove(struct platform_device *pdev)
> > +static void sunxi_mmc_remove(struct platform_device *pdev)
> >  {
> >         struct mmc_host *mmc =3D platform_get_drvdata(pdev);
> >         struct sunxi_mmc_host *host =3D mmc_priv(mmc);
> > @@ -1499,8 +1499,6 @@ static int sunxi_mmc_remove(struct platform_devic=
e *pdev)
> >         }
> >         dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg=
_dma);
> >         mmc_free_host(mmc);
> > -
> > -       return 0;
> >  }
> >
> >  #ifdef CONFIG_PM
> > @@ -1556,7 +1554,7 @@ static struct platform_driver sunxi_mmc_driver =
=3D {
> >                 .pm =3D &sunxi_mmc_pm_ops,
> >         },
> >         .probe          =3D sunxi_mmc_probe,
> > -       .remove         =3D sunxi_mmc_remove,
> > +       .remove_new     =3D sunxi_mmc_remove,
> >  };
> >  module_platform_driver(sunxi_mmc_driver);
> >
> > --
> > 2.39.0
> >
