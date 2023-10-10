Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB60CD98C3
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Oct 2023 21:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjJJVE5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Oct 2023 17:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjJJVE4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Oct 2023 17:04:56 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA2E92
        for <linux-mmc@vger.kernel.org>; Tue, 10 Oct 2023 14:04:54 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d818d65f23cso6676038276.3
        for <linux-mmc@vger.kernel.org>; Tue, 10 Oct 2023 14:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696971894; x=1697576694; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0JPdI81s1g1jD64Q6FcuAIQKwcDv5/ca0TQcTmOhurM=;
        b=Os+bFrzjhKtV+ps1T390Qm8hpHMVq3LwUOgCgOVfUlkN3Q8TL8cVK0ReTu0o6Sq4JB
         2/wAEYVjoN2plvvMndkzomzIMsYozdssEUPQx5b5NS0wz5W3noHvSJMeB3mvmwW4oFnu
         FXMA4aVMjstZ4AvEWAcR736DnW62WaGhYP7aezjJK+/mPOITmfXCHoiGCLgiJlMl1pPv
         4/VpSq3O+EYV7x7Hk2TI1Gcp0UGmYE/x2oMdl689WUHUHorp56k2jfmOnjliti+CfnJ1
         Ck1dHaOiYmtG8dCclg7t2TwRqapvu4cr5BpQu4DHsSVTrUDDSJ6dPs0TqMpaY4VsTTmc
         Dm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696971894; x=1697576694;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0JPdI81s1g1jD64Q6FcuAIQKwcDv5/ca0TQcTmOhurM=;
        b=kaS9eGJk7bSQybw3Q3qDllqBRfrywzfezofdhZKZREQbwkalamE83qpGZxuzmt+kno
         OKwjIyyCOgwi/Zqf1e6eFEhIbV5jPF9e5g0xxKzxWHFJbdYxJgzGyWI+ZqvyGP2/vyiU
         p7XE8q7oBsL7uziSpD69b7+Cn19UlN2ilEordYsE0eTPkHwJUGUV5nHySftaddseoRAp
         CXc9TP3X7fHr6g4mNbM1qY22SNIdIIsBQ0XVGxX0jdg36vbRKk7bXUn3yfEDxeYk+eyg
         lWBp+aivzQiaalqjSl3qS/ttnNe2K4QPeHIIHvBKHoAfnM8Ek46t/gHsFKPvA5T5XlQR
         FtMg==
X-Gm-Message-State: AOJu0YxOeP/r0Pv1dNxGUFfaiLv9+Qtu6sB6rRRkj98QIKFusNTmMXKr
        T/wTBMIazbCDJoBWrNOF4h4X9cFvh0CirgWmRBSV8w==
X-Google-Smtp-Source: AGHT+IHuv4B4I/7pSOoU5p4zYXXxB+UnuU5+plZrypxjr00y7A8QvxFJzcakHp6OBM059ut4sqv1nhHOkk4zB/QCxkI=
X-Received: by 2002:a05:6902:707:b0:d84:afae:96a8 with SMTP id
 k7-20020a056902070700b00d84afae96a8mr23439973ybt.7.1696971893895; Tue, 10 Oct
 2023 14:04:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231001194943.658299-1-beanhuo@iokpp.de> <CAPDyKFpgPEhVuTbxe5YhYQ0W6907SwJRxSQLB1F2FbVW3zKHxg@mail.gmail.com>
 <254df9b8ca7475ad9dbd3a303c60e1f99eca9c56.camel@iokpp.de>
In-Reply-To: <254df9b8ca7475ad9dbd3a303c60e1f99eca9c56.camel@iokpp.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Oct 2023 23:04:16 +0200
Message-ID: <CAPDyKFofJR0xtpmjCQXM7=VzUeN5jQLD2AZYEWocuyCnYNObYw@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: Add quirk MMC_QUIRK_BROKEN_CACHE_FLUSH for Micron
 eMMC Q2J54A
To:     Bean Huo <beanhuo@iokpp.de>
Cc:     adrian.hunter@intel.com, beanhuo@micron.com,
        jakub.kwapisz@toradex.com, rafael.beims@toradex.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 10 Oct 2023 at 17:33, Bean Huo <beanhuo@iokpp.de> wrote:
>
> Hi Ulf,
>
> thanks for your comments, I didn't quite get your points:
>
> On Tue, 2023-10-10 at 16:20 +0200, Ulf Hansson wrote:
> > > @@ -2381,8 +2381,11 @@ enum mmc_issued mmc_blk_mq_issue_rq(struct
> > > mmc_queue *mq, struct request *req)
> > >                          }
> > >                          ret = mmc_blk_cqe_issue_flush(mq, req);
> > >                          break;
> > > -               case REQ_OP_READ:
> > >                  case REQ_OP_WRITE:
> > > +                       if (mmc_card_broken_cache_flush(card) &&
> > > !card->written_flag)
> >
> > It looks superfluous to me to check mmc_card_broken_cache_flush() and
> > !card->written_flag. Just set the card->written_flag unconditionally.
>
> what did you mean "Just set the card->written_flag unconditionally."?
> This means I just need to check card->written_flag and set card-
> >written_flag to true and false in the case
> MMC_QUIRK_BROKEN_CACHE_FLUSH? or don't need to call
> mmc_card_broken_cache_flush()?

I mean skip the checks above and just do the assignment below.

>
> >
> > > +                               card->written_flag = true;
> > > +                       fallthrough;
> > > +               case REQ_OP_READ:
> > >                          if (host->cqe_enabled)
> > >                                  ret = mmc_blk_cqe_issue_rw_rq(mq,
> > > req);
> > >                          else
> > > diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
> > > index 4edf9057fa79..b7754a1b8d97 100644
> > > --- a/drivers/mmc/core/card.h
> > > +++ b/drivers/mmc/core/card.h
> > > @@ -280,4 +280,8 @@ static inline int
> > > mmc_card_broken_sd_cache(const struct mmc_card *c)
> > >          return c->quirks & MMC_QUIRK_BROKEN_SD_CACHE;
> > >   }
> > >
> > > +static inline int mmc_card_broken_cache_flush(const struct
> > > mmc_card *c)
> > > +{
> > > +       return c->quirks & MMC_QUIRK_BROKEN_CACHE_FLUSH;
> > > +}
> > >   #endif
> > > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > > index 89cd48fcec79..47896c32086e 100644
> > > --- a/drivers/mmc/core/mmc.c
> > > +++ b/drivers/mmc/core/mmc.c
> > > @@ -1929,6 +1929,8 @@ static int mmc_init_card(struct mmc_host
> > > *host, u32 ocr,
> > >          if (!oldcard)
> > >                  host->card = card;
> > >
> > > +       card->written_flag = false;
> > > +
> >
> > How about doing this after a successful flush operation instead? In
> > other words in _mmc_flush_cache().
>
> Here initializes flag and the patch is intenting to eliminate the cache
> flush command before writing. what do you mean adding in
> mmc_flush_cache()?

mmc_init_card() is called while initializing and re-initializing the
card. So, it certainly works to reset the flag from here.

However, _mmc_flush_cache() is called before powering off the card,
which then would work similarly to the above, but also gets called for
REQ_OP_FLUSH. Wouldn't that mean that we may be able to skip some
unnecessary/troublesome cache flush requests if we would reset the
flag from  mmc_flush_cache(), rather than from mmc_init_card()?

Kind regards
Uffe
