From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] sdhci: allow controller private registers to be
 changaed on reset
Date: Fri, 24 Sep 2010 18:26:52 +0100
Message-ID: <20100924182652.59f38462@lxorguk.ukuu.org.uk>
References: <3622567C-B5F4-40D4-A525-0AAE641E2B28@marvell.com>
	<73FAA3FF-6415-4A67-94FE-F93C3DA4A05C@marvell.com>
	<772C1381-0CF0-41CD-B580-CBD090BBA1AB@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:53180 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757143Ab0IXRDk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Sep 2010 13:03:40 -0400
In-Reply-To: <772C1381-0CF0-41CD-B580-CBD090BBA1AB@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>

On Fri, 24 Sep 2010 09:42:15 -0700
Philip Rakity <prakity@marvell.com> wrote:

> >From 9d64df0fa6874371446147f67c071e78c587c0d6 Mon Sep 17 00:00:00 2001
> From: Philip Rakity <prakity@marvell.com>
> Date: Fri, 24 Sep 2010 05:27:11 -0700
> Subject: [PATCH] sdhci: allow controller private registers to be changaed on reset
> 
> allow controllers that have private registers that are reset when
> the controller is reset. They need to be reprogrammed back to their
> values when the reset happens.  Provide a hook to allow this to happen.
> 
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> ---
>  drivers/mmc/host/sdhci.c |    3 +++
>  drivers/mmc/host/sdhci.h |    1 +
>  2 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 401527d..0774dad 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -174,6 +174,9 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
>  
>  	if (host->quirks & SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)
>  		sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK, ier);
> +
> +	if (host->ops->platform_specific_reset)
> +		host->ops->platform_specific_reset(host, mask);
>  }
>  
>  static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index d316bc7..f68af47 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -323,6 +323,7 @@ struct sdhci_ops {
>  	unsigned int	(*get_max_clock)(struct sdhci_host *host);
>  	unsigned int	(*get_min_clock)(struct sdhci_host *host);
>  	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
> +	void	(*platform_specific_reset)(struct sdhci_host *host, u8 mask);

See the patches I posted earlier about reset. All of sdhci_reset could be
cleaned up further by replacing sdhci_reset as a whole with a hookable
interface, and the hook you propose isn't sufficient for the Intel
devices, nor can it eliminate some of the other quirk flags.

Alan
