Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA6AC433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 24 May 2022 22:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239411AbiEXWBC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 May 2022 18:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiEXWBB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 May 2022 18:01:01 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4B773562
        for <linux-mmc@vger.kernel.org>; Tue, 24 May 2022 15:01:00 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id fd25so24762399edb.3
        for <linux-mmc@vger.kernel.org>; Tue, 24 May 2022 15:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2VzUpvq1TKMkoLi0+DTKi478LS2776TPp3B2qvzGUXc=;
        b=BJH7ptQma4+xzUDxx9dLH6FM508FrlBjT+qYB1j6ms+Y6tjxh2KR7toa4+JMY/VIav
         6hv2NAEnLjFil5Gtvt1mUhXeBLRFmhtvbSJFZZy1cPXvZYKrvEHRLKW+yP3fYYJLYIOO
         gzwGIQTV2F0iTNHmiU71U1QblHNBY4/2gXubM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2VzUpvq1TKMkoLi0+DTKi478LS2776TPp3B2qvzGUXc=;
        b=qXMFK/2rFiseUUi+SJ2zGFDXprPewSgtrwRxOsoRel9HnHPi5eDC/PRm4XaWKZAYVr
         0Nj0liZLY5Fo2/mH6wJTTS1l1W2vx9D5SwQABf2Fk/JPz9QIEvWGfYP1qYusmV5v6ENm
         ciEkuS+IADTYDHqp1zlC753IMR1m9VOtcM3KvaQxBsu/KTvGQSZGq3f2w+NgJCA/UQVB
         YynYMOYel3ydKBiv6odLUabMV3dqP8q5MFkfcF3H8MJBh5UydTGHls+CciMnB+4VowHd
         i4E0b1D7fc+XlfjLn5VEozh/XWvnBCdkc7z89NB+Al8rA/m/rE6w0RRXUhI+o4yHO1Tu
         gs1w==
X-Gm-Message-State: AOAM530fmGTlXCAYaYW2RHgKnR+skZW+fw52nkKSaUu4s330ZqQq0Gv2
        IQVdmunKCl6HF+SuEvw+LsvG5cfgV96tW6mu
X-Google-Smtp-Source: ABdhPJx+nlCU6EvrKsHC6CIp7WDWOIKZv2xREvMTDHWXGvdYSV8dAsAp1FigbE4jqLyNTsN6fFTZ+w==
X-Received: by 2002:aa7:c506:0:b0:42a:b067:cbe7 with SMTP id o6-20020aa7c506000000b0042ab067cbe7mr31135307edq.4.1653429658696;
        Tue, 24 May 2022 15:00:58 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id st5-20020a170907c08500b006fedeb8b838sm2669212ejc.153.2022.05.24.15.00.57
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 15:00:57 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id i20-20020a05600c355400b0039456976dcaso1717717wmq.1
        for <linux-mmc@vger.kernel.org>; Tue, 24 May 2022 15:00:57 -0700 (PDT)
X-Received: by 2002:a05:600c:3d18:b0:397:6531:b585 with SMTP id
 bh24-20020a05600c3d1800b003976531b585mr2314036wmb.38.1653429657300; Tue, 24
 May 2022 15:00:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220523121836.27442-1-ulf.hansson@linaro.org>
In-Reply-To: <20220523121836.27442-1-ulf.hansson@linaro.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 May 2022 15:00:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiYh33UCe_sKvLWYY-ptPL6=T4m60b8vCX_t=qvmmOWWg@mail.gmail.com>
Message-ID: <CAHk-=wiYh33UCe_sKvLWYY-ptPL6=T4m60b8vCX_t=qvmmOWWg@mail.gmail.com>
Subject: Re: [GIT PULL] MMC updates for v5.19
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, May 23, 2022 at 5:18 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.19

Please stop doing the horrible undocumented merges.

You have three merge commits that have *no* documentation. They say
"Merge branch 'fixes' into next", and that's it.

If you can't be bothered to explain why and what a merge does, then
just don't do it.

It really is that simple.

I've pulled this, but I really want to stop seeing bad merges.

                    Linus
