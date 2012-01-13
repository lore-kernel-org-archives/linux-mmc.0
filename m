From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH 3/4 v5] SDHCI: add sdhci_get_cd callback to detect the
 card
Date: Fri, 13 Jan 2012 02:25:18 +0000
Message-ID: <8A2FC72B45BB5A4C9F801431E06AE48F116692DB@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1323829093-29655-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe005.messaging.microsoft.com ([213.199.154.208]:11559
	"EHLO AM1EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755806Ab2AMCZ3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 12 Jan 2012 21:25:29 -0500
In-Reply-To: <1323829093-29655-1-git-send-email-r66093@freescale.com>
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
> Sent: Wednesday, December 14, 2011 10:18 AM
> To: linux-mmc@vger.kernel.org
> Cc: Huang Changming-R66093; Chris Ball
> Subject: [PATCH 3/4 v5] SDHCI: add sdhci_get_cd callback to detect the
> card
> 
> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> 
> Add callback function sdhci_get_cd to detect the card.
> And one new callback added to implement the card detect in sdhci
> struncture.
> If special platform has the card detect callback, it will return the card
> state, the value zero is for absent cardi and one is for present card.
> If the controller don't support card detect, sdhci_get_cd will return -
> ENOSYS.
> 
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> CC: Chris Ball <cjb@laptop.org>
> ---
> changes for v2:
> 	- when controller don't support get_cd, return -ENOSYS
> 	- add new callback for sdhci to detect the card
> 	- add the CC
> changes for v3:
> 	- use pin_lock only when get_cd defined
> changes for v4:
> 	- enalbe the controller clock in platform, instead of core
> changes for v5:
> 	- remove the copyright
> 
>  drivers/mmc/host/sdhci.c |   21 ++++++++++++++++++++++
>  drivers/mmc/host/sdhci.h |    2 ++
>  2 files changed, 23 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 6d8eea3..fbe2f46 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1518,6 +1519,26 @@ static int sdhci_get_ro(struct mmc_host *mmc)
>  	return ret;
>  }
> 
> +/* Return values for the sdjco_get_cd callback:
> + *   0 for a absent card
> + *   1 for a present card
> + *   -ENOSYS when not supported (equal to NULL callback)
> + */
> +static int sdhci_get_cd(struct mmc_host *mmc)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	unsigned long flags;
> +	int present = -ENOSYS;
> +
> +	if (host->ops->get_cd) {
> +		spin_lock_irqsave(&host->lock, flags);
> +		present = host->ops->get_cd(host);
> +		spin_unlock_irqrestore(&host->lock, flags);
> +	}
> +
> +	return present;
> +}
> +
>  static void sdhci_enable_sdio_irq_nolock(struct sdhci_host *host, int
> enable)
>  {
>  	if (host->flags & SDHCI_DEVICE_DEAD)
> @@ -1884,6 +1905,7 @@ static const struct mmc_host_ops sdhci_ops = {
>  	.request	= sdhci_request,
>  	.set_ios	= sdhci_set_ios,
>  	.get_ro		= sdhci_get_ro,
> +	.get_cd		= sdhci_get_cd,
>  	.hw_reset	= sdhci_hw_reset,
>  	.enable_sdio_irq = sdhci_enable_sdio_irq,
>  	.start_signal_voltage_switch	= sdhci_start_signal_voltage_switch,
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 0a5b654..82f4d27 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -69,6 +69,7 @@
>  #define  SDHCI_SPACE_AVAILABLE	0x00000400
>  #define  SDHCI_DATA_AVAILABLE	0x00000800
>  #define  SDHCI_CARD_PRESENT	0x00010000
> +#define  SDHCI_CARD_CDPL	0x00040000
>  #define  SDHCI_WRITE_PROTECT	0x00080000
>  #define  SDHCI_DATA_LVL_MASK	0x00F00000
>  #define   SDHCI_DATA_LVL_SHIFT	20
> @@ -261,6 +262,7 @@ struct sdhci_ops {
> 
>  	void	(*set_clock)(struct sdhci_host *host, unsigned int clock);
> 
> +	int		(*get_cd)(struct sdhci_host *host);
>  	int		(*enable_dma)(struct sdhci_host *host);
>  	unsigned int	(*get_max_clock)(struct sdhci_host *host);
>  	unsigned int	(*get_min_clock)(struct sdhci_host *host);
> --
> 1.7.5.4


