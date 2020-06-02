Return-Path: <SRS0=LU6H=7P=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9982EC433E0
	for <linux-mmc@archiver.kernel.org>; Tue,  2 Jun 2020 00:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BABA20734
	for <linux-mmc@archiver.kernel.org>; Tue,  2 Jun 2020 00:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ic+u8p6S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbgFBAwE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 1 Jun 2020 20:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgFBAwE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Jun 2020 20:52:04 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA2AC061A0E;
        Mon,  1 Jun 2020 17:52:04 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l26so1220614wme.3;
        Mon, 01 Jun 2020 17:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q4MVUxv0On8GX8obZ3p2sWE39V+Nq6X018ptq3gDGoM=;
        b=Ic+u8p6SFi2DqCGneU/7he/W3LvMaI3M2ib4TwAdH7fj7P4zQx10xckkylip+PVM5Q
         vIe0rvBqouCIv4eXoKGNwlsxZeGOb1ySj3UVnkmrrUxqv3NxA6tR/NSdVTs+y33AFE9v
         3VeXL+0K89skDVaq+PTzJtRXwzZ82ZW7RAhLS8bQZToyId5zc3MoNdlBmj7AFLkGmhnH
         midLDA548kIj2QkP+L9ixMCqhq5Lxycuh4q4Y3agUILtJ0vU76RPOTQy6YeQhAP0AvHB
         i7YSc54/L/LST1HVT3MNdMqiqiX/ZBL6V4jLNzERJBvk/7jUKFUkJdWbWY35Bhd134ni
         6pAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q4MVUxv0On8GX8obZ3p2sWE39V+Nq6X018ptq3gDGoM=;
        b=HkbjXytCmDjKG7+JfGqqdDW6fibp/N+P5mWA4MPKATUTFO9PQUmurHxT5xrcm8YTF9
         ceD6WryPlS/iXPoIwfIhP+yn0dc/+d6kx3CxaieoMwYwlsCa7bIFhwSk1v3tEbj4pF0H
         4YxkMAvcV7QCNIwCFH9esdKmHsR2wxg8mw+9v1Bf6JLOIl9stOh7OBCmymN5YevsWGOD
         ntBZClvEiSL7tjZdTz/NgvmEH5GIqgTVuvI5hRJRcaTmYRjyolUbKtKJ6FypjJB6s33N
         cZ0PBToBSA5XOWVZPjaj7zGnuDjUnl7M+xANnZx1EDBWEIJRYHgVRbuTCPLZ8DymBSa3
         cf1g==
X-Gm-Message-State: AOAM532HwN2R5x4ohqBLWmrT5jWCZl23qKJOlQolRhj0xG3abOk0MUOR
        M2LGaRTdCz2+tp5YVH7WZ/RGTsTv6EAwRkqMcsMxjKJN/Wc=
X-Google-Smtp-Source: ABdhPJw28KyFBIlWwF//bIvAV05fuo3FykaRcpy6MKV8UhwSgPkX8XySztmLJkN0g5EIv0ek4dKqMU8JMc2r8E3mMoQ=
X-Received: by 2002:a1c:9e13:: with SMTP id h19mr1704536wme.107.1591059122900;
 Mon, 01 Jun 2020 17:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <CACYmiSfM00o864c5pxxWEQNZsgFMkNwJePCGvae6P7o31NXMyw@mail.gmail.com>
 <0fc7c8c2-ac6a-2b66-074b-92b5d03219b6@infradead.org>
In-Reply-To: <0fc7c8c2-ac6a-2b66-074b-92b5d03219b6@infradead.org>
From:   Philip Schwartz <philquadra@gmail.com>
Date:   Mon, 1 Jun 2020 19:51:51 -0500
Message-ID: <CACYmiSer8FA+qjh8NHZJ2maxSd-=RwDdZ2F7_-E4uM1NXuZ8gQ@mail.gmail.com>
Subject: Re: Bug in your kernel since version 5.2
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, RickyWu <ricky_wu@realtek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Thanks, I'll check it out.

On Mon, Jun 1, 2020 at 7:35 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> [adding Cc:s and comments]
>
>
> On 6/1/20 3:52 PM, Philip Schwartz wrote:
> > This is my sixth attempt to send a bug report.
> >
> > The first time you didn't like my email address.
> > The second time you didn't like that I copied the whole url.
> > The third time you didn't like that the part of the url that I copied
> > looked a bit like a url.
> > The fourth time you complained that "The message contains HTML
> > subpart,therefore we consider it SPAM"
>
> Yes.
>
> > The fifth time you didn't like ?????????.
> >
> > Kernel dot org Bugzilla       I D equals  204003
> >
> >
> > I look forward to your email rejection message.
>
>
> Please see https://bugzilla.kernel.org/show_bug.cgi?id=204003
>
> Several people are having problems with Intel NUCs and/or
> the RTS5229 PCI Express Card Reader/driver, beginning with
> 5.1-rc1.
>
> Here is one bugzilla comment:
> Did a git bisect and found the culprit.
>
> bede03a579b3b4a036003c4862cc1baa4ddc351f is the first bad commit
> commit bede03a579b3b4a036003c4862cc1baa4ddc351f
> Author: RickyWu <ricky_wu@realtek.com>
> Date:   Tue Feb 19 20:49:58 2019 +0800
>
>     misc: rtsx: Enable OCP for rts522a rts524a rts525a rts5260
>
>     this enables and adds OCP function for Realtek A series cardreader chips
>     and fixes some OCP flow in rts5260.c
>
>     Signed-off-by: RickyWu <ricky_wu@realtek.com>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> :040000 040000 65bfdc473b7b85cb423ff528309fc92d73eae5b4 1292d8564f678027d0e5c77550e37d696b134b28 M      drivers
>
> Just revert that and you'll be golden.
>
> rts522a,rts524a,rts525a,rts5260
> So somehow OCP got enabled for rts5229 unless a means rts522x. I guess they need to make sure its not enabled for 5229.
> {end of bugzilla comment}
>
>
>
> --
> ~Randy
>
