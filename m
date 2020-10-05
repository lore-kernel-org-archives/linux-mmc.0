Return-Path: <SRS0=j7Ik=DM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A232C4363A
	for <linux-mmc@archiver.kernel.org>; Mon,  5 Oct 2020 12:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20BE4208A9
	for <linux-mmc@archiver.kernel.org>; Mon,  5 Oct 2020 12:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jeCAFGdV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgJEMbK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 5 Oct 2020 08:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgJEMbK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Oct 2020 08:31:10 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2CAC0613A7
        for <linux-mmc@vger.kernel.org>; Mon,  5 Oct 2020 05:31:10 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a3so11630955ejy.11
        for <linux-mmc@vger.kernel.org>; Mon, 05 Oct 2020 05:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=fiCrvDEC+N91sV5tSYfiRUfHF9WZ4cEQDOciG9CIIEo=;
        b=jeCAFGdVVyZTTJVSAYgmCTbMhs2z/jLPfL6bbH5ezEq64dztUXuA3/Nq27U3WKMgFG
         Lemw0JeuJdSf2TIvfuTw4vbryHp7U8pI38jM8Po5eehY/qRSRsqpc19Ku6NhF+OM10yN
         TCzAII1A1p4ibrR/zRIWRgrMSDTX2P+9vmLeh+RRNjGxwaxJj/vu/smwC7lHIcE8F2Ao
         eoQxO7MHjUY4RO644XNJcFYAOgMEQMt+UBJlJGUJKdCUOPgXlSEQNN0FFImFlQb2Udi6
         ZJS5GICnohvXBu0nqUY13Nnz0jYxaLe7FNc5h8MMm6QKbFIDewptfKzRElGQ119pgj8Q
         1VtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=fiCrvDEC+N91sV5tSYfiRUfHF9WZ4cEQDOciG9CIIEo=;
        b=UIfYcsVpE+f6VHPjeX2dD+Pl5ZQZleq4DrfB199XxYr6lagEbpu8uECsY+Nr1Va0mg
         mIT0gHY5/rhsGX1iNLSMopNNDg61/4v/S51rhzCdQ69Lpz0A5Gw103DyXbnLEbPC3dP8
         /haQzFCo4a9gIfGO9h7162nHBmBnSV8KZwwFAt0nbGHR0O2QLqniYDdebfx9bBgoiw1m
         +1O6JssZNRGnmW4uQB5b8ATggFu/hFtiHyz2g/4DfTSA3knaMTBmnkQu/wDVOhKkg1vC
         eccbJAGj9mpsGi0Ryj85dXqF6PhpluWEck6J+5BjQNAlibOQr8vx73NafOC1cTPtsWqL
         /T+g==
X-Gm-Message-State: AOAM5308JIZhAmkxwUmP/N4MOMNXdQMCD+WHLyzGCHTG+sKYWs3U2GE8
        95XUsIEQ/vIgCzbLaP9JIqeibQ==
X-Google-Smtp-Source: ABdhPJy02NnD+4aHKxW6Hc8US3lVSSNA3BxcKCnClvJhFQf261x5iusEFWzdEVvbeZjYWA02noZaqA==
X-Received: by 2002:a17:906:2dd:: with SMTP id 29mr15898934ejk.31.1601901068443;
        Mon, 05 Oct 2020 05:31:08 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id i14sm8004849ejp.2.2020.10.05.05.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 05:31:07 -0700 (PDT)
References: <20201002164915.938217-1-jbrunet@baylibre.com> <CAPDyKFo6T_P+TQQZSzFgHwLeE08f146KxKBpAutv209MXq0mjA@mail.gmail.com> <87wo052grp.fsf@nanos.tec.linutronix.de>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        "open list\:ARM\/Amlogic Meson..." 
        <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc\@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Brad Harper <bjharper@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] mmc: meson-gx: remove IRQF_ONESHOT
In-reply-to: <87wo052grp.fsf@nanos.tec.linutronix.de>
Date:   Mon, 05 Oct 2020 14:31:06 +0200
Message-ID: <1jlfgkrh11.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On Mon 05 Oct 2020 at 10:55, Thomas Gleixner <tglx@linutronix.de> wrote:

> On Mon, Oct 05 2020 at 10:22, Ulf Hansson wrote:
>> On Fri, 2 Oct 2020 at 18:49, Jerome Brunet <jbrunet@baylibre.com> wrote:
>>>
>>> IRQF_ONESHOT was added to this driver to make sure the irq was not enabled
>>> again until the thread part of the irq had finished doing its job.
>>>
>>> Doing so upsets RT because, under RT, the hardirq part of the irq handler
>>> is not migrated to a thread if the irq is claimed with IRQF_ONESHOT.
>>> In this case, it has been reported to eventually trigger a deadlock with
>>> the led subsystem.
>>>
>>> Preventing RT from doing this migration was certainly not the intent, the
>>> description of IRQF_ONESHOT does not really reflect this constraint:
>>>
>>>  > IRQF_ONESHOT - Interrupt is not reenabled after the hardirq handler finished.
>>>  >              Used by threaded interrupts which need to keep the
>>>  >              irq line disabled until the threaded handler has been run.
>>>
>>> This is exactly what this driver was trying to acheive so I'm still a bit
>>> confused whether this is a driver or an RT issue.
>>>
>>> Anyway, this can be solved driver side by manually disabling the IRQs
>>> instead of the relying on the IRQF_ONESHOT. IRQF_ONESHOT may then be removed
>>> while still making sure the irq won't trigger until the threaded part of
>>> the handler is done.
>>
>> Thomas, may I have your opinion on this one.
>>
>> I have no problem to apply $subject patch, but as Jerome also
>> highlights above - this kind of makes me wonder if this is an RT
>> issue, that perhaps deserves to be solved in a generic way.
>>
>> What do you think?
>
> Let me stare at the core code. Something smells fishy.

FYI: initial discussion can be found here
https://lore.kernel.org/linux-amlogic/24a844c3-c2e0-c735-ccb7-83736218b548@gmail.com/
