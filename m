Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42BBC11F67
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Jun 2021 00:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A222261D58
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Jun 2021 00:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbhF3AfF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 29 Jun 2021 20:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbhF3AfF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Jun 2021 20:35:05 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFB5C061760
        for <linux-mmc@vger.kernel.org>; Tue, 29 Jun 2021 17:32:36 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id q16so1688151lfr.4
        for <linux-mmc@vger.kernel.org>; Tue, 29 Jun 2021 17:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RfnFimPRCxfTJmRt8thhHu4tHeBHNXexcJ0yUUdS3Qo=;
        b=FJfLARCuHIXBJT76/U6QnnPIAGkx7FRwCtrmcOCwz8H+rQDJySyi7e0TKs98bPl5y7
         YxEDxir75Xqt+eq6xVmmUyq3jd+uhgMpVD/Fy2CrLWkBcdRk6YBMQY1eL81A1JHRSvgr
         h6/sj7uYa2e8k1Dp3yZMR7yHvhVxWUAIOm7HAhiTuMYYbXXuFzwr3U3X3nS3rR08h2uD
         SULFOHOyp422skkmJnKKA4O5+Nxo+6g8KtrlfcqYgGc7S7rHqZDpCvb94BhRk1dK2lpD
         RzTEOuktkPL4cQlM95PlfXmp6wFoCu3tZDMyPbymcIV/sE9q9dZPB/U3vVg7K9iKfcMf
         uWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RfnFimPRCxfTJmRt8thhHu4tHeBHNXexcJ0yUUdS3Qo=;
        b=jpPw/Cf4kSRxmxCIouh+OoqWIKzmqo97I/HlgH1PF0ISLS6AhHXK3Hd4gbT9leEYGX
         qeAy+lUnqAck5mN8RcG4q7P2r89dg0r72Tko3tedZC01ej7V2Led2j1mhUC1JU94zWav
         aG5BFR7nP4qlNeyWrD1c9PwOADOgnQJ42KQFRbrYq3Pfoems6UzyvvFfIN22UFWs5Mh4
         c7fK+6d2qOGPvLxAoX0Y+3YTwBw+4vF1gdOji0VdnNRF4Z8K0GB542UCFi+JC0zdwX8C
         nD39gJEqAQ5u9oMitwqN4+b7jmmK0A/o7D6jDl32eJDixdasLltS8LHNRlvh+ERjlSBQ
         VCkg==
X-Gm-Message-State: AOAM531nWH+RxQ2HZA5OR8IxNjtvsWW8oLp30S1gYANyCiF0A4pCXWiM
        BlTywlf3RNQ/g/cERI05Cs/PAnocekVdlMFagcgY5Q==
X-Google-Smtp-Source: ABdhPJyyE7pWFPQzI9BKWR2SflSDIx0Yj/6qFHvxhfS/sbtibNON8JqmFePfT7ez4SGdJEUCAXReF79M+R1i12vS5iU=
X-Received: by 2002:ac2:5237:: with SMTP id i23mr26325127lfl.29.1625013155161;
 Tue, 29 Jun 2021 17:32:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210619225118.1862634-1-linus.walleij@linaro.org>
 <20210619225118.1862634-2-linus.walleij@linaro.org> <CAPDyKFppUJWcmHHzP4V1WQPRmMYe50M721kwtaLkkp6M9rz2Gg@mail.gmail.com>
In-Reply-To: <CAPDyKFppUJWcmHHzP4V1WQPRmMYe50M721kwtaLkkp6M9rz2Gg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 30 Jun 2021 02:32:23 +0200
Message-ID: <CACRpkdahDF=fO8DZCCV+QhOjsG=NPB9WDEjsUrjOCUofgYriog@mail.gmail.com>
Subject: Re: [PATCH 2/3] mmc: mmci: Implement .hw_reset() callback
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Yann Gautier <yann.gautier@foss.st.com>,
        Ludovic Barre <ludovic.barre@st.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Jun 29, 2021 at 1:47 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:

> > +static void mmci_hw_reset(struct mmc_host *mmc)
> > +{
> > +       struct mmci_host *host = mmc_priv(mmc);
> > +
> > +       reset_control_assert(host->rst);
> > +       udelay(2);
> > +       reset_control_deassert(host->rst);
> > +}
>
> Unfortunately, this is not the purpose of the ->hw_reset() ops.
> Instead, it's supposed to be used to make a HW reset of the card, not
> the controller.

OK I see, let's skip this patch.

I think patch 1 & 3 should be fine though?

Yours,
Linus Walleij
