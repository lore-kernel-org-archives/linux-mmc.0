Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443D4C55ABD
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Nov 2020 15:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0108B22249
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Nov 2020 15:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="s0sKGyNm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgKMPZv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 13 Nov 2020 10:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgKMPZu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Nov 2020 10:25:50 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28633C0617A6
        for <linux-mmc@vger.kernel.org>; Fri, 13 Nov 2020 07:25:50 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id r17so10358977wrw.1
        for <linux-mmc@vger.kernel.org>; Fri, 13 Nov 2020 07:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=fh3sdYN4ySXdPD1FQVu1dC99IKskbJzhUsIZcKGht60=;
        b=s0sKGyNmrJtRczni+Nu+OHhlp+MV89+jp4a4uDTvYiCXoFX/gKAryrs9SHnrzvKw/r
         VxQ99Xuk8w4VDNr/7alL4kaXMyh7rPEQRsCslHv9on8T5EluVheEEAFzL5shdMbm+YQQ
         QT8lLkDiYgokmKugcSJQQZoKBUj82R0cBLMYI6r54fvf64H35J2w+pee9qlxQ8ifXpvY
         KkVksUXxX3JmkQjkgZXvQQbd7NIraiYvDhHEPSC5vo2Av+qV7c3NazQZLUEQureZ0o7H
         2Fn5h0UsupUIl1eyiR6Fy2c+CXXy0OruErlsoZREyOgQFeqw0G096ePP2xAojI98jVI5
         7fAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=fh3sdYN4ySXdPD1FQVu1dC99IKskbJzhUsIZcKGht60=;
        b=ppErHObmjPZO3EIYVxiPOKErZw1XU7Wl1NE4E/xtFoFLNB0wRjh/NCEK0Wf8M6UCSt
         HYIS178ZgnYH/L6Bip4vC62amzFIUrvo2x3GeMt3NgUgi6YulyMsL19LCQbY9kZidGTL
         b6SgbIQAIV2YMCOdmkcCyUSZy+gweKvUPNGklIZ3m6w/QtCD3aaMv97GJfRHh1hP8Fwc
         IbdXYTZUlj70LHtCD+AQ+jd0jP5i8GbZFYhsQ8VcTVtR7ClGCQOy6sV3XM0nV5N9EsTN
         Hl0x+j/PDUBoTZmtCIlqU+RCBLS6/cn4EeglBGE8DUUthg/iMxK2XclANi+7+r+7dzTT
         lciw==
X-Gm-Message-State: AOAM530Wt9lgLRiWwhUtyv0UbbOy2sQH3cmmEqYGpHPIj5seJEmdYgXA
        ThwPkFAdrtoX9gHFVXKKHoJlXw==
X-Google-Smtp-Source: ABdhPJwxconarfbkZMVreTzCgPKy8Q++gyfX3htiuHqgomRWZqBVyLzWlq1KmyWIF2JU2EisYgCWrA==
X-Received: by 2002:adf:eb4f:: with SMTP id u15mr4103486wrn.165.1605281143931;
        Fri, 13 Nov 2020 07:25:43 -0800 (PST)
Received: from localhost (253.35.17.109.rev.sfr.net. [109.17.35.253])
        by smtp.gmail.com with ESMTPSA id f17sm10738795wmf.41.2020.11.13.07.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 07:25:43 -0800 (PST)
References: <e4e6cc45-bc18-40ec-035e-fdb45b9a8f46@gmail.com>
 <87o8lf74j5.fsf@nanos.tec.linutronix.de>
 <CAPDyKFosR2wd=jqADBF_dNd3kCMbM4oDAHyxiYC-5RF=SZ_E5A@mail.gmail.com>
 <1jzh3p9rs6.fsf@starbuckisacylon.baylibre.com>
 <CAPDyKFq8dM7Z48uUWHai83avwdhOOGU2NEefM7ifaOUcfW+BsA@mail.gmail.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Brad Harper <bjharper@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] mmc: meson-gx: remove IRQF_ONESHOT
In-reply-to: <CAPDyKFq8dM7Z48uUWHai83avwdhOOGU2NEefM7ifaOUcfW+BsA@mail.gmail.com>
Message-ID: <1jft5d1doq.fsf@starbuckisacylon.baylibre.com>
Date:   Fri, 13 Nov 2020 16:25:41 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On Wed 11 Nov 2020 at 11:47, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> On Tue, 10 Nov 2020 at 16:05, Jerome Brunet <jbrunet@baylibre.com> wrote:
>>
>>
>> On Thu 08 Oct 2020 at 11:08, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> >
>> > Thomas, thanks a lot for helping out and looking at this!
>> >
>> > It looks like the testing of the patch below went well. Are you
>> > intending to queue up the patch via your tip tree?
>> >
>> > If you need any help, just tell us!
>> >
>> > Kind regards
>> > Uffe
>> >
>>
>> Hi everyone,
>>
>> Do we have a plan for this issue ?
>> I've had Thomas's change in my tree for a month, so far, so good.
>
> Instead of waiting for Thomas, perhaps you can pick up his patch and
> re-submit it?

TBH, I'm not confortable signing off something when I have no idea about
the implication, which is the case here.

>
> From my side, I can of course apply your original fix to the mmc
> driver, as an intermediate step.

In Thomas first reply, I did not really understand if it was bad from
the driver to use IRQF_ONESHOT. If it is OK, i'd prefer if things stayed
as they are. Otherwise, feel free to apply it.

> Is there a hurry?
>

Absolutely no hurry, at least not for me.

I noticed I still had Thomas's patch on top of the last rc which means
it had not been applied yet. Fishing for news, that's all.

> Kind regards
> Uffe

