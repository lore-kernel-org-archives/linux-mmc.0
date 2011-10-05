From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH 2/3] mmc: Add OF bindings support for mmc host controller
	capabilities
Date: Wed, 05 Oct 2011 08:29:58 -0500
Message-ID: <4E8C5BD6.2070709@gmail.com>
References: <1317809581-28783-1-git-send-email-thomas.abraham@linaro.org>
	<1317809581-28783-3-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1317809581-28783-3-git-send-email-thomas.abraham@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: kgene.kim@samsung.com, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, cjb@laptop.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Thomas,

On 10/05/2011 05:13 AM, Thomas Abraham wrote:
> Device nodes representing sd/mmc controllers in a device tree would include
> mmc host controller capabilities. Add support for parsing of mmc host
> controller capabilities included in device nodes.
> 
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  .../devicetree/bindings/mmc/linux-mmc-host.txt     |   11 +++++++
>  drivers/mmc/core/host.c                            |   31 ++++++++++++++++++++
>  include/linux/mmc/host.h                           |    3 ++
>  3 files changed, 45 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/linux-mmc-host.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/linux-mmc-host.txt b/Documentation/devicetree/bindings/mmc/linux-mmc-host.txt
> new file mode 100644
> index 0000000..cb43905
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/linux-mmc-host.txt
> @@ -0,0 +1,11 @@
> +* Linux mmc host capabilities
> +
> +MMC Host Controller capabilities used in linux:

These aren't really linux properties... Is the capabilities register
really this broken that all these are needed? If so, perhaps just a
straight caps register value to override with would be better.

> +- linux,mmc_cap_4_bit_data - host can do 4 bit transfers
> +- linux,mmc_cap_mmc_highspeed - host can do MMC high-speed timing
> +- linux,mmc_cap_sd_highspeed - host can do SD high-speed timing
> +- linux,mmc_cap_needs_poll - host needs polling for card detection
> +- linux,mmc_cap_8_bit_data - host can do 8 bit transfer

"sdhci,1-bit-only" already exists as a binding. Perhaps add
"sdhci,4-bit-only". No property then means can do 8-bit.

> +- linux,mmc_cap_disable - host can be disabled

What?

> +- linux,mmc_cap_nonremovable - host is connected to nonremovable media
> +- linux,mmc_cap_erase - host allows erase/trim commands

Isn't TRIM a card property and transparent to the host controller?

> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 793d0a0..4ee2e43 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -19,6 +19,7 @@
>  #include <linux/leds.h>
>  #include <linux/slab.h>
>  #include <linux/suspend.h>
> +#include <linux/of.h>
>  
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/card.h>
> @@ -385,3 +386,33 @@ void mmc_free_host(struct mmc_host *host)
>  }
>  
>  EXPORT_SYMBOL(mmc_free_host);
> +
> +#ifdef CONFIG_OF
> +/**
> + *	mmc_of_parse_host_caps - parse mmc host capabilities from device node
> + *	@np: pointer to device node in device tree
> + *	@caps: pointer to host caps value to be returned
> + *
> + *	Search the device node in device tree for mmc host capabilities.
> + */
> +void mmc_of_parse_host_caps(struct device_node *np, unsigned long *caps)
> +{
> +	if (of_find_property(np, "linux,mmc_cap_4_bit_data", NULL))
> +		*caps |= MMC_CAP_4_BIT_DATA;
> +	if (of_find_property(np, "linux,mmc_cap_mmc_highspeed", NULL))
> +		*caps |= MMC_CAP_MMC_HIGHSPEED;
> +	if (of_find_property(np, "linux,mmc_cap_sd_highspeed", NULL))
> +		*caps |= MMC_CAP_SD_HIGHSPEED;
> +	if (of_find_property(np, "linux,mmc_cap_needs_poll", NULL))
> +		*caps |= MMC_CAP_NEEDS_POLL;
> +	if (of_find_property(np, "linux,mmc_cap_8_bit_data", NULL))
> +		*caps |= MMC_CAP_8_BIT_DATA;
> +	if (of_find_property(np, "linux,mmc_cap_disable", NULL))
> +		*caps |= MMC_CAP_DISABLE;
> +	if (of_find_property(np, "linux,mmc_cap_nonremovable", NULL))
> +		*caps |= MMC_CAP_NONREMOVABLE;
> +	if (of_find_property(np, "linux,mmc_cap_erase", NULL))
> +		*caps |= MMC_CAP_ERASE;
> +}
> +EXPORT_SYMBOL(mmc_of_parse_host_caps);
> +#endif /* CONFIG_OF */
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 1d09562..72b5df2 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -309,6 +309,9 @@ extern struct mmc_host *mmc_alloc_host(int extra, struct device *);
>  extern int mmc_add_host(struct mmc_host *);
>  extern void mmc_remove_host(struct mmc_host *);
>  extern void mmc_free_host(struct mmc_host *);
> +#ifdef CONFIG_OF
> +extern void mmc_of_parse_host_caps(struct device_node *np, unsigned long *caps);
> +#endif

You don't need a ifdef around this.

Rob
