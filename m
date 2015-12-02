From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC v03 03/15] dmaengine: core: Introduce new, universal API to
 request a channel
Date: Wed, 2 Dec 2015 16:35:40 +0200
Message-ID: <CAHp75VcBnP-d=GSvfLFUQe8P1LFBtN6W9A+jvTTUw2vTSscBiA@mail.gmail.com>
References: <1449064765-27427-1-git-send-email-peter.ujfalusi@ti.com>
	<1449064765-27427-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1449064765-27427-4-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dmaengine <dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Dec 2, 2015 at 3:59 PM, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> =
wrote:
> The two API function can cover most, if not all current APIs used to
> request a channel. With minimal effort dmaengine drivers, platforms a=
nd
> dmaengine user drivers can be converted to use the two function.
>
> struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask)=
;
>
> To request any channel matching with the requested capabilities, can =
be
> used to request channel for memcpy, memset, xor, etc where no hardwar=
e
> synchronization is needed.
>
> struct dma_chan *dma_request_chan(struct device *dev, const char *nam=
e);
> To request a slave channel. The dma_request_chan() will try to find t=
he
> channel via DT, ACPI or in case if the kernel booted in non DT/ACPI m=
ode
> it will use a filter lookup table and retrieves the needed informatio=
n from
> the dma_filter_map provided by the DMA drivers.
> This legacy mode needs changes in platform code, in dmaengine drivers=
 and
> finally the dmaengine user drivers can be converted:
>
> For each dmaengine driver an array of DMA device, slave and the param=
eter
> for the filter function needs to be added:
>
> static const struct dma_filter_map da830_edma_map[] =3D {
>         { "davinci-mcasp.0", "rx", EDMA_FILTER_PARAM(0, 0) },
>         { "davinci-mcasp.0", "tx", EDMA_FILTER_PARAM(0, 1) },
>         { "davinci-mcasp.1", "rx", EDMA_FILTER_PARAM(0, 2) },
>         { "davinci-mcasp.1", "tx", EDMA_FILTER_PARAM(0, 3) },
>         { "davinci-mcasp.2", "rx", EDMA_FILTER_PARAM(0, 4) },
>         { "davinci-mcasp.2", "tx", EDMA_FILTER_PARAM(0, 5) },
>         { "spi_davinci.0", "rx", EDMA_FILTER_PARAM(0, 14) },
>         { "spi_davinci.0", "tx", EDMA_FILTER_PARAM(0, 15) },
>         { "da830-mmc.0", "rx", EDMA_FILTER_PARAM(0, 16) },
>         { "da830-mmc.0", "tx", EDMA_FILTER_PARAM(0, 17) },
>         { "spi_davinci.1", "rx", EDMA_FILTER_PARAM(0, 18) },
>         { "spi_davinci.1", "tx", EDMA_FILTER_PARAM(0, 19) },
> };
>
> This information is going to be needed by the dmaengine driver, so
> modification to the platform_data is needed, and the driver map shoul=
d be
> added to the pdata of the DMA driver:
>
> da8xx_edma0_pdata.slave_map =3D da830_edma_map;
> da8xx_edma0_pdata.slavecnt =3D ARRAY_SIZE(da830_edma_map);
>
> The DMA driver then needs to configure the needed device -> filter_fn
> mapping before it registers with dma_async_device_register() :
>
> if (info->slave_map) {
>         ecc->dma_slave.filter_map.map =3D info->slave_map;
>         ecc->dma_slave.filter_map.mapcnt =3D info->slavecnt;
>         ecc->dma_slave.filter_map.filter_fn =3D edma_filter_fn;
> }
>
> When neither DT or ACPI lookup is available the dma_request_chan() wi=
ll
> try to match the requester's device name with the filter_map's list o=
f
> device names, when a match found it will use the information from the
> dma_filter_map to get the channel with the dma_get_channel() internal
> function.
>

=46ew nitpicks below.

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
> ---
>  Documentation/dmaengine/client.txt | 23 +++------
>  drivers/dma/dmaengine.c            | 98 ++++++++++++++++++++++++++++=
++++++++++
>  include/linux/dmaengine.h          | 27 +++++++++++
>  3 files changed, 131 insertions(+), 17 deletions(-)
>
> diff --git a/Documentation/dmaengine/client.txt b/Documentation/dmaen=
gine/client.txt
> index d9f9f461102a..6c72a06eb1a5 100644
> --- a/Documentation/dmaengine/client.txt
> +++ b/Documentation/dmaengine/client.txt
> @@ -22,25 +22,14 @@ The slave DMA usage consists of following steps:
>     Channel allocation is slightly different in the slave DMA context=
,
>     client drivers typically need a channel from a particular DMA
>     controller only and even in some cases a specific channel is desi=
red.
> -   To request a channel dma_request_channel() API is used.
> +   To request a channel dma_request_chan() API is used.
>
>     Interface:
> -       struct dma_chan *dma_request_channel(dma_cap_mask_t mask,
> -                       dma_filter_fn filter_fn,
> -                       void *filter_param);
> -   where dma_filter_fn is defined as:
> -       typedef bool (*dma_filter_fn)(struct dma_chan *chan, void *fi=
lter_param);
> -
> -   The 'filter_fn' parameter is optional, but highly recommended for
> -   slave and cyclic channels as they typically need to obtain a spec=
ific
> -   DMA channel.
> -
> -   When the optional 'filter_fn' parameter is NULL, dma_request_chan=
nel()
> -   simply returns the first channel that satisfies the capability ma=
sk.
> -
> -   Otherwise, the 'filter_fn' routine will be called once for each f=
ree
> -   channel which has a capability in 'mask'.  'filter_fn' is expecte=
d to
> -   return 'true' when the desired DMA channel is found.
> +       struct dma_chan *dma_request_chan(struct device *dev, const c=
har *name);
> +
> +   Which will find and return the 'name' DMA channel associated with=
 the 'dev'
