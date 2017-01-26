From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/6] mmc: block: command issue cleanups
Date: Thu, 26 Jan 2017 09:07:19 +0100
Message-ID: <CAPDyKFrB9UfkfGD08fTKegSB2W65pdWuDU=10mGukQmB=yhaqQ@mail.gmail.com>
References: <20170124101757.19676-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-block-owner@vger.kernel.org>
In-Reply-To: <20170124101757.19676-1-linus.walleij@linaro.org>
Sender: linux-block-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-block@vger.kernel.org, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Paolo Valente <paolo.valente@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On 24 January 2017 at 11:17, Linus Walleij <linus.walleij@linaro.org> wrote:
> The function mmc_blk_issue_rw_rq() is hopelessly convoluted and
> need to be refactored to it can be understood by humans.
>
> In the process I found some weird magic return values passed
> around for no good reason.
>
> Things are more readable after this.
>
> This work is done towards the goal of breaking the function in
> two parts: one just submitting the requests and one checking the
> result and possibly resubmitting the command on error, so we
> can make the usual path (non-errorpath) smooth and quick, and
> be called directly when the driver completes a request.
>
> That in turn is a prerequisite for proper blk-mq integration
> with the MMC/SD stack.
>
> All that comes later.
>
> Linus Walleij (6):
>   mmc: block: break out mmc_blk_rw_cmd_abort()
>   mmc: block: break out mmc_blk_rw_start_new()
>   mmc: block: do not assign mq_rq when aborting command
>   mmc: block: inline command abortions
>   mmc: block: introduce new_areq and old_areq
>   mmc: block: stop passing around pointless return values
>
>  drivers/mmc/core/block.c | 108 ++++++++++++++++++++++++++---------------------
>  drivers/mmc/core/block.h |   2 +-
>  2 files changed, 60 insertions(+), 50 deletions(-)
>
> --
> 2.9.3
>

Thanks, applied for next!

Kind regards
Uffe
