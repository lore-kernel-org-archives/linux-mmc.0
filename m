From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: KASAN + general protection fault while writing to mmc
Date: Tue, 22 Aug 2017 14:17:38 +0200
Message-ID: <CACRpkda+KZbbsMjmZe2LCNwuJ5CWHnG22zwvKJGC9_Kdn89LSw@mail.gmail.com>
References: <20170810200733.27sqzr47ixlpxd62@macchiaveli>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170810200733.27sqzr47ixlpxd62@macchiaveli>
Sender: linux-kernel-owner@vger.kernel.org
To: Seraphime Kirkovski <kirkseraph@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Aug 10, 2017 at 10:07 PM, Seraphime Kirkovski
<kirkseraph@gmail.com> wrote:

> I got this while restoring a backup with dd on an SDCard.
> On 4.13.0-rc4 I get it everytime.
>
> I'm not sure if it isn't a hardware problem as I have no more cards
> left.

The only patch that touched blk_rq_map_sg() that calls sg_next()
was this:

commit 67e69d5220c904238f94bb2e6001d7c590f5a0bb
Author: Linus Walleij <linus.walleij@linaro.org>
Date:   Fri May 19 15:37:27 2017 +0200

    mmc: block: remove req back pointer

    Just as we can use blk_mq_rq_from_pdu() to get the per-request
    tag we can use blk_mq_rq_to_pdu() to get a request from a tag.
    Introduce a static inline helper so we are on the clear what
    is happening.

    Suggested-by: Christoph Hellwig <hch@lst.de>
    Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
    Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Can you try reverting it and see if the problem goes away?

Yours,
Linus Walleij
