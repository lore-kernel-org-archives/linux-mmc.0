Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BCDC49EA2
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Jun 2021 09:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E4CF61410
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Jun 2021 09:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhFQKBM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbhFQKBG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Jun 2021 06:01:06 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71133C061574
        for <linux-mmc@vger.kernel.org>; Thu, 17 Jun 2021 02:58:57 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id l7so1246825vkk.2
        for <linux-mmc@vger.kernel.org>; Thu, 17 Jun 2021 02:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OYaWFAmTtxmIx4SKywhtr8a4SqDaDzqjBCGGtLGU/+0=;
        b=fUo7M6mqD7YawUEwJgqJhK4QCX7qicV+JHxE6Mz0lXGSaBU31SAJMVRa7XGotjPjMU
         +8Al2APuUOPSIOVVFcgiDqUsyr2SvVrnMW+CMK1u7Bi7V4baL9c9qktdkFy084SnMhO6
         yGF3Kx3cToUXzpZCKmQI3i9OHv9jyd07uvM0p7ZjzX/Bkb45W8tTFFBRTdxiTWIwKaHJ
         lYZ0H80ZT1ddFwbXLLqpJWs6jLi6ZTphvA/h+WBQtBhTAH7+vJaWd5P7hk1gGRlayBzm
         CpzV8VeO8RBkgBXCxGugW2iOzuyhq1EZmMdxq+VsL0cG1ZfevF6UDS0/E3vJZAbl29x/
         EegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OYaWFAmTtxmIx4SKywhtr8a4SqDaDzqjBCGGtLGU/+0=;
        b=AOdNwl2d6XRYHUQh7DqnFKhJods9ODoykpCJqj+wlRAW1t+gnUZvI6n1WLktGHeG7t
         IFkH3eGytcIXIShvL0A1aKSFdBilNtwYsiq08q9BoewDdL7oNXpExrmHxuEjunT8Cojz
         o8F1ybuNG4yYtof/Iao4ONOb4xcCiezOSTpogu1/UKmcv6VNFO/LjmW5d1NDhbqzsIqI
         AISYScdZ9huPHsTLt48cdMqASHIcrPnjBRueeI2EjVzx5G1lJ58snasKtC0h1mXunRHg
         /zoz/9nU9U+QS+ef0lUXrfRsj3ntWL/0kXKqPT39TQZTxFUBXMbMKSIPGeninSNX6URH
         KTzQ==
X-Gm-Message-State: AOAM5302rrPW0JIQ1gUDQSB1tQ8jzl/CFpySdJk2YMqKC0vRgPFpvcoc
        yVjmSnhWpIQJ4ikwsKRo9GE68gVtaysqa/XxxkFyYw==
X-Google-Smtp-Source: ABdhPJyIZga3abYOI3nzgl4Yaha/nsc+4zOdXfgH0s0eyQC6r6mAcL/fEYaekMcxaUc/gITsdWnBqo6q89C6TK3jJ2c=
X-Received: by 2002:a1f:9542:: with SMTP id x63mr3031503vkd.15.1623923936658;
 Thu, 17 Jun 2021 02:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210616053934.880951-1-hch@lst.de>
In-Reply-To: <20210616053934.880951-1-hch@lst.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Jun 2021 11:58:20 +0200
Message-ID: <CAPDyKFpAeUfMuXxbYE62Hjdjs==9zDZthvTDjBnrDd6v9iPGQQ@mail.gmail.com>
Subject: Re: convert the mmc driver to use blk_mq_alloc_disk
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Jens

On Wed, 16 Jun 2021 at 07:39, Christoph Hellwig <hch@lst.de> wrote:
>
> Hi Ulf,
>
> can you take a look at this series which converts the mmc driver to the
> new blk_mq_alloc_disk interface.  It is based upon Jens' for-5.14/block
> or for-next trees.

I don't see any issues with queuing this via Jens' tree, as I have
only a few minor changes queued in my mmc tree that touch the
corresponding files. None of which should cause a merge conflict, I
think.

>
> Diffstat:
>  block.c |   28 ++++------------------------
>  queue.c |   23 ++++++++++-------------
>  queue.h |    2 +-
>  3 files changed, 15 insertions(+), 38 deletions(-)

Kind regards
Uffe
