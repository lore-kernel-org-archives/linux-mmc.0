From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v4 7/7] arm64: configs: Enable Actions Semi platform in
 defconfig
Date: Mon, 14 Oct 2019 20:16:20 +0530
Message-ID: <20191014144620.GC8583@mani>
References: <20190916154546.24982-1-manivannan.sadhasivam@linaro.org>
 <20190916154546.24982-8-manivannan.sadhasivam@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190916154546.24982-8-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, afaerber@suse.de, robh+dt@kernel.org, sboyd@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, thomas.liau@actions-semi.com, linux-actions@lists.infradead.org, linus.walleij@linaro.org, linux-clk@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Sep 16, 2019 at 09:15:46PM +0530, Manivannan Sadhasivam wrote:
> Since the Actions Semi platform can now boot a distro, enable it in
> ARM64 defconfig.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied for v5.5.

Thanks,
Mani

> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 0e58ef02880c..8e27777d6687 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -29,6 +29,7 @@ CONFIG_BLK_DEV_INITRD=y
>  CONFIG_KALLSYMS_ALL=y
>  # CONFIG_COMPAT_BRK is not set
>  CONFIG_PROFILING=y
> +CONFIG_ARCH_ACTIONS=y
>  CONFIG_ARCH_AGILEX=y
>  CONFIG_ARCH_SUNXI=y
>  CONFIG_ARCH_ALPINE=y
> -- 
> 2.17.1
> 
