From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V1] mmc: sdhci: Fix sdhci_do_enable_v4_mode
Date: Fri, 14 Dec 2018 09:34:27 +0200
Message-ID: <3c980500-77d8-c8a7-ce7a-31eb8df1b17a@intel.com>
References: <1544733246-11678-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544733246-11678-1-git-send-email-skomatineni@nvidia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 13/12/18 10:34 PM, Sowjanya Komatineni wrote:
> V4_MODE is Bit-15 of SDHCI_HOST_CONTROL2 register.
> Need to perform word access to this register.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Fixes: b3f80b434f726 ("mmc: sdhci: Add sd host v4 mode")

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 99bdae53fa2e..fde984d10619 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -127,12 +127,12 @@ static void sdhci_do_enable_v4_mode(struct sdhci_host *host)
>  {
>  	u16 ctrl2;
>  
> -	ctrl2 = sdhci_readb(host, SDHCI_HOST_CONTROL2);
> +	ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>  	if (ctrl2 & SDHCI_CTRL_V4_MODE)
>  		return;
>  
>  	ctrl2 |= SDHCI_CTRL_V4_MODE;
> -	sdhci_writeb(host, ctrl2, SDHCI_HOST_CONTROL);
> +	sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
>  }
>  
>  /*
> 
