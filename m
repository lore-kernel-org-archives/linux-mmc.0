From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v4 1/4] mmc: dw_mmc: Don't try to enable the CD until we're
 sure we're not deferring
Date: Fri, 13 Mar 2015 20:32:43 +0900
Message-ID: <5502CADB.4040204@samsung.com>
References: <1426112117-18220-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1426112117-18220-1-git-send-email-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>, Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>
Cc: Mark Brown <broonie@kernel.org>, Alexandru Stan <amstan@chromium.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Addy Ke <addy.ke@rock-chips.com>, javier.martinez@collabora.co.uk, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, chris@printf.net, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Doug,

Will apply. Thanks!

Best Regards,
Jaehoon Chung

On 03/12/2015 07:15 AM, Doug Anderson wrote:
> If dw_mci_init_slot() returns that we got a probe deferral then it may
> leave slot->mmc as NULL.  That will cause dw_mci_enable_cd() to crash
> when it calls mmc_gpio_get_cd().
> 
> Fix this by moving the call of dw_mci_enable_cd() until we're sure
> that we're good.  Note that if we have more than one slot and one
> defers (but the others don't) things won't work so well.  ...but
> that's not a new thing and everyone has already agreed that multislot
> support ought to be removed from dw_mmc eventually anyway since it is
> unused, untested, and you can see several bugs like this by inspecting
> the code.
> 
> Fixes: bcafaf5470f0 ("mmc: dw_mmc: Only enable CD after setup and only if needed")
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
> Changes in v4:
> - Defer vs. card detect fix patch new for v4.
> 
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/mmc/host/dw_mmc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 47dfd0e..e2811cf 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2863,9 +2863,6 @@ int dw_mci_probe(struct dw_mci *host)
>  			init_slots++;
>  	}
>  
> -	/* Now that slots are all setup, we can enable card detect */
> -	dw_mci_enable_cd(host);
> -
>  	if (init_slots) {
>  		dev_info(host->dev, "%d slots initialized\n", init_slots);
>  	} else {
> @@ -2874,6 +2871,9 @@ int dw_mci_probe(struct dw_mci *host)
>  		goto err_dmaunmap;
>  	}
>  
> +	/* Now that slots are all setup, we can enable card detect */
> +	dw_mci_enable_cd(host);
> +
>  	if (host->quirks & DW_MCI_QUIRK_IDMAC_DTO)
>  		dev_info(host->dev, "Internal DMAC interrupt fix enabled.\n");
>  
> 
