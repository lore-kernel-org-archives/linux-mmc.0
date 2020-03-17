Return-Path: <SRS0=U+Jx=5C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5C1C18E5B
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 02:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E45206C0
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 02:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brmuR0X4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgCQCAf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Mar 2020 22:00:35 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33001 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgCQCAf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Mar 2020 22:00:35 -0400
Received: by mail-qt1-f195.google.com with SMTP id d22so16208779qtn.0;
        Mon, 16 Mar 2020 19:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SAIHfbIIQekHhAbbBxMugf/Z3JyJbRfD6jfI9jRWXU0=;
        b=brmuR0X4B5q0JVb9Xm3u5iX3WuRqdZyuSBwF+7l+LsUuDvD/h+IRJKKqOkMTwyMBNN
         9TbFpOAQMB5BRgxcAEzMTJcLu0Ckhvfl/RN521/b3h9p/UnjDR00WQLBT0nDAmYTRSVQ
         vY6QuQoGGoJKDrO4FTe7FmHpkqmCL7C5PA+2huy4FHXyxbCOeW7kyTslWDWI7fNxfs4j
         1K48m9SygMEwh3Iqy+W8s9WDTMWISwDHlQhu4T2gIeYz766LuJba9WFahAq6vj7Ceeoe
         c8ym+2HL9nL0ojkgKYPDCUpVlYZ3qYj9mQSYcE28Y/4MpSN8/Xc+tKlFa8hssgV7eLgm
         KnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SAIHfbIIQekHhAbbBxMugf/Z3JyJbRfD6jfI9jRWXU0=;
        b=OyXsf9VyTLBxPNcYoLQb7HnXAGesSErnB1UEfsEd1Q5oppJoZtQWvzbMoKZe0ady7B
         UHXU2FBc0q1K5EjCxbWXRveSmLw2/nLc8UTYbzbk6JbdmpBAT6+2G3wi+eEO4iNvZ5Ud
         +w59khjV0EoXgp19eFl1qskgq5tQP10ha+Uzf1OxzuW5S0fZMvIoyzIDaFu3bqWyH4Jk
         G5rDqgYC61b+mQvNqQDBzZDxQfmG4BNMr/imhUGK3uR2CsIF2pFgrCZugEQPZb8uvKDB
         m39m9QLb5VdfO9f9M+GdqPiU3vIUm4F1H18MrSaLGRvQJOcxk2FOnOZBe1e+oFqh3hhY
         i4GA==
X-Gm-Message-State: ANhLgQ1zf+q+nBPfGYP8iregg199cQzMF+h4qmE17FwoS1qn7tpfwt7T
        IRF+vOGiwvCoWtDqMIPNnkzYzXf6ovJIyFVe1Wc=
X-Google-Smtp-Source: ADFU+vvRH7YsoeX5jyigNtS4TX8IX75PFK70SWJYQ6bJIsaZgt3FeLpAw8AlZZItSLbwj2HbA0v8RtYDwP72tDNTY64=
X-Received: by 2002:ac8:1add:: with SMTP id h29mr3220938qtk.258.1584410434019;
 Mon, 16 Mar 2020 19:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583307441.git.baolin.wang7@gmail.com> <ace53bca354e2846f19684bd33a9c0f3c2ee2c44.1583307441.git.baolin.wang7@gmail.com>
 <CAPDyKFp-HvMtEX4F-aumBy93DMn8aPjx8kBm+rCSL316HFPL0w@mail.gmail.com>
In-Reply-To: <CAPDyKFp-HvMtEX4F-aumBy93DMn8aPjx8kBm+rCSL316HFPL0w@mail.gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Tue, 17 Mar 2020 10:00:22 +0800
Message-ID: <CADBw62qPEO_iWpf5v3H-_xHCJRJ-6M8Y+jA1TTxPPdJvutCmSw@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/3] mmc: host: Introduce the request_atomic() for
 the host
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

On Mon, Mar 16, 2020 at 7:48 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 4 Mar 2020 at 08:42, Baolin Wang <baolin.wang7@gmail.com> wrote:
> >
> > The SD host controller can process one request in the atomic context if
> > the card is nonremovable, which means we can submit next request in the
> > irq hard handler when using the MMC software queue to reduce the latency.
> > Thus this patch adds a new API request_atomic() for the host controller
> > and implement it for the SD host controller.
> >
> > Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> > ---
> >  drivers/mmc/host/sdhci.c | 27 +++++++++++++++++++--------
> >  drivers/mmc/host/sdhci.h |  1 +
> >  include/linux/mmc/host.h |  3 +++
> >  3 files changed, 23 insertions(+), 8 deletions(-)
>
> I think the code split of the changes in the series can be improved a
> bit, so I suggest you move the code around in the series to reach
> this:
>
> 1. A patch that adds the new host ops callback, combined with the
> change you have in patch3.
> 2. The sdhci core specific changes, from $subject patch.
> 3. The sdhci-sprd changes, as in patch2.
>
> Other than that, I think the code looks good to me, besides a minor
> comment on patch2, see separate reply.

Sure. Will do as you suggested. Thanks.

-- 
Baolin Wang
