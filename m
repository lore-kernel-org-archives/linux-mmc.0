From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci: fix ctrl_2 on super-speed selection
Date: Thu, 27 Jun 2013 11:56:42 -0400
Message-ID: <87li5vmts5.fsf@octavius.laptop.org>
References: <1371134488-20219-1-git-send-email-peppe.cavallaro@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:52955 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753258Ab3F0P4p (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 27 Jun 2013 11:56:45 -0400
In-Reply-To: <1371134488-20219-1-git-send-email-peppe.cavallaro@st.com>
	(Giuseppe CAVALLARO's message of "Thu, 13 Jun 2013 16:41:28 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Cc: linux-mmc@vger.kernel.org

Hi Giuseppe,

On Thu, Jun 13 2013, Giuseppe CAVALLARO wrote:
> This patch fixes the HC ctrl_2 programming where, in case of
> SDR104 and HS200, we have to write 100b in the the UHS Mode
> bits. We wrote 101b that is reserved from Arasan Specs.
>
> Reported-by: Youssef Triki <youssef.triki@st.com>
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> ---
>  drivers/mmc/host/sdhci.c |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index b8bb3b3..ae745ab 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1526,16 +1526,15 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
>  			ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>  			/* Select Bus Speed Mode for host */
>  			ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
> -			if (ios->timing == MMC_TIMING_MMC_HS200)
> -				ctrl_2 |= SDHCI_CTRL_HS_SDR200;
> +			if ((ios->timing == MMC_TIMING_MMC_HS200) ||
> +			    (ios->timing == MMC_TIMING_UHS_SDR104))
> +				ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
>  			else if (ios->timing == MMC_TIMING_UHS_SDR12)
>  				ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
>  			else if (ios->timing == MMC_TIMING_UHS_SDR25)
>  				ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
>  			else if (ios->timing == MMC_TIMING_UHS_SDR50)
>  				ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
> -			else if (ios->timing == MMC_TIMING_UHS_SDR104)
> -				ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
>  			else if (ios->timing == MMC_TIMING_UHS_DDR50)
>  				ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
>  			sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);

Thanks, pushed to mmc-next for 3.11.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
