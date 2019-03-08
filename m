From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V1 09/11] mmc: cqhci: add CQHCI_SSC1 register CBC field
 mask
Date: Fri, 8 Mar 2019 14:14:36 +0200
Message-ID: <47d5ee65-4614-59e3-4b23-b67030b2f5d2@intel.com>
References: <1551504025-3541-1-git-send-email-skomatineni@nvidia.com>
 <1551504025-3541-9-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551504025-3541-9-git-send-email-skomatineni@nvidia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, riteshh@codeaurora.org
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, anrao@nvidia.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 2/03/19 7:20 AM, Sowjanya Komatineni wrote:
> This patch adds define for CBC field mask of the register
> CQHCI_SSC1.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/cqhci.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
> index f96d8565cc07..f1dc48c7436f 100644
> --- a/drivers/mmc/host/cqhci.h
> +++ b/drivers/mmc/host/cqhci.h
> @@ -88,6 +88,7 @@
>  
>  /* send status config 1 */
>  #define CQHCI_SSC1			0x40
> +#define CQHCI_SSC1_CBC_MASK		GENMASK(19, 16)
>  
>  /* send status config 2 */
>  #define CQHCI_SSC2			0x44
> 
