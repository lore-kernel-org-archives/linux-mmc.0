From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: mmc_test: replace strict_strtol() with kstrtol_from_user()
Date: Sat, 24 Aug 2013 23:19:27 -0400
Message-ID: <87haeesbi8.fsf@octavius.laptop.org>
References: <000c01ce844d$f75ba650$e612f2f0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:41218 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755647Ab3HYDTc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 24 Aug 2013 23:19:32 -0400
In-Reply-To: <000c01ce844d$f75ba650$e612f2f0$@samsung.com> (Jingoo Han's
	message of "Fri, 19 Jul 2013 16:02:43 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-mmc@vger.kernel.org

Hi Jingoo,

On Fri, Jul 19 2013, Jingoo Han wrote:
> The usage of strict_strtol() is not preferred, because
> strict_strtol() is obsolete. Thus, kstrtol() should be
> used.
>
> Also, both kstrtol() and copy_from_user() can be replaced
> with kstrtol_from_user() to make the code simpler.
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/mmc/card/mmc_test.c |   14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
> index a69df52..0c0fc52 100644
> --- a/drivers/mmc/card/mmc_test.c
> +++ b/drivers/mmc/card/mmc_test.c
> @@ -2849,18 +2849,12 @@ static ssize_t mtf_test_write(struct file *file, const char __user *buf,
>  	struct seq_file *sf = (struct seq_file *)file->private_data;
>  	struct mmc_card *card = (struct mmc_card *)sf->private;
>  	struct mmc_test_card *test;
> -	char lbuf[12];
>  	long testcase;
> +	int ret;
>  
> -	if (count >= sizeof(lbuf))
> -		return -EINVAL;
> -
> -	if (copy_from_user(lbuf, buf, count))
> -		return -EFAULT;
> -	lbuf[count] = '\0';
> -
> -	if (strict_strtol(lbuf, 10, &testcase))
> -		return -EINVAL;
> +	ret = kstrtol_from_user(buf, count, 10, &testcase);
> +	if (ret)
> +		return ret;
>  
>  	test = kzalloc(sizeof(struct mmc_test_card), GFP_KERNEL);
>  	if (!test)

Thanks, pushed to mmc-next for 3.12.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
