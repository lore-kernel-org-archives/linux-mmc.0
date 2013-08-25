From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/1] mmc: vub300: Staticize vub300_init_card
Date: Sat, 24 Aug 2013 21:40:11 -0400
Message-ID: <87bo4mv98k.fsf@octavius.laptop.org>
References: <1372228350-6375-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38091 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754920Ab3HYBkP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 24 Aug 2013 21:40:15 -0400
In-Reply-To: <1372228350-6375-1-git-send-email-sachin.kamat@linaro.org>
	(Sachin Kamat's message of "Wed, 26 Jun 2013 12:02:30 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-mmc@vger.kernel.org, tony.olech@elandigitalsystems.com

Hi Sachin,

On Wed, Jun 26 2013, Sachin Kamat wrote:
> 'vub300_init_card' is used only in this file. Make it
> static.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/mmc/host/vub300.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
> index cb9f361..e9028ad 100644
> --- a/drivers/mmc/host/vub300.c
> +++ b/drivers/mmc/host/vub300.c
> @@ -2079,7 +2079,7 @@ static void vub300_enable_sdio_irq(struct mmc_host *mmc, int enable)
>  	kref_put(&vub300->kref, vub300_delete);
>  }
>  
> -void vub300_init_card(struct mmc_host *mmc, struct mmc_card *card)
> +static void vub300_init_card(struct mmc_host *mmc, struct mmc_card *card)
>  {				/* NOT irq */
>  	struct vub300_mmc_host *vub300 = mmc_priv(mmc);
>  	dev_info(&vub300->udev->dev, "NO host QUIRKS for this card\n");

Thanks, pushed to mmc-next for 3.12.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
