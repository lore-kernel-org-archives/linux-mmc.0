From: Joel Fernandes <joelf@ti.com>
Subject: Re: [PATCH v2] ARM: EDMA: Fix clearing of unused list for DT DMA
 resources
Date: Mon, 29 Jul 2013 22:47:04 -0500
Message-ID: <51F73738.6080901@ti.com>
References: <1374515989-7391-1-git-send-email-joelf@ti.com> <51F61359.1090309@ti.com>
Reply-To: <joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48640 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753185Ab3G3ElP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Jul 2013 00:41:15 -0400
In-Reply-To: <51F61359.1090309@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Vinod Koul <vinod.koul@intel.com>, Benoit Cousson <benoit.cousson@linaro.org>, Balaji TK <balajitk@ti.com>, Arnd Bergmann <arnd@arndb.de>, Jason Kridner <jkridner@beagleboard.org>, Mark Jackson <mpfj-list@newflow.co.uk>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Pantel Antoniou <panto@antoniou-consulting.com>

On 07/29/2013 02:01 AM, Sekhar Nori wrote:> On Monday 22 July 2013 11:2=
9
PM, Joel Fernandes wrote:
>> HWMOD removal for MMC is breaking edma_start as the events are being
manually
>> triggered due to unused channel list not being clear, Thanks to
Balaji TK for
>> finding this issue.
>
> So, Reported-by: Balaji T K <balajitk@ti.com>
>
> ?

Sure, I'll add that as well.

>
>>
>> This patch fixes the issue, by reading the "dmas" property from the
DT node if
>> it exists and clearing the bits in the unused channel list.
>>
>> Cc: Balaji T K <balajitk@ti.com>
>> Cc: Pantel Antoniou <panto@antoniou-consulting.com>
>> Signed-off-by: Joel Fernandes <joelf@ti.com>
>> ---
>> v2 changes: Fixed compiler warning
>>
>>  arch/arm/common/edma.c |   31 +++++++++++++++++++++++--------
>>  1 file changed, 23 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
>> index a432e6c..765d578 100644
>> --- a/arch/arm/common/edma.c
>> +++ b/arch/arm/common/edma.c
>> @@ -561,14 +561,29 @@ static int reserve_contiguous_slots(int ctlr,
unsigned int id,
>>  static int prepare_unused_channel_list(struct device *dev, void *da=
ta)
>>  {
>>  	struct platform_device *pdev =3D to_platform_device(dev);
>> -	int i, ctlr;
>> -
>> -	for (i =3D 0; i < pdev->num_resources; i++) {
>> -		if ((pdev->resource[i].flags & IORESOURCE_DMA) &&
>> -				(int)pdev->resource[i].start >=3D 0) {
>> -			ctlr =3D EDMA_CTLR(pdev->resource[i].start);
>> -			clear_bit(EDMA_CHAN_SLOT(pdev->resource[i].start),
>> -					edma_cc[ctlr]->edma_unused);
>> +	int i =3D 0, ctlr;
>> +	u32 dma_chan;
>> +	const __be32 *dma_chan_p;
>> +	struct property *prop;
>> +
>> +	if (dev->of_node) {
>> +		of_property_for_each_u32(dev->of_node, "dmas", prop, \
>> +					 dma_chan_p, dma_chan) {
>> +			if (i++ & 1) {
>> +				ctlr =3D EDMA_CTLR(dma_chan);
>> +				clear_bit(EDMA_CHAN_SLOT(dma_chan),
>> +						edma_cc[ctlr]->edma_unused);
>> +			}
>
> I think it will be cleaner if you use of_property_count_strings() on
> dma-names to get the count of DMA channels for this device and then u=
se
> of_parse_phandle_with_args() to get access to the args. Honestly, I h=
ave
> not used these APIs myself, so if this doesn=92t work the way I think=
 it
> should then let me know and I will try to do some experiments myself.
>
> The current way of skipping over even fields really depends on
> #dma-cells for EDMA to be 1. That in itself is not such a bad
> assumption, but if you have APIs which already take care of this for
> you, why not use them?

Sure, looks like of_dma_request_slave_channel does same thing in
drive/dma/of-dma.c. Let me follow up with a patch that does it this way=
=2E
I agree its cleaner.

>> +		}
>> +	} else {
>> +		for (; i < pdev->num_resources; i++) {
>> +			if ((pdev->resource[i].flags & IORESOURCE_DMA) &&
>> +			    (int)pdev->resource[i].start >=3D 0) {
>> +				ctlr =3D EDMA_CTLR(pdev->resource[i].start);
>> +				clear_bit(EDMA_CHAN_SLOT(
>> +					  pdev->resource[i].start),
>> +					  edma_cc[ctlr]->edma_unused);
>> +			}
>
> So there is very little in common between OF and non-OF versions of t=
his
> function. Why not have two different versions of this function for th=
e
> two cases? The OF version can reside under the CONFIG_OF conditional
> already in use in the file. This will also save you the ugly line bre=
aks
> you had to resort to due to too deep indentation.

Actually those line breaks are not necessary and wouldn't result in
compilation errors. I was planning to drop them. I'll go ahead and spli=
t
it out anyway, now that also the OF version of the function is going to
be bit longer if we use the of_parse functions.

Thanks for your review,

Regards,

-Joel
