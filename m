From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: dw_mmc: Add more capabilities field
Date: Sat, 24 Dec 2011 21:07:31 -0500
Message-ID: <m2obuxz9ng.fsf@bob.laptop.org>
References: <00a901ccb637$35e66590$a1b330b0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <00a901ccb637$35e66590$a1b330b0$%jun@samsung.com> (Seungwon
	Jeon's message of "Fri, 09 Dec 2011 14:55:52 +0900")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Fri, Dec 09 2011, Seungwon Jeon wrote:
> This patch adds another capabilities field for MMC_CAPS2_XXX.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c  |    6 ++++++
>  include/linux/mmc/dw_mmc.h |    1 +
>  2 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 3aaeb08..366df6b 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1681,6 +1681,12 @@ static int __init dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>  	else
>  		mmc->caps = 0;
>  
> +	if (host->pdata->caps2)
> +		mmc->caps2 = host->pdata->caps2;
> +	else
> +		mmc->caps2 = 0;
> +
> +

I think the else clause is unnecessary here (and above), so I'll suggest
merging this patch to mmc-next for 3.3 and also adding:

From: Chris Ball <cjb@laptop.org>
Subject: [PATCH] mmc: dw_mmc: Remove unnecessary else clauses.

Signed-off-by: Chris Ball <cjb@laptop.org>

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 69e5889..9b839fa 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1678,14 +1678,9 @@ static int __init dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 
 	if (host->pdata->caps)
 		mmc->caps = host->pdata->caps;
-	else
-		mmc->caps = 0;
 
 	if (host->pdata->caps2)
 		mmc->caps2 = host->pdata->caps2;
-	else
-		mmc->caps2 = 0;
-
 
 	if (host->pdata->get_bus_wd)
 		if (host->pdata->get_bus_wd(slot->id) >= 4)

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
