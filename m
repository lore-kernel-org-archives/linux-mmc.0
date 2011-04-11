From: John Calixto <john.calixto@modsystems.com>
Subject: Re: [PATCH 1/4] MMC: Rename erase_timeout to cmd_timeout.
Date: Mon, 11 Apr 2011 12:18:11 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1104111213230.32082@peruna>
References: <1302052193-23317-1-git-send-email-andreiw@motorola.com> <1302052193-23317-2-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from elasmtp-banded.atl.sa.earthlink.net ([209.86.89.70]:35997 "EHLO
	elasmtp-banded.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753836Ab1DKTSW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Apr 2011 15:18:22 -0400
In-Reply-To: <1302052193-23317-2-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>

Hi Andrei,

On Tue, 5 Apr 2011, Andrei Warkentin wrote:
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index 07f27af..a7d7da7 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -92,7 +92,7 @@ struct mmc_command {
>   *              actively failing requests
>   */
>  
> -	unsigned int		erase_timeout;	/* in milliseconds */
> +	unsigned int		cmd_timeout;	/* in milliseconds */
>  
>  	struct mmc_data		*data;		/* data segment associated with cmd */
>  	struct mmc_request	*mrq;		/* associated request */

Could you rename this field to "cmd_timeout_ms"?  When I was testing the
addition of cmd_timeout to my ioctl patch, I noticed that data timeout
was being specified in ns and I had to scale cmd_timeout appropriately.

Cheers,

John
