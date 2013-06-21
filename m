From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v12 05/11] edma: config: Enable config options for EDMA
Date: Fri, 21 Jun 2013 15:46:01 +0530
Message-ID: <51C427E1.2000800@ti.com>
References: <1371762407-24544-1-git-send-email-joelagnel@ti.com>
	<1371762407-24544-6-git-send-email-joelagnel@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1371762407-24544-6-git-send-email-joelagnel-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Joel A Fernandes <joelagnel-l0cyMroinI0@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Koen Kooi <koen-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 6/21/2013 2:36 AM, Joel A Fernandes wrote:
> From: Joel A Fernandes <agnel.joel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> Build TI_EDMA by default for ARCH_DAVINCI and ARCH_OMAP2PLUS
> 
> Signed-off-by: Joel A Fernandes <joelagnel-l0cyMroinI0@public.gmane.org>

You should sign-off with author e-mail address.

> ---
>  arch/arm/Kconfig            |    1 +
>  arch/arm/mach-omap2/Kconfig |    1 +
>  drivers/dma/Kconfig         |    2 +-
>  3 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index b1c66a4..7d58cd9 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -841,6 +841,7 @@ config ARCH_DAVINCI
>  	select HAVE_IDE
>  	select NEED_MACH_GPIO_H
>  	select TI_PRIV_EDMA
> +	select DMADEVICES

It is generally a bad idea to force select on something that can be
enabled using menuconfig. Unless used carefully, select causes "unmet
direct dependency" warnings which folks are already fighting hard to
fix. This leads to what Russell referred in the past as "select madness" [1]

In this particular case, it is perfectly okay to have a DaVinci platform
without DMA engine support. Drivers figure out they don't have DMA
support and switch to PIO mode.

Add this in defconfig if its useful for most folks using the platform,
but don't force it for everyone through select.

>  	select USE_OF
>  	select ZONE_DMA
>  	help
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index f91b07f..c02f083 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -17,6 +17,7 @@ config ARCH_OMAP2PLUS
>  	select PROC_DEVICETREE if PROC_FS
>  	select SOC_BUS
>  	select SPARSE_IRQ
> +	select DMADEVICES
>  	select TI_PRIV_EDMA
>  	select USE_OF
>  	help
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 3215a3c..b2d6f15 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -216,7 +216,7 @@ config TI_EDMA
>  	depends on ARCH_DAVINCI || ARCH_OMAP
>  	select DMA_ENGINE
>  	select DMA_VIRTUAL_CHANNELS
> -	default n
> +	default y

Can't see why DMA support should default to y.

Thanks,
Sekhar

[1] http://lkml.org/lkml/2013/3/4/114
