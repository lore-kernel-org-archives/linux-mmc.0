From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH v3 04/16] ARM: edma: add DT and runtime PM support
 for AM33XX
Date: Sun, 28 Oct 2012 16:33:39 +0530
Message-ID: <508D110B.8010908@ti.com>
References: <1350566815-409-1-git-send-email-mporter@ti.com>
 <1350566815-409-5-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1350566815-409-5-git-send-email-mporter-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 10/18/2012 6:56 PM, Matt Porter wrote:
> Adds support for parsing the TI EDMA DT data into the required
> EDMA private API platform data.
> 
> Calls runtime PM API only in the DT case in order to unidle the
> associated hwmods on AM33XX.

Runtime PM is supported on DaVinci now, so if that was the reason for
this choice, then it doesn't need to be that way.

> 
> Signed-off-by: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/common/edma.c                      |  255 +++++++++++++++++++++++++--
>  arch/arm/mach-davinci/board-da830-evm.c     |    4 +-
>  arch/arm/mach-davinci/board-da850-evm.c     |    8 +-
>  arch/arm/mach-davinci/board-dm646x-evm.c    |    4 +-
>  arch/arm/mach-davinci/board-omapl138-hawk.c |    8 +-
>  arch/arm/mach-davinci/devices-da8xx.c       |    8 +-
>  arch/arm/mach-davinci/devices-tnetv107x.c   |    4 +-
>  arch/arm/mach-davinci/dm355.c               |    4 +-
>  arch/arm/mach-davinci/dm365.c               |    4 +-
>  arch/arm/mach-davinci/dm644x.c              |    4 +-
>  arch/arm/mach-davinci/dm646x.c              |    4 +-
>  include/linux/platform_data/edma.h          |    8 +-
>  12 files changed, 272 insertions(+), 43 deletions(-)
> 
> diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
> index a3d189d..6d2a590 100644
> --- a/arch/arm/common/edma.c
> +++ b/arch/arm/common/edma.c
> @@ -24,6 +24,13 @@
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
>  #include <linux/slab.h>
> +#include <linux/edma.h>
> +#include <linux/err.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/of_dma.h>
> +#include <linux/of_irq.h>
> +#include <linux/pm_runtime.h>
>  
>  #include <linux/platform_data/edma.h>
>  
> @@ -1366,31 +1373,237 @@ void edma_clear_event(unsigned channel)
>  EXPORT_SYMBOL(edma_clear_event);
>  
>  /*-----------------------------------------------------------------------*/
> +static int edma_of_read_u32_to_s8_array(const struct device_node *np,
> +					 const char *propname, s8 *out_values,
> +					 size_t sz)
> +{
> +	struct property *prop = of_find_property(np, propname, NULL);
> +	const __be32 *val;
> +
> +	if (!prop)
> +		return -EINVAL;
> +	if (!prop->value)
> +		return -ENODATA;
> +	if ((sz * sizeof(u32)) > prop->length)
> +		return -EOVERFLOW;
> +
> +	val = prop->value;
> +
> +	while (sz--)
> +		*out_values++ = (s8)(be32_to_cpup(val++) & 0xff);
> +
> +	/* Terminate it */
> +	*out_values++ = -1;
> +	*out_values++ = -1;
> +
> +	return 0;
> +}
> +
> +static int edma_of_read_u32_to_s16_array(const struct device_node *np,
> +					 const char *propname, s16 *out_values,
> +					 size_t sz)
> +{
> +	struct property *prop = of_find_property(np, propname, NULL);
> +	const __be32 *val;
> +
> +	if (!prop)
> +		return -EINVAL;
> +	if (!prop->value)
> +		return -ENODATA;
> +	if ((sz * sizeof(u32)) > prop->length)
> +		return -EOVERFLOW;
> +
> +	val = prop->value;
> +
> +	while (sz--)
> +		*out_values++ = (s16)(be32_to_cpup(val++) & 0xffff);
> +
> +	/* Terminate it */
> +	*out_values++ = -1;
> +	*out_values++ = -1;
> +
> +	return 0;
> +}

I think these helper functions will have some general use beyond EDMA
and can be kept in drivers/of/base.c. Grant/Rob need to agree though.

> diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
> index 95b5e10..ffcbec1 100644
> --- a/arch/arm/mach-davinci/board-da830-evm.c
> +++ b/arch/arm/mach-davinci/board-da830-evm.c
> @@ -512,7 +512,7 @@ static struct davinci_i2c_platform_data da830_evm_i2c_0_pdata = {
>   * example: Timer, GPIO, UART events etc) on da830/omap-l137 EVM, hence
>   * they are being reserved for codecs on the DSP side.
>   */
> -static const s16 da830_dma_rsv_chans[][2] = {
> +static s16 da830_dma_rsv_chans[][2] = {

I wonder why you had to remove const here and in other places. You seem
to be allocating new memory for DT case anyway. Its also not a good idea
to modify the passed platform data.

Thanks,
Sekhar
