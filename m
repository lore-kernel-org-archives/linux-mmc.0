From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: Re: [PATCH 4/4] mmc: mtk-sd: select REGULATOR
Date: Sun, 5 May 2019 15:52:52 +0800
Message-ID: <1557042772.18628.36.camel@mhfsdcap03>
References: <155696540998.8632.5242582397805128125.stgit@noble.brown>
         <155696549700.8632.10790498625986428152.stgit@noble.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <155696549700.8632.10790498625986428152.stgit@noble.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neil@brown.name>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, thirtythreeforty@gmail.com
List-Id: linux-mmc@vger.kernel.org

On Sat, 2019-05-04 at 20:24 +1000, NeilBrown wrote:
> The mtk-sd driver requires a regulator to be present, even if it is
> the "fixed" regulator.  So select REGULATOR to make it hard to build
> unusable configurations.
> 
> Signed-off-by: NeilBrown <neil@brown.name>
 Reviewed-by:Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  drivers/mmc/host/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 9c01310a0d2e..1249cde7004d 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -941,6 +941,7 @@ config MMC_BCM2835
>  config MMC_MTK
>  	tristate "MediaTek SD/MMC Card Interface support"
>  	depends on HAS_DMA
> +	select REGULATOR
>  	help
>  	  This selects the MediaTek(R) Secure digital and Multimedia card Interface.
>  	  If you have a machine with a integrated SD/MMC card reader, say Y or M here.
> 
> 
