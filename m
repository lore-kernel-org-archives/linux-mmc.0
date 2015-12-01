From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [RFC v02 02/15] dmaengine: core: Move and merge the code paths
 using private_candidate
Date: Tue, 1 Dec 2015 10:41:18 +0200
Message-ID: <565D5D2E.4020000@ti.com>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
 <1448891145-10766-3-git-send-email-peter.ujfalusi@ti.com>
 <CAHp75VdbV3C8h8V8M=dKpTov70rPvmxuXCr5Kh=Ns3y+ZGnkhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38686 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755732AbbLAIlw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 1 Dec 2015 03:41:52 -0500
In-Reply-To: <CAHp75VdbV3C8h8V8M=dKpTov70rPvmxuXCr5Kh=Ns3y+ZGnkhQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, linux-spi <linux-spi@vger.kernel.org>

On 11/30/2015 04:42 PM, Andy Shevchenko wrote:
> On Mon, Nov 30, 2015 at 3:45 PM, Peter Ujfalusi <peter.ujfalusi@ti.co=
m> wrote:
>> Channel matching with private_candidate() is used in two paths, the =
error
>> checking is slightly different in them and they are duplicating code=
 also.
>> Move the code under dma_get_channel() to provide consistent executio=
n and
>> going to allow us to reuse this mode of channel lookup later.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  drivers/dma/dmaengine.c | 81 +++++++++++++++++++++++++-------------=
-----------
>>  1 file changed, 42 insertions(+), 39 deletions(-)
>>
>> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
>> index 52c3eee48e2e..1249165fb4b2 100644
>> --- a/drivers/dma/dmaengine.c
>> +++ b/drivers/dma/dmaengine.c
>> @@ -549,6 +549,42 @@ static struct dma_chan *private_candidate(const=
 dma_cap_mask_t *mask,
>>         return NULL;
>>  }
>>
>> +static struct dma_chan *dma_get_channel(struct dma_device *device,
>=20
> Naming scheme inside dmaengine.c looks like a mess.

Yes, I agree.

>=20
> Since it's static function that utilizes private_candidate() may I
> propose the name like find_candidate() ?

I had __* version as well, but the find_candidate() sounds better.

Thanks,
P=C3=A9ter
