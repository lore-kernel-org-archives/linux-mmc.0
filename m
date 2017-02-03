From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 10/10] mmc: core: start to break apart mmc_start_areq()
Date: Fri, 3 Feb 2017 10:51:53 +0100
Message-ID: <CAPDyKFrUF__pfDW0cB4nNc9z2T7PJSoX0VRiaF7344X5i71XJg@mail.gmail.com>
References: <20170201124800.13865-1-linus.walleij@linaro.org> <20170201124800.13865-11-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37091 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752921AbdBCJv5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Feb 2017 04:51:57 -0500
Received: by mail-wm0-f43.google.com with SMTP id v77so19471362wmv.0
        for <linux-mmc@vger.kernel.org>; Fri, 03 Feb 2017 01:51:56 -0800 (PST)
In-Reply-To: <20170201124800.13865-11-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>

On 1 February 2017 at 13:48, Linus Walleij <linus.walleij@linaro.org> wrote:
> This function is doing to many clever things at the same time under
> too many various conditions.
>
> Start to make things clearer by refactoring: break out the
> finalization of the previous asynchronous request to its own
> function mmc_finalize_areq(). We can get rid of the default
> assignment of status and let the call deal with this.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mmc/core/core.c | 65 ++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 43 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index a160c3a7777a..41b4cd01fccc 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -631,6 +631,37 @@ static void mmc_post_req(struct mmc_host *host, struct mmc_request *mrq,
>  }
>
>  /**
> + * mmc_finalize_areq() - finalize an asynchronous request
> + * @host: MMC host to finalize any ongoing request on
> + * @ret_stat: the status of the ongoing asynchronous request:

This looks like a copy paste error as there is no ret_stat variable.

> + *     will return MMC_BLK_SUCCESS if no request was
> + *     going on.
> + */
> +static enum mmc_blk_status mmc_finalize_areq(struct mmc_host *host)
> +{

[...]

No need for you to re-spin, allow me to take care of the minor
nitpicks before I apply this.

Kind regards
Uffe
