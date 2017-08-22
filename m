From: Seraphime Kirkovski <kirkseraph@gmail.com>
Subject: Re: KASAN + general protection fault while writing to mmc
Date: Tue, 22 Aug 2017 17:52:31 +0200
Message-ID: <20170822155231.voiydjrfgbiomdkm@macchiaveli>
References: <20170810200733.27sqzr47ixlpxd62@macchiaveli>
 <CACRpkda+KZbbsMjmZe2LCNwuJ5CWHnG22zwvKJGC9_Kdn89LSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37623 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751003AbdHVPwg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Aug 2017 11:52:36 -0400
Content-Disposition: inline
In-Reply-To: <CACRpkda+KZbbsMjmZe2LCNwuJ5CWHnG22zwvKJGC9_Kdn89LSw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Aug 22, 2017 at 02:17:38PM +0200, Linus Walleij wrote:
 
> commit 67e69d5220c904238f94bb2e6001d7c590f5a0bb
> Author: Linus Walleij <linus.walleij@linaro.org>
> Date:   Fri May 19 15:37:27 2017 +0200
> 
>     mmc: block: remove req back pointer
> 
>     Just as we can use blk_mq_rq_from_pdu() to get the per-request
>     tag we can use blk_mq_rq_to_pdu() to get a request from a tag.
>     Introduce a static inline helper so we are on the clear what
>     is happening.
> 
>     Suggested-by: Christoph Hellwig <hch@lst.de>
>     Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>     Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Can you try reverting it and see if the problem goes away?
> 
> Yours,
> Linus Walleij

Thanks for the reply !

The problem doesn't go away, it is only delayed.

Will try to find some time to bisect it.

Thanks,
Seraphime Kirkovski
