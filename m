From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] mmc: jz4740: simplify use of SIMPLE_DEV_PM_OPS
Date: Mon, 19 Aug 2013 18:45:26 +0200
Message-ID: <52124BA6.8000905@metafoo.de>
References: <1376929000-12573-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:59512 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750931Ab3HSQpD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Aug 2013 12:45:03 -0400
In-Reply-To: <1376929000-12573-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On 08/19/2013 06:16 PM, James Hogan wrote:
> Commit 5d5c035 (mmc: jz4740: Use SIMPLE_DEV_PM_OPS) converted jz4740_mmc
> to use SIMPLE_DEV_PM_OPS, but it did so within the #ifdef
> CONFIG_PM_SLEEP. SIMPLE_DEV_PM_OPS already handles when CONFIG_PM_SLEEP
> is disabled, so move it out of the ifdef and remove the
> JZ4740_MMC_PM_OPS indirection.
>
> Compile tested with CONFIG_PM_SLEEP enabled and disabled.
>
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: linux-mmc@vger.kernel.org

Nack, the generated code is not the same.

> ---
>   drivers/mmc/host/jz4740_mmc.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
> index 0308c9f..28af392 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -898,13 +898,10 @@ static int jz4740_mmc_resume(struct device *dev)
>
>   	return 0;
>   }
> +#endif
>
>   static SIMPLE_DEV_PM_OPS(jz4740_mmc_pm_ops, jz4740_mmc_suspend,
>   	jz4740_mmc_resume);
> -#define JZ4740_MMC_PM_OPS (&jz4740_mmc_pm_ops)
> -#else
> -#define JZ4740_MMC_PM_OPS NULL
> -#endif
>
>   static struct platform_driver jz4740_mmc_driver = {
>   	.probe = jz4740_mmc_probe,
> @@ -912,7 +909,7 @@ static struct platform_driver jz4740_mmc_driver = {
>   	.driver = {
>   		.name = "jz4740-mmc",
>   		.owner = THIS_MODULE,
> -		.pm = JZ4740_MMC_PM_OPS,
> +		.pm = &jz4740_mmc_pm_ops,
>   	},
>   };
>
>

