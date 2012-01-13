From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH 3/5 v4] ESDHC: Power management for ESDHC
Date: Fri, 13 Jan 2012 02:36:50 +0000
Message-ID: <8A2FC72B45BB5A4C9F801431E06AE48F11669367@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1325827997-27490-1-git-send-email-r66093@freescale.com>
 <1325827997-27490-2-git-send-email-r66093@freescale.com>
 <1325827997-27490-3-git-send-email-r66093@freescale.com>
 <1325827997-27490-4-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:45346
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752817Ab2AMCgz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 12 Jan 2012 21:36:55 -0500
In-Reply-To: <1325827997-27490-4-git-send-email-r66093@freescale.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi, Anton,
Could you have any comment about this serial patch?

Thanks
Jerry Huang

> -----Original Message-----
> From: Huang Changming-R66093
> Sent: Friday, January 06, 2012 1:33 PM
> To: linux-mmc@vger.kernel.org
> Cc: Huang Changming-R66093; Jiang Yutang-B14898; Chris Ball
> Subject: [PATCH 3/5 v4] ESDHC: Power management for ESDHC
> 
> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> 
> For FSL ESDHC controllor, when enter the sleep, the controller will power
> off,
> therefore the register will lost its valuse, and driver should save value
> of
> register during suspend and used during resume.
> 
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> Signed-off-by: Jiang Yutang <b14898@freescale.com>
> CC: Chris Ball <cjb@laptop.org>
> ---
> changes for v2:
> 	- change the property to compatible for quirks
> changes for v3:
> 	- fix one compile error
> changes for v4:
> 	- use hooks to suspend/resume the special platform
> 
>  drivers/mmc/host/sdhci-of-esdhc.c |   19 +++++++++++++++++++
>  1 files changed, 19 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-
> of-esdhc.c
> index c21be67..385a4ff 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -104,6 +104,21 @@ static int esdhc_of_get_cd(struct sdhci_host *host)
>  	return present;
>  }
> 
> +#ifdef CONFIG_PM
> +static u32 esdhc_proctl;
> +static void esdhc_of_suspend(struct sdhci_host *host)
> +{
> +	esdhc_proctl = sdhci_be32bs_readl(host, SDHCI_HOST_CONTROL);
> +}
> +
> +static void esdhc_of_resume(struct sdhci_host *host)
> +{
> +	esdhc_of_enable_dma(host);
> +	sdhci_be32bs_writel(host, esdhc_proctl, SDHCI_HOST_CONTROL);
> +
> +}
> +#endif
> +
>  static struct sdhci_ops sdhci_esdhc_ops = {
>  	.read_l = sdhci_be32bs_readl,
>  	.read_w = esdhc_readw,
> @@ -116,6 +131,10 @@ static struct sdhci_ops sdhci_esdhc_ops = {
>  	.get_max_clock = esdhc_of_get_max_clock,
>  	.get_min_clock = esdhc_of_get_min_clock,
>  	.get_cd = esdhc_of_get_cd,
> +#ifdef CONFIG_PM
> +	.platform_suspend = esdhc_of_suspend,
> +	.platform_resume = esdhc_of_resume,
> +#endif
>  };
> 
>  static struct sdhci_pltfm_data sdhci_esdhc_pdata = {
> --
> 1.7.5.4


