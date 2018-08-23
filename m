From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V5 06/10] mmc: sdhci: Disable auto-CMD23 if stuff bits is
 set in CMD23 argument
Date: Thu, 23 Aug 2018 15:50:11 +0300
Message-ID: <9de08b30-cb92-01c6-caf3-c4abc3591dcf@intel.com>
References: <1534406064-10065-1-git-send-email-zhang.chunyan@linaro.org>
 <1534406064-10065-7-git-send-email-zhang.chunyan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534406064-10065-7-git-send-email-zhang.chunyan@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chunyan Zhang <zhang.chunyan@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Billows Wu <billows.wu@unisoc.com>, Jason Wu <jason.wu@unisoc.com>, Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 16/08/18 10:54, Chunyan Zhang wrote:
> For version 4.10 and aboves, SDHCI_ARGUMENT2 is also uses to indicate
> 32-bit number of blocks, it doesn't support stuff bits in argument of
> CMD23, but only block count for the following command (CMD18/25).
> 
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> ---
>  drivers/mmc/host/sdhci.c | 9 +++++++++
>  drivers/mmc/host/sdhci.h | 1 +
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index b3328ee..a72ad0d 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1729,6 +1729,15 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  		}
>  	}
>  
> +	/*
> +	 * For version 4.10 and above, ARGUMENT2 register is also used as 32-bit
> +	 * block count register which don't support stuff bits of CMD23 argument
> +	 */
> +	if (host->version >= SDHCI_SPEC_410 &&
> +	    mrq->sbc && (mrq->sbc->arg & SDHCI_ARG2_STUFF) &&
> +	    (host->flags & SDHCI_AUTO_CMD23))
> +		host->flags &= ~SDHCI_AUTO_CMD23;

I would prefer this be done in sdhci-sprd.c by hooking ->request().  Someone
sent a patch recently to export sdhci_request().

> +
>  	if (!present || host->flags & SDHCI_DEVICE_DEAD) {
>  		mrq->cmd->error = -ENOMEDIUM;
>  		sdhci_finish_mrq(host, mrq);
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index d34971ac..daf8c1e 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -28,6 +28,7 @@
>  
>  #define SDHCI_DMA_ADDRESS	0x00
>  #define SDHCI_ARGUMENT2		SDHCI_DMA_ADDRESS
> +#define  SDHCI_ARG2_STUFF	GENMASK(31, 16)
>  #define SDHCI_32BIT_BLK_CNT	SDHCI_DMA_ADDRESS
>  
>  #define SDHCI_BLOCK_SIZE	0x04
> 
