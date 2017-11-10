From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 00/12 v5] Multiqueue for MMC/SD
Date: Fri, 10 Nov 2017 14:39:09 +0100
Message-ID: <CACRpkdb72u4Pso9YwCpsWey4pLazKbLmL6z5RxhswMf0zbAnsw@mail.gmail.com>
References: <20171110100143.12256-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:49658 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752592AbdKJNjK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Nov 2017 08:39:10 -0500
Received: by mail-io0-f194.google.com with SMTP id x63so1398058ioe.6
        for <linux-mmc@vger.kernel.org>; Fri, 10 Nov 2017 05:39:10 -0800 (PST)
In-Reply-To: <20171110100143.12256-1-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-block <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Paolo Valente <paolo.valente@linaro.org>, Avri Altman <Avri.Altman@sandisk.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

On Fri, Nov 10, 2017 at 11:01 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:

> Removing a card during I/O does not work well however :/
> So I guess I would need to work on that if this series should
> continue. (Hopefully unlikely.)

I tested a bit more and it turns out this doesn't work on any of
the MQ patch sets.

Which matches Christoph's statement that this is not really
working. I haven't really analyzed why though, I can see that
the kernel crashes firmly into a brick wall, but on mainline
it does not.

I think it's just something we have to smoke out in the next
release cycle as we switch to MQ.

Yours,
Linus Walleij
