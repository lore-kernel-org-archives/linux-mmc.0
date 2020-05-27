Return-Path: <SRS0=ylMS=7J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E0BC433DF
	for <linux-mmc@archiver.kernel.org>; Wed, 27 May 2020 08:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C63F21531
	for <linux-mmc@archiver.kernel.org>; Wed, 27 May 2020 08:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aymzI/kI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387566AbgE0IOb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 27 May 2020 04:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388055AbgE0IOa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 27 May 2020 04:14:30 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCFCC061A0F
        for <linux-mmc@vger.kernel.org>; Wed, 27 May 2020 01:14:30 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id u79so13318634vsu.4
        for <linux-mmc@vger.kernel.org>; Wed, 27 May 2020 01:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fmfoZfmhzabeVMwsdzGnuv3UwDmwdg3Ym71EQQu5TQU=;
        b=aymzI/kITTngEX0ptV4HPIee8CEDXaqxZ0X7KK99fhKxiif92uxZUjEMciisprTvhB
         3qXwRWZiEz1wExJkpFhqSBXUuRsd1mctOosGTOCThWfYUVIOLblXbESzuRloR5eofbwB
         UVFPdWLhHfI6ujettMl2PjsdAk4iDymfWfK4aTyrxcd65byi9HB28z1mIUpCl/QQFb27
         TmM0TlSVUJXCbN8A++Pqmr6Yqpc3M9kdhBMe4+SVkoZAwaXHenp6FpuoEehhKvuxorw9
         qRJea/CN5mlljFOjHJHOHxDvGYXr9bzOF+elZzNqx08pKzmWLvG7k6bjurgXG5TMrqlv
         /iJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fmfoZfmhzabeVMwsdzGnuv3UwDmwdg3Ym71EQQu5TQU=;
        b=he2Lqjfc02Ydh5JAgKFanAlfguoZAvgmCaUuSTzGPv6WCvhE9faB0xq/eRa2Engpyc
         eIJgHXUyV0lTxmkVHd/sd1+wiq/3p2cXsfVDCj/0SPTQD85uH8cWc9vBsffYAuaP0GzB
         WeKbbQdUx5nbisTeJgug92RvEd9TSK5474J+qXhM0jBqWie/bY58KYEBR2GiH4ZpVeSh
         8EXpUpw8WmqWtEpX/Xwpir8vX9bSjlLjPx05Yeo6C/Eb0JJSj+q4DK0DV4KzMNfGa2Vo
         Yq+354HJkEgZ2e6/zZXrsBiARA0Xn7OKVqMQi7K7Aogp2sN3kJi9TN0FFbcl134Z767j
         jMBA==
X-Gm-Message-State: AOAM533VtQvGBrsWdCa9FQxBMGvLNeDPgU5lpAd0MWXRF0FdplCMJLQR
        WC9V5gss7yW69W7LL04KCGBTc0cXqI8kwHxRC25Pm628mc1Qaw==
X-Google-Smtp-Source: ABdhPJwEqUEIdC4IfQOMlhlKfn71iTS2HgyzieFq/GTWNQrIba2U/ILr7oM6a1fbT+XffPEJ2ddCMmVVyQPr6gld5h8=
X-Received: by 2002:a67:be05:: with SMTP id x5mr3580242vsq.35.1590567269334;
 Wed, 27 May 2020 01:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200526154334.21222-1-pali@kernel.org> <20200526154334.21222-2-pali@kernel.org>
 <CAPDyKFq4KxT+m6nZbi9fM0Pf=JYkT7TTfERDxtUVX5qAiLAQBQ@mail.gmail.com> <20200527080007.gtd7w7fzwfrk4pef@pali>
In-Reply-To: <20200527080007.gtd7w7fzwfrk4pef@pali>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 27 May 2020 10:13:53 +0200
Message-ID: <CAPDyKFodXg3oAs3VfNbTRY=Rd+X+BqxzRAJq=mKT5QLXisPKAA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: core: Export device/vendor ids from Common CIS
 for SDIO cards
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 27 May 2020 at 10:00, Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Wednesday 27 May 2020 09:39:50 Ulf Hansson wrote:
> > On Tue, 26 May 2020 at 17:43, Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > >
> > > Device/vendor ids from Common CIS (Card Information Structure) may be
> > > different as device/vendor ids from CIS on particular SDIO function.
> > >
> > > Export these "main" device/vendor ids for SDIO and SD combo cards at =
top
> > > level mmc device in sysfs so userspace can do better identification o=
f
> > > connected SDIO and SD combo cards.
> >
> > What would userspace do with this information, more exactly?
>
> Userspace can e.g. write udev rules based on Common CIS vendor/device
> id. Or can exactly identify SDIO card by CIS vendor/device id. Also it
> can be suitable for "lssdio" tool to print all information about SDIO
> card.
>
> Currently I do not know any way how userspace can retrieve these ids for
> particular SDIO card. And correct identification is important.
>
> Other important thing is that kernel on some places (e.g. mmc quirks)
> uses Common CIS vendor/device id and on other places (e.g. binding
> drivers) it uses SDIO function device/vendor ids.
>
> So for debugging and developing kernel drivers it is needed to know
> correct Common CIS vendor/device id and SDIO functions vendor/device
> ids.
>
> > Isn't it just sufficient to give events per SDIO func, as we already
> > do in sdio_bus_uevent()?
>
> No because some SDIO cards have different Common CIS vendor/device id
> and different vendor/device ids for particular SDIO functions.
>
> Common CIS vendor/device id is the "main" identification of SDIO card,
> functions vendor/device ids just identify one of those functions.
>
> For example look at my patch "mmc: sdio: Fix macro name for Marvell
> device with ID 0x9134" [1]. Without knowing correct CIS vendor/device id
> I was not able to fully understand problem and mess with names and ids.
> Because mmc quirks list uses CIS vendor/device ids (I guess for obvious
> reason as SDIO functions are not enumerated yet).

Good points, much appreciated to understand the use cases better!

May I suggest that you put some of this information into the commit message=
?

>
> [1] - https://lore.kernel.org/linux-mmc/20200522144412.19712-2-pali@kerne=
l.org/
>

[...]

Kind regards
Uffe
