From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH mmc-next] mmc: sdhci: fix __sdhci_adma_write_desc
Date: Mon, 17 Sep 2018 09:21:16 +0300
Message-ID: <0bec0d01-9fde-1df3-3cc3-fb922dd5350d@intel.com>
References: <20180917133041.66100101@xhacker.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180917133041.66100101@xhacker.debian>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 17/09/18 08:30, Jisheng Zhang wrote:
> If hosts provides ops->adma_write_desc, we should not fall back to the
> general sdhci_adma_write_desc().
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
> 
> Hi Ulf, Adrian,
> 
> When I introduced .adma_write_desc, I made a mistake since v4 -- if the host
> provide ops->adma_write_desc, we should just call it and don't fall back
> to the general sdhci_adma_write_desc(). Before v4, the adma_write_desc return
> int, since v4 there's no return value, so when I prepared the v4, I just
> removed return, this is where the mistake is from. I dunno how to handle
> this case, fold the patch into previous commit or apply it as a separate patch?

Up to Ulf, but in any case:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> I'm very sorry for this. In fact, Adrian caught another similar bug during
> review.
> 
> Sorry about the inconvenience,
> Jisheng
> 
>  drivers/mmc/host/sdhci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 0dda6f4b6a24..99bdae53fa2e 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -649,8 +649,8 @@ static inline void __sdhci_adma_write_desc(struct sdhci_host *host,
>  {
>  	if (host->ops->adma_write_desc)
>  		host->ops->adma_write_desc(host, desc, addr, len, cmd);
> -
> -	sdhci_adma_write_desc(host, desc, addr, len, cmd);
> +	else
> +		sdhci_adma_write_desc(host, desc, addr, len, cmd);
>  }
>  
>  static void sdhci_adma_mark_end(void *desc)
> 
