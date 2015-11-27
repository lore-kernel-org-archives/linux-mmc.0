From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [RFC 3/6] dmaengine: core: Introduce new, universal API to
 request a channel
Date: Fri, 27 Nov 2015 13:16:37 +0200
Message-ID: <56583B95.7060503@ti.com>
References: <1448612982-28141-1-git-send-email-peter.ujfalusi@ti.com>
 <1448612982-28141-4-git-send-email-peter.ujfalusi@ti.com>
 <24788322.ynD35Kf0xi@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <24788322.ynD35Kf0xi@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
Cc: vinod.koul@intel.com, andy.shevchenko@gmail.com, linux-mmc@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 11/27/2015 01:00 PM, Arnd Bergmann wrote:
> On Friday 27 November 2015 10:29:39 Peter Ujfalusi wrote:
>> struct dma_chan *dma_request_chan(struct device *dev, const char *na=
me,
>> 				  const dma_cap_mask_t *mask);
>> To request a slave channel. The mask parameter is optional and it is=
 used
>> to check if the received channel's capabilities can satisfy the requ=
ested
>> mask. The dma_request_chan() will try to find the channel via DT, AC=
PI or
>> in case if the kernel booted in non DT/ACPI mode it will use a filte=
r
>> lookup table and retrieves the RESOURCE_DMA from the requester's dev=
ice.
>> This legacy mode needs changes in platform code, in dmaengine driver=
s and
>> finally the dmaengine user drivers can be converted:
>=20
> I think we should not introduce the mask parameter at all. In the rar=
e
> case that we actually need to pass a mask other than DMA_SLAVE today,
> we should be able to encode that in the data we pass to the filter
> function.

I have seen that drivers check the capabilities themselves after gettin=
g the
channel, so I thought that if we move that also to the core we can save=
 on
duplicated lines around the kernel. It is not needed to get the channel=
=2E As
you can see in the mmc patch, I pass NULL and the channel I got is the =
correct
one.
Sure, I can remove it.

>> RESOURCE_DMA needs to be added to the platform devices with names
>>
>> For each dmaengine driver a string array listing the devices handled=
 by the
>> given DMA driver:
>>
>> static char *da8xx_edma0_devices[] =3D {
>> 	"davinci-mcasp.0",
>> 	"da830-mmc.0",
>> };
>>
>> This information is going to be needed by the dmaengine driver, so
>> modification to the platform_data is needed, and the driver map shou=
ld be
>> added to the pdata of the DMA driver:
>=20
> However, a lot of drivers definitely need to pass a data pointer for
> each device. I see that you currently rely on the IORESOURCE_DMA
> method that a couple of platforms use today, but I think it would
> be backwards to do it that way for the platforms that require passing
> more than an integer number today.
>=20
> Having a pointer as the filter function argument is intentional and I=
'd
> prefer to change the platforms that currently use IORESOURCE_DMA (dav=
inci,
> pxa, omap1, blackfin, alchemy) to stop doing it instead, and return
> IORESOURCE_DMA to its original meaning that was limited to ISAPNP sty=
le
> devices not using the dmaengine API.

Something like this:

/* include/linux/dmaengine.h */

struct dma_filter_map {
	char *devname;
	char *slave;
	void *param;
};

struct dma_filter {
	dma_filter_fn filter_fn;
	int mapcnt;
	struct dma_filter_map *map;
};

/* arch/arm/mach-davinci/devices-da8xx.c */

static struct dma_filter_map da8xx_edma0_map[] =3D {
	{
		.devname =3D "davinci-mcasp.0",
		.slave =3D "tx",
		.param =3D (void*)DAVINCI_DA8XX_DMA_MCASP0_AXEVT,
	},
	{
		.devname =3D "davinci-mcasp.0",
		.slave =3D "rx",
		.param =3D (void*)DAVINCI_DA8XX_DMA_MCASP0_AREVT,
	},
	{
		.devname =3D "da830-mmc.0",
		.slave =3D "tx",
		.param =3D (void*)DA8XX_DMA_MMCSD0_TX,
	},
	{
		.devname =3D "da830-mmc.0",
		.slave =3D "rx",
		.param =3D (void*)DA8XX_DMA_MMCSD0_RX,
	},
};

I had this version first, but decided to go with a simpler one present =
in this
RFC series.

--=20
P=E9ter
