Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBEDCDB474
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Oct 2023 21:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjJQV3o (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Oct 2023 17:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbjJQV3k (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Oct 2023 17:29:40 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5025C121
        for <linux-mmc@vger.kernel.org>; Tue, 17 Oct 2023 14:29:34 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d8a000f6a51so6895613276.3
        for <linux-mmc@vger.kernel.org>; Tue, 17 Oct 2023 14:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697578173; x=1698182973; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k4C4JKwIA7asFauDo29zvruEioTkAyj/G+TnXmdCzBA=;
        b=gimieKTMiqMZ9J/ZE7wQJd8F72xDh4hNRCwaXrxel96uogf6s6Y5Ep65EA3WrWQV97
         IjEVsEc7zD6rsRd9ZK2kv2HBCJmzL71Pq0xTqFQHyp0AtV6V1Y3miwmPAwYWkqFCSmFt
         vblas+BJXlk11usdwVZ3pgNSPKzqBtjmu9LihGQRO7vMimvlAK0tJRwvHN3Za2MMLMoM
         CI8UYLlJk0qkkA4KzNl9G2WZT6PbtFSLT5d8yMVIkA06az4o/df0E11p2ZhOPj7g/OG/
         m7ZtaVHy1tFE2SmZ81ipr44IOlJa2fH2GnBxp6zK61VDOn5edjcczgk14Wp/3ug92wmy
         DrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697578173; x=1698182973;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k4C4JKwIA7asFauDo29zvruEioTkAyj/G+TnXmdCzBA=;
        b=JKVZUxBQaAQVUtcQzqlUvDWOUTcHv02LDFW8wgtpAgkRRjOw3NgNVQSlrj0cDl3G7M
         jFU6LWqFFgqwqg3PoezfxRWe780GLklDmyRQyBlY1wF1yBDar/CwK6JCRRmcXPC0VLNO
         uaJAeY/fvNP88JmMDq2dPxcWbvLcugLY+tDKDiuzHQb8LJ6QzUcQAsSWEzFZBp1m9TZ/
         eVE9oMbkeIsZ9c9RaXEAAVAw0SinS8VGmJgFu/kttI3H9UT3fE9l/SRvbvbRxWYgH2n0
         eeNJIO6VVWKzqbjq/+x/Hi8jcyzpvUePG561DWAiLGFVs0XY+bxjmr+Qdp1Rqonaewqn
         o2WA==
X-Gm-Message-State: AOJu0YyNyQpbc/VcO+fRNrXPOAQjtAEoWcyC6UBYyKlTWsESwENtpRPL
        IZXTQ8w9KP64zMsEdDpd6ObYYJtIYkEUAVdzVR0CmCy8qZHbpVBcp+A=
X-Google-Smtp-Source: AGHT+IHYVzSeGslRcQznJjQsW0F50tU/YplulewZG+1qzblCSC/Rty55Ek6MhYAy+3KVQBFoWrissUDTr9tvkwo5jcE=
X-Received: by 2002:a25:b06:0:b0:d9a:5021:4f34 with SMTP id
 6-20020a250b06000000b00d9a50214f34mr3193343ybl.15.1697578173377; Tue, 17 Oct
 2023 14:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <8e61aed5f64e434abc1d7b6f81859c8a@realtek.com> <CAPDyKFrLpim75nUB7ksDie2edkWsnFSq6TbFSFFpw5cY5d4y1w@mail.gmail.com>
 <fabaed5751f04105a9719c1cb0390c98@realtek.com> <CAPDyKFr3NRUgfKtkb2DBrhziekFAB0jT_X3Fsfvjk_bGZLC9mA@mail.gmail.com>
 <fa10aa1c644241808c2ad880088240ab@realtek.com> <CAPDyKFrtBKHHRgeF-JO27ANsbSmt8rdnhn-WNr5Je9okEgA29Q@mail.gmail.com>
 <feb0c4e71e9c48a2a21f18b7d3baf135@realtek.com> <CAPDyKFoq_PDk_JgW4D+o4eEPdcffUq2RLbBreRDqeK47m0UnJA@mail.gmail.com>
 <a82d7e877dc041d4be5e0ef38c2da406@realtek.com> <CAPDyKFo59Q3dmUJU-hJ++=k0uwx2KxamW9KckDX=O_CA84O1_g@mail.gmail.com>
 <a533dde76d2d4345b85cd060a8e403db@realtek.com> <CAPDyKFp3sbbQmKiV6NnuWnPmpfuyWzRBTuYJaWx_7oTLLsXdaA@mail.gmail.com>
 <5752164983174ca68a669c241e7ef436@realtek.com>
In-Reply-To: <5752164983174ca68a669c241e7ef436@realtek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 17 Oct 2023 23:28:56 +0200
Message-ID: <CAPDyKFpeirjA4QmCiqnu4MxN8Yph6d0GiyA95pcmOBRYf8ywSg@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: rtsx: improve performance for multi block rw
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     "tommyhebb@gmail.com" <tommyhebb@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 13 Oct 2023 at 04:27, Ricky WU <ricky_wu@realtek.com> wrote:
>
> > On Wed, 11 Oct 2023 at 07:36, Ricky WU <ricky_wu@realtek.com> wrote:
> > >
> > > Hi Ulf Hansson,
> > >
> > > Can I know what is this patch status or has some concern on this patch?
> >
> > Didn't you read my earlier replies?
> >
>
> Are you talking about BFQ for testing speed?
> Because we tested the Read/Write speed are better than before and our customer that uses our reader on their product also tested the Read/Write speed, they want us to push this patch on

It's certainly a very positive thing that your target is to upstream
solutions that improve performance. We all appreciate this!

In this regard, I believe I have tried to guide you on how to move
forward with this. This particular optimization doesn't belong in an
mmc host driver, but rather at the common upper block device driver
layer, such that it can benefit more than one particular mmc host
driver.

I fully understand that making that kind of improvement is way more
difficult and requires in-depth analysis to understand what is
happening on those layers too. On the other hand it could be something
that may benefit a lot of devices/platforms. Unfortunately, I am
currently not in a position where I have the bandwidth to dive deeper
into this.

If you decide to pursue your investigations, I think we need to
involve the experts from the common block community (linux-block
mailing list) to get their advice.

So to be clear, I am not going to apply $subject patch - or anything
similar to an mmc host driver.

[...]

Kind regards
Uffe
