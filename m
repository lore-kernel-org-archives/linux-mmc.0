From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCHv3 2/4] mmc: dw_mmc: use the __mmc_of_parse to parse the
 slot node
Date: Fri, 30 May 2014 21:53:08 +0900
Message-ID: <001b01cf7c06$1b692f80$523b8e80$%jun@samsung.com>
References: <1401255351-17653-1-git-send-email-jh80.chung@samsung.com>
 <1401255351-17653-3-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1401255351-17653-3-git-send-email-jh80.chung@samsung.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org
Cc: chris@printf.net, ulf.hansson@linaro.org, ludovic.desroches@atmel.com, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, cpgs@samsung.com
List-Id: linux-mmc@vger.kernel.org

On Wed, May 28, 2014, Jaehoon Chung wrote:
> dw-mmc controller has the multiple slot.
> Then it needs to parse the property for each slot.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks,
Seungwon Jeon

> ---
> Changelog V3:
> 	- Fix typo.
> 	- Maintained the dw_mci_of_quirks().
> Changelog V2:
> 	- None
> 
>  drivers/mmc/host/dw_mmc.c |   15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 1ac227c..3285bdd 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1015,12 +1015,11 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
>  {
>  	int present;
>  	struct dw_mci_slot *slot = mmc_priv(mmc);
> -	struct dw_mci_board *brd = slot->host->pdata;
>  	struct dw_mci *host = slot->host;
>  	int gpio_cd = mmc_gpio_get_cd(mmc);
> 
>  	/* Use platform get_cd function, else try onboard card detect */
> -	if (brd->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION)
> +	if (slot->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION)
>  		present = 1;
>  	else if (!IS_ERR_VALUE(gpio_cd))
>  		present = gpio_cd;
> @@ -2010,6 +2009,9 @@ static struct dw_mci_of_slot_quirks {
>  	{
>  		.quirk	= "disable-wp",
>  		.id	= DW_MCI_SLOT_QUIRK_NO_WRITE_PROTECT,
> +	}, {
> +		.quirk	= "broken-cd",
> +		.id	= DW_MCI_QUIRK_BROKEN_CARD_DETECTION,
>  	},
>  };
> 
> @@ -2088,7 +2090,7 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>  	if (host->pdata->caps2)
>  		mmc->caps2 = host->pdata->caps2;
> 
> -	mmc_of_parse(mmc);
> +	__mmc_of_parse(mmc, dw_mci_of_find_slot_node(host->dev, slot->id));
> 
>  	if (host->pdata->blk_settings) {
>  		mmc->max_segs = host->pdata->blk_settings->max_segs;
> @@ -2234,12 +2236,7 @@ static inline bool dw_mci_ctrl_all_reset(struct dw_mci *host)
>  static struct dw_mci_of_quirks {
>  	char *quirk;
>  	int id;
> -} of_quirks[] = {
> -	{
> -		.quirk	= "broken-cd",
> -		.id	= DW_MCI_QUIRK_BROKEN_CARD_DETECTION,
> -	},
> -};
> +} of_quirks[] = {};
> 
>  static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>  {
> --
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
