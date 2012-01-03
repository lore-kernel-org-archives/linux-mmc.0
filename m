From: Chris Ball <cjb@laptop.org>
Subject: Re: regression: sd cards no longer recognized
Date: Mon, 02 Jan 2012 19:29:10 -0500
Message-ID: <m2vcotoch5.fsf@bob.laptop.org>
References: <20120101115146.GE16096@segv.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:44053 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753505Ab2ACA3T (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 2 Jan 2012 19:29:19 -0500
In-Reply-To: <20120101115146.GE16096@segv.de> (Alexander Elbs's message of
	"Sun, 1 Jan 2012 12:51:46 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexander Elbs <alex@segv.de>
Cc: Arindam Nath <arindam.nath@amd.com>, Philip Rakity <prakity@marvell.com>, linux-mmc@vger.kernel.org

Hi Alexander,

On Sun, Jan 01 2012, Alexander Elbs wrote:
> Hi,
>
> on a dell vostro with an integrated SD card reader I have the problem, that
> inserted SD cards are no longer recognized.
> The reader is a "O2 Micro, Inc. Integrated MMC/SD Controller (rev 02)"
> (1217:7120).
>
> Doing a git bisect I found that commit 49c468f "mmc: sd: add support for uhs
> bus speed mode selection" caused this regression.
>
> Looking more closely into it I found that the flag SDHCI_CTRL_HISPD is always
> set even on MMC_TIMING_UHS_SDR12 (which is an alias for MMC_TIMING_LEGACY).
>
> If that flag in that case is not set (as was before commit 49c468f) my reader
> works fine again.
>
> Could you include that fix or does it break other readers?
>
> Regards,
> Alexander Elbs
>
> ---
>  drivers/mmc/host/sdhci.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 6d8eea3..8872e92 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1364,8 +1364,7 @@ static void sdhci_do_set_ios(struct sdhci_host *host,
> struct mmc_ios *ios)
>                 if ((ios->timing == MMC_TIMING_UHS_SDR50) ||
>                     (ios->timing == MMC_TIMING_UHS_SDR104) ||
>                     (ios->timing == MMC_TIMING_UHS_DDR50) ||
> -                   (ios->timing == MMC_TIMING_UHS_SDR25) ||
> -                   (ios->timing == MMC_TIMING_UHS_SDR12))
> +                   (ios->timing == MMC_TIMING_UHS_SDR25))
>                         ctrl |= SDHCI_CTRL_HISPD;
>  
>                 ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);

Thanks for the report -- adding Arindam and Philip to CC for comments.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
