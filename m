From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: dw-mmc: fix the error for a few argument
Date: Tue, 04 Dec 2012 02:26:39 -0500
Message-ID: <87boeagtw0.fsf@octavius.laptop.org>
References: <50BD781B.4050609@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:51065 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750765Ab2LDH0q (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 4 Dec 2012 02:26:46 -0500
In-Reply-To: <50BD781B.4050609@samsung.com> (Jaehoon Chung's message of "Tue,
	04 Dec 2012 13:12:11 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>, James Hogan <James.Hogan@imgtec.com>

Hi,

On Mon, Dec 03 2012, Jaehoon Chung wrote:
> The argument of dw_mci_setup_bus is modified.
> (Abhilash's patch: mmc: dw-mc: Add sdio power binding)
> This patch used the dw_mci_setup_bus(slot, false) instead of
> dw_mci_setup_bus(slot)
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 069ca70..323c502 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -807,7 +807,7 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  		drv_data->set_ios(slot->host, ios);
>  
>  	/* Slot specific timing and width adjustment */
> -	dw_mci_setup_bus(slot);
> +	dw_mci_setup_bus(slot, false);
>  
>  	switch (ios->power_mode) {
>  	case MMC_POWER_UP:

Thanks for noticing -- I've rolled this change into your patch in
mmc-next now.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
