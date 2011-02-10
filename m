From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2] dw_mmc: Enable low-power mode for the card clock.
Date: Thu, 10 Feb 2011 19:44:31 +0000
Message-ID: <20110210194431.GB19076@void.printf.net>
References: <AANLkTikkCeo2YSyw_w7Qny0k9iugrM59pFWDTSwQx=i2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:60622 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752507Ab1BJToc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 10 Feb 2011 14:44:32 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTikkCeo2YSyw_w7Qny0k9iugrM59pFWDTSwQx=i2@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: linux-mmc@vger.kernel.org

Hi,

On Thu, Feb 10, 2011 at 10:40:57AM +0000, Will Newton wrote:
> Setting this bit in the clock enable register will stop the clock
> when the card is in the IDLE state.
> 
> Signed-off-by: Will Newton <will.newton@imgtec.com>
> ---
>  drivers/mmc/host/dw_mmc.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 0b0bedd..4cf560d 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -562,7 +562,8 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot)
>  			     SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT, 0);
> 
>  		/* enable clock */
> -		mci_writel(host, CLKENA, SDMMC_CLKEN_ENABLE);
> +		mci_writel(host, CLKENA, SDMMC_CLKEN_ENABLE |
> +			   SDMMC_CLKEN_LOW_PWR);
> 
>  		/* inform CIU */
>  		mci_send_cmd(slot,

Pushed to mmc-next for .39, thanks.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
