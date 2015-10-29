From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC PATCH v8 09/10] arm: multi_v7_defconfig: remove
 CONFIG_MMC_DW_IDMAC
Date: Thu, 29 Oct 2015 11:32:22 +0900
Message-ID: <56318536.1010408@samsung.com>
References: <1442385625-26775-1-git-send-email-shawn.lin@rock-chips.com>
 <1442385795-1389-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1442385795-1389-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, ulf.hansson@linaro.org
Cc: Vineet.Gupta1@synopsys.com, Wei Xu <xuwei5@hisilicon.com>, Joachim Eastwood <manabian@gmail.com>, Alexey Brodkin <abrodkin@synopsys.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Russell King <linux@arm.linux.org.uk>, Jun Nie <jun.nie@linaro.org>, Ralf Baechle <ralf@linux-mips.org>, Govindraj Raja <govindraj.raja@imgtec.com>, Arnd Bergmann <arnd@arndb.de>, heiko@sntech.de, dianders@chromium.org, linux-samsung-soc@vger.kernel.org, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi, All.

Is there any other opinion about this patch?

Best Regards,
Jaehoon Chung

On 09/16/2015 03:43 PM, Shawn Lin wrote:
> DesignWare MMC Controller's transfer mode should be decided
> at runtime instead of compile-time. So we remove this config
> option and read dw_mmc's register to select DMA master.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
> Changes in v8: None
> Changes in v7: None
> Changes in v6: None
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  arch/arm/configs/multi_v7_defconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 03deb7f..ad929ea 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -539,7 +539,6 @@ CONFIG_MMC_ATMELMCI=y
>  CONFIG_MMC_MVSDIO=y
>  CONFIG_MMC_SDHI=y
>  CONFIG_MMC_DW=y
> -CONFIG_MMC_DW_IDMAC=y
>  CONFIG_MMC_DW_PLTFM=y
>  CONFIG_MMC_DW_EXYNOS=y
>  CONFIG_MMC_DW_ROCKCHIP=y
> 
