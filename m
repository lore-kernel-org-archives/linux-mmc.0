From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 3/4] mmc: Kconfig: Enable CONFIG_MMC_SDHCI_IO_ACCESSORS
Date: Tue, 3 Oct 2017 14:44:34 +0300
Message-ID: <35266316-e199-30a7-dc7d-bb31f173e018@intel.com>
References: <1506490483-46871-1-git-send-email-vviswana@codeaurora.org>
 <1506490483-46871-4-git-send-email-vviswana@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1506490483-46871-4-git-send-email-vviswana@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vijay Viswanath <vviswana@codeaurora.org>, ulf.hansson@linaro.org, will.deacon@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, riteshh@codeaurora.org, subhashj@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

On 27/09/17 08:34, Vijay Viswanath wrote:
> Enable CONFIG_MMC_SDHCI_IO_ACCESSORS so that SDHC controller specific
> register read and write APIs, if registered, can be used.
> 
> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 2db84dd..11bfb82 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -420,6 +420,7 @@ config MMC_SDHCI_MSM
>  	tristate "Qualcomm SDHCI Controller Support"
>  	depends on ARCH_QCOM || (ARM && COMPILE_TEST)
>  	depends on MMC_SDHCI_PLTFM
> +	select MMC_SDHCI_IO_ACCESSORS
>  	help
>  	  This selects the Secure Digital Host Controller Interface (SDHCI)
>  	  support present in Qualcomm SOCs. The controller supports
> 
