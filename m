Return-Path: <SRS0=U+Jx=5C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C2DC0044D
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 02:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8829520674
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 02:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxAw1x5u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgCQCCT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Mar 2020 22:02:19 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46615 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgCQCCS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Mar 2020 22:02:18 -0400
Received: by mail-qk1-f195.google.com with SMTP id f28so29966849qkk.13;
        Mon, 16 Mar 2020 19:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GfwiC+344U8psPjXqa0wm09HURQ3uUDHZEYcEibliGw=;
        b=IxAw1x5u4ehF5o0WeS17DGZ7kb7j9nMi2Xm1UqyutqGICGpvViUsiFRLaWVBHIhKoR
         3qTn8R8TfUTFe4TZDtRCnSnm87KSStORtK7JrqpO8anmsG7qKdBonpQXhpjOMNvkYJ0F
         XFTRn4t+e75LWMBYxSjJ8afc36eKQ/Jjmc1dcA/avO/4qcQ3VC/KG/HrplY4OKG7L5kE
         8tHZfCKMEgnGqX0Xc7LKZy8nOlFGUU8NwzZUvO+Cc+4yyw4/pP1+iUEMuC4qj+aNeyTN
         L4vidOkH/oOf+Ifnu6CBGU6zO0XafcysjMLAdEBSPbQT2Sww2dS57J+GCd4yKhkBLJr/
         R+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GfwiC+344U8psPjXqa0wm09HURQ3uUDHZEYcEibliGw=;
        b=qn/jOsLY7UyxPiaC98MeFsc6UPV7uFiEYqv+Km+Pz+PRdUzc9ZXjZJNxve5mRmxELI
         /4zFDujJSbLCMQebUz3yAZlnxfuCVO0u87Ty2tr7aisDwGbz74IvP1MumxmI5+uRKl46
         Pg4fQ1ttL9w3BME6i/+emMrI8nUI1ZrQJmo6ZDykVCjnl/1F8sTzlhuSp07ws/dh84wE
         kSV/ttiv8QxBlEbemSv5DhQPYs/kiNDzNG03Po8XLmxTdYG7SJWWqpuhhSEjBwwPhQW4
         rlmXop+j5MnvAX7uAgvNVkJwZRB0IXDU0Tg33O/Xr7ku8AejMJypprybvwBUDO3p877D
         DBOQ==
X-Gm-Message-State: ANhLgQ2u1HqNZWKHYuqXs/8Ka+RkIGpejDDhp8L6oQVC3qgTEApRdIrl
        DZZ+o8GZa2cVTvUuvOa3wDvCf0joO+cEp6PEnhPUZZ6j
X-Google-Smtp-Source: ADFU+vtpREl3Ph/YdBPhjq8xSZ78Hx8l94PN5EyvsxWf+Tot+Bmq/hpMD0ffX6sgsW2OsWdG33mFavYXIeggbdPnxNc=
X-Received: by 2002:a05:620a:539:: with SMTP id h25mr2652050qkh.395.1584410537015;
 Mon, 16 Mar 2020 19:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583307441.git.baolin.wang7@gmail.com> <b6c0c003d887bf7c272c493212f4f89d28097ad4.1583307441.git.baolin.wang7@gmail.com>
 <CAPDyKFoKzBPNFkG=4OenZ_7ZVgqfhhEDRxsSbu6cJOSgCPPL1Q@mail.gmail.com>
In-Reply-To: <CAPDyKFoKzBPNFkG=4OenZ_7ZVgqfhhEDRxsSbu6cJOSgCPPL1Q@mail.gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Tue, 17 Mar 2020 10:02:05 +0800
Message-ID: <CADBw62qMMBf8P0j-ya-Qz9WNhAMPrzE6h8P=_VLko3_yJ0cwAw@mail.gmail.com>
Subject: Re: [RESEND PATCH 2/3] mmc: host: sdhci-sprd: Implement the
 request_atomic() API
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Mar 16, 2020 at 7:47 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 4 Mar 2020 at 08:42, Baolin Wang <baolin.wang7@gmail.com> wrote:
> >
> > Implement the request_atomic() API for nonremovable cards, that means
> > we can submit next request in the irq hard handler context to reduce
> > latency.
> >
> > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> > ---
> >  drivers/mmc/host/sdhci-sprd.c | 28 ++++++++++++++++++++++++++--
> >  1 file changed, 26 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> > index 2ab42c5..bddf0f3 100644
> > --- a/drivers/mmc/host/sdhci-sprd.c
> > +++ b/drivers/mmc/host/sdhci-sprd.c
> > @@ -426,6 +426,27 @@ static void sdhci_sprd_request(struct mmc_host *mmc, struct mmc_request *mrq)
> >         sdhci_request(mmc, mrq);
> >  }
> >
> > +static void sdhci_sprd_request_atomic(struct mmc_host *mmc,
> > +                                     struct mmc_request *mrq)
> > +{
> > +       struct sdhci_host *host = mmc_priv(mmc);
> > +       struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
> > +
> > +       host->flags |= sprd_host->flags & SDHCI_AUTO_CMD23;
> > +
> > +       /*
> > +        * From version 4.10 onward, ARGUMENT2 register is also as 32-bit
> > +        * block count register which doesn't support stuff bits of
> > +        * CMD23 argument on Spreadtrum's sd host controller.
> > +        */
> > +       if (host->version >= SDHCI_SPEC_410 &&
> > +           mrq->sbc && (mrq->sbc->arg & SDHCI_SPRD_ARG2_STUFF) &&
> > +           (host->flags & SDHCI_AUTO_CMD23))
> > +               host->flags &= ~SDHCI_AUTO_CMD23;
>
> Looks like the above code is a copy of what is done in
> sdhci_sprd_request(). Perhaps add a helper function that deals with
> this to avoid open coding?

Sure. Will do in next version. Thanks.

>
> > +
> > +       sdhci_request_atomic(mmc, mrq);
> > +}
> > +
> >  static int sdhci_sprd_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
> >  {
> >         struct sdhci_host *host = mmc_priv(mmc);
> > @@ -561,6 +582,11 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
> >         if (ret)
> >                 goto pltfm_free;
> >
> > +       if (!mmc_card_is_removable(host->mmc))
> > +               host->mmc_host_ops.request_atomic = sdhci_sprd_request_atomic;
> > +       else
> > +               host->always_defer_done = true;
> > +
> >         sprd_host = TO_SPRD_HOST(host);
> >         sdhci_sprd_phy_param_parse(sprd_host, pdev->dev.of_node);
> >
> > @@ -654,8 +680,6 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
> >         if (ret)
> >                 goto err_cleanup_host;
> >
> > -       host->always_defer_done = true;
> > -
> >         ret = __sdhci_add_host(host);
> >         if (ret)
> >                 goto err_cleanup_host;
> > --
> > 1.9.1
> >
>
> Kind regards
> Uffe



-- 
Baolin Wang
