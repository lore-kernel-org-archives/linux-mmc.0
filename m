Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23A7C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Apr 2022 12:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241774AbiDSMxx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 Apr 2022 08:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237698AbiDSMxv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2022 08:53:51 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C492A36B7B
        for <linux-mmc@vger.kernel.org>; Tue, 19 Apr 2022 05:51:08 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 21so21167215edv.1
        for <linux-mmc@vger.kernel.org>; Tue, 19 Apr 2022 05:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=frK4ELbA3jfI5PJwRqa6vMvLk5oMvD1W9mfa1RZXlWU=;
        b=iSaPxjgEQzTUtSGUwhPyGHNLCcobELAXeGfD7Q95TlAkiCffIpiQ4yVfYMJcRRxkje
         GpUOPDTt6sL1KQs+FapySmJnjOIlxHXohMlHMZc43QgnAfzRklFEmVTo1TIHY9n2GPxH
         9JvU6mNGHM1bgOkZaItOByOkPKZ3Cowai7PxDYGI6WjYRGIZ/EwZs0XB5YRRArarZr9U
         y1wrjw3kth/7gGeARdBk1xI5nMlW5IHoCfZD6z+CIvodql1ZwSSr/KWna//jkglnpL2Q
         2/1wnimzNLmcUQASrFKOgjQPMapdk15tkfy9623vwPZlA8ct9pFfMqjA6QNs7w/Epstk
         OL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=frK4ELbA3jfI5PJwRqa6vMvLk5oMvD1W9mfa1RZXlWU=;
        b=3zlfo7NJ6B9uKQokN4PKIE+gh9J6lXqn3lkgi3q6axfwU9wWlQ3KDYC3n7fwRj2m8p
         fbAmrKZ2ZKUJys17LXT5VS7v2G3DSu8epoaxrfE+IIkb7xEV/9OrNJ6k0HQt6rOPGxMF
         s3H7HlZzl+G/qWWNmb4j+KxnsLIVoPqceDTyMThLOKtKTlQa/9oZ4CR+/82d5UaXDb3F
         CgC0NbKXWjW1VTgzxUAL4Ul4PYoby0OXXWSmD2//eHMSlcV//CFT/6jglGwDctVm0pod
         74nSoM01qVMBC5VL8/pAXrNYgzUmD4u9Y8ET6m9bQPTa7X+HVk4bVP1e9Vcs4jMCWzo3
         zQzw==
X-Gm-Message-State: AOAM533b+ZIdap6fhSoglNZLsBJu0byuEddmzn+Fm7LNVm4STC/n2hNd
        on6DlCdzgB5qGCZ6s4TTejpaFhr8e+oP8UHV9B8Jl9Z+hn8=
X-Google-Smtp-Source: ABdhPJzWtNi3kq/d3Ti0EmgTW4/gcmCMWBUuMN3+tckamA2qyotYFDwmbZP2BBgJlrK2IuccnzKKITSeGxvTMHmJn7w=
X-Received: by 2002:a50:d4d9:0:b0:41d:6ee0:80d with SMTP id
 e25-20020a50d4d9000000b0041d6ee0080dmr16948642edj.254.1650372667043; Tue, 19
 Apr 2022 05:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAHCN7xK_fr_gREVsOzN=atcS08mwufr-=7q1JAN=CCyVk_k-dA@mail.gmail.com>
 <YlR9TCeV8FJVu38U@ninjato> <CAHCN7xLso6kwWxeT3VuRQBcs9oKZMctGbsWmd1T=mwgHx0T+SA@mail.gmail.com>
 <YlVApjtNOBLgA0hy@ninjato> <YlWUV1SW4lVLjIZi@shikoro>
In-Reply-To: <YlWUV1SW4lVLjIZi@shikoro>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 19 Apr 2022 07:50:56 -0500
Message-ID: <CAHCN7xLLsXikG=8zSM=udqnqwvbkqkSLH8iYcuLiLVvHa=LPPQ@mail.gmail.com>
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

On Tue, Apr 12, 2022 at 10:01 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > Anyhow, I'll report back with results from today.
>
> So, no news here. When the board is "cold" (hasn't been used for some
> days), probing the SD card occasionally fails, but after some reboots it
> just works. I don't see a pattern.

From what I have been able to determine, the U-Boot code explicitly
disables DMA during the tuning phase:

<snip>
/* Force PIO for the tuning */
caps = priv->caps;
priv->caps &= ~TMIO_SD_CAP_DMA_INTERNAL;

ret = mmc_send_tuning(mmc, opcode, NULL);

priv->caps = caps;

if (ret == 0)
taps |= BIT(i);
<snip>

When doing this, the value of taps is non-zero.  For this card, it is fefe
In U-Boot smpcmp is also the save value.

However, Linux does not disable the DMA, and the value of taps is zero
and the tuning ultimately fails.

I did some experiments to attempt to disable it, but when I do, it
usually ends up hanging or a kernel panic.

Does anyone have a suggestion on how I can properly attempt to disable
the DMA and use PIO during the tuning phase to see if this fixes the
micro SD card initialization issue I'm seeing.

If I manually set taps  to match priv->smpcmp when taps=0, the microSD
card enumerates correctly.

thanks

adam

>
