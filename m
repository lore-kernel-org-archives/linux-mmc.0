From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mmc: dw_mmc: Add second capability field
Date: Sat, 24 Dec 2011 21:37:20 -0500
Message-ID: <m2ty4pxtpb.fsf@bob.laptop.org>
References: <006801ccc088$40cf1460$c26d3d20$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <006801ccc088$40cf1460$c26d3d20$%jun@samsung.com> (Seungwon
	Jeon's message of "Thu, 22 Dec 2011 18:01:12 +0900")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 'James Hogan' <james@albanarts.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Thu, Dec 22 2011, Seungwon Jeon wrote:
> This patch adds caps2 filed for second capability in dw_mmc.
> It corresponds with MMC_CAPS2_XXX. And this patch removes the
> unnecessary condition statement for assigning caps.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c  |    6 ++----
>  include/linux/mmc/dw_mmc.h |    1 +
>  2 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 3aaeb08..3f5a77a 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1676,10 +1676,8 @@ static int __init dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>  	if (host->pdata->setpower)
>  		host->pdata->setpower(id, 0);
>  
> -	if (host->pdata->caps)
> -		mmc->caps = host->pdata->caps;
> -	else
> -		mmc->caps = 0;
> +	mmc->caps |= host->pdata->caps;
> +	mmc->caps2 |= host->pdata->caps2;

Ah, I replied earlier without having seen this patch.  I still prefer
the version I proposed, which doesn't dereference host->pdata->caps{,2}
without testing it first.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
