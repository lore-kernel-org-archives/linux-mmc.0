Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203DBC433E0
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Feb 2021 12:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C133064DCC
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Feb 2021 12:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhBHMLi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Feb 2021 07:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhBHMJ5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Feb 2021 07:09:57 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36ED7C0617AB
        for <linux-mmc@vger.kernel.org>; Mon,  8 Feb 2021 04:07:38 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id x201so7402290vsc.0
        for <linux-mmc@vger.kernel.org>; Mon, 08 Feb 2021 04:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q+j5o1c0su2L6YdF71vWuSQLkAAyzmVika0Z7We4Rac=;
        b=fGVWBffzUrOIaO3OE9oqhO2bDHkyUt6xA45dv+PjB3q6C2+dLEpXekxAyisHfGOK+K
         ykgs+JcdTimpWykmP6LCmsZIUB8GrEmDWzU/hg7gooX8xJWFXUZMNORu/vPtadQUMdR4
         1Om4gc4kgRhtpIllX9VLrQxhtdQKBd9LSk92ZhbA8B22mG00N9T+VjOIAKztk0/F57k1
         ESTec0UJjqRtFNbSEWwqm6dJFxzWDjgrBfnRX9IS8A1tAtfWhjWG5Ocz9ProgoozNGHR
         RN2ww2Ey2y0zLA7/edPES5Jf0PRSTh0lN0adOf5qc5lMY8M3+CFTgUVzIED9TKqP7TpX
         +qUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q+j5o1c0su2L6YdF71vWuSQLkAAyzmVika0Z7We4Rac=;
        b=ilaSuwsSCNCUNonIqFooN8DQ6iMYYlom1P5D5sV0l51L2zaFNCk473j3+xqMH64Oe4
         D77iwcClNIQei1sQmbtoHW0VYHwLuMWfEK1ME/BTPDapvvaRUp1PAGrfW1F63YWBRVwy
         4DStDgE2BYgyLgv6l1+DIqaGbCLYAFdauxZnBXJxibfmwqX68I28PqnQCYSPLUImarVX
         Z3Cbe01T03JdvAGXc8e9v3E4/4HUIgzaMOAmDN6z83GQlbCubqgq78g+hBQzsKBe5Bc6
         I86vfCwoMadB3DpK69K0NxDkjj8BAPzDT06wtMS2KKSavkofmEQMeXuLndl7Fs++jH0N
         9FWQ==
X-Gm-Message-State: AOAM530vjV6mFYnGd4dZI/vO6B0PRuk6HKNaQrvnNdO/7H99axkswla4
        OEZQj+AQQPDoIfCsjog4TCyR0W0Abtcwp0R1XOiwcc2B4TGfVw==
X-Google-Smtp-Source: ABdhPJzdeJt7cR2Lci0/u43eiwTMDXryQjeAQX7GjhkgnwIUBZrkUU985x0DMiJvS4aJ2y06E5DIneLyvogQpFyKpI4=
X-Received: by 2002:a67:c787:: with SMTP id t7mr10392016vsk.48.1612786057397;
 Mon, 08 Feb 2021 04:07:37 -0800 (PST)
MIME-Version: 1.0
References: <20210204151847.91353-1-kernel@esmil.dk>
In-Reply-To: <20210204151847.91353-1-kernel@esmil.dk>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 8 Feb 2021 13:07:00 +0100
Message-ID: <CAPDyKFrFPWu-mb+krWBYAC=DPpWDqYDseACRRFHyscKbG7yHaA@mail.gmail.com>
Subject: Re: [PATCH 0/9] drivers: mmc: Update trivial tasklet_init() callers
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ben Dooks <ben-linux@fluff.org>, Alex Dubov <oakad@yahoo.com>,
        Bruce Chang <brucechang@via.com.tw>,
        Harald Welte <HaraldWelte@viatech.com>,
        Pierre Ossman <pierre@ossman.eu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 4 Feb 2021 at 16:19, Emil Renner Berthing <kernel@esmil.dk> wrote:
>
> This updates callers of tasklet_init() in drivers/mmc to the new API
> in commit 12cc923f1ccc ("tasklet: Introduce new initialization API")
>
> All changes are made by coccinelle using the following semantic patch:
>
> @ match @
> type T;
> T *container;
> identifier tasklet;
> identifier callback;
> @@
>         tasklet_init(&container->tasklet, callback, (unsigned long)container);
>
> @ patch1 depends on match @
> type match.T;
> identifier match.tasklet;
> identifier match.callback;
> identifier data;
> identifier container;
> @@
> -void callback(unsigned long data)
> +void callback(struct tasklet_struct *t)
> {
>         ...
> -       T *container = \( (T *)data \| (void *)data \);
> +       T *container = from_tasklet(container, t, tasklet);
>         ...
> }
>
> @ patch2 depends on match @
> type match.T;
> identifier match.tasklet;
> identifier match.callback;
> identifier data;
> identifier container;
> @@
> -void callback(unsigned long data)
> +void callback(struct tasklet_struct *t)
> {
>         ...
> -       T *container;
> +       T *container = from_tasklet(container, t, tasklet);
>         ...
> -       container = \( (T *)data \| (void *)data \);
>         ...
> }
>
> @ depends on (patch1 || patch2) @
> match.T *container;
> identifier match.tasklet;
> identifier match.callback;
> @@
> -       tasklet_init(&container->tasklet, callback, (unsigned long)container);
> +       tasklet_setup(&container->tasklet, callback);
>
>
> Emil Renner Berthing (9):
>   mmc: atmel-mci: Use new tasklet API
>   mmc: au1xmmc: Use new tasklet API
>   mmc: dw_mmc: Use new tasklet API
>   mmc: omap: Use new tasklet API
>   mmc: s3cmci: Use new tasklet API
>   mmc: tifm_sd: Use new tasklet API
>   mmc: uniphier-sd: Use new tasklet API
>   mmc: via-sdmmc: Use new tasklet API
>   mmc: wbsd: Use new tasklet API
>
>  drivers/mmc/host/atmel-mci.c   |  6 +++---
>  drivers/mmc/host/au1xmmc.c     | 14 ++++++--------
>  drivers/mmc/host/dw_mmc.c      |  6 +++---
>  drivers/mmc/host/omap.c        |  7 +++----
>  drivers/mmc/host/s3cmci.c      |  6 +++---
>  drivers/mmc/host/tifm_sd.c     |  7 +++----
>  drivers/mmc/host/uniphier-sd.c | 14 ++++++--------
>  drivers/mmc/host/via-sdmmc.c   |  9 +++------
>  drivers/mmc/host/wbsd.c        | 35 +++++++++++++++-------------------
>  9 files changed, 45 insertions(+), 59 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe
