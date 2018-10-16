From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci: use goto rather than return directly
Date: Tue, 16 Oct 2018 11:28:46 +0300
Message-ID: <88801a36-44cf-237f-a762-985bb215c104@intel.com>
References: <1539677982-13762-1-git-send-email-zhang.chunyan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539677982-13762-1-git-send-email-zhang.chunyan@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chunyan Zhang <zhang.chunyan@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 16/10/18 11:19 AM, Chunyan Zhang wrote:
> The driver should clean resources requested in the function before
> unnormal return.
> 
> CC: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> Fixes: bd9b902798ab ("mmc: sdhci: Implement an SDHCI-specific bounce buffer")
> ---
>  drivers/mmc/host/sdhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 1b3fbd9..f6b57e1 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3991,7 +3991,7 @@ int sdhci_setup_host(struct sdhci_host *host)
>  		/* This may alter mmc->*_blk_* parameters */
>  		ret = sdhci_allocate_bounce_buffer(host);

Do we need the error return?  It seems to be zero always.

>  		if (ret)
> -			return ret;
> +			goto unreg;
>  	}
>  
>  	return 0;
> 
