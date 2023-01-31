Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEDEC636CC
	for <linux-mmc@archiver.kernel.org>; Tue, 31 Jan 2023 09:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbjAaJ54 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 31 Jan 2023 04:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjAaJ5x (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Jan 2023 04:57:53 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58F4485B9
        for <linux-mmc@vger.kernel.org>; Tue, 31 Jan 2023 01:57:50 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id u72so17381406ybi.7
        for <linux-mmc@vger.kernel.org>; Tue, 31 Jan 2023 01:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W3tPlXlfIp5di2Tll1ipjBBYi6NQvaCY8G0JGUrqHog=;
        b=l3ugYEo4Zmo1EWmGKFto6ElkYN26JVdZBSaRNvkqwtP1SFobU4UNTtzJIWOuHqLu7o
         D5kL9GBSisIgoYfjjjFivaYrPaWFrQEpN+VxNdRQj5dLkxofKirKhqfYreHy/z/GyKI9
         Z71XtpHIPJ9FIt18dV+xRIwPWBxsFhNjBuCUC+pehJd0P9KvtSXqYQWUQqbOeaArjPli
         pEvF5Ux9odgOyoszKKlLs42ucZXeQCW4iB6nPI84kxJ0LYMt5fZdyWQIsHzVbIExutm0
         0CbltVRp4HcNQ/oP075/eg1vrVhKsJiObVw4MpjI5+wcQ9RRIzdI80+TKBWwZhqFG+yb
         ehZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W3tPlXlfIp5di2Tll1ipjBBYi6NQvaCY8G0JGUrqHog=;
        b=pOnJAN+Nt6TDuWLLAgQFjCmZRgwQOL3gjK4kH/flAf2BMOXypuT5CcSvc4yCNJD1+e
         VRTZKLR+xcAFIsAXotLbl1KNPpHmhgSZePmJkppyiXXB3ZoxzCKgdDVfRAHTR8gzRUWW
         YLAermCDoWIPFZu45tiNPgeYHAN026lue2qsq1yXJlZBCelU8YCk7SVxXShBHKES0zyh
         uCvO/GcliSVGyGbE6gCHVAli/Vrn6Nn/tdYW+jFUb4abh//fMRF7g4IYD7n2s0KULgBk
         DTB4e/tbBVkRuqoJCplBpBMfh1QrHTkp/+JgkHAVOFUgjsg6uRpuh32yiEiXCdts0bGE
         vC0w==
X-Gm-Message-State: AFqh2kp7oygUJIcJA2c10KQZuogjMmSk/s0Prxdqzr9zlxhXlGlt/H5q
        zEWgMnvLx4hM1JT4oskFlXYAIzCgL4uL0gn/8DcTDw==
X-Google-Smtp-Source: AMrXdXsB43+oVHPXnP4JOyDh9rTbc3qUj14/yr6VpfExDogP0IDLHXRZpSF08NTbuAjgLiyHLD1nLpFXweDgLUS1VPI=
X-Received: by 2002:a25:5303:0:b0:7e4:fa1:b33 with SMTP id h3-20020a255303000000b007e40fa10b33mr4756198ybb.460.1675159069967;
 Tue, 31 Jan 2023 01:57:49 -0800 (PST)
MIME-Version: 1.0
References: <20230131084742.1038135-1-linus.walleij@linaro.org> <Y9jY2zsNbSCWluZG@infradead.org>
In-Reply-To: <Y9jY2zsNbSCWluZG@infradead.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 31 Jan 2023 10:57:38 +0100
Message-ID: <CACRpkda3mk8wkdxWQFev9PrK6bPsxR6qLJo_gXnK+_jaTCFfjg@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Imply IOSCHED_BFQ
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Jan 31, 2023 at 10:01 AM Christoph Hellwig <hch@infradead.org> wrote:
> On Tue, Jan 31, 2023 at 09:47:42AM +0100, Linus Walleij wrote:
> > If we enable the MMC/SD block layer, use Kconfig to imply the BFQ
> > I/O scheduler.
> >
> > As all MMC/SD devices are single-queue, this is the scheduler that
> > users want so let's be helpful and make sure it gets
> > default-selected into a manual kernel configuration. It will still
> > need to be enabled at runtime (usually with udev scripts).
>
> NAK.  Nothing requires a specific scheduler here - the scheduler is a
> pure user choice.

If MMC required a specific scheduler I would use

select IOSCHED_BFQ.

Now it doesn't require it, it will just perform better, so thus I use

imply IOSCHED_BFQ

the point with it is to help users make the right decisions, not
enforce them. fs/crypto/Kconfig does the same thing for example,
advice not enforce.

Yours,
Linus Walleij
