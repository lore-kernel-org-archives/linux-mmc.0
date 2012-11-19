From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH 4/4 v4] ESDHC: add callback esdhc_of_get_cd to detect
 card
Date: Mon, 19 Nov 2012 02:50:49 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C224FA5@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1351584769-16662-1-git-send-email-r66093@freescale.com>
 <1351584769-16662-2-git-send-email-r66093@freescale.com>
 <1351584769-16662-3-git-send-email-r66093@freescale.com>
 <1351584769-16662-4-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [65.55.88.14] ([65.55.88.14]:9412 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752894Ab2KSCwD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 18 Nov 2012 21:52:03 -0500
In-Reply-To: <1351584769-16662-4-git-send-email-r66093@freescale.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi, Anton,
No any feedback since posted.
Could you give some comment about it?

Best Regards
Jerry Huang


> -----Original Message-----
> From: Huang Changming-R66093
> Sent: Tuesday, October 30, 2012 4:13 PM
> To: linux-mmc@vger.kernel.org
> Cc: Huang Changming-R66093; Anton Vorontsov; Chris Ball
> Subject: [PATCH 4/4 v4] ESDHC: add callback esdhc_of_get_cd to detect
> card
> 
> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> 
> In order to check if the card is present, we will read the PRESENT STATE
> register and check the bit13(Card detect pin level) and bit15(CINS).
> 
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> CC: Anton Vorontsov <cbouatmailru@gmail.com>
> CC: Chris Ball <cjb@laptop.org>
> ---
> changes for v2:
> 	- add new callback for esdhc to detect the card state
> 	- add the CC
> changes for v3:
> 	- enable the controller clock when detect the card state, not core
> changes for v4:
> 	- based on the latest version
> 
>  drivers/mmc/host/sdhci-of-esdhc.c |   23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-
> of-esdhc.c
> index 63d219f..7053218 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -179,6 +179,28 @@ static void esdhc_of_platform_init(struct sdhci_host
> *host)
>  		host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
>  }
> 
> +/* Return: none zero - the card is presetn; 0 - card is absent */
> +static int esdhc_of_get_cd(struct sdhci_host *host)
> +{
> +	int present;
> +
> +	if (host->flags & SDHCI_DEVICE_DEAD)
> +		present = 0;
> +	else {
> +		int sysctl = sdhci_be32bs_readl(host, SDHCI_CLOCK_CONTROL);
> +		/* Enable the controller clock to update the present state */
> +		sdhci_be32bs_writel(host, sysctl | SDHCI_CLOCK_INT_EN,
> +				SDHCI_CLOCK_CONTROL);
> +		/* Detect the card present or absent */
> +		present = sdhci_be32bs_readl(host, SDHCI_PRESENT_STATE);
> +		present &= (SDHCI_CARD_PRESENT | SDHCI_CARD_CDPL);
> +		/* Resve the previous to System control register */
> +		sdhci_be32bs_writel(host, sysctl, SDHCI_CLOCK_CONTROL);
> +	}
> +
> +	return present;
> +}
> +
>  static struct sdhci_ops sdhci_esdhc_ops = {
>  	.read_l = esdhc_readl,
>  	.read_w = esdhc_readw,
> @@ -191,6 +213,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
>  	.get_max_clock = esdhc_of_get_max_clock,
>  	.get_min_clock = esdhc_of_get_min_clock,
>  	.platform_init = esdhc_of_platform_init,
> +	.get_cd = esdhc_of_get_cd,
>  #ifdef CONFIG_PM
>  	.platform_suspend = esdhc_of_suspend,
>  	.platform_resume = esdhc_of_resume,
> --
> 1.7.9.5


