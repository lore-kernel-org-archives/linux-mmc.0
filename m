From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v3 2/2] mmc: sdhci-msm: set sdma_boundary to zero
Date: Thu, 3 Aug 2017 16:14:41 +0300
Message-ID: <8520c8ea-48d5-92bc-5f15-a4f61e663376@intel.com>
References: <20170803124614.21788-1-srinivas.kandagatla@linaro.org>
 <20170803124614.21788-3-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170803124614.21788-3-srinivas.kandagatla@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: srinivas.kandagatla@linaro.org, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 03/08/17 15:46, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Programming legacy HOST SDMA Buffer Boundary bits in Block Size Register
> (0x04) is not supported in Qualcomm sdhci controllers. Writing to this
> would cause the controller not to transfer last block in case block size
> is 4 bytes or less.
> 
> This issue was noticed while testing sdio wlan card on Qcom DB410c board.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-msm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 9d601dc..adfe5bd 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -1133,6 +1133,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  	if (IS_ERR(host))
>  		return PTR_ERR(host);
>  
> +	host->sdma_boundary = 0;
>  	pltfm_host = sdhci_priv(host);
>  	msm_host = sdhci_pltfm_priv(pltfm_host);
>  	msm_host->mmc = host->mmc;
> 
