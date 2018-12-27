From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V5 1/3] mmc: sdhci: Fix sdhci_do_enable_v4_mode
Date: Thu, 27 Dec 2018 10:13:35 +0200
Message-ID: <9b1f6ba3-113a-7c65-81af-fe911c51a875@intel.com>
References: <1545355509-6914-1-git-send-email-skomatineni@nvidia.com>
 <1545355509-6914-2-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1545355509-6914-2-git-send-email-skomatineni@nvidia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>, robh+dt@kernel.org, mark.rutland@arm.com, mperttunen@nvidia.com, thierry.reding@gmail.com, jonathanh@nvidia.com, ulf.hansson@linaro.org
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 21/12/18 3:25 AM, Sowjanya Komatineni wrote:
> V4_MODE is Bit-15 of SDHCI_HOST_CONTROL2 register.
> Need to perform word access to this register.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

This patch has already been applied.

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
