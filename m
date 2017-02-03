From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 00/10] Further MMC core/block cleanups
Date: Fri, 3 Feb 2017 10:58:18 +0100
Message-ID: <CAPDyKFrsU8Km3Hc01YatMVdkeCtgDDOfTpAhSGAvMFt-aE1y8A@mail.gmail.com>
References: <20170201124800.13865-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38075 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752952AbdBCJ6V (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Feb 2017 04:58:21 -0500
Received: by mail-wm0-f52.google.com with SMTP id r141so19616288wmg.1
        for <linux-mmc@vger.kernel.org>; Fri, 03 Feb 2017 01:58:20 -0800 (PST)
In-Reply-To: <20170201124800.13865-1-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>

On 1 February 2017 at 13:47, Linus Walleij <linus.walleij@linaro.org> wrote:
> This is a continuation of the series merged to start cleaning
> up the very big mmc_blk_issue_rw_rq() and friends.
>
> Again the goal is to get the code in a shape such that I can
> get rid of flusing the pipeline with NULLs and report the
> requests as finished directly to the block layer, without
> having to wait for an iteration of mmc_blk_issue_req() to
> happen before they get postprocessed and finished.
>
> Feel free to apply this partially, or defer it all to after
> v4.11-rc1 *NO*RUSH*.
>
> It is just my idead of a cleanup road toward blk MQ
> compliance. I think most patches stand on their own but can
> be perceived as over-pedantic without that context.

I like it as is! Please continue! :-)

Each step puts me in a better position of maintaining the code.

>
> Linus Walleij (10):
>   mmc: block: inline the command abort and start new goto:s
>   mmc: block: rename rqc and req
>   mmc: core: rename mmc_start_req() to *areq()
>   mmc: block: refactor mmc_blk_rw_try_restart()
>   mmc: block: rename mmc_active to areq
>   mmc: queue: turn queue flags into bools
>   mmc: block: return errorcode from mmc_sd_num_wr_blocks()
>   mmc: block: respect bool returned from blk_end_request()
>   mmc: block: return 0 where evident
>   mmc: core: start to break apart mmc_start_areq()
>
>  drivers/mmc/core/block.c    | 179 ++++++++++++++++++++++++--------------------
>  drivers/mmc/core/core.c     |  79 ++++++++++++-------
>  drivers/mmc/core/mmc_test.c |   8 +-
>  drivers/mmc/core/queue.c    |  12 +--
>  drivers/mmc/core/queue.h    |   7 +-
>  include/linux/mmc/core.h    |   2 +-
>  6 files changed, 163 insertions(+), 124 deletions(-)
>
> --
> 2.9.3
>

I have reviewed this and it looks good to me. As we likely can expect
getting at least an rc7 from Linus, I think we still have time.

So, I have queued this up for next! Thanks!

Kind regards
Uffe
