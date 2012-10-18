From: Philip Rakity <prakity@nvidia.com>
Subject: Re: [PATCH 2/3] drivers: mmc: core: sdio.c: fixed coding style
 error on for() statement
Date: Thu, 18 Oct 2012 18:10:25 +0200
Message-ID: <8B292373-3C73-41EF-A193-0ECF614BE06E@nvidia.com>
References: <n> <1350576394-2008-1-git-send-email-antiroot@gmail.com>
 <1350576394-2008-2-git-send-email-antiroot@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1350576394-2008-2-git-send-email-antiroot@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sangho Yi <antiroot@gmail.com>
Cc: "prakity@marvell.com" <prakity@marvell.com>, "aaron.lu@amd.com" <aaron.lu@amd.com>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "ulf.hansson@stericsson.com" <ulf.hansson@stericsson.com>, "cjb@laptop.org" <cjb@laptop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org


On 18 Oct 2012, at 17:06, Sangho Yi <antiroot@gmail.com> wrote:

> add a whitespace after ";" on for statement, to follow a coding style guideline.
> 
> Signed-off-by: Sangho Yi <antiroot@gmail.com>
> ---
> drivers/mmc/core/sdio.c |    4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 14326e8..df09b63 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -819,7 +819,7 @@ static void mmc_sdio_remove(struct mmc_host *host)
> 	BUG_ON(!host);
> 	BUG_ON(!host->card);
> 
> -	for (i = 0;i < host->card->sdio_funcs;i++) {
> +	for (i = 0; i < host->card->sdio_funcs; i++) {
> 		if (host->card->sdio_func[i]) {
> 			sdio_remove_func(host->card->sdio_func[i]);
> 			host->card->sdio_func[i] = NULL;
> @@ -1151,7 +1151,7 @@ int mmc_attach_sdio(struct mmc_host *host)
> 	/*
> 	 * ...then the SDIO functions.
> 	 */
> -	for (i = 0;i < funcs;i++) {
> +	for (i = 0; i < funcs; i++) {
> 		err = sdio_add_func(host->card->sdio_func[i]);
> 		if (err)
> 			goto remove_added;
> -- 
> 1.7.9.5
> 
> --

Reviewed-by: Philip Rakity <prakity@nvidia.com>

> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