> +   device. The association is done via DT, ACPI or board file based
> +   dma_map_filter matching table.
>
>     A channel allocated via this interface is exclusive to the caller=
,
>     until dma_release_channel() is called.
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index ea9d66982d40..b9dc1512c4aa 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -43,6 +43,7 @@
>
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> +#include <linux/platform_device.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/init.h>
>  #include <linux/module.h>
> @@ -712,6 +713,103 @@ struct dma_chan *dma_request_slave_channel(stru=
ct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(dma_request_slave_channel);
>
> +const static struct dma_filter_map *dma_filter_match(struct dma_devi=
ce *device,
> +                                              const char *name,
> +                                              struct device *dev)
> +{
> +       const struct dma_filter_map *map_found =3D NULL;
> +       int i;
> +
> +       if (!device->filter_map.mapcnt)
> +               return NULL;
> +
> +       for (i =3D 0; i < device->filter_map.mapcnt; i++) {
> +               const struct dma_filter_map *map =3D &device->filter_=
map.map[i];
> +
> +               if (!strcmp(map->devname, dev_name(dev)) &&
> +                   !strcmp(map->slave, name)) {
> +                       map_found =3D map;
> +                       break;

return map?

> +               }
> +       }
> +

return NULL;

> +       return map_found;
> +}
> +
> +/**
> + * dma_request_chan - try to allocate an exclusive slave channel
> + * @dev:       pointer to client device structure
> + * @name:      slave channel name
> + *
> + * Returns pointer to appropriate DMA channel on success or an error=
 pointer.
> + */
> +struct dma_chan *dma_request_chan(struct device *dev, const char *na=
me)
> +{
> +       struct dma_device *device, *_d;

If you name *d, *_d; it would=E2=80=A6

> +       struct dma_chan *chan =3D NULL;
> +

> +       /* If device-tree is present get slave info from here */
> +       if (dev->of_node)
> +               chan =3D of_dma_request_slave_channel(dev->of_node, n=
ame);
> +
> +       /* If device was enumerated by ACPI get slave info from here =
*/
> +       if (has_acpi_companion(dev) && !chan)
> +               chan =3D acpi_dma_request_slave_chan_by_name(dev, nam=
e);

This part might be a good candidate to be moved to
drivers/base/property.c as
struct dma_chan *device_property_dma_request_chan(=E2=80=A6) or alike.


> +
> +       if (chan) {
> +               /* Valid channel found */
> +               if (!IS_ERR(chan))
> +                       return chan;
> +

They might return EPROBE_DEFER. Is any specific handling needed here?

> +               pr_warn("%s: %s DMA request failed, falling back to l=
egacy\n",
> +                       __func__, dev->of_node ? "OF" : "ACPI");
> +       }
> +
> +       /* Try to find the channel via the DMA filter map(s) */
> +       mutex_lock(&dma_list_mutex);
> +       list_for_each_entry_safe(device, _d, &dma_device_list, global=
_node) {
> +               dma_cap_mask_t mask;
> +               const struct dma_filter_map *map =3D dma_filter_match=
(device,
> +                                                                   n=
ame, dev);
> +
> +               if (!map)
> +                       continue;
> +
> +               dma_cap_zero(mask);
> +               dma_cap_set(DMA_SLAVE, mask);
> +
> +               chan =3D find_candidate(device, &mask,
> +                                     device->filter_map.filter_fn, m=
ap->param);

=E2=80=A6allow to put this on single line I believe.

> +               if (!IS_ERR(chan))
> +                       break;
> +       }
> +       mutex_unlock(&dma_list_mutex);
> +
> +       return chan ? chan : ERR_PTR(-EPROBE_DEFER);
> +}
> +EXPORT_SYMBOL_GPL(dma_request_chan);
> +
> +/**
> + * dma_request_chan_by_mask - allocate a channel satisfying certain =
capabilities
> + * @mask: capabilities that the channel must satisfy
> + *
> + * Returns pointer to appropriate DMA channel on success or an error=
 pointer.
> + */
> +struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask=
)
> +{
> +       struct dma_chan *chan;
> +
> +       if (!mask)
> +               return ERR_PTR(-ENODEV);
> +
> +       chan =3D __dma_request_channel(mask, NULL, NULL);
> +       if (!chan)
> +               chan =3D ERR_PTR(-ENODEV);
> +
> +       return chan;
> +}
> +EXPORT_SYMBOL_GPL(dma_request_chan_by_mask);
> +
>  void dma_release_channel(struct dma_chan *chan)
>  {
>         mutex_lock(&dma_list_mutex);
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index a2b7c2071cf4..49d48e69c179 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -606,6 +606,18 @@ enum dmaengine_alignment {
>         DMAENGINE_ALIGN_64_BYTES =3D 6,
>  };
>
> +struct dma_filter_map {
> +        char *devname;

const ?

> +        char *slave;

Ditto.

> +        void *param;
> +};
> +
> +struct dma_filter {
> +        dma_filter_fn filter_fn;
> +        int mapcnt;
> +        const struct dma_filter_map *map;
> +};


--=20
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
