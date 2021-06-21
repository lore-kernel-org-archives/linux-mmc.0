Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3308C48BE5
	for <linux-mmc@archiver.kernel.org>; Mon, 21 Jun 2021 09:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85B01611B0
	for <linux-mmc@archiver.kernel.org>; Mon, 21 Jun 2021 09:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhFUJX2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 21 Jun 2021 05:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhFUJX2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Jun 2021 05:23:28 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A623C061574
        for <linux-mmc@vger.kernel.org>; Mon, 21 Jun 2021 02:21:14 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id l26so674544vsm.9
        for <linux-mmc@vger.kernel.org>; Mon, 21 Jun 2021 02:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Vd+PiHe/bRMwnxiMCntHGnrHkv4JBBFa+zKaAXH/ik=;
        b=o19037BEi9Dfo1ZRbE+9uwTl0qZClU4ImAXQTQPWpbRUvSpymIfO03q37ef6YgjjpX
         IMFhFXsueQpoElj4cxKi959NDwhJQpkswzbWSAF+1DI470H1uHbfBh17femO8xSzr9E6
         OshtcVwygLfmP8W0dR521utFAK/ugxiOq3aQB4rwy33SYAm0vtOAijsdpTObtSNimpK9
         zzhhkM4MwyWav2y9BW0wumJdLbOa61PA1okKfXuqVDMwBrcIuL1LUtV2lk/Uhdwi0yja
         gD6U9TdPK+GKQmETtWuUsL4dAu4M1+b72qVEeHW556tdMbnzl+X7FTdTzoZKSjzbVmiT
         JZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Vd+PiHe/bRMwnxiMCntHGnrHkv4JBBFa+zKaAXH/ik=;
        b=tmkbQ2JUX7MDUxpF7nIt2UspfI+LDztip0D9DWAQBcCXjSHflODhR8QJuSzI8Df3Ci
         DoF6PqeMJOlcQ9yrP56rT2znjQHMRTONYnRa1hR4KYaWhifnIGXaCwt7yAk04+Bq7KER
         Tg6it+KCarFimSWRmihAfY3BJ5rApru8X4FxBfKLXuhpiWLeZL7V9UV2vpJ54TouXUaA
         vW/h28YXzVl8CqyjTYyb0WXePxShgY24aivkV0CVb8GfXgVoXd2pD68lYdRguB+91AhP
         WVCt8byCqamI/88v5Mu1Q3M65sCE5czqyjwfB4A5yA1KPWnEte5WKBJS9OlIqO+gl5Ge
         NxSg==
X-Gm-Message-State: AOAM5300uYeDX8WdEVkPJySzzFx9sWqDEkvGuUEsyiQ0/tLi8E6nCw/+
        GD4doYQLsrYBiVseYK8CBpgqnIhIqeHC5HZYtcflBw==
X-Google-Smtp-Source: ABdhPJyWynQJTb2V6t+oCYPeSuI9ZT9iQyheQZxOsYra5j4JCehtuF1qKlo0ua3FavFCXS9dY9cP3NthP6wRLhlbwhU=
X-Received: by 2002:a05:6102:3a70:: with SMTP id bf16mr6298082vsb.48.1624267273523;
 Mon, 21 Jun 2021 02:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210320045720.11872-1-chgokhl@gmail.com> <CAPDyKFqXtKPngfnQZXXaF=rvqw0=nWzDc7P++QxNHPwGHHSxUA@mail.gmail.com>
 <CAMjpFAUTsei-PWLDdM+_78qXTo=QFdw-Wbgo9QA2Jnss+i4yRA@mail.gmail.com>
In-Reply-To: <CAMjpFAUTsei-PWLDdM+_78qXTo=QFdw-Wbgo9QA2Jnss+i4yRA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 21 Jun 2021 11:20:36 +0200
Message-ID: <CAPDyKFqUhx8SmpXj=kmxzEKLWt4RU8rTxiiQgAXWX=fzmL=J0Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Mark mmc_host device with pm_runtime_no_callbacks
To:     chgokhl@163.com
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kehuanlin@fishsemi.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 21 Jun 2021 at 03:38, hieagle <chgokhl@gmail.com> wrote:
>
> Sorry, I don't receive the reply email in my gmail.
>
> Normally the mmc_host's power.disable_depth is large than zero, the
> rpm_resume(mmc:0001) will not be called recursively for parent. This is
> the most case.
>
> Although the mmc class device never calls pm_runtime_enable() directly,
> there are still some cases as below to call pm_runtime_enable(), which
> may cause it's power.disable_depth decremented to zero.
>   case1: device_resume_early->pm_runtime_enable
>   case2: device_resume->pm_runtime_enable

Those calls to pm_runtime_enable() are in balance with previous calls
to __pm_runtime_disable and pm_runtime_disable(), in
__device_suspend() and __device_suspend_late().

In other words, the power.disable_depth is not being decremented to
zero in any of those above path, I think.

>
> Anything that can go wrong will go wrong. Unfortunately we meet the case.
> If you trigger to set the mmc_host's power.disable_depth value to zero
> after mmc suspended, you can find the issue.
>
> In our platform the mmc device's parent list is as below:
>      mmc0:0001->mmc_host mmc0->fa630000.mmc->soc.
> The rpm_resume call trace is as below in our scenario:
>
> rpm_resume(mmc0:0001)
> |
> if (!parent && dev->parent) //true
> if (!parent->power.disable_depth
>    && !parent->power.ignore_children) //true
> rpm_resume(parent, 0) --->  rpm_resume(mmc_host, 0)
> |                           |
> |                           callback = RPM_GET_CALLBACK(mmc_host, ...) = NULL
> |                           retval = rpm_callback(callback, mmc_host) = -ENOSYS
> |                           |
> |                           return retval = -ENOSYS
> if (retval) goto out; //skip rpm_callback()
> return retval = -ENOSYS
>
> The scenario is rare, but anything that can go wrong will go wrong.
> The patch can enhance the code to avoid this scenario.

Well, I am still not convinced as I don't see how the
power.disable_depth can ever reach zero.

If you could provide a stack-trace of when power.disable_depth reaches
zero, that would be helpful.

[...]

Kind regards
Uffe
