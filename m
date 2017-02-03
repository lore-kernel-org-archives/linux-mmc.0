From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 08/10] mmc: block: respect bool returned from blk_end_request()
Date: Fri, 3 Feb 2017 10:52:30 +0100
Message-ID: <CAPDyKFq8YygebEL7OSo0ApoeVXUk1tuu5k1K1ZuCWozd8yFsTg@mail.gmail.com>
References: <20170201124800.13865-1-linus.walleij@linaro.org> <20170201124800.13865-9-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36152 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752945AbdBCJwc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Feb 2017 04:52:32 -0500
Received: by mail-wm0-f49.google.com with SMTP id c85so20138928wmi.1
        for <linux-mmc@vger.kernel.org>; Fri, 03 Feb 2017 01:52:32 -0800 (PST)
In-Reply-To: <20170201124800.13865-9-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>

[...]

>
>  static void mmc_blk_rw_cmd_abort(struct mmc_card *card, struct request *req)
>  {
> -       int ret = 1;
> -
>         if (mmc_card_removed(card))
>                 req->rq_flags |= RQF_QUIET;
> -       while (ret)
> -               ret = blk_end_request(req, -EIO,
> -                                     blk_rq_cur_bytes(req));
> +       while (blk_end_request(req, -EIO, blk_rq_cur_bytes(req)))
> +       {
> +       }

These brackets isn't needed, so am going to change this before applying.

while (blk_end_request(req, -EIO, blk_rq_cur_bytes(req)));

[...]

Kind regards
Uffe
