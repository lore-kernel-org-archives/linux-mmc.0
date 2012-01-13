From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH 2/4 v4] MMC/SD: Add callback function to detect card
Date: Fri, 13 Jan 2012 02:25:11 +0000
Message-ID: <8A2FC72B45BB5A4C9F801431E06AE48F116692C7@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1324972835-12264-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe002.messaging.microsoft.com ([213.199.154.205]:41079
	"EHLO AM1EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757087Ab2AMCZQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 12 Jan 2012 21:25:16 -0500
In-Reply-To: <1324972835-12264-1-git-send-email-r66093@freescale.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Changming-R66093 <r66093@freescale.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>

Hi, Chris,
Could you have any comment about this patch?
Can it go into 3.3 or 3.4?

Thanks
Jerry Huang
> -----Original Message-----
> From: Huang Changming-R66093
> Sent: Tuesday, December 27, 2011 4:01 PM
> To: linux-mmc@vger.kernel.org
> Cc: Huang Changming-R66093; Chris Ball
> Subject: [PATCH 2/4 v4] MMC/SD: Add callback function to detect card
> 
> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> 
> In order to check whether the card has been removed, the function
> mmc_send_status() will send command CMD13 to card and ask the card
> to send its status register to sdhc driver, which will generate
> many interrupts repeatedly and make the system performance bad.
> 
> Therefore, add callback function get_cd() to check whether
> the card has been removed when the driver has this callback function.
> 
> If the card is present, 1 will return, if the card is absent, 0 will
> return.
> If the controller will not support this feature, -ENOSYS will return.
> 
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> CC: Chris Ball <cjb@laptop.org>
> ---
> changes for v2:
>         - when controller don't support get_cd, return -ENOSYS
>         - add the CC
> changes for v3:
>         - enalbe the controller clock in platform, instead of core
> changes for v4:
> 	- move the detect code to core.c according to the new structure
> 
>  drivers/mmc/core/core.c |   10 ++++++++--
>  1 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 6db6621..d570c72 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2060,7 +2060,7 @@ static int mmc_rescan_try_freq(struct mmc_host
> *host, unsigned freq)
> 
>  int _mmc_detect_card_removed(struct mmc_host *host)
>  {
> -	int ret;
> +	int ret = -ENOSYS;
> 
>  	if ((host->caps & MMC_CAP_NONREMOVABLE) || !host->bus_ops->alive)
>  		return 0;
> @@ -2068,7 +2068,13 @@ int _mmc_detect_card_removed(struct mmc_host *host)
>  	if (!host->card || mmc_card_removed(host->card))
>  		return 1;
> 
> -	ret = host->bus_ops->alive(host);
> +	if (host->ops->get_cd) {
> +		ret = host->ops->get_cd(host);
> +		if (ret >= 0)
> +			ret = !ret;
> +	}
> +	if (ret < 0)
> +		ret = host->bus_ops->alive(host);
>  	if (ret) {
>  		mmc_card_set_removed(host->card);
>  		pr_debug("%s: card remove detected\n", mmc_hostname(host));
> --
> 1.7.5.4


