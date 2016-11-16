From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCHv2 02/10] mmc: dw_mmc: fix the debug message for checking
 card's present
Date: Wed, 16 Nov 2016 17:01:58 +0800
Message-ID: <3c5a8732-7009-0ec4-fb5a-c66d1578ef3c@rock-chips.com>
References: <20161115101232.3854-1-jh80.chung@samsung.com>
 <20161115101232.3854-3-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161115101232.3854-3-jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 2016/11/15 18:12, Jaehoon Chung wrote:
> If display the debug message, this message should be spamming.
> If flags is maintained the previous value, didn't display the debug
> message.
>
> Signed-off-by: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Tested-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>

Looks correct to me,

Reviewed-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

> ---
>  drivers/mmc/host/dw_mmc.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index e53899e..6c0c4c5 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1537,13 +1537,10 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
>  			== 0 ? 1 : 0;
>
>  	spin_lock_bh(&host->lock);
> -	if (present) {
> -		set_bit(DW_MMC_CARD_PRESENT, &slot->flags);
> +	if (present && !test_and_set_bit(DW_MMC_CARD_PRESENT, &slot->flags))
>  		dev_dbg(&mmc->class_dev, "card is present\n");
> -	} else {
> -		clear_bit(DW_MMC_CARD_PRESENT, &slot->flags);
> +	else if (!test_and_clear_bit(DW_MMC_CARD_PRESENT, &slot->flags))
>  		dev_dbg(&mmc->class_dev, "card is not present\n");
> -	}
>  	spin_unlock_bh(&host->lock);
>
>  	return present;
>


-- 
Best Regards
Shawn Lin

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
