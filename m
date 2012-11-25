From: Philip Rakity <prakity@nvidia.com>
Subject: Re: [PATCH 1/2] sdhci: add quirk for lack of 1.8v support
Date: Sun, 25 Nov 2012 21:26:02 +0100
Message-ID: <66CF5EBE-E77D-4172-833E-8B392FBE6443@nvidia.com>
References: <20121125180121.31FB3FACF5@dev.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:9666 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753370Ab2KYU0J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 25 Nov 2012 15:26:09 -0500
In-Reply-To: <20121125180121.31FB3FACF5@dev.laptop.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "jrudholm@gmail.com" <jrudholm@gmail.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>


On Nov 25, 2012, at 6:01 PM, Daniel Drake <dsd@laptop.org> wrote:

> The OLPC XO-1.75 laptop includes a SDHCI controller which is 1.8v
> capable, and it truthfully reports so in its capabilities. This
> alternate voltage is used for driving new "UHS-I" SD cards at their
> full speed.
> 
> However, what the controller doesn't know is that the motherboard
> physically doesn't have a 1.8v supply available.
> 
> Add a quirk so that systems such as this one can override disable
> 1.8v support, adding support for UHS-I cards (by running them at
> 3.3v).
> 
> This avoids a problem where the system would first try to run the
> card at 1.8v, fail, and then not be able to fully reset the card
> to retry at the normal 3.3v voltage.
> 
> This is more appropriate than using the MISSING_CAPS quirk, which
> is intended for cases where the SDHCI controller is actually lying
> about its capabilities, and would force us to somehow override both
> caps words from another source.
> 
> Signed-off-by: Daniel Drake <dsd@laptop.org>
> ---
> drivers/mmc/host/sdhci.c  | 4 ++++
> include/linux/mmc/sdhci.h | 2 ++
> 2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c7851c0..7273523 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2865,6 +2865,10 @@ int sdhci_add_host(struct sdhci_host *host)
> 		caps[1] &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
> 		       SDHCI_SUPPORT_DDR50);
> 
> +	if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V)
> +		caps[1] &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
> +		       SDHCI_SUPPORT_DDR50);
> +
> 	/* Any UHS-I mode in caps implies SDR12 and SDR25 support. */
> 	if (caps[1] & (SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
> 		       SDHCI_SUPPORT_DDR50))
> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> index 1edcb4d..1a42747 100644
> --- a/include/linux/mmc/sdhci.h
> +++ b/include/linux/mmc/sdhci.h
> @@ -92,6 +92,8 @@ struct sdhci_host {
> 
> #define SDHCI_QUIRK2_HOST_OFF_CARD_ON			(1<<0)
> #define SDHCI_QUIRK2_HOST_NO_CMD23			(1<<1)
> +/* The system physically doesn't support 1.8v, even if the host does */
> +#define SDHCI_QUIRK2_NO_1_8_V				(1<<2)
> 
> 	int irq;		/* Device IRQ */
> 	void __iomem *ioaddr;	/* Mapped address */
> -- 
> 1.7.11.7
> 

Reviewed-by:  Philip Rakity <prakity@nvidia.com>

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
