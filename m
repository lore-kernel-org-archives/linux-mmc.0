Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9C8C433DB
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 11:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 823EE23A40
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 11:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbhANL40 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Jan 2021 06:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbhANL4Z (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jan 2021 06:56:25 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E5CC061574
        for <linux-mmc@vger.kernel.org>; Thu, 14 Jan 2021 03:55:45 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id w7so1669934uap.13
        for <linux-mmc@vger.kernel.org>; Thu, 14 Jan 2021 03:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B5UPIaQcaOt1sU5aw6DX3Ebj1luWJJO/dXhi5/M+GXI=;
        b=GLFZJESf15UW7RIMVRGKyfz+4AIlj0qS348Z85V6mVQFyeveEBCwB996PwaU8JRA6C
         eAuE7/5YgxMlkRCXtwuDhIa7LfsuSoORl7s0HYXnYaS6+xHtev6A0WMgkUKa3SbhMYVw
         IJUXadXfVSzBFAj1bGh9IY4TkjfjnLdSm0VgiywCudajI3Nx+GP3C+9HpsHT1gi3Hpj1
         x75aE8zGtUIhd0Ezg/bCfrjkFHUYYcqN1pplrzTV6yWPcxv7qYLG6VRQ8DIj0BBXVoz6
         KiWNuUyxsiwvILdLBbPdNZBG3X9jtFhzOK2b5aFtVvskYBehsQ0mb+pUk0Lj/qergZHO
         IN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B5UPIaQcaOt1sU5aw6DX3Ebj1luWJJO/dXhi5/M+GXI=;
        b=qyzwj/pqAdnFCb3tadwAT7K0nL3aF4yvjyhTvQTYLxFcUqx5BcOYDOPRf2EenpHhRA
         oYSE7MjD7TdPraCYihEbtrerwbmhd3GE/TmH5FoG67I27JdA6TIAiJsJoiwtBWIlHMDa
         UsSMPMGZqepszFCKKop6Qv+eVjnXxwMgLF17B4eUPdPzjLX0nOqxOu4v1EhXv2GYyNoh
         fazZJU4ZnSLGQNPbrjiDIfEFPL0bBUSTA6dopFyw3/WCzkwiB/GpQUSntEuwVf3qyyON
         tknk7Uc9yK1/HGi6++Wp0GyWcolwYl6cVHkqLUjvBLZHsIsbEpB57KrXM6+zP77HbSZv
         nHHQ==
X-Gm-Message-State: AOAM530lI1GPvGOzfMgSb1ESZx+BsKygUGlLZn1hYcSJspAWxjoxXqHr
        GZUrWr/6gaqBLcdikqBe8KJrPz9ifGtmFYOd5qFvpQ==
X-Google-Smtp-Source: ABdhPJyKGWog9XtxzRfsPlKrm2aIF5fzCIHENGiFJDFNjR2g1WrLXz8ju1l3L0O+2qk/1Lki2PH0rEijCiP0ueGyd20=
X-Received: by 2002:ab0:2e99:: with SMTP id f25mr5348091uaa.104.1610625343834;
 Thu, 14 Jan 2021 03:55:43 -0800 (PST)
MIME-Version: 1.0
References: <CAG=_e5DcNhoVM3rbzsocpBKwuwt9C0x7-B-fLwrFwyN82zTvHQ@mail.gmail.com>
In-Reply-To: <CAG=_e5DcNhoVM3rbzsocpBKwuwt9C0x7-B-fLwrFwyN82zTvHQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Jan 2021 12:55:07 +0100
Message-ID: <CAPDyKFoycHLO_c3xfpoHLmLKzri6vQa1zvuFUjGiB803XxkGUQ@mail.gmail.com>
Subject: Re: Bug Report Broadcom BCM57765/57785
To:     =?UTF-8?B?TWFydMOtbiBYacO6aG5lbCBNb3JhIFJvbGTDoW4=?= 
        <necrodos@gmail.com>, Scott Branden <scott.branden@broadcom.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Scott

On Thu, 14 Jan 2021 at 02:50, Mart=C3=ADn Xi=C3=BAhnel Mora Rold=C3=A1n
<necrodos@gmail.com> wrote:
>
> Hi, I want to report a bug related to the drivers of the sd card
> reader Broadcom Broadcom Corporation BCM57765/57785 SDXC/MMC Card
> Reader. Basically It doesn't show the inserted cards, and even though
> it has a workaround that has worked flawless for mac users, many acer
> user seem to have problems like not being able to transfer large files
> (larger than a couple or not being able to format the card. I know
> this has been reported before but it keeps having problems. Thanks for
> your help, here are some links to previous reports of this bug and
> previous attempts to solve this issue. I experience this bug on a
> laptop acer v5-131 with said sd card reader running elementary 5.1.7
> Hera but I've encountered this same bug on all other ubuntu flavors on
> this same device. All using Kernel 5.4
>
> Please, if I'm doing something wrong by trying to report this bug,
> please let me know
>
> https://gist.github.com/samgooi4189/2e6e18fd1d562acaf39246e5e386d7cb
>
> https://askubuntu.com/questions/444484/broadcom-card-reader-bcm57765-bcm5=
7785-doesnt-work-on-ubuntu-12-04-lts
>
> https://bugzilla.kernel.org/show_bug.cgi?id=3D206005
>
> Thanks you so much for your attention

Hi Martin,

I am sorry, but this isn't really my cup of tea.

It looks like the sd controller is based upon sdhci-pci. As far as I
know, I don't think there have been any Broadcom engineers working on
that driver ever, but I might not have the complete history.

In any case, I have looped in Scott Branden from Broadcom, perhaps he
can help to move this forward in some way or the other.

Kind regards
Uffe
