From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [RFC v02 04/15] dmaengine: edma: Add support for DMA filter
 mapping to slave devices
Date: Tue, 1 Dec 2015 11:58:53 +0200
Message-ID: <565D6F5D.3060603@ti.com>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
 <1448891145-10766-5-git-send-email-peter.ujfalusi@ti.com>
 <7490116.jHcmUxB3Rf@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7490116.jHcmUxB3Rf@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: vinod.koul@intel.com, andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, nsekhar@ti.com, linux-spi@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 11/30/2015 04:11 PM, Arnd Bergmann wrote:
> On Monday 30 November 2015 15:45:34 Peter Ujfalusi wrote:
>> @@ -2428,6 +2436,22 @@ bool edma_filter_fn(struct dma_chan *chan, vo=
id *param)
>>  }
>>  EXPORT_SYMBOL(edma_filter_fn);
>> =20
>> +static bool edma_filter_for_map(struct dma_chan *chan, void *param)
>> +{
>> +       bool match =3D false;
>> +
>> +       if (chan->device->dev->driver =3D=3D &edma_driver.driver) {
>> +               struct edma_chan *echan =3D to_edma_chan(chan);
>> +               unsigned ch_req =3D (unsigned)param;
>> +               if (ch_req =3D=3D echan->ch_num) {
>> +                       /* The channel is going to be used as HW syn=
chronized */
>> +                       echan->hw_triggered =3D true;
>> +                       match =3D true;
>> +               }
>> +       }
>> +       return match;
>> +}
>> +
>>  static int edma_init(void)
>>
>=20
> I don't see the difference between edma_filter_fn and edma_filter_for=
_map.
> Why do you need both?

edma_filter_fn:
	unsigned ch_req =3D *(unsigned *)param;

edma_filter_for_map:
	unsigned ch_req =3D (unsigned)param;


If I want to reuse the edma_filter_fn, I would need an unsigned array f=
or the
eDMA event numbers in the board files to be able to provide the pointer=
 to
each of them.

--=20
P=E9ter
