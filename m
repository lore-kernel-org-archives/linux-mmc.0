Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DC0C433B4
	for <linux-mmc@archiver.kernel.org>; Tue, 11 May 2021 10:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2D9860FEB
	for <linux-mmc@archiver.kernel.org>; Tue, 11 May 2021 10:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbhEKK5x (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 11 May 2021 06:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbhEKK5x (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 May 2021 06:57:53 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A63EC061574
        for <linux-mmc@vger.kernel.org>; Tue, 11 May 2021 03:56:47 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id u15so6195099ual.9
        for <linux-mmc@vger.kernel.org>; Tue, 11 May 2021 03:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SucpVkeQo2gzFHxSx4ZsD2akx3g+C3xmtwYaxxMF/nE=;
        b=AYxAujt2SNB7zp2bbLbo6vzwxhDGmoe0pC6+UweXRHhMJktnfnXX7rgDiZN2Gf9NO2
         owTldJ8bNo3emPBhRbNPFvbR5mKE/SANZtuT8TMvVtcT0vyIi1RnNtr7IFQqE0QSQgOf
         /en8v4P1QsKpKh/4xz8MF+OXE08asJKg0mLFGOkVomgULV4ccSw2KNBjTsaToEUGXn7u
         AC2cP96TpCxJ6PruyUzi0PrmGXamXg7XqbRjo+lMt+50X2sgoq3Ks4MPb9wAcdr9qzEo
         5oBkNkN5gv/t2I7VbzFhEJIZQWzOalqfI3VSC5qQMGVECKJA5+Mv1PCpah53ThrjsH+H
         FxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SucpVkeQo2gzFHxSx4ZsD2akx3g+C3xmtwYaxxMF/nE=;
        b=WrR3XDAGyGW5mmW51vuGGeHBjMSFbFglCPQSIPticYBzoHd2vjX902/rE9f0+nvI2Y
         csXG7S7gRVhxhJk2NQib916H9pWSx9Rld9/Za4inzCnqR9lOapniTHy7ePJqScQPNX9q
         7eAoHrX57BINPHDhOu0xgdMslSvQoR4jvFkSBqHpUao5B3P9w/jRvEapIjVQFR/jiVx2
         zRfsTG80qXmmDNPdIijlWepSofmBb0A22KweNbHOIx5RDg/AAw6ymb0g/0Xh8iPvHt/C
         ZFTBRjbkzdixvXTlgnD9jM/COr4sm4vlLc3OALiBNcQxFo8goRWF6MkeD/gY0YTZKWZc
         /giw==
X-Gm-Message-State: AOAM533OneGevxrsKz87K7QC1nl3GyKo+BkZ4OYnxSK9EVgjn1Sjihe3
        G5ytE+osXdH1rt9uu/DEvXEsobvQJW9kh+8mjklR1D9euxD3gQ==
X-Google-Smtp-Source: ABdhPJwUE5JjRKxQFsFK4lmroPWSHTrFPNnNz8ucc3sIeZ1ViXpdlHd0X3C6YjSTC0GEzai3pSLPLnMCsWmFU/aSEqU=
X-Received: by 2002:ab0:59cb:: with SMTP id k11mr10344471uad.100.1620730606337;
 Tue, 11 May 2021 03:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <1617765339-28946-1-git-send-email-tiantao6@hisilicon.com> <CAPDyKFo4L4d0URRyBBj8wFnbJpaMkGrMzNQaGKFSv_PaHcz2aQ@mail.gmail.com>
In-Reply-To: <CAPDyKFo4L4d0URRyBBj8wFnbJpaMkGrMzNQaGKFSv_PaHcz2aQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 May 2021 12:56:09 +0200
Message-ID: <CAPDyKFq2DiCS09RwWxuhBxrUu3=vdp1qm9a_D746iDAcMByY5w@mail.gmail.com>
Subject: Re: [PATCH] mmc: s3cmci: move to use request_irq by IRQF_NO_AUTOEN flag
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 12 Apr 2021 at 09:50, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 7 Apr 2021 at 05:15, Tian Tao <tiantao6@hisilicon.com> wrote:
> >
> > disable_irq() after request_irq() still has a time gap in which
> > interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
> > disable IRQ auto-enable because of requesting.
> >
> > this patch is made base on "add IRQF_NO_AUTOEN for request_irq" which
> > is being merged: https://lore.kernel.org/patchwork/patch/1388765/
> >
> > Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
>
> FYI, I will have to wait to apply the $subject patch until the above
> change (which is commit cbe16f35bee6 in linux-next) is available in an
> rc.

Applied for next, thanks!

[...]

Kind regards
Uffe
