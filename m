From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [RFC v02 03/15] dmaengine: core: Introduce new, universal API to
 request a channel
Date: Tue, 1 Dec 2015 11:48:34 +0200
Message-ID: <565D6CF2.8090305@ti.com>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
 <1448891145-10766-4-git-send-email-peter.ujfalusi@ti.com>
 <2436417.uspUkNqtIA@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2436417.uspUkNqtIA@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: vinod.koul@intel.com, andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, nsekhar@ti.com, linux-spi@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 11/30/2015 04:09 PM, Arnd Bergmann wrote:
> On Monday 30 November 2015 15:45:33 Peter Ujfalusi wrote:
>>                                                   const char *name);
>>  struct dma_chan *dma_request_slave_channel(struct device *dev, cons=
t char *name);
>> +
>> +struct dma_chan *dma_request_chan(struct device *dev, const char *n=
ame);
>> +struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mas=
k);
>> +
>>  void dma_release_channel(struct dma_chan *chan);
>>  int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps=
 *caps);
>>  #else
>> @@ -1268,6 +1291,14 @@ static inline struct dma_chan *dma_request_sl=
ave_channel(struct device *dev,
>>  {
>>         return NULL;
>>  }
>> +static inline struct dma_chan *dma_request_chan(struct device *dev)
>> +{
>> +       return ERR_PTR(-ENODEV);
>> +}
>>
>=20
> The prototypes for dma_request_chan() don't match, otherwise looks go=
od.

Aargh, the !CONFIG_DMA_ENGINE path...
=46ixed for the next RFC

Thanks,
P=E9ter
