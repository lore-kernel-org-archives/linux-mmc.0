From: Hein_Tibosch <hein_tibosch@yahoo.es>
Subject: Re: [PATCH 1/5 v2] MMC/core: Make sure the power is up, when detect
 the card
Date: Tue, 06 Dec 2011 20:12:52 +0800
Message-ID: <4EDE06C4.2060303@yahoo.es>
References: <1323163107-32619-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bosmailout06.eigbox.net ([66.96.189.6]:54037 "EHLO
	bosmailout06.eigbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753038Ab1LFM4f (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Dec 2011 07:56:35 -0500
Received: from bosmailscan14.eigbox.net ([10.20.15.14])
	by bosmailout06.eigbox.net with esmtp (Exim)
	id 1RXtua-0003yg-1T
	for linux-mmc@vger.kernel.org; Tue, 06 Dec 2011 07:14:16 -0500
In-Reply-To: <1323163107-32619-1-git-send-email-r66093@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: r66093@freescale.com
Cc: linux-mmc@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>, Chris Ball <cjb@laptop.org>

Hi Jerry,

On 12/6/2011 5:18 PM, r66093@freescale.com wrote:
> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
>
> Before running get_cd() recall function to detect whether the card is
> present, must make sure the power is up.
>
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> CC: Chris Ball <cjb@laptop.org>
> ---
> changes for v2:
> 	- add the CC
>
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

If get_cd is not defined, a power-up for sure isn't necessary:

>  	if (host->ops->get_cd && host->ops->get_cd(host) == 0)
>  		goto out;

Did you intent to leave it powered-up in case get_cd() fails?

> +	mmc_power_off(host);
>  
>  	mmc_claim_host(host);
>  	for (i = 0; i < ARRAY_SIZE(freqs); i++) {
