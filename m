From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 1/2] mmc: sdhci: restore host settings when card is removed
Date: Tue, 03 Jul 2012 20:40:17 -0400
Message-ID: <87zk7g5pfy.fsf@octavius.laptop.org>
References: <1340957852-28936-1-git-send-email-aaron.lu@amd.com>
	<1340957852-28936-2-git-send-email-aaron.lu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:48823 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756547Ab2GDAkY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 3 Jul 2012 20:40:24 -0400
In-Reply-To: <1340957852-28936-2-git-send-email-aaron.lu@amd.com> (Aaron Lu's
	message of "Fri, 29 Jun 2012 16:17:31 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Lu <aaron.lu@amd.com>
Cc: linux-mmc@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>

Hi,

On Fri, Jun 29 2012, Aaron Lu wrote:
> Some of the host settings are affected by different cards inserted, e.g.
> when an UHS-I card is inserted, the SDHCI_NEEDS_RETUING flag might be
> set when the tuning timer expired and host's max_blk_count will be
> reduced to make sure the data transfer for a command does not exceed 4MiB
> to meet the retuning mode 1's requirement.
>
> When the card is removed, we should restore the original setting of the
> host since we can't be sure the next card being inserted will still be
> an UHS-I card that needs tuning. The original setting include its
> max_blk_count and no set of the flag of SDHCI_NEEDS_RETUNING.
>
> Signed-off-by: Aaron Lu <aaron.lu@amd.com>
> ---
>  drivers/mmc/host/sdhci.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index ff522ec..7e182ad 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -245,6 +245,18 @@ static void sdhci_init(struct sdhci_host *host, int soft)
>  static void sdhci_reinit(struct sdhci_host *host)
>  {
>  	sdhci_init(host, 0);
> +	/*
> +	 * Retuning stuffs are affected by different cards inserted and only
> +	 * applicable to UHS-I cards. So reset these fields to their initial
> +	 * value when card is removed.
> +	 */
> +	if (host->version >= SDHCI_SPEC_300 && host->tuning_count &&
> +			host->tuning_mode == SDHCI_TUNING_MODE_1) {
> +		del_timer_sync(&host->tuning_timer);
> +		host->flags &= ~SDHCI_NEEDS_RETUNING;
> +		host->mmc->max_blk_count =
> +			(host->quirks & SDHCI_QUIRK_NO_MULTIBLOCK) ? 1 : 65535;
> +	}
>  	sdhci_enable_card_detection(host);
>  }

Thanks, pushed to mmc-next for 3.6.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
