From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] SDHCI: Modify checks to determine the presense of card.
Date: Fri, 27 Aug 2010 20:35:34 +0100
Message-ID: <20100827193534.GD23079@void.printf.net>
References: <1267772377-14723-1-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1267772377-14723-1-git-send-email-thomas.ab@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>
Cc: linux-mmc@vger.kernel.org, ben-linux@fluff.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

This wasn't picked up -- any comments from the list?

On Fri, Mar 05, 2010 at 12:29:37PM +0530, Thomas Abraham wrote:
> In the sdhci_request function, the card is determined to be present based
> on the SDCD pin status. SDHCI host controllers that do not use SDCD pin
> but rely on other mechanism such as external pin interrupts, update the
> host flags with SDHCI_DEVICE_DEAD flag based on the card insertion status.
> This patch modifies the sdhci_request function such that the it uses
> both the SDCD status and SDHCI_DEVICE_DEAD host flag to determine if the
> card is inserted or not.
> 
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  drivers/mmc/host/sdhci.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c279fbc..f1a6ebe 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1106,7 +1106,7 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  		present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
>  				SDHCI_CARD_PRESENT;
>  
> -	if (!present || host->flags & SDHCI_DEVICE_DEAD) {
> +	if (!present && host->flags & SDHCI_DEVICE_DEAD) {
>  		host->mrq->cmd->error = -ENOMEDIUM;
>  		tasklet_schedule(&host->finish_tasklet);
>  	} else
> -- 
> 1.6.6.rc2

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
