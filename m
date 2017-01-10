From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 7/8] mmc-core: Use kcalloc() in mmc_test_alloc_mem()
Date: Tue, 10 Jan 2017 16:28:35 +0800
Message-ID: <f115b5c6-9dc2-acb2-1ed8-a0271f8d39cc@rock-chips.com>
References: <8e2accf5-90b3-6bd0-2abd-699927bc459b@users.sourceforge.net>
 <304ae7a7-bc51-83d7-2a6b-844cdf4c346f@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <304ae7a7-bc51-83d7-2a6b-844cdf4c346f@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Harjani Ritesh <riteshh@codeaurora.org>, Jens Axboe <axboe@fb.com>, Linus Walleij <linus.walleij@linaro.org>, Mike Christie <mchristi@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: shawn.lin@rock-chips.com, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 2017/1/9 5:50, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 8 Jan 2017 21:43:12 +0100
>
> * The script "checkpatch.pl" pointed information out like the following.
>
>   WARNING: Prefer kcalloc over kzalloc with multiply
>
>   Thus fix the affected source code place.
>

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> * Replace the specification of a data structure by a pointer dereference
>   to make the corresponding size determination a bit safer according to
>   the Linux coding style convention.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/mmc/core/mmc_test.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
> index 294d3c675734..cb4750de2720 100644
> --- a/drivers/mmc/core/mmc_test.c
> +++ b/drivers/mmc/core/mmc_test.c
> @@ -360,8 +360,7 @@ static struct mmc_test_mem *mmc_test_alloc_mem(unsigned long min_sz,
>  	if (!mem)
>  		return NULL;
>
> -	mem->arr = kzalloc(sizeof(struct mmc_test_pages) * max_segs,
> -			   GFP_KERNEL);
> +	mem->arr = kcalloc(max_segs, sizeof(*mem->arr), GFP_KERNEL);
>  	if (!mem->arr)
>  		goto out_free;
>
>


-- 
Best Regards
Shawn Lin
