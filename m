Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A11CC07E96
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Jul 2021 13:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B27A61456
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Jul 2021 13:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhGHNGs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 8 Jul 2021 09:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbhGHNGs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Jul 2021 09:06:48 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D89C06175F
        for <linux-mmc@vger.kernel.org>; Thu,  8 Jul 2021 06:04:07 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id m12so3524680vst.8
        for <linux-mmc@vger.kernel.org>; Thu, 08 Jul 2021 06:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KEHvtk/qDbB4blO1SCEyQUaWYrL3oXULeK/saz6CTeE=;
        b=AoVRYb45kt0ltweZhxP5zSUmqreVyxGzhf0gfCOx5WHPtiPAeuuN2aeLc5WfwYke3G
         KCG5DghU1Hp3un1DSxPPc+BCmXKhndrA5ZfJU+LP+oSptOxPEOqzFdZEpKAhS+Wc81sz
         vKJgu6XBA/mWwzrEYesOipfqr+E3OpPg3DTWDEr9LbVpljtpI2bUyI5avGDqMoPMofb+
         QEzR9gpXS9XIpuiKfojrj1xM9LWCT1S83yT0/gNiJYt+yO5P1DSSBXH367plz4y/FLs8
         cLluvRJ8zgdIoDHf1H7lmrd1E4I+i6q42vNx/XbZ5CZ0JubHDui5MtOOPaaSxi9JZI3f
         Z9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KEHvtk/qDbB4blO1SCEyQUaWYrL3oXULeK/saz6CTeE=;
        b=SclkXuDDODfNKs8u/9XKk6yWIfXcAJrotZHQdpiwOiQPoipEexEj3s8U/o06MSvgBN
         VchuTZrHQXLRxMcdGHvhO/RUuJ3Zv1vEwi4tO/2hsDLi4JH3SxSi3iVqz25ZRvQWkIVg
         JsOkW6R2MEBV66iMrfySzPNpSIMPEPH40l2YMe9HGk+UxoAgPVVzqyubPn/BnB0zMenq
         AEwbLjYic8uFwA/w4jAWLxyf9p7BYQnajK6YQZ0dm8NHtfrP9SCkFcmiBUS7BJMDodf/
         2JRSE4ph0/Wv+Z/pA5kwsdgINSdahS8WLX90evN1X1t1xjXYpar4QXtnfQ4jOA30nsFw
         W7cA==
X-Gm-Message-State: AOAM532aXuSavQJ3wX+yAhzwSAIU2x067Wbw4q4IWERuGMTF2nj/dJiw
        ZbbK7VM2EB85SSkM6R27jVuVr9fRKR2jvoYbxOTusg==
X-Google-Smtp-Source: ABdhPJxXd15HTOj1S79pKDlOlKLm6vFjRSvtykjfTPrGVEJUaYx/vzhhBQjyJBbp+A/154EsGOxphqSdkkg0KisQ/yE=
X-Received: by 2002:a67:ee54:: with SMTP id g20mr27739180vsp.55.1625749446193;
 Thu, 08 Jul 2021 06:04:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210623101731.87885-1-andriy.shevchenko@linux.intel.com>
 <CAPDyKFoM-gkFPoFePbHS62r-HUpk6ipA5J-qPbQ8NWL9Mm_N2Q@mail.gmail.com> <CAHp75VfdDXwboZWZgRdFNXLpONy8UgDryeZWd6UD2RaCXo=uOw@mail.gmail.com>
In-Reply-To: <CAHp75VfdDXwboZWZgRdFNXLpONy8UgDryeZWd6UD2RaCXo=uOw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 8 Jul 2021 15:03:30 +0200
Message-ID: <CAPDyKFqmswO9a-Sv6Wk5x4XA0P-idT1zZwRvjVbK7oS=J2cesg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mmc: mmc_spi: Simplify busy loop in mmc_spi_skip()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 8 Jul 2021 at 14:50, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> On Thu, Jul 8, 2021 at 3:33 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On Wed, 23 Jun 2021 at 12:17, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
>
> ...
>
> > This certainly is an improvement.
> >
> > Although, what do you think of moving to readx_poll_timeout(), that
> > should allow even a better cleanup, don't you think?
>
> I believe you meant rather read_poll_timeout(). Either way I don't see
> the benefit of using that macro when you have to customize its body a
> lot. Besides that the macro doesn't use cond_sched() or even
> schedule() and I'm not sure it will be an equivalent change.
>
> That said, I prefer going this patch as is for the time being. We may
> adjust it later on.

Okay, no strong opinion from my side. Queued for v5.15 on my devel
branch, thanks!

Kind regards
Uffe
