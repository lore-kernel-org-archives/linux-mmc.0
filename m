From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/3] The uncontroversial patches
Date: Mon, 10 Apr 2017 15:53:33 +0200
Message-ID: <CAPDyKFojk8h2KqB5i8Km=UhtKwQOa55nHSko+5GDNV5q1SYfDw@mail.gmail.com>
References: <20170328084031.11995-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f182.google.com ([209.85.217.182]:34529 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753334AbdDJNxk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Apr 2017 09:53:40 -0400
Received: by mail-ua0-f182.google.com with SMTP id u103so37580588uau.1
        for <linux-mmc@vger.kernel.org>; Mon, 10 Apr 2017 06:53:39 -0700 (PDT)
In-Reply-To: <20170328084031.11995-1-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On 28 March 2017 at 10:40, Linus Walleij <linus.walleij@linaro.org> wrote:
> These are the three patches from my "stop flushing the queue with NULL
> and convert to MQ" patch series that are uncontroversial. I send them
> separately so (hopefully) Ulf can apply them and shrink my patch stack
> a bit.
>
> Linus Walleij (3):
>   mmc: core: move some code in mmc_start_areq()
>   mmc: core: refactor asynchronous request finalization
>   mmc: core: refactor mmc_request_done()
>
>  drivers/mmc/core/core.c | 126 +++++++++++++++++++++---------------------------
>  1 file changed, 54 insertions(+), 72 deletions(-)
>
> --
> 2.9.3
>

Thanks, applied for next!

Kind regards
Uffe
