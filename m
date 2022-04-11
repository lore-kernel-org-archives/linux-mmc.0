Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402B5C433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Apr 2022 19:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348116AbiDKTks (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 11 Apr 2022 15:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244590AbiDKTkr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Apr 2022 15:40:47 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050471D302
        for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2022 12:38:30 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id g18so8052871ejc.10
        for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2022 12:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=e+KBmFjS1K+rC980qWl91puxJ4gewnilNoHGcgMKQoc=;
        b=lfsemvgekvvOaB+81RkHbnUqWRCh1Fix0wKsqEadDuhbzquWlOfbqU6typxIk/pW4q
         3PwQ2zxu06N67mNi5DBOrdRetTniXXXOUSbF+h5N65EAfmEFySOl+yJ5iDXSR5hrrE0j
         QX1Y6kJORz1NcYdksBs2/y8hX4q1muJeJbcJj4alk+VmW4lVQjFYwHed9IxFtKBnDc0Y
         mDj3duKA475k90W5SVHuSh5Hud1XSBjCZ3F34wQ2jd7pzbUaEcHi/Pe2WTHJRsYaZf1R
         Q05205GHAYJDC+XuODV0X6Kx6J+BNhsPGMgoYt4JTb7VPPbeyY0C+6DVi7Eg5knQ4Di5
         eGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=e+KBmFjS1K+rC980qWl91puxJ4gewnilNoHGcgMKQoc=;
        b=jCVI0lODkh7o75Nq+khp5Xy4U+3K5GhWeb3515SGq39JN1rNB5LQr/Cjm7OL3tva6k
         7ikrQ65V/d8ngEwU4IHKjdEe+uTHJhm1p1+GqFd12LqTnX60vZ4nm9h90vbOdyXBemqG
         fC0CNrqC8gpQ5CJha3iP4wwYSaU/+dFaHYVlcc0Ccu9P5eVS474AXnfwMAmMGUDTl2FA
         vqmUGAi0xNbP6fLMiphECZS94hnrzzdxKzWtzncRxKAbHjcIxY7Lnbhx32Wn+fNL0K8h
         7kEWTBtWzi5yWBnGy+vP8Bv4QX/xEp9Baa19wxEckmVJN26vGd3iYuuj668Y2x6JcFD4
         OWCA==
X-Gm-Message-State: AOAM530EQTgLD9AL6srG1T3Zyo7B/PtHZsCSeKImAR3Yh4MozQbdrckQ
        GXNRo5uEyd+10Rtgvtbb3ufta48s4Nc0lchH8FpPbLtj
X-Google-Smtp-Source: ABdhPJw/qdRpbj1QxwIfJKTJt/0X7De1GVaHVeBRY2EHwSJPm7eKhdjIoc22WwlraV0x/hE+QfxDP5rWmB0PJWyN5tw=
X-Received: by 2002:a17:906:dc93:b0:6e8:8d81:b4bb with SMTP id
 cs19-20020a170906dc9300b006e88d81b4bbmr6677593ejc.32.1649705908809; Mon, 11
 Apr 2022 12:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAHCN7xK_fr_gREVsOzN=atcS08mwufr-=7q1JAN=CCyVk_k-dA@mail.gmail.com>
 <YlR9TCeV8FJVu38U@ninjato>
In-Reply-To: <YlR9TCeV8FJVu38U@ninjato>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 11 Apr 2022 14:38:17 -0500
Message-ID: <CAHCN7xLso6kwWxeT3VuRQBcs9oKZMctGbsWmd1T=mwgHx0T+SA@mail.gmail.com>
Subject: Re: RZ/G2M Hangs when booting some SD cards
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adam Ford <aford173@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Apr 11, 2022 at 2:11 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Hi,
>
> > I was thinking about taking the math from the U-Boot and porting it to
> > Linux to see if the issue goes away, but before I did that, I was
> > hoping someone might have some insights to see if that's the right
> > direction to go.
>
> Thank you very much for your detailed report!
>
> I have one SanDisk card which sometimes fails to probe on one specific
> board, so for me it was really hard to debug the issue because it was
> hardly reproducible. Can you tell me which cards fail and if they do
> that realiably? Also which Renesas HW do you use?
>

I have cards that fail 100% on my RZ//G2M.  I have an N and H as well,
but I haven't tested them yet.

Unfortunately, a colleague of mine tested positive for covid-19, which
prompted several of us to get tests, and I received a positive test,
so I cannot go back to the office for at least 5 days.  (I am feeling
fine today)
Because I cannot go into the office I can't get the exact part number,
but the card I have is a Patriot card, but a colleague of mine
reported another brand was failing the same way.

I was given permission to ship one out if you're interested but I have
to wait until next week to test anything or ship anything. Please
don't feel obligated to accept the card,but I know it can be easier to
have actual hardware.

> So much for a first response. I will have a closer look at your findings

Thanks for responding.  I'll try to get card info / part number from
my colleague.

adam

> tomorrow.
>
> Thanks again,
>
>    Wolfram
>
