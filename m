From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 6/8] mmc/core/mmc_test: Improve a size determination in
 five functions
Date: Tue, 10 Jan 2017 16:31:14 +0800
Message-ID: <0757efb9-8a77-8460-153f-1a9c67f26bba@rock-chips.com>
References: <8e2accf5-90b3-6bd0-2abd-699927bc459b@users.sourceforge.net>
 <b8461289-1930-08ed-55ef-e2d7dd09a312@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:40280 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751026AbdAJIcB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Jan 2017 03:32:01 -0500
In-Reply-To: <b8461289-1930-08ed-55ef-e2d7dd09a312@users.sourceforge.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Harjani Ritesh <riteshh@codeaurora.org>, Jens Axboe <axboe@fb.com>, Linus Walleij <linus.walleij@linaro.org>, Mike Christie <mchristi@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: shawn.lin@rock-chips.com, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

On 2017/1/9 5:49, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 8 Jan 2017 21:25:44 +0100
>
> Replace the specification of a data structure by a pointer dereference
> as the parameter for the operator "sizeof" to make the corresponding size
> determination a bit safer according to the Linux coding style convention.
>


Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/mmc/core/mmc_test.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
> index bb9f569a5dd5..294d3c675734 100644
> --- a/drivers/mmc/core/mmc_test.c
> +++ b/drivers/mmc/core/mmc_test.c
> @@ -356,7 +356,7 @@ static struct mmc_test_mem *mmc_test_alloc_mem(unsigned long min_sz,
>  	if (max_segs > max_page_cnt)
>  		max_segs = max_page_cnt;
>
> -	mem = kzalloc(sizeof(struct mmc_test_mem), GFP_KERNEL);
> +	mem = kzalloc(sizeof(*mem), GFP_KERNEL);
>  	if (!mem)
>  		return NULL;
>
> @@ -545,7 +545,7 @@ static void mmc_test_save_transfer_result(struct mmc_test_card *test,
>  	if (!test->gr)
>  		return;
>
> -	tr = kmalloc(sizeof(struct mmc_test_transfer_result), GFP_KERNEL);
> +	tr = kmalloc(sizeof(*tr), GFP_KERNEL);
>  	if (!tr)
>  		return;
>
> @@ -2973,8 +2973,7 @@ static void mmc_test_run(struct mmc_test_card *test, int testcase)
>  			}
>  		}
>
> -		gr = kzalloc(sizeof(struct mmc_test_general_result),
> -			GFP_KERNEL);
> +		gr = kzalloc(sizeof(*gr), GFP_KERNEL);
>  		if (gr) {
>  			INIT_LIST_HEAD(&gr->tr_lst);
>
> @@ -3108,7 +3107,7 @@ static ssize_t mtf_test_write(struct file *file, const char __user *buf,
>  	if (ret)
>  		return ret;
>
> -	test = kzalloc(sizeof(struct mmc_test_card), GFP_KERNEL);
> +	test = kzalloc(sizeof(*test), GFP_KERNEL);
>  	if (!test)
>  		return -ENOMEM;
>
> @@ -3213,7 +3212,7 @@ static int __mmc_test_register_dbgfs_file(struct mmc_card *card,
>  		return -ENODEV;
>  	}
>
> -	df = kmalloc(sizeof(struct mmc_test_dbgfs_file), GFP_KERNEL);
> +	df = kmalloc(sizeof(*df), GFP_KERNEL);
>  	if (!df) {
>  		debugfs_remove(file);
>  		dev_err(&card->dev,
>


-- 
Best Regards
Shawn Lin

