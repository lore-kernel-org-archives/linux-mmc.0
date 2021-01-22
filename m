Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AFAC433E6
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Jan 2021 10:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94BBE235E4
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Jan 2021 10:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbhAVKAk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 Jan 2021 05:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbhAVKAR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Jan 2021 05:00:17 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1953C061797
        for <linux-mmc@vger.kernel.org>; Fri, 22 Jan 2021 01:50:56 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id 187so2687752vsg.4
        for <linux-mmc@vger.kernel.org>; Fri, 22 Jan 2021 01:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HqmXNnhOvww/se+uqGpbG2r6Wj6LjG3RtqIoCGkH17k=;
        b=Bqt3b8b7kp2zQsjWv07hRffU5ZdsKDvLLb7CTBAQdsqsw2qRHDDv257TenVn8PQ0eh
         7Faa1tfN668wJ7fnNrENLH7AoZ+Yz7eIgCNhVFIajtS786Ovqkv97Wr+V6k7E2k62MxY
         +zFfZILJZPCMb2mgb5PIp7UG3mhyPOfuQoIscUoL7KcMmyArbnUdaC0O1T1v40yAIWCH
         kb3Y/uHtCaFYyztgZ4c9IexZUktiJQ8TjmoyT1uO1aGHIVI3c5zzudaDyrdeK9RYpTX9
         cIrmQQoHomR+23NhDIIBOqW/csi0rItWAjz9B7IdKkogQi35H0szd9iVKvGtnr3lgOid
         vpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HqmXNnhOvww/se+uqGpbG2r6Wj6LjG3RtqIoCGkH17k=;
        b=W0UmvCWbRRh4KfrpGc62R57keTSdCHqHHsHEfY0hPv/yQzQd+FmnKnRz63KnibSSsJ
         k4VoSFGP/UKfGtpbU53L7gQS5pmkdizV3ejbEPqY4aPQWZUZVi2s7PRCmeEZTYTJNKOA
         JsqUqH0TfrEPP8ZQiC89QJuqpA5KfE6Ua2dRszoWQChmMKy17WRui9DQEzKMXqNsW+8l
         LQrT2U7n5TTx1OtS29fv+RRGelfJBScTCZ2FqTiDIh+QhV7rwyF7csfZsIEKp4BA/bFn
         sN5Vap67Su7hIfRcofE5hFcreKBggHUAXLzP05ezsl93KOOZAK6mDi8IsZ0Mea2IXqq3
         UwLA==
X-Gm-Message-State: AOAM531ZOpSTDWp0ZxM0eVTELNrQtcYZqc9tBON+2CERKEM+g3BjP+nd
        RZ/8u6MHLC9i0C70BaAn850+29WYKpBFKaPrR0ZCbQ==
X-Google-Smtp-Source: ABdhPJzQkvbtXPAnaOXaJNiT2RO7BkT9eaJIQxnmfKyCTkaPtmRekmQxRuUvkDQuHQpmYuEkgvFe4kOJ3FrZfm16N6Y=
X-Received: by 2002:a67:f997:: with SMTP id b23mr235525vsq.34.1611309056136;
 Fri, 22 Jan 2021 01:50:56 -0800 (PST)
MIME-Version: 1.0
References: <20210122092824.20971-1-guoqing.jiang@cloud.ionos.com> <20210122092824.20971-3-guoqing.jiang@cloud.ionos.com>
In-Reply-To: <20210122092824.20971-3-guoqing.jiang@cloud.ionos.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 22 Jan 2021 10:50:20 +0100
Message-ID: <CAPDyKFoPL4drfh3efKXyhXLp6Ce+j=oHwNd9VnVP4aaKQ0zmDQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] block: remove unnecessary argument from blk_execute_rq
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-nvme@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-ide@vger.kernel.org, target-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 22 Jan 2021 at 10:28, Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
>
> We can remove 'q' from blk_execute_rq as well after the previous change
> in blk_execute_rq_nowait.
>
> And more importantly it never really was needed to start with given
> that we can trivial derive it from struct request.
>
> Cc: linux-scsi@vger.kernel.org
> Cc: virtualization@lists.linux-foundation.org
> Cc: linux-ide@vger.kernel.org
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-nvme@lists.infradead.org
> Cc: linux-nfs@vger.kernel.org
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

[...]

>  drivers/mmc/core/block.c          | 10 +++++-----

[...]

From mmc point of view, please add:

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

At the moment I don't think this will conflict with any changes to
mmc, but if that happens let's sort it then...

Kind regards
Uffe
