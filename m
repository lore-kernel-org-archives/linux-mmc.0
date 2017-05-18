From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/5] mmc: core: Allocate per-request data using the block
 layer core
Date: Thu, 18 May 2017 15:31:53 +0200
Message-ID: <CACRpkdZMNWp2PmTf-ypn=hxHa8GPCbVhA5OKdCWp5FBRUQu22Q@mail.gmail.com>
References: <20170510082418.10513-1-linus.walleij@linaro.org>
 <20170510082418.10513-3-linus.walleij@linaro.org> <f432dc3d-f66a-fcfe-fd8f-ac764b29c9db@intel.com>
 <CACRpkdaZuyZNDV=bjy2maZ0HYMEZCkNctkbEivThNM4jDT_c8Q@mail.gmail.com> <eb50dffe-5cb9-d8d3-e218-399de512b074@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:36477 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934945AbdERNcJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 18 May 2017 09:32:09 -0400
Received: by mail-io0-f172.google.com with SMTP id o12so28461767iod.3
        for <linux-mmc@vger.kernel.org>; Thu, 18 May 2017 06:32:04 -0700 (PDT)
In-Reply-To: <eb50dffe-5cb9-d8d3-e218-399de512b074@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Paolo Valente <paolo.valente@linaro.org>

On Thu, May 18, 2017 at 2:42 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 18/05/17 11:21, Linus Walleij wrote:

>> It's better to do what everyone else does and let the core do this
>> allocation of extra data (tag) instead.
>
> I agree it is much nicer, but the extra bounce buffer allocations still seem
> gratuitous.  Maybe we should allocate them as needed from a memory pool,
> instead of for every request.

Incidentally IIRC that is what happens when we migrate to MQ.
In the old block layer, the per-request data is indeed initialized for
every request as you say, but in MQ the same struct request *'s
are reused from a pool, they are only initialized once, i.e. when
you add the block device.

(If I remember my logs right.)

Yours,
Linus Walleij
