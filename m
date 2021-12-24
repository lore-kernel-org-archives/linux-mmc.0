Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD206C433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Dec 2021 17:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbhLXRfQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Dec 2021 12:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbhLXRfP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Dec 2021 12:35:15 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E00C061401
        for <linux-mmc@vger.kernel.org>; Fri, 24 Dec 2021 09:35:14 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id m21so36844393edc.0
        for <linux-mmc@vger.kernel.org>; Fri, 24 Dec 2021 09:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iaq7bS4lyD8/TjhAqNZqzIVhFIl3Gv4mH1y72nw1x3I=;
        b=JQTi6YLMKX+geLs8Yj7l/Btzr5ea1KEGgxQamLGjmbtZ7GI3qX43p3Mw+KeJ6IHl/B
         OLsDAk2hQBKKpgKMcKjMNrSpcQ+v4mPqejI1erBocH24gzxpBEUKSFEsKnFVt3tJ+6lc
         XYRtR2RjUpt78bWnJ8u1/b3x9pz6V8gv1H4+ZNdRgJbpUt6P4ljYdqHKfBmwPfENEkIs
         SZkbJ+MDkR05QEicVRv4WZSxWiOZG/iDjVtJAUL2o2oGTiMl73dxN5NJfxxA1xPPmCNd
         wJcfkAbZvxJkzgGnLnSBrRIMqhAGojS3q7VKvLnuAyt3jzR/oy+eGD6r9+v1OPcOvBzt
         wXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iaq7bS4lyD8/TjhAqNZqzIVhFIl3Gv4mH1y72nw1x3I=;
        b=OMd4GPh9daunrHWDt47QYQnXEVtUY3MterIoLapdSSORMzZC1/6mKA1v6TzzJSbO7k
         dzcwqfIcR/RVhXSxkvjUTr0E0BCK2kJJCWge6SXv8yUtTvHsTmk2EOWEh28ZPMJPOXej
         7lOgLPbAaMFToZ5MmpCRbNraCCJRfCyRwIFVN0s25kf6dWM6zEgXWqCGKFN/6q5MVNbG
         LAfJI8N+o9PvnpV2dWlO5v544RevXx2AfXGsco233+AS2Lqji5pYLatsxvhfCyl5Z06z
         Pq1gtKp3+V+GRdPjJs6p2hquIKpEHb5INmTobrOqydWt3yH1P72wi/d2dXq/7wOJKZN5
         AD2Q==
X-Gm-Message-State: AOAM530r/S2lfBqybwtz+VEOT01BX/N9oULH+ArgGrV2toV1MWD92ynb
        FpPNeoZCTE93jQg3J+yHCtfy5PDLRcSSOR2eIU4=
X-Google-Smtp-Source: ABdhPJwyjpBJ9V/xFtZgW5lzfQ4CL3AMPgTiItklF3vtwX+dZAJbyFio0CVF4KNOt/QO5apULfKNDWbTBduG7M5Pk8c=
X-Received: by 2002:aa7:d55a:: with SMTP id u26mr6561187edr.265.1640367313494;
 Fri, 24 Dec 2021 09:35:13 -0800 (PST)
MIME-Version: 1.0
References: <20211223171202.8224-1-s.shtylyov@omp.ru> <20211223171202.8224-3-s.shtylyov@omp.ru>
In-Reply-To: <20211223171202.8224-3-s.shtylyov@omp.ru>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 24 Dec 2021 18:35:02 +0100
Message-ID: <CAFBinCAd4QTZ78S7QrT0Zsduvk=09rJa3gHHb15HLpwspQzuTw@mail.gmail.com>
Subject: Re: [PATCH RFC 02/13] mmc: meson-gx: fix deferred probing
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Sergey,

thank you for spotting and fixing this!

On Thu, Dec 23, 2021 at 6:12 PM Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
>
> The driver overrides the error codes and IRQ0 returned by platform_get_irq()
> to -EINVAL, so if it returns -EPROBE_DEFER, the driver will fail the probe
> permanently instead of the deferred probing. Switch to propagating the error
> codes upstream. IRQ0 is no longer returned by platform_get_irq(), so we now
> can safely ignore it...
>
> Fixes: cbcaac6d7dd2 ("mmc: meson-gx-mmc: Fix platform_get_irq's error checking
> ")
I suggest putting the ") on the previous line. Most "Fixes" tag I have
seen don't use any line-break at all, even if the line gets long.

> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
with above comment addressed you can add my:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Best regards,
Martin
