From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [RFC v02 01/15] dmaengine: core: Allow NULL mask pointer in
 __dma_device_satisfies_mask()
Date: Tue, 1 Dec 2015 11:47:29 +0200
Message-ID: <565D6CB1.8030808@ti.com>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
 <1448891145-10766-2-git-send-email-peter.ujfalusi@ti.com>
 <CAHp75VfY=NU4MG7q1w=oYdTiTr0dqtNTQU3UkEaL=tXPJADH5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36912 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754181AbbLAJsC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 1 Dec 2015 04:48:02 -0500
In-Reply-To: <CAHp75VfY=NU4MG7q1w=oYdTiTr0dqtNTQU3UkEaL=tXPJADH5Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, linux-spi <linux-spi@vger.kernel.org>

On 11/30/2015 04:35 PM, Andy Shevchenko wrote:
> On Mon, Nov 30, 2015 at 3:45 PM, Peter Ujfalusi <peter.ujfalusi@ti.co=
m> wrote:
>> Treat as true condition the case when the mask is NULL.
>=20
> What do you think about setting some default (all "on") mask when mas=
k
> is not supplied?

Probably rephrasing the commit message to say that when the mask is NUL=
L it
means that the caller does not care about the capabilities of the dma d=
evice
thus return with true in such a case.

We could also drop this patch and in private_candidate() :

-	if (!__dma_device_satisfies_mask(dev, mask)) {
+	if (mask && !__dma_device_satisfies_mask(dev, mask)) {
		pr_debug("%s: wrong capabilities\n", __func__);
		return NULL;
	}


> I don't know for sure but there might be cases when you don't want
> literally *any* channel to satisfy.

Or set DMA_SLAVE only in dma_request_chan()? What happens if we have ca=
ses
when we are able to request channel for memcpy via dma_request_chan()
(dedicated memcpy channel/DMA engine?) in that case we will have the SL=
AVE
set, but not MEMCPY, or any other variation we do not know yet?

>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  drivers/dma/dmaengine.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
>> index daf54a39bcc7..52c3eee48e2e 100644
>> --- a/drivers/dma/dmaengine.c
>> +++ b/drivers/dma/dmaengine.c
>> @@ -184,6 +184,9 @@ __dma_device_satisfies_mask(struct dma_device *d=
evice,
>>  {
>>         dma_cap_mask_t has;
>>
>> +       if (!want)
>> +               return true;
>> +
>>         bitmap_and(has.bits, want->bits, device->cap_mask.bits,
>>                 DMA_TX_TYPE_END);
>>         return bitmap_equal(want->bits, has.bits, DMA_TX_TYPE_END);
>> --
>> 2.6.3
>>
>=20
>=20
>=20


--=20
P=C3=A9ter
