Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683ECC4361B
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Dec 2020 17:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C8C52389F
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Dec 2020 17:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgLQRNM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Dec 2020 12:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbgLQRNM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Dec 2020 12:13:12 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085A3C0617A7
        for <linux-mmc@vger.kernel.org>; Thu, 17 Dec 2020 09:12:31 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id 17so9077740uaq.4
        for <linux-mmc@vger.kernel.org>; Thu, 17 Dec 2020 09:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lc21cq0ymggpuStIBav4pWq/h6ih3KgGZXha7oGAj9I=;
        b=xzgq2RDmDvQdWkRXgZQeLWKLHkZ2GVoPk5BNc12QN79DNUAN26PsKWuWZG+Z0JZLvo
         uXrBKH8ftZvNRDx+o4HYqmvTP+X49sFM8Jn83MHS31LoGfvAqu7gB1Zhl8pzDdNrs45a
         874rDmw4huPKXUChuOIq2h8Res2w3pbLqHnZICNHpaPHxyAo21fz3//qMlyeewXVesMl
         /nj7m3yyQrXlxDceF//kFWW/zQ4dacFpQRNhqI6psUlnrfZplugzeCNp5voJgS+S6JO8
         LwkOe0sLwu0SvR45RkNWP15upO4bsoDAGDpc8AmBnaogXjOhho/Mh/jVDemCdp96toad
         7DRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lc21cq0ymggpuStIBav4pWq/h6ih3KgGZXha7oGAj9I=;
        b=LDsRoeFVQ0slb1zbtpVLArr996oKZLqnT3rqHx/B1OxW4AHtxmo7KLaIhz39vSfr0M
         GCsy3sCSWGa0gDWMQnMYSxFIukcqm5UCkz0NkKZrbTeYRfexobQYIvQlTh8rqBcHGugX
         qEE6irBtm8gjmtDFUKZiscanEyZe6B7ykkXfiKJvvZt69jT1K2fZzU0nt7bZ3jJuUtFn
         WOor57J/sH+WukuSaAiPyLR8W5YyQq2la0Qefl3+RAu+3HFfuYkUQhokAxIHSN7cMB3j
         /XuOTD4dIv8hRpVB095V4XmxXSugQs5TNiQrX1b/DdoGsQPnJvM+2slyofjG4WhZRX2r
         DZIA==
X-Gm-Message-State: AOAM532JPP+1la5601MJHI+ZmBHPqZUtHNhJbbLpY7aLcWi0Xns6BhNK
        NZqJ8I04RvvnX1k/5Qqe4UYUhfcTIFGrU3gf4ZiluQ==
X-Google-Smtp-Source: ABdhPJxsrjSgmF6i7SHQNyLNx60nOHm4gQJBNrgSBnDWWv1rsZIrt5HMWv8RROwO44wXNX2R+lqGG/p1bar838U25l8=
X-Received: by 2002:a9f:204e:: with SMTP id 72mr10422527uam.19.1608225151200;
 Thu, 17 Dec 2020 09:12:31 -0800 (PST)
MIME-Version: 1.0
References: <20201207115753.21728-1-bbudiredla@marvell.com>
 <20201207115753.21728-2-bbudiredla@marvell.com> <CAPDyKFqQwvG6vkwqPZutXjdV0hVrKp3MiqRRMZZ4C8Zr2Of9rg@mail.gmail.com>
 <CY4PR1801MB2070FD9FB1AB7166651198D1DEC60@CY4PR1801MB2070.namprd18.prod.outlook.com>
 <CAPDyKFqMsMdqw=Uwzby0tNNvPieRT2i6PAmHu_9XRRVy1MykuQ@mail.gmail.com>
 <CY4PR1801MB207090582E5E763F3672153BDEC60@CY4PR1801MB2070.namprd18.prod.outlook.com>
 <CAPDyKFpvRgsE3biXZncbR_qfU4+9Z1mf7fCB=aAchH7hTsq+Vw@mail.gmail.com>
 <CY4PR1801MB2070AE5FDA2AC539DD85D3CCDEC50@CY4PR1801MB2070.namprd18.prod.outlook.com>
 <CAPDyKFoWh8Ms3hqgWwkQgx2a9PZa+GLcYhgXX68K0ZC5JJAzHw@mail.gmail.com> <BN6PR1801MB2068B9F13F0E21BF726562E5DEC40@BN6PR1801MB2068.namprd18.prod.outlook.com>
In-Reply-To: <BN6PR1801MB2068B9F13F0E21BF726562E5DEC40@BN6PR1801MB2068.namprd18.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Dec 2020 18:11:54 +0100
Message-ID: <CAPDyKFoSr72bKd3qzYi9QZT5L3DewjEYjRExE+V4XmdiqHLkXw@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH 1/2] mmc: Support kmsg dumper based on pstore/blk
To:     Bhaskara Budiredla <bbudiredla@marvell.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 17 Dec 2020 at 12:36, Bhaskara Budiredla <bbudiredla@marvell.com> wrote:
>
>
> [...]
>
> >> >> An extra check can be added to see if host was runtime suspended
> >> >> ahead of panic write attempt.
> >> >
> >> >What if that is the case, should we just return an error?
> >> >
> >> Yes.
> >>
> >> >Moreover, even the device belonging to the mmc card can be runtime
> >> >suspended too. So if that is the case, we should return an error too?
> >> >
> >>
> >> Yes, same here.
> >>
>
> Please comment if returning error is sufficient here or
> can there be an attempt to wake the device through either of the atomic activation calls:
> pm_runtime_get(),  pm_request_resume()?

Hmm, I would start with playing with the below. mmc_claim_host
supports also nested claims.

mmc_claim_host(host)  - this will call pm_runtime_get_sync(host)
mmc_get_card(card, NULL) - this will call can
pm_runtime_get_sync(card)) and also try to claim the host

Kind regards
Uffe
