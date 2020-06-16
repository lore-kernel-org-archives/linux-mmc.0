Return-Path: <SRS0=InOK=75=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35367C433E1
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Jun 2020 11:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1213720B80
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Jun 2020 11:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g4DpScBl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgFPLdd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 16 Jun 2020 07:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728636AbgFPLdX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Jun 2020 07:33:23 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827A6C08C5C5
        for <linux-mmc@vger.kernel.org>; Tue, 16 Jun 2020 04:33:23 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id q69so4698999vkq.10
        for <linux-mmc@vger.kernel.org>; Tue, 16 Jun 2020 04:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c/wQCOtZ7VPDw2XJ2yptMvRf8QIvCUh49jB4HiuppiU=;
        b=g4DpScBl9piGKELlbYgtS+DzFMLyVA8mcZAQPN/a67D0w3YcTWO87waVHna+DmP/Vi
         wOjno2wXPcO/tmawg6lyfFVkYRjVWcFUjzcX8ncbEsl92C5lmNTbEXFdUDMQjUlUyizh
         UrxZ6F5d90KfhD9T4YFQwnYYNDyJaWnuuzGhEQJweMgVRnTJNuk6hY2HjZa0HYVzUPZa
         7SVH6sx8Wif1/xvpqqEhrZWDzPsdK7BVedOzIdRnxFDrpnFRBfdjkglXI1QNor1kBxsh
         66z7pbpYEkGcPe217Xbh5qMxzVBcVh1Lan997HROoFQoKPGbh/RhJNyU3L2RkG7NiRAy
         qwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c/wQCOtZ7VPDw2XJ2yptMvRf8QIvCUh49jB4HiuppiU=;
        b=jcchyzSUblLR4tWJm/t/Nd9lVqwGx0EGglsUlz/A9uKTfUDuHPXZnW8xHVpKOH3ALg
         9Jz8Df5GCOUt/ZAqdWLS84Qe/hQoev+0F9Y2ipyOvQFA9umQPm73aZF4P65/PmNcFWE4
         hrce99kAx0LklroOq9NqqIur1LuXBtGBST8iJmrSk9GTsaqqmqqMcX8A2B+0u2sc2osP
         CESjmyOf7d4nPwZaNEmMXVTHuBU+Bx2scvYrdae91n5+f6+CTNwN54vqETLvnkyOHbCt
         voNneX7A2TXzwzdPTET0dWCJaD37j3Rcqflw2U059OsQ0PHRySI+40t8Q+sLhQEzTUse
         MOcQ==
X-Gm-Message-State: AOAM5315TYxcLxe5WHVP8Z8aZqSKe4Eatf5W8jDXfJBOcwhGVn1Utugu
        sdNsAjQ3vo9QL6raAuddx5kuznjfhnr4p/qeubuYAg==
X-Google-Smtp-Source: ABdhPJwLCepxeafgO/HW2u7C9kc53qMMeSr00IXvmoitUxDXnfAcpAR3O26smpsI/3iC1LSgNWtb3JVQ+h/63iGzR5g=
X-Received: by 2002:a1f:c103:: with SMTP id r3mr1142395vkf.25.1592307202724;
 Tue, 16 Jun 2020 04:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200609081431.6376-1-zbestahu@gmail.com> <CAPDyKFr+NKoQVLqK9J-gmW9E7pwfZKeJQ8JEdx792jDA1kYKiA@mail.gmail.com>
 <20200609184032.00001199.zbestahu@gmail.com>
In-Reply-To: <20200609184032.00001199.zbestahu@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 16 Jun 2020 13:32:46 +0200
Message-ID: <CAPDyKFpewV+N39uDxZKx9qsPFrBbhjKHDLWGkP9ATACeJyJ+XA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdio: Fix 1-bit mode for SD-combo cards during suspend
To:     Yue Hu <zbestahu@gmail.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        huyue2@yulong.com, zhangwen@yulong.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 9 Jun 2020 at 12:40, Yue Hu <zbestahu@gmail.com> wrote:
>
> On Tue, 9 Jun 2020 12:01:42 +0200
> Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> > On Tue, 9 Jun 2020 at 10:14, Yue Hu <zbestahu@gmail.com> wrote:
> > >
> > > From: Yue Hu <huyue2@yulong.com>
> > >
> > > Commit 6b5eda369ac3 ("sdio: put active devices into 1-bit mode during
> > > suspend") disabled 4-bit mode during system suspend. After this patch,
> > > commit 7310ece86ad7 ("mmc: implement SD-combo (IO+mem) support") used
> > > new sdio_enable_4bit_bus() instead of sdio_enable_wide() to support
> > > SD-combo cards, also for card resume. However, no corresponding support
> > > added during suspend. That is not correct. Let's fix it.
> >
> > I believe the change makes sense to me.
> >
> > However, the commit 6b5eda369ac3 that you refer to is from v2.6.34,
> > which is more than ten years ago. That makes me wonder, are these
> > cards really being used?
>
> Current code logic will switch to 1-bit/4-bit mode in suspend/resume.
>
> >
> > Did you test this with a combo card?
>
> No, i have no real environment to test it. I'm just reading the code.
> Obviously, sdio_disable_wide() used in suspend is for SDIO cards only.
> However, sdio_enable_4bit_mode() used in resume is for SD-combo cards.
> We should also add the support in suspend to avoid the potential issue.
>
> Thank you.

Alright, let's give this a try and hopefully there is no regression reported.

Applied for next, thanks!

Kind regards
Uffe


>
> >
> > >
> > > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > > ---
> > >  drivers/mmc/core/sdio.c | 23 ++++++++++++++++++++++-
> > >  1 file changed, 22 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> > > index ebb387a..2d2ae35 100644
> > > --- a/drivers/mmc/core/sdio.c
> > > +++ b/drivers/mmc/core/sdio.c
> > > @@ -285,6 +285,27 @@ static int sdio_disable_wide(struct mmc_card *card)
> > >         return 0;
> > >  }
> > >
> > > +static int sdio_disable_4bit_bus(struct mmc_card *card)
> > > +{
> > > +       int err;
> > > +
> > > +       if (card->type == MMC_TYPE_SDIO)
> > > +               goto out;
> > > +
> > > +       if (!(card->host->caps & MMC_CAP_4_BIT_DATA))
> > > +               return 0;
> > > +
> > > +       if (!(card->scr.bus_widths & SD_SCR_BUS_WIDTH_4))
> > > +               return 0;
> > > +
> > > +       err = mmc_app_set_bus_width(card, MMC_BUS_WIDTH_1);
> > > +       if (err)
> > > +               return err;
> > > +
> > > +out:
> > > +       return sdio_disable_wide(card);
> > > +}
> > > +
> > >
> > >  static int sdio_enable_4bit_bus(struct mmc_card *card)
> > >  {
> > > @@ -960,7 +981,7 @@ static int mmc_sdio_suspend(struct mmc_host *host)
> > >         mmc_claim_host(host);
> > >
> > >         if (mmc_card_keep_power(host) && mmc_card_wake_sdio_irq(host))
> > > -               sdio_disable_wide(host->card);
> > > +               sdio_disable_4bit_bus(host->card);
> > >
> > >         if (!mmc_card_keep_power(host)) {
> > >                 mmc_power_off(host);
> > > --
> > > 1.9.1
> > >
> >
> > Kind regards
> > Uffe
>
