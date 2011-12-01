From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: mmc_test: align max_seg_size
Date: Thu, 01 Dec 2011 12:43:50 -0500
Message-ID: <87hb1kmbl5.fsf@laptop.org>
References: <1321268664-22006-1-git-send-email-per.forlin@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:58512 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751142Ab1LARnp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 1 Dec 2011 12:43:45 -0500
In-Reply-To: <1321268664-22006-1-git-send-email-per.forlin@stericsson.com>
	(Per Forlin's message of "Mon, 14 Nov 2011 12:04:24 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@stericsson.com>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@stericsson.com, Linus Walleij <linus.walleij@linaro.org>, Sujit Reddy Thumma <sthumma@codeaurora.org>

Hi,

On Mon, Nov 14 2011, Per Forlin wrote:
> If max_seg_size is unaligned, mmc_test_map_sg() may create sg element
> sizes that are not aligned with 512 byte. Fix, align max_seg_size at
> mmc_test_area_init().
>
> Signed-off-by: Per Forlin <per.forlin@stericsson.com>
> ---
>  drivers/mmc/card/mmc_test.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
> index b038c4a..5848998 100644
> --- a/drivers/mmc/card/mmc_test.c
> +++ b/drivers/mmc/card/mmc_test.c
> @@ -1581,6 +1581,7 @@ static int mmc_test_area_init(struct mmc_test_card *test, int erase, int fill)
>  
>  	t->max_segs = test->card->host->max_segs;
>  	t->max_seg_sz = test->card->host->max_seg_size;
> +	t->max_seg_sz -= t->max_seg_sz % 512;
>  
>  	t->max_tfr = t->max_sz;
>  	if (t->max_tfr >> 9 > test->card->host->max_blk_count)

Thanks, pushed to mmc-next for 3.2.  (Sujit, please let us know if you
still have worries about aligning to host->max_blk_size.)

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
