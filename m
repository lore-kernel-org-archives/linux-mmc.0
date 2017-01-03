From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] RFD: switch MMC/SD to use blk-mq multiqueueing
Date: Tue, 3 Jan 2017 13:57:44 +0100
Message-ID: <CACRpkdatyPCfs3ymGwNyxZ4=Zcvb+n0fwiGXmnHx5o9cEGU7Jg@mail.gmail.com>
References: <1482242508-26131-1-git-send-email-linus.walleij@linaro.org>
 <20161228085503.GA340@lst.de> <CACRpkdb2zyjRz_zniT5nLxWCeLwagn1ZiTWwXc6bHW229NmfPQ@mail.gmail.com>
 <2360959.cyJgAELf50@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:34471 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934268AbdACM5p (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Jan 2017 07:57:45 -0500
Received: by mail-qk0-f170.google.com with SMTP id h201so234358263qke.1
        for <linux-mmc@vger.kernel.org>; Tue, 03 Jan 2017 04:57:45 -0800 (PST)
In-Reply-To: <2360959.cyJgAELf50@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, Ritesh Harjani <riteshh@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-block@vger.kernel.org, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Paolo Valente <paolo.valente@linaro.org>

On Mon, Jan 2, 2017 at 10:40 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> b) without MMC CMDQ support:
>   - report queue depth of '2'
>   - first request gets handled as above
>   - if one request is pending, prepare the second request and
>     add a pointer to the mmc host structure (not that different
>     from what we do today)
>   - when the host driver completes a request, have it immediately
>     issue the next one from the interrupt handler. In case we need
>     to sleep here, use a threaded IRQ, or a workqueue. This should
>     avoid the need for the NULL requests

This part we can do already today with the old block layer and I think
we (heh, I guess me) should do that as the first step.

After this migrating to blk-mq becomes much easier.

Yours,
Linus Walleij
