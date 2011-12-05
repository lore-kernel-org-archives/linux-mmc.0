From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH 3/4] MMC/core: Make sure the power is up, when detect
 the card
Date: Mon, 5 Dec 2011 16:48:03 +0100
Message-ID: <4EDCE7B3.8090406@stericsson.com>
References: <1323077026-12071-1-git-send-email-r66093@freescale.com> <1323077026-12071-2-git-send-email-r66093@freescale.com> <1323077026-12071-3-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:56110 "EHLO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932421Ab1LEPsQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Dec 2011 10:48:16 -0500
In-Reply-To: <1323077026-12071-3-git-send-email-r66093@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "r66093@freescale.com" <r66093@freescale.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jerry Huang <Chang-Ming.Huang@freescale.com>

Hi Jerry,

r66093@freescale.com wrote:
> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> 
> Before running get_cd() recall function to detect whether the card is
> present, must make sure the power is up.
> 
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> ---
>  drivers/mmc/core/core.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 5278ffb..a08e6b1 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2066,8 +2066,10 @@ void mmc_rescan(struct work_struct *work)
>  	 */
>  	mmc_bus_put(host);
>  
> +	mmc_power_up(host);
>  	if (host->ops->get_cd && host->ops->get_cd(host) == 0)
>  		goto out;
> +	mmc_power_off(host);

This does not feel right. get_cd is typically a function which makes use 
of some GPIO pin to find out if there is a card present and thus no 
power_up should be needed.

If your host driver does not support GPIO mechanism of detecting the 
card, the polling mechanism is maybe what you want.

>  
>  	mmc_claim_host(host);
>  	for (i = 0; i < ARRAY_SIZE(freqs); i++) {


Best regards
Ulf Hansson
