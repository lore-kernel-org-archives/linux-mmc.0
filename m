From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 4/6] mmc: sd: Add new CONFIG_MMC_PARANOID_SD_INIT for enabling retries during SD detection
Date: Tue, 26 Apr 2011 15:35:52 +0200
Message-ID: <201104261535.52521.arnd@arndb.de>
References: <1303520502-32171-1-git-send-email-john.stultz@linaro.org> <1303520502-32171-5-git-send-email-john.stultz@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:62844 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754361Ab1DZNgR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Apr 2011 09:36:17 -0400
In-Reply-To: <1303520502-32171-5-git-send-email-john.stultz@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Stultz <john.stultz@linaro.org>
Cc: linux-mmc@vger.kernel.org, San Mehat <san@google.com>, Chris Ball <cjb@laptop.org>, Dima Zavin <dima@android.com>

On Saturday 23 April 2011, John Stultz wrote:
> @@ -482,7 +485,26 @@ int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
>  		/*
>  		 * Fetch switch information from card.
>  		 */
> +#ifdef CONFIG_MMC_PARANOID_SD_INIT
> +		for (retries = 1; retries <= 3; retries++) {
> +			err = mmc_read_switch(card);
> +			if (!err) {
> +				if (retries > 1) {
> +					printk(KERN_WARNING
> +					       "%s: recovered\n",
> +					       mmc_hostname(host));
> +				}
> +				break;
> +			} else {
> +				printk(KERN_WARNING
> +				       "%s: read switch failed (attempt %d)\n",
> +				       mmc_hostname(host), retries);
> +			}
> +		}
> +#else
>  		err = mmc_read_switch(card);
> +#endif
> +

I see no reason to have this as a compile time option. Having retries in here
might be useful, but a better place would be inside of mmc_read_switch()
or mmc_sd_switch() so it is only done if the error comes from the controller,
not for cases where we know it will fail (e.g. !(card->csd.cmdclass & CCC_SWITCH)).

I would also recommend being a bit less noisy, e.g. print a warning only
after either giving up or succeeding a retry.

	Arnd
