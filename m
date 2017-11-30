From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: block: make function mmc_cqe_issue_type static
Date: Thu, 30 Nov 2017 14:09:45 +0100
Message-ID: <CAPDyKFobBdiisrg4NnaNuM5xQiWMUuLEXcNveU8-EAnWp6_XYw@mail.gmail.com>
References: <20171130113738.3851-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171130113738.3851-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, kernel-janitors@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 30 November 2017 at 12:37, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The function mmc_cqe_issue_type is local to the source and does
> not need to be in global scope, so make it static.
>
> Cleans up sparse warning:
> drivers/mmc/core/queue.c:62:21: warning: symbol 'mmc_cqe_issue_type'
> was not declared. Should it be static?
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/core/queue.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index d8394007bc99..5db388081789 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -59,8 +59,8 @@ static inline bool mmc_cqe_can_dcmd(struct mmc_host *host)
>         return host->caps2 & MMC_CAP2_CQE_DCMD;
>  }
>
> -enum mmc_issue_type mmc_cqe_issue_type(struct mmc_host *host,
> -                                      struct request *req)
> +static enum mmc_issue_type mmc_cqe_issue_type(struct mmc_host *host,
> +                                             struct request *req)
>  {
>         switch (req_op(req)) {
>         case REQ_OP_DRV_IN:
> --
> 2.14.1
>
