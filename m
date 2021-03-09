Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BA5C433E0
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Mar 2021 15:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7D8465253
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Mar 2021 15:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhCIPtK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 Mar 2021 10:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbhCIPsq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Mar 2021 10:48:46 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7596C06174A
        for <linux-mmc@vger.kernel.org>; Tue,  9 Mar 2021 07:48:35 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id i4so3075190vkc.12
        for <linux-mmc@vger.kernel.org>; Tue, 09 Mar 2021 07:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L8cB9tMKMFt76X4DI8vDrI1a5iyPbEIyxmNJ3xpjUSc=;
        b=vaLGYAwlAjZ0elpOzFH3kfX66njVwKt7vK07Mw/8+99GCgafTtnYimcYWxuorjYaHb
         6WMooeKon/4CwDM5u283kZ58sv2/Nt0RnC079M17hHoTY6xhxJQDSudsVfOgohzJE7I6
         fXvYNiqfiaybT4SzDHzz7+UDAVxdJQEnMflMYwNX63T0WEml2jkoH5SwadsgnXJeNc9U
         SW9GPNUTJKOpz5cA6UR4hYOm7J+mlShZBM40UmqhkpXWI/jXRfbGM1NnR0b0U+m0MgNa
         5u2kP9eSN5HcJnaV1KIp7qlK8CDbPk5ILi1tkYcJRR5vI2Md7RUOkZKkJVyrBF2Dp2ki
         gNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L8cB9tMKMFt76X4DI8vDrI1a5iyPbEIyxmNJ3xpjUSc=;
        b=erLlSumeenD1M/Ac5pQzw+TAuTAxeZRqZD5A3sEXozCNTfjyxX88UkxuOe61xSsPyQ
         XF8XvJNJQZr5t9RzQlzh8u6aZIach9WRlxiVk8NEh2QT3cndomhQExwhrBdNECqEfbhv
         VH5clDj0t6DWRaZ16pposD5tAHTXNmRf3Sf2A54bdXJ7/5Zxhbg9Jl8OtvtoDjxphP21
         5pFnM2lCrdIf0Lbtcf+AqRJkoaCtuvKFw5fcADAsQfqTTaoVo0iuhR5n3F3WJLR8jF+O
         MiLqY7Snd4A73aaK/q2kRPolbJNc4/AcbUUqcb70uSvvqlCDRR2DqwrkZkZRbonS1vaA
         jS1w==
X-Gm-Message-State: AOAM53026AYv4RLvMMCWKi7Ls4SvEBp5bZfE1KF8Qrf6p8kms343Hr7T
        Q3qmoQAK2/umirDC98sfj50CYwyRT3H962bIaOB2Sw==
X-Google-Smtp-Source: ABdhPJxBZ1hZCP4GFAmcD1QdbUmpG9CMdEl3OGyg3seI8qa40ZdgYmo1FLBZzCqnz/x+6LppAmPd9zD3gzRDr9aSkb4=
X-Received: by 2002:a1f:2e88:: with SMTP id u130mr16606990vku.15.1615304915030;
 Tue, 09 Mar 2021 07:48:35 -0800 (PST)
MIME-Version: 1.0
References: <20210215003249.GA12303@lupo-laptop> <CAPDyKFqy5z3a5sCXM8BCrhWQgNCUuOGc4VoOBqVwXnHZSdQaxQ@mail.gmail.com>
 <CABhGgDPpUXPHJ49E_ku5N-fO=GWZKTdQQUGugAruG6y2=J1YgA@mail.gmail.com>
In-Reply-To: <CABhGgDPpUXPHJ49E_ku5N-fO=GWZKTdQQUGugAruG6y2=J1YgA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 9 Mar 2021 16:47:58 +0100
Message-ID: <CAPDyKFri_6G2M7iP-p9Z2b-DmGgWtvndjosxpLRk0fNsuDhCtA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] Make cmdq_en attribute writeable
To:     Luca Porzio <porzio@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Zhan Liu <zliua@micron.com>, Luca Porzio <lporzio@micron.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 9 Mar 2021 at 14:18, Luca Porzio <porzio@gmail.com> wrote:
>
>
>>
>> This means adding a new path for when the host needs to get locked
>> (claimed), which is the opposite direction of what we have been
>> working on for SD/eMMC during the last couple of years.
>>
>> Please have a look at mmc_blk_issue_drv_op(), where you can find how
>> these kinds of requests are being funneled through the mmc block
>> device layer instead. This is the preferred option.
>>
>> That said, I am actually wondering if we perhaps could manage the
>> enable/disable of CQE "automagically" for FFU, along the lines of what
>> we do for RPMB already. In fact, maybe the best/easiest approach is to
>> *always* disable CQE when there is a request being received through
>> the mmc ioctl interface. Of course, then if we disabled CQE we should
>> also re-enable it when the ioctl request has been completed.
>>
>> What do you think?
>>
>>
>
> Thanks a lot for your feedback!
>
> The reason why this is an RFC patch and not a clear patch is exactly what you
> say here.
> During the FFU (as well as other sequence of commands issued through
> multi cmd() ioctl feature, is that sometimes it may require an emmc reboot or
> some other legacy command subsequent sequence (= which needs to be
> sent with two ioctl() multi_cmd sequences) and the legacy mode need to
> survive across reboots or partition changes.

The reboot is kind of a separate problem, even if it's related, isn't it?

What you propose is to add a sysfs node to let userspace
enable/disable CQE. I was under the impression that this was solely to
allow the FFU process to be completed, no?

Are you saying that we may want CQE to stay disabled beyond the FFU
process, to allow the reboot to be completed safely?

> Also we need to claim the host to make sure all the pending commands
> in the queue are completed successfully before disabling.

Yes, of course. It sounds like you may have misinterpreted my proposals.

The problem is not that we need to claim the host, but that you add an
entirely new path to do it.

*If* we conclude that we should add a sysfs node to control CQE, we
should create a mmc blk request for it (which will manage the claim
for us as well). I suggest you have a closer look at
power_ro_lock_store(), which should be the equivalent to what we need
to implement here.

>
> I can rethink the patch to implement a specific iotcl() request which disables
> CMDQ if you think that is a better implementation but in the end it will still
> require the host claim.
>
> Any feedback or suggestion is appreciated.

To be clear, I am not proposing to add a new ioctl for mmc. Those we
have today, should be sufficient I think.

However, rather than adding a new sysfs node to control CQE, perhaps
we can parse the received ioctl data structure, to find out if the
command/request is for FFU and then take specific actions. Along the
lines of what we do for mmc_sanitize(), for example.

Another option, rather than parsing ioctl data for the FFU
command/request, is to always temporarily disable CQE while processing
an mmc ioctl request.

Would this work?

Kind regards
Uffe
