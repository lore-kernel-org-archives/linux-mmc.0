From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdricoh_cs: remove redundant check if len is non-zero
Date: Mon, 15 May 2017 12:51:32 +0200
Message-ID: <CAPDyKFqFRqqeNa0kXUmXwF2s8=GoLiuF7iQzovSsEXVKy4Uw8g@mail.gmail.com>
References: <20170509154504.31901-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:35820 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754692AbdEOKvd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 May 2017 06:51:33 -0400
Received: by mail-qt0-f170.google.com with SMTP id v27so69284528qtg.2
        for <linux-mmc@vger.kernel.org>; Mon, 15 May 2017 03:51:33 -0700 (PDT)
In-Reply-To: <20170509154504.31901-1-colin.king@canonical.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Sascha Sommer <saschasommer@freenet.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, kernel-janitors@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 9 May 2017 at 17:45, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> At the end of either of the read or write loops len is always zero
> and hence the non-zero check on len and return of -EIO is redundant
> and can be removed.
>
> Detected by CoverityScan, CID#114293 ("Logically dead code")
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks, applied for next!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdricoh_cs.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdricoh_cs.c b/drivers/mmc/host/sdricoh_cs.c
> index 5ff26ab81eb1..70cb00aa79a0 100644
> --- a/drivers/mmc/host/sdricoh_cs.c
> +++ b/drivers/mmc/host/sdricoh_cs.c
> @@ -256,9 +256,6 @@ static int sdricoh_blockio(struct sdricoh_host *host, int read,
>                 }
>         }
>
> -       if (len)
> -               return -EIO;
> -
>         return 0;
>  }
>
> --
> 2.11.0
>
