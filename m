From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] mmc: tegra: Disable UHS-I modes for tegra30
Date: Tue, 10 May 2016 17:13:33 +0100
Message-ID: <573208AD.4090506@nvidia.com>
References: <1462806903-13860-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1462806903-13860-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


On 09/05/16 16:15, Jon Hunter wrote:
> Support for SD cards is not working on the Tegra30 Beaver board and on
> boot the following error message is seen if an SD card is present:
> 
>  mmc0: error -110 whilst initialising SD card
> 
> In addition to this, Tegra30 is also randomly hanging during system
> suspend when entering and is caused by the Tegra SDHCI driver. Similar
> issues have been seen on the Tegra124 Jetson TK1 and are linked to the
> UHS-I tuning sequence. Disabling the UHS-I modes for Tegra30 fixes SD
> card support and prevents any hangs from occurring when entering system
> suspend. Therefore, disable the UHS-I modes for Tegra30 for now until
> we can correct the tuning sequence for Tegra.
> 
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index bcc0de47fe7e..24c33aee8e7c 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -347,10 +347,6 @@ static const struct sdhci_pltfm_data sdhci_tegra30_pdata = {
>  
>  static const struct sdhci_tegra_soc_data soc_data_tegra30 = {
>  	.pdata = &sdhci_tegra30_pdata,
> -	.nvquirks = NVQUIRK_ENABLE_SDHCI_SPEC_300 |

Ugh ... looks like I may have been a bit trigger happy with sending this
patch. I should not have removed the above line. However, it seems that
if I don't then the problem with the SD not initialising persists. So
this implies that something else is going on here with this particular
SD card. Furthermore, I have seen that another tegra30-beaver is
initialising the SD card fine on kernelci.org and it seems this is
working for Lucas too.

Plus in suspend I have not seen the mmc timeout warning that I was
seeing on tegra114/124 when they were failing. That also implies a
different problem.

Stephen, for your u-boot testing, do you are set the bit in the vendor
misc register to enable version 3.0 support for sdhci on tegra30? This
is what the above quirk is doing (and has done so for a very long time).

Sorry I am usually more thorough ...

Jon
