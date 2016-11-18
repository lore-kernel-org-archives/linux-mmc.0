From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [patch] mmc: mmc_test: Uninitialized return value
Date: Fri, 18 Nov 2016 15:29:18 +0100
Message-ID: <CAPDyKFrOH2h7TXLx8GUr8_nb6DHTqUr9J=ppJM-UJNDaJj-rLw@mail.gmail.com>
References: <20161114113134.GA20543@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20161114113134.GA20543@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Per Forlin <per.forlin@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 14 November 2016 at 12:31, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> We never set "ret" to RESULT_OK.
>
> Fixes: 9f9c4180f88d ("mmc: mmc_test: add test for non-blocking transfers")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks, applied for next!

Kind regards
Uffe

>
> diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
> index f61c812..5ba6d77 100644
> --- a/drivers/mmc/card/mmc_test.c
> +++ b/drivers/mmc/card/mmc_test.c
> @@ -832,7 +832,7 @@ static int mmc_test_nonblock_transfer(struct mmc_test_card *test,
>         struct mmc_async_req *other_areq = &test_areq[1].areq;
>         enum mmc_blk_status status;
>         int i;
> -       int ret;
> +       int ret = RESULT_OK;
>
>         test_areq[0].test = test;
>         test_areq[1].test = test;
