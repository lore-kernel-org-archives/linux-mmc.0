From: Sujit Reddy Thumma <sthumma@codeaurora.org>
Subject: Re: [PATCH] mmc: mmc_test: align max_seg_size
Date: Thu, 17 Nov 2011 09:26:24 +0530
Message-ID: <4EC485E8.4040706@codeaurora.org>
References: <1321268664-22006-1-git-send-email-per.forlin@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:24357 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754687Ab1KQD43 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Nov 2011 22:56:29 -0500
In-Reply-To: <1321268664-22006-1-git-send-email-per.forlin@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@stericsson.com>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@stericsson.com, Linus Walleij <linus.walleij@linaro.org>, Chris Ball <cjb@laptop.org>

On 11/14/2011 4:34 PM, Per Forlin wrote:
> If max_seg_size is unaligned, mmc_test_map_sg() may create sg element
> sizes that are not aligned with 512 byte. Fix, align max_seg_size at
> mmc_test_area_init().
>
> Signed-off-by: Per Forlin<per.forlin@stericsson.com>
> ---
>   drivers/mmc/card/mmc_test.c |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
> index b038c4a..5848998 100644
> --- a/drivers/mmc/card/mmc_test.c
> +++ b/drivers/mmc/card/mmc_test.c
> @@ -1581,6 +1581,7 @@ static int mmc_test_area_init(struct mmc_test_card *test, int erase, int fill)
>
>   	t->max_segs = test->card->host->max_segs;
>   	t->max_seg_sz = test->card->host->max_seg_size;
> +	t->max_seg_sz -= t->max_seg_sz % 512;

Shouldn't we align this to host->max_blk_size supported by controller? I 
guess there are some extended capacity cards which claim to support 
4096bytes as block size. I am not sure if any card/controller supports 
this mode yet.

>
>   	t->max_tfr = t->max_sz;
>   	if (t->max_tfr>>  9>  test->card->host->max_blk_count)


-- 
Thanks,
Sujit
