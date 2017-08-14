From: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/4] sdhci: key 8BITBUS bit off MMC_CAP_8_BIT_DATA
Date: Mon, 14 Aug 2017 14:58:58 +0300
Message-ID: <5fe67188-e8ad-3062-7f93-0f9bdac2d27a@intel.com>
References: <cover.1502310654.git.mirq-linux@rere.qmqm.pl>
 <96ece1eb7b8f6e188e3975f75754aeaf195f3dc0.1502310654.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <96ece1eb7b8f6e188e3975f75754aeaf195f3dc0.1502310654.git.mirq-linux-CoA6ZxLDdyEEUmgCuDUIdw@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux-CoA6ZxLDdyEEUmgCuDUIdw@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 09/08/17 23:36, Michał Mirosław wrote:
> 
> Hosts supporting 8-bit bus are marked accordingly. If MMC_CAP_8_BIT_DATA
> is not among host capabilities, 8BITBUS bit will never be set and it
> is not cleared in case some non-SDHCI3 host uses it for something else.
> 
> Signed-off-by: Michał Mirosław <mirq-linux-CoA6ZxLDdyEEUmgCuDUIdw@public.gmane.org>

Subject should begin "mmc: sdhci: "...

Otherwise:

Acked-by: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

> ---
>  drivers/mmc/host/sdhci.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index ecd0d4350e8a..cca21246cf61 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1544,10 +1544,9 @@ void sdhci_set_bus_width(struct sdhci_host *host, int width)
>  	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
>  	if (width == MMC_BUS_WIDTH_8) {
>  		ctrl &= ~SDHCI_CTRL_4BITBUS;
> -		if (host->version >= SDHCI_SPEC_300)
> -			ctrl |= SDHCI_CTRL_8BITBUS;
> +		ctrl |= SDHCI_CTRL_8BITBUS;
>  	} else {
> -		if (host->version >= SDHCI_SPEC_300)
> +		if (host->mmc->caps & MMC_CAP_8_BIT_DATA)
>  			ctrl &= ~SDHCI_CTRL_8BITBUS;
>  		if (width == MMC_BUS_WIDTH_4)
>  			ctrl |= SDHCI_CTRL_4BITBUS;
> 
