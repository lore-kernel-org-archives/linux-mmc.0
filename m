From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [RFC v03 03/15] dmaengine: core: Introduce new, universal API to
 request a channel
Date: Thu, 3 Dec 2015 12:34:00 +0200
Message-ID: <56601A98.8040607@ti.com>
References: <1449064765-27427-1-git-send-email-peter.ujfalusi@ti.com>
 <1449064765-27427-4-git-send-email-peter.ujfalusi@ti.com>
 <CAHp75VcBnP-d=GSvfLFUQe8P1LFBtN6W9A+jvTTUw2vTSscBiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33708 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964802AbbLCKej (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 3 Dec 2015 05:34:39 -0500
In-Reply-To: <CAHp75VcBnP-d=GSvfLFUQe8P1LFBtN6W9A+jvTTUw2vTSscBiA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, linux-spi <linux-spi@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On 12/02/2015 04:35 PM, Andy Shevchenko wrote:
>> +const static struct dma_filter_map *dma_filter_match(struct dma_dev=
ice *device,
>> +                                              const char *name,
>> +                                              struct device *dev)
>> +{
>> +       const struct dma_filter_map *map_found =3D NULL;
>> +       int i;
>> +
>> +       if (!device->filter_map.mapcnt)
>> +               return NULL;
>> +
>> +       for (i =3D 0; i < device->filter_map.mapcnt; i++) {
>> +               const struct dma_filter_map *map =3D &device->filter=
_map.map[i];
>> +
>> +               if (!strcmp(map->devname, dev_name(dev)) &&
>> +                   !strcmp(map->slave, name)) {
>> +                       map_found =3D map;
>> +                       break;
>=20
> return map?
>=20
>> +               }
>> +       }
>> +
>=20
> return NULL;

OK.

>=20
>> +       return map_found;
>> +}
>> +
>> +/**
>> + * dma_request_chan - try to allocate an exclusive slave channel
>> + * @dev:       pointer to client device structure
>> + * @name:      slave channel name
>> + *
>> + * Returns pointer to appropriate DMA channel on success or an erro=
r pointer.
>> + */
>> +struct dma_chan *dma_request_chan(struct device *dev, const char *n=
ame)
>> +{
>> +       struct dma_device *device, *_d;
>=20
> If you name *d, *_d; it would=85
>=20
>> +       struct dma_chan *chan =3D NULL;
>> +
>=20
>> +       /* If device-tree is present get slave info from here */
>> +       if (dev->of_node)
>> +               chan =3D of_dma_request_slave_channel(dev->of_node, =
name);
>> +
>> +       /* If device was enumerated by ACPI get slave info from here=
 */
>> +       if (has_acpi_companion(dev) && !chan)
>> +               chan =3D acpi_dma_request_slave_chan_by_name(dev, na=
me);
>=20
> This part might be a good candidate to be moved to
> drivers/base/property.c as
> struct dma_chan *device_property_dma_request_chan(=85) or alike.

Not sure if it is a good idea. We want users to use the dmaengine API f=
or
requesting DMA channels, but if we just add renamed
dma_request_slave_channel_reason() - essentially the
device_property_dma_request_chan() would be the same - what users will =
stop to
use some random API to request the channel?
I'm not really sure if something which is returning 'struct dma_chan *'=
 can be
considered as property to anything. The DMA request number can be seen =
as a
property for a given device, but a dmaengine related pointer?

Actually I was thinking to move the declaration for these from
include/linux/of_dma.h/acpi_dma.h to a header under drivers/dma/

Also move as much local to dmaengine as it is possible to have cleaner
interface towards the client drivers.

>=20
>> +
>> +       if (chan) {
>> +               /* Valid channel found */
>> +               if (!IS_ERR(chan))
>> +                       return chan;
>> +
>=20
> They might return EPROBE_DEFER. Is any specific handling needed here?

-EPROBE_DEFER means that the DMA driver is not yet loaded and in this c=
ase the
lookup for the filter function would also fail, but we have additional =
and
needless warning printed out. It is better to return with the deferred =
code also.

>=20
>> +               pr_warn("%s: %s DMA request failed, falling back to =
legacy\n",
>> +                       __func__, dev->of_node ? "OF" : "ACPI");
>> +       }
>> +
>> +       /* Try to find the channel via the DMA filter map(s) */
>> +       mutex_lock(&dma_list_mutex);
>> +       list_for_each_entry_safe(device, _d, &dma_device_list, globa=
l_node) {
>> +               dma_cap_mask_t mask;
>> +               const struct dma_filter_map *map =3D dma_filter_matc=
h(device,
>> +                                                                   =
name, dev);
>> +
>> +               if (!map)
>> +                       continue;
>> +
>> +               dma_cap_zero(mask);
>> +               dma_cap_set(DMA_SLAVE, mask);
>> +
>> +               chan =3D find_candidate(device, &mask,
>> +                                     device->filter_map.filter_fn, =
map->param);
>=20
> =85allow to put this on single line I believe.

if not in one line, but will look much better.

>=20
>> +               if (!IS_ERR(chan))
>> +                       break;
>> +       }
>> +       mutex_unlock(&dma_list_mutex);
>> +
>> +       return chan ? chan : ERR_PTR(-EPROBE_DEFER);
>> +}
>> +EXPORT_SYMBOL_GPL(dma_request_chan);
>> +
>> +/**
>> + * dma_request_chan_by_mask - allocate a channel satisfying certain=
 capabilities
>> + * @mask: capabilities that the channel must satisfy
>> + *
>> + * Returns pointer to appropriate DMA channel on success or an erro=
r pointer.
>> + */
>> +struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mas=
k)
>> +{
>> +       struct dma_chan *chan;
>> +
>> +       if (!mask)
>> +               return ERR_PTR(-ENODEV);
>> +
>> +       chan =3D __dma_request_channel(mask, NULL, NULL);
>> +       if (!chan)
>> +               chan =3D ERR_PTR(-ENODEV);
>> +
>> +       return chan;
>> +}
>> +EXPORT_SYMBOL_GPL(dma_request_chan_by_mask);
>> +
>>  void dma_release_channel(struct dma_chan *chan)
>>  {
>>         mutex_lock(&dma_list_mutex);
>> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
>> index a2b7c2071cf4..49d48e69c179 100644
>> --- a/include/linux/dmaengine.h
>> +++ b/include/linux/dmaengine.h
>> @@ -606,6 +606,18 @@ enum dmaengine_alignment {
>>         DMAENGINE_ALIGN_64_BYTES =3D 6,
>>  };
>>
>> +struct dma_filter_map {
>> +        char *devname;
>=20
> const ?
>=20
>> +        char *slave;
>=20
> Ditto.

Sure.
I'm also going to change the name of the struct to dma_slave_map

>=20
>> +        void *param;
>> +};
>> +
>> +struct dma_filter {
>> +        dma_filter_fn filter_fn;
>> +        int mapcnt;
>> +        const struct dma_filter_map *map;
>> +};
>=20
>=20


--=20
P=E9ter
